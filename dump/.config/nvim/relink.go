// Symlinks plugins described in enabled-plugins.txt from lua/pluggers to lua/enabled
package main

import (
	"bufio"
	"fmt"
	"io/fs"
	"log"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	argsWithoutProg := os.Args[1:]
	if len(argsWithoutProg) > 1 {
		fmt.Printf("Usage: relink.go [directory]\n")
		os.Exit(1)
	} else if len(argsWithoutProg) == 1 {
		err := os.Chdir(argsWithoutProg[0])
		if err != nil {
			log.Fatal(err)
		}
	}

	file, err := os.Open("./enabled-plugins.txt")
	if err != nil {
		log.Fatal(err)
	}

	err = os.Chdir("./lua")
	if err != nil {
		log.Fatal(err)
	}

	_, err = os.Stat("./enabled/")
	if err != nil || os.IsNotExist(err) {
		// return true, nil
		os.Mkdir("./enabled/", 0o755)
	}
	defer file.Close()

	deleteSymlinks()
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		plugin := scanner.Text()
		for i, v := range plugin {
			if v == '#' {
				plugin = plugin[:i]
				break
			}
		}
		plugin = strings.TrimSpace(plugin)

		if len(plugin) != 0 {
			plugger := "../pluggers/" + plugin + ".lua"
			enabled := "enabled/" + filepath.Base(plugin) + ".lua"
			err = os.Symlink(plugger, enabled)
			if err != nil {
				log.Fatal(err)
			}
		}
	}
}

func deleteSymlinks() {
	os.Chdir("./enabled")
	files, err := os.ReadDir("./")
	if err != nil {
		log.Fatal(err)
		return
	}
	for _, v := range files {
		info, _ := v.Info()
		if info.Mode()&fs.ModeSymlink != 0 {
			err = os.Remove(v.Name())
			if err != nil {
				log.Fatal(err)
			}
		}
	}
	os.Chdir("../")
}
