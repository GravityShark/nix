// Symlinks plugins in enabled-plugins.txt relative to the pluggers folders
package main

import (
	"bufio"
	"io/fs"
	"log"
	"os"
	"path/filepath"
)

func main() {
	file, err := os.Open("enabled-plugins.txt")
	if err != nil {
		log.Fatal(err)
	}

	os.Chdir("./lua/pluggers/")
	defer file.Close()

	deleteSymlinks()
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		plugin := scanner.Text()
		if len(plugin) == 0 {
			continue
		}
		if plugin[0] != '#' {
			os.Symlink(plugin, filepath.Base(plugin))
		}
	}
}

func deleteSymlinks() {
	files, err := os.ReadDir("./")
	if err != nil {
		log.Fatal(err)
		return
	}
	for _, v := range files {
		info, _ := v.Info()
		if info.Mode()&fs.ModeSymlink != 0 {
			os.Remove(v.Name())
		}
	}
}
