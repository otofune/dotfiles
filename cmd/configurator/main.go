package main

import (
	"fmt"
	"github.com/otofune/dotfiles/cmd/configurator/tools"
	"io"
	"io/ioutil"
	"mime"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
	"time"
)

func platform() (string, error) {
	switch runtime.GOOS {
	case "linux":
		fallthrough
	case "darwin":
		return runtime.GOOS, nil
	}
	return "", fmt.Errorf("unsupported platform")
}

type fromTo struct {
	From string
	To   string
}

func backup(p string) error {
	to := p + "-b" + fmt.Sprintf("%v", time.Now().Unix())
	fmt.Printf("=> Backuping %s => %s\n", p, to)
	return os.Rename(p, to)
}
func copy(dst, src string) error {
	s, err := os.Open(src)
	if err != nil {
		return err
	}
	defer s.Close()
	d, err := os.Create(dst)
	if err != nil {
		return err
	}
	defer d.Close()
	if _, err := io.Copy(d, s); err != nil {
		return err
	}
	return nil
}

func patchOverlay(overlays []*fromTo) error {
	fmt.Println("== Overlay ==")
	for _, target := range overlays {
		fmt.Printf("Patching %s => %s\n", target.From, target.To)

		stat, err := os.Stat(target.To)
		isExist := !os.IsNotExist(err)

		if err := os.MkdirAll(filepath.Dir(target.To), 0755); err != nil {
			return err
		}

		switch mime.TypeByExtension(filepath.Ext(target.To)) {
		case "application/json":
			if isExist {
				cmd := exec.Command("jq", "-rs", "add", target.To, target.From)
				out, err := cmd.Output()
				if err != nil {
					return err
				}

				if err := backup(target.To); err != nil {
					return err
				}

				if err := ioutil.WriteFile(target.To, out, stat.Mode()); err != nil {
					return err
				}
			} else {
				if err := copy(target.To, target.From); err != nil {
					return err
				}
			}
		default:
			return fmt.Errorf("Unsupported Type")
		}
	}
	return nil
}
func symlinkReplacement(replacements []*fromTo) error {
	fmt.Println("== Symlink ==")
	for _, target := range replacements {
		fmt.Printf("Linking %s => %s\n", target.From, target.To)
		stat, err := os.Lstat(target.To)
		if !os.IsNotExist(err) {
			if stat.Mode()&os.ModeSymlink == 0 {
				backup(target.To)
			} else {
				fmt.Printf("=> Removing existing %s...\n", target.To)
				if err := os.Remove(target.To); err != nil {
					return err
				}
			}
		}
		if err := os.MkdirAll(filepath.Dir(target.To), 0755); err != nil {
			return err
		}
		if err := os.Symlink(target.From, target.To); err != nil {
			return err
		}
	}
	return nil
}

func main() {
	platform, err := platform()
	if err != nil {
		panic(err)
	}

	finder := tools.NewFinder([]string{".gitignore"})

	platformDir, _ := filepath.Abs(fmt.Sprintf("./platform-%s", platform))
	allDir, _ := filepath.Abs("./platform-all")
	replacements := append(finder.ListAllFiles(filepath.Join(platformDir, "./replacement")), finder.ListAllFiles(filepath.Join(allDir, "./replacement"))...)
	overlays := append(finder.ListAllFiles(filepath.Join(platformDir, "./overlay")), finder.ListAllFiles(filepath.Join(allDir, "./overlay"))...)

	home, err := os.UserHomeDir()
	if err != nil {
		panic(err)
	}

	conv := func(a []*tools.File, base string) (r []*fromTo) {
		for _, file := range a {
			r = append(r, &fromTo{
				From: file.AbsolutePath,
				To:   filepath.Join(base, file.RelativePath),
			})
		}
		return
	}

	var flag string
	if len(os.Args) > 1 {
		flag = os.Args[1]
	}

	if flag == "-D" {
		f := func(mode string, targets []*fromTo) {
			for _, t := range targets {
				fmt.Printf("%s %s => %s\n", mode, t.From, t.To)
			}
		}
		f("[D] Linking", conv(replacements, home))
		f("[D] Patching", conv(overlays, home))
		return
	}

	if flag == "-R" || flag == "" {
		if err := symlinkReplacement(conv(replacements, home)); err != nil {
			panic(err)
		}
	}
	if flag == "-P" || flag == "" {
		if err := patchOverlay(conv(overlays, home)); err != nil {
			panic(err)
		}
	}
}
