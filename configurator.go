package main

import (
	"fmt"
	"io"
	"io/ioutil"
	"mime"
	"os"
	"os/exec"
	"path"
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

type target struct {
	TargetDir  string
	TargetName string
	Source     string
}

func digAllFiles(base string, rel string) (targets []*target) {
	files, err := ioutil.ReadDir(filepath.Join(base, rel))
	if err != nil {
		return
	}
	for _, file := range files {
		name := file.Name()
		if name == ".gitignore" {
			continue
		}
		path := filepath.Join(rel, name)
		if file.IsDir() {
			targets = append(targets, digAllFiles(base, path)...)
			continue
		}

		targets = append(targets, &target{
			Source:     base + "/" + path,
			TargetName: name,
			TargetDir:  rel,
		})
	}
	return
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

func patchOverlay(base string, overlays []*target) error {
	fmt.Println("== Overlay ==")
	for _, target := range overlays {
		targetPath := path.Join(base, target.TargetDir, target.TargetName)

		fmt.Printf("Patching %s => %s\n", target.Source, targetPath)

		stat, err := os.Stat(targetPath)
		isExist := !os.IsNotExist(err)

		if err := os.MkdirAll(path.Join(base, target.TargetDir), 0755); err != nil {
			return err
		}

		switch mime.TypeByExtension(filepath.Ext(target.TargetName)) {
		case "application/json":
			if isExist {
				cmd := exec.Command("jq", "-rs", "add", targetPath, target.Source)
				out, err := cmd.Output()
				if err != nil {
					return err
				}

				if err := backup(targetPath); err != nil {
					return err
				}

				if err := ioutil.WriteFile(targetPath, out, stat.Mode()); err != nil {
					return err
				}
			} else {
				if err := copy(targetPath, target.Source); err != nil {
					return err
				}
			}
		default:
			return fmt.Errorf("Unsupported Type")
		}
	}
	return nil
}
func symlinkReplacement(base string, replacements []*target) error {
	fmt.Println("== Symlink ==")
	for _, target := range replacements {
		targetPath := path.Join(base, target.TargetDir, target.TargetName)
		fmt.Printf("Linking %s => %s\n", target.Source, targetPath)
		stat, err := os.Lstat(targetPath)
		if !os.IsNotExist(err) {
			if stat.Mode()&os.ModeSymlink == 0 {
				backup(targetPath)
			} else {
				fmt.Printf("=> Removing existing %s...\n", targetPath)
				if err := os.Remove(targetPath); err != nil {
					return err
				}
			}
		}
		if err := os.MkdirAll(path.Join(base, target.TargetDir), 0755); err != nil {
			return err
		}
		if err := os.Symlink(target.Source, targetPath); err != nil {
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

	platformDir, _ := filepath.Abs(fmt.Sprintf("./platform-%s", platform))
	allDir, _ := filepath.Abs("./platform-all")

	replacements := append(digAllFiles(path.Join(platformDir, "./replacement"), ""), digAllFiles(path.Join(allDir, "./replacement"), "")...)
	overlays := append(digAllFiles(path.Join(platformDir, "./overlay"), ""), digAllFiles(path.Join(allDir, "./overlay"), "")...)

	home, err := os.UserHomeDir()
	if err != nil {
		panic(err)
	}

	var flag string
	if len(os.Args) > 1 {
		flag = os.Args[1]
	}

	if flag == "-D" {
		f := func(mode, base string, targets []*target) {
			for _, t := range targets {
				tp := path.Join(base, t.TargetDir, t.TargetName)
				fmt.Printf("%s %s => %s\n", mode, t.Source, tp)
			}
		}
		f("[D] Linking", home, replacements)
		f("[D] Patching", home, overlays)
		return
	}

	if flag == "-R" || flag == "" {
		if err := symlinkReplacement(home, replacements); err != nil {
			panic(err)
		}
	}
	if flag == "-P" || flag == "" {
		if err := patchOverlay(home, overlays); err != nil {
			panic(err)
		}
	}
}
