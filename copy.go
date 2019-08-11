package main

import (
	"fmt"
	"io/ioutil"
	"os"
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
	fis, err := ioutil.ReadDir(base + "/" + rel)
	if err != nil {
		return
	}
	for _, file := range fis {
		var path string
		name := file.Name()
		if name == ".gitignore" {
			continue
		}
		if rel == "" {
			path = name
		} else {
			path = rel + "/" + name
		}
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

func move(p string) error {
	to := p + "-b" + fmt.Sprintf("%v", time.Now().Unix())
	fmt.Printf("Backuping %s => %s", p, to)
	return os.Rename(p, to)
}
func patchOverlay(base string, overlays []*target) error {
	// TODO
	return nil
}
func symlinkReplacement(base string, replacements []*target) error {
	for _, target := range replacements {
		targetPath := path.Join(base, target.TargetDir, target.TargetName)
		fmt.Printf("Linking %s => %s\n", target.Source, targetPath)
		stat, err := os.Lstat(targetPath)
		if err == nil {
			if stat.Mode()&os.ModeSymlink == 0 {
				move(targetPath)
			} else {
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

	replacements := digAllFiles(platformDir+"/replacement", "")
	replacements = append(replacements, digAllFiles(allDir+"/replacement", "")...)
	overlays := digAllFiles(platformDir+"/overlay", "")
	overlays = append(overlays, digAllFiles(allDir+"/overlay", "")...)

	home, err := os.UserHomeDir()
	if err != nil {
		panic(err)
	}
	if err := symlinkReplacement(home, replacements); err != nil {
		panic(err)
	}
}
