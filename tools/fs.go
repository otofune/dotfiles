package tools

import (
	"io/ioutil"
	"path/filepath"
)

type File struct {
	AbsolutePath string
	RelativePath string
}

func includes(actual string, expects []string) bool {
	for _, expect := range expects {
		if expect == actual {
			return true
		}
	}
	return false
}

type Finder struct {
	ignoreNames []string
}

func NewFinder(ignoreNames []string) *Finder {
	return &Finder{
		ignoreNames: ignoreNames,
	}
}

func (f *Finder) ListAllFiles(baseDirectory string) (files []*File) {
	fis, err := ioutil.ReadDir(baseDirectory)
	if err != nil {
		return
	}
	for _, fileinfo := range fis {
		name := fileinfo.Name()

		// Blacklist
		if includes(name, f.ignoreNames) {
			continue
		}

		absolutePath := filepath.Join(baseDirectory, name)

		if fileinfo.IsDir() {
			childFiles := f.ListAllFiles(absolutePath)
			for _, childFile := range childFiles {
				files = append(files, &File{
					AbsolutePath: childFile.AbsolutePath,
					RelativePath: filepath.Join(name, childFile.RelativePath),
				})
			}
			continue
		}

		files = append(files, &File{
			AbsolutePath: absolutePath,
			RelativePath: name,
		})
	}
	return
}
