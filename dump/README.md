# pumpnnix

my pumpndump but now im moving it to home manager cause why not

## non declarative stuff

1. doom emacs
   - _should_ automatically install using `home-manager switch`, you just need
     to invoke `doom env` and check up on `doom doctor` if theres anything wrong

     ```bash
     doom env
     ```

2. browsers firefox
   - you gotta reinstall the extension setttings from [./home/dump/firefox_extension_settings/]
   - sync the browser using firefox cause i love being tracked (but mainly because you really can't beat it)

3. Redownload and setup some wallpapers or something
   - [Distrotube](https://gitlab.com/dwt1/wallpapers)
   - Rosepine ([1](https://github.com/rose-pine/wallpapers), [2](https://wallhaven.cc/tag/162505), or just [google](https://www.google.com/search?q=rose+pine+wallpaper&tbs=imgo:1&udm=2) [it](https://duckduckgo.com/?t=h_&q=rose+pine+wallpaper&ia=images&iax=images))
   - [Wallhaven](https://wallhaven.cc/)
   - [Gruvbox](https://gruvbox-wallpapers.pages.dev/)
   - maybe not cause its goonna fetch the wallpaper for you anyway using stylix.nix

### minecraft

mainly follow this guide - https://its-saanvi.github.io/linux-mcsr/minecraft/mmc.html#further-optimizations

#### multiplayer

- if you have problem of unable to join in 1.16.4-1.16.5 use [this](https://github.com/MCTeamPotato/MultiOfflineFix/releases)
- if you want to make servers use [e4mc](https://modrinth.com/mod/e4mc) or [e4mcbiat](https://github.com/DuncanRuns/e4mcbiat/)
  - if you need udp like bedrock edition, use [playit.gg](https://playit.gg/)

#### choosing a java version

there are 3 factors i want to test (sorted for best for CLIENT to least)

1. java version (25,21,17,8)
2. jre provider (azul prime (uses it's own gc), graalvm ee, adoptium)
3. garbage collector (shenandoah, zgc + zgenerational, zgc, g1gc)

try to use the best and then slowly go down the list

## links

- https://github.com/brucethemoose/Minecraft-Performance-Flags-Benchmarks
- https://github.com/Radk6/MC-Optimization-Guid
- https://github.com/DataDalton/Minecraft-Performance-Guide/blob/main/Java%20Arguments/README.md
- https://noflags.sh/
