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
   - you gotta reinstall the extension setttings from
     [./home/dump/firefox_extension_settings/]
   - sync the browser using firefox cause i love being tracked (but mainly
     because you really can't beat it)
3. Redownload and setup some wallpapers or something
   - [Distrotube](https://gitlab.com/dwt1/wallpapers)
   - Rosepine ([1](https://github.com/rose-pine/wallpapers),
     [2](https://wallhaven.cc/tag/162505), or just
     [google](https://www.google.com/search?q=rose+pine+wallpaper&tbs=imgo:1&udm=2)
     [it](https://duckduckgo.com/?t=h_&q=rose+pine+wallpaper&ia=images&iax=images))
   - [Wallhaven](https://wallhaven.cc/)
   - [Gruvbox](https://gruvbox-wallpapers.pages.dev/)
   - maybe not cause its goonna fetch the wallpaper for you anyway using
     stylix.nix
4. OBS-studio
   - https://its-saanvi.github.io/linux-mcsr/post_install/obs.html#splitting-audio

### Minecraft

Please read the links below before copy and pasting anything here.

I mainly follow this guide -
https://its-saanvi.github.io/linux-mcsr/minecraft/mmc.html#further-optimizations.

The setup goes like

#### Prism Launcher Defaults

Settings

Settings > Minecraft > General > Window Size > Start Minecraft Maximized ✅

Settings > Minecraft > Tweaks > Native library workarounds > Use system
installation of GLFW ✅

Settings > Minecraft > Tweaks > Performance > Use discrete GPU ✅

Settings > Java > Memory > Minimum & Maximum memory allocation = 6144MiB

Settings > Java > Java Runtime > Java path: = _select GraalVM EE 25_

Settings > Java > Java Runtime > Skip Java compatibility checks ✅

Settings > Java > Java Runtime > JVM arguments: =
`-XX:+UseZGC -XX:+UseCompactObjectHeaders -XX:+AlwaysPreTouch -XX:+UseTransparentHugePages -Djdk.graal.TuneInlinerExploration=1`

Settings > Custom Commands > Wrapper command: = `jemalloc.sh`

Settings > Environment Variables > Name: `__GL_THREADED_OPTIMIZATIONS` Value:
`0`

#### Jemalloc

- just add `jemalloc.sh` at the very start of a "wrapper command"

#### Heap Size

- Always set the minimum and the maximum as the same.
- Allocating 6G (or 6144MB), should work most of the time.
  - [this](https://vazkii.notion.site/A-semi-technical-explanation-of-why-you-shouldn-t-allocate-too-much-RAM-to-Minecraft-78e7bd41ba6646de8d1c55c033674bce)
    says don't allocate too much
  - but [this](https://exa.y2k.diy/garden/jvm-args/) says it doesn't matter if
    you have a good gc (usually java 21+ with ZGenerational)

#### Choosing a Java Version

What I use is by default for all is GraalVM EE 25 with these flags

`-XX:+UseZGC -XX:+UseCompactObjectHeaders -XX:+AlwaysPreTouch -XX:+UseTransparentHugePages -Djdk.graal.TuneInlinerExploration=1`

1. Java Version (25,21,17,8)
   - You mainly want to pick the highest version that won't crash the game
   - Otherwise consult
     [this](https://github.com/Radk6/MC-Optimization-Guide/blob/main/java-n-stuff/java-things.md)
   - Using non-LTS bulids are stupid cause that is no longer being updated
2. Java Bulids
   - GraalVM EE - recommended, works most of the time
   - Adoptium Temurin - it ain't that bad compared to graalvm but it usually has
     greater compatibility
   - Anything else is basically irrelevant

3. Java Garbage Collector (shenandoah, zgc + zgenerational (generational is
   default by v24+), zgc, g1gc)
   - 24 `-XX:+UseZGC`, ZGenerational became default
   - 21-23 `-XX:+UseZGC -XX:+ZGenerational`
   - 11-20 `-XX:+UseZGC`
   - 8 `-XX:+UseG1GC`
   - If you are feeling spicy you can try Shenandoah. YMMV, but it would mostly
     be just slightly less than ZGC.
     - `-XX:+UseShenandoahGC`
4. Java Flags
   - In Java 25, `-XX:+UseCompactObjectHeaders` is free optimization
   - `-XX:+AlwaysPreTouch` allocates all memory upfront, useful for like large
     (128GB) heap sizes, but slower startup.
   - `-XX:+UseTransparentHugePages` **if** transparent huge pages are enabled in
     linux.
   - `-Djdk.graal.TuneInlinerExploration=1` GraalVM exclusive, exerpt from the
     docs:
     > To tune for better peak performance or faster warmup. It automatically
     > adjusts values governing the effort spent during inlining. The value of
     > the option is a float clamped between -1 and 1 inclusive. Anything below
     > 0 reduces inlining effort and anything above 0 increases inlining effort.
     > In general, peak performance is improved with more inlining effort while
     > less inlining effort improves warmup (albeit to a lower peak). Note that
     > this option is only a heuristic and the optimal value can differ from
     > application to application (only available in Oracle GraalVM).
   - `-XX:+DisableExplicitGC` disables the manual garbage collect API. Useful if
     you are using stupid java code (like plugins, mods and such), but harmful
     if you aren't.

   - Otherwise Choosing java flags shouldn't be made by you, if a mod pack
     recommends you to use them, **try them if you'd like**.
   - But if there is **nothing** said, **don't** use your own.
   - You can check
     [here](https://github.com/Radk6/MC-Optimization-Guide/blob/main/modpack-specific/modpack-instructions.md)
     for them.

#### Minecraft Speedrunning (1.16.1)

For MCSR with SeedQueue I add nmethodsweepactivity and still use GraalVM EE 25

`-XX:+UseZGC -XX:+UseCompactObjectHeaders -XX:+AlwaysPreTouch -XX:NmethodSweepActivity=1 -XX:+UseTransparentHugePages -Djdk.graal.TuneInlinerExploration=1`

Otherwise (like MCSR Ranked) use the default one.

1. People recommend to only use java 17-22
   - Specifically GraalVM EE 21, because using Java 22 is stupid cause the
     software isn't updated anymore
   - **BUT** I personally find good or even _better_ to still use Java 25 (I've
     only tested for MCSR Ranked tbh)
2. Memory Allocation
   - **SEEDQUEUE**: 7500 MB
     - You might need slightly more or less depending on the category, i.e. less
       for SSG and more for AA.
   - **NO SEEDQUE**: 3200-6400 MB
     - **FOR RANKED**: use 2048MiB, **3072MiB** or 4096MiB
3. `-XX:+UseZGC -XX:+AlwaysPreTouch -Djdk.graal.TuneInlinerExploration=1 -XX:NmethodSweepActivity=1`
   by recommendation of others
   - ZGenerational wass known to be slower
4. Recommended SeedQueue settings:
   - Max Queued Seeds: 22
   - Max Generating Seeds: 2 You can try a higher value, and if you start
     consistently lagging after tabbing into a world, lower it back.
   - Max Generating Seeds (Wall): 9
5. waywall
   - just add `waywall wrap --` at the end of your thing, keeping `jemalloc.sh`
     at the start. `jemalloc.sh waywall wrap --`
6. LWJGL
   - Right click your instance in Prism > Edit > Version > Right click LWJGL 3 >
     Change Version > Select 3.3.3
7. Install the latest
   [MCSR Practice Map](https://github.com/Dibedy/The-MCSR-Practice-Map)
8. Download and use
   [Mod Check](https://github.com/tildejustin/modcheck/releases) on the instance
   (make sure fabric is already installed)
9. Set up MPK, there is already one in ~/.nix/dump/.config/waywall
10. Set up Standard Settings and Atum, yet again ~/.nix/dump/.config/waywall
11. Edit and run `clear-world` script from ~/.scripts to clear worlds, or setup
    tmpfs

#### MCSR Ranked Defaults

Keep everything default from prism launcher

Settings > Java > Memory > Minimum & Maximum memory allocation = 3072MiB

Settings > Custom Commands > Wrapper command: = `jemalloc.sh waywall wrap --`

#### Multiplayer

- if you have problem of unable to join in 1.16.4-1.16.5 use
  [this](https://github.com/MCTeamPotato/MultiOfflineFix/releases)
- if you want to make servers use [e4mc](https://modrinth.com/mod/e4mc) or
  [e4mcbiat](https://github.com/DuncanRuns/e4mcbiat/)
  - if you need udp like bedrock edition, use [playit.gg](https://playit.gg/)
- if you're too lazy to setup an offline server get something like offlinelan

#### Neoforge and Wayland

- This [issue](https://github.com/neoforged/NeoForge/issues/393) says you need
  to add this flag to make it work
  - `-Dfml.earlyprogresswindow=false`

### Mouse Settings

- Set cho dpi to `2700`
- Set the left side mouse button to `backspace`
- Set the right side mouse button to `home`
- Set the middle dpi button to as low as it can be

## links

- https://exa.y2k.diy/garden/jvm-args/ <--- really reccommend to read
  - https://notes.highlysuspect.agency/blog/managing_java/
- https://github.com/Radk6/MC-Optimization-Guide <- has some mod specific java
  flags if you need em. and also general tips
- https://github.com/DataDalton/Minecraft-Performance-Guide/blob/main/Java%20Arguments/README.md
  <- some people don't like this cause it's outdated
- https://noflags.sh/
