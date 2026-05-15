# Minecraft

Please read the links below before copy and pasting anything here.

I mainly follow this guide -
https://its-saanvi.github.io/linux-mcsr/minecraft/mmc.html#further-optimizations.

The setup goes like

## Tutorial

### Lunar Client 1.8

Use Lunar Client, just use the saved options

- Set Java Arguments to `-XX:+UseG1GC`
- Wrapper Command `nvidia-offload jemalloc.sh`
- Environment Variables `__GL_THREADED_OPTIMIZATIONS` = `0`

### Prism Launcher Defaults

- Settings
- Settings > Minecraft > General > Window Size > Start Minecraft Maximized ✅
- Settings > Minecraft > Tweaks > Native library workarounds > Use system
  installation of GLFW ✅
- Settings > Minecraft > Tweaks > Performance > Use discrete GPU ✅
- Settings > Java > Memory > Minimum & Maximum memory allocation = 6144MiB
- Settings > Java > Java Runtime > Java path: = Select Temurin 21
- Settings > Java > Java Runtime > Skip Java compatibility checks ✅
- Settings > Java > Java Runtime > JVM arguments: =
  `-XX:+UseZGC -XX:+AlwaysPreTouch -XX:+UseTransparentHugePages -XX:+ZGenerational`
- Settings > Custom Commands > Wrapper command: = `jemalloc.sh`
- Settings > Environment Variables > Name: `__GL_THREADED_OPTIMIZATIONS` Value:
  `0`

### Setup a MCSR RSG or Ranked Instance

- Based on [This vid by draconix](https://www.youtube.com/watch?v=l-q-_4R8_6M)
- I've named the instances MCSR 1.16.1 and MCSR Ranked respectively

1. Add Instance > Modrinth and search for
   [SpeedrunPack](https://modrinth.com/modpack/speedrun)
   - This is so you can update using the Modrinth section
   - **ON WAYWALL**: Deselect the mod "SleepBackground" as it could cause issues
2. Edit > Settings > Java > Java Installation & Java Arguments
   - **No SeedQueue** (Ranked): Adoptium 21
     `-XX:+UseZGC -XX:+AlwaysPreTouch -XX:+UseTransparentHugePages -XX:NmethodSweepActivity=1`
   - **SeedQueue** (RSG): GraalVM EE 17
     `-XX:+UseZGC -XX:+AlwaysPreTouch -XX:+UseTransparentHugePages -XX:NmethodSweepActivity=1 -Djdk.graal.TuneInlinerExploration=1 `
3. Edit > Settings > Java > Memory > Minimum & Maximum
   - **No SeedQueue** (Ranked): 2048MiB, **3072MiB** or 4096MiB
   - **SeedQueue** (RSG): **7500MiB**
     - You might need slightly more or less depending on the category, i.e. less
       for SSG and more for AA.
4. Edit > Settings > Custom Commands > Wrapper Command:
   `jemalloc.sh waywall wrap --`
5. Edit > Version > Right click LWJGL 3 > Change Version > Select 3.3.3
6. Install [MCSR Practice Map](https://github.com/Dibedy/The-MCSR-Practice-Map)
   and Add it to worlds
7. Configs
   - Copy the folder [config/mcsr](./config/mcsr/) to config/
   - Copy the folder [config/speedrunigt](./config/speedrunigt/) to root
   - Copy the file [hotbar.nbt](./config/hotbar.nbt) to root
   - Copy the folder [config/Chloe Wall](<./config/Chloe\ Wall/>) to
     resourcepacks/. Then apply the resource pack in-game.
8. Edit and run `clear-world` script from ~/.scripts to clear worlds, or setup
   tmpfs
9. To fully turn it into ranked just add the **Project: MCSR Ranked** Mod and it
   should work

### PVP Instance

1. Find the "Optimization" modpack and add
2. Edit > Settings > Custom Commands > Wrapper Command:
   `jemalloc.sh waywall wrap --`
3. Download these mods
   - Anchor Optimizer
   - AppleSkin
   - BetterPing Display
   - Bobby
   - Centered Crosshair
   - Cloth Config
   - Combat Hitboxes (might remove)
   - Compact Chat
   - Consumable Optimizer
   - Cookey Mod
   - Crosshair Addons
   - gatekeep
   - HeroBot
   - In_Game Account Switcher
   - Inventory Hud +
   - Ixeris (?)
   - Kind's Crystal Optimizer
   - Mod Menu
   - More Chat History
   - No Chat Reports
   - Noisisium
   - Nvidium
   - OfflineLAN
   - Optimized Fullbright
   - Packet fixer
   - Scalable Lux
   - Scoreboard Tweaks
   - SettingsManagerLib
   - Shielf Fixes
   - Shulker Box Tooltips
   - Smooth Skies
   - Status Effect Timer
   - Title Tweaks
   - Toggle Sprint Display (find a better one)
   - Very Many Players

## Ideas

### MCSR Ranked Defaults

- Settings > Java > Java Arguments = ``
- Settings > Java > Memory > Minimum & Maximum memory allocation = **3072MiB**
- Settings > Custom Commands > Wrapper command: = `jemalloc.sh waywall wrap --`

### Minecraft Speedrunning RSG (1.16.1)

- For MCSR with SeedQueue use GraalVMEE 17 because 21 isnt updated
  - `-XX:+UseZGC -XX:+AlwaysPreTouch -XX:+UseTransparentHugePages -XX:NmethodSweepActivity=1 -Djdk.graal.TuneInlinerExploration=1 `
- For Ranked use Adoptium 21
  - `-XX:+UseZGC -XX:+AlwaysPreTouch -XX:+UseTransparentHugePages -XX:NmethodSweepActivity=1`

1. People recommend to only use java 17-22
   - Specifically GraalVM EE 21, because using Java 22 is stupid cause the
     software isn't updated anymore
   - ZGenerational was known to be slower for seedqueue
2. Memory Allocation
   - **SEEDQUEUE**: 7500 MB
     - You might need slightly more or less depending on the category, i.e. less
       for SSG and more for AA.
   - **NO SEEDQUEUE**: 3200-6400 MB
     - **FOR RANKED**: use 2048MiB, **3072MiB** or 4096MiB
3. Recommended SeedQueue settings:
   - Max Queued Seeds: 22
   - Max Generating Seeds: 2 You can try a higher value, and if you start
     consistently lagging after tabbing into a world, lower it back.
   - Max Generating Seeds (Wall): 9
4. waywall
   - just add `waywall wrap --` at the end of your thing, keeping `jemalloc.sh`
     at the start. `jemalloc.sh waywall wrap --`
5. LWJGL
   - Right click your instance in Prism > Edit > Version > Right click LWJGL 3 >
     Change Version > Select 3.3.3
6. Install the latest
   [MCSR Practice Map](https://github.com/Dibedy/The-MCSR-Practice-Map)
7. Set up MPK, there is already one in ~/.nix/dump/.config/waywall
8. Set up Standard Settings and Atum, yet again ~/.nix/dump/.config/waywall
9. Edit and run `clear-world` script from ~/.scripts to clear worlds, or setup
   tmpfs

### Choosing a Java Version

TLDR:

- Adoptium 25 (26.1)
  `-XX:+UseZGC -XX:+AlwaysPreTouch -XX:+UseTransparentHugePages -XX:+UseCompactObjectHeaders `
- Adoptium 21 (Default)
  `-XX:+UseZGC -XX:+AlwaysPreTouch -XX:+UseTransparentHugePages -XX:+ZGenerational`
- Adoptium 21 (Ranked)
  `-XX:+UseZGC -XX:+AlwaysPreTouch -XX:+UseTransparentHugePages -XX:NmethodSweepActivity=1`
- GraalVM EE 17 (RSG)
  `-XX:+UseZGC -XX:+AlwaysPreTouch -XX:+UseTransparentHugePages -XX:NmethodSweepActivity=1 -Djdk.graal.TuneInlinerExploration=1 `

1. Java Version (25,21,17,8)
   - You mainly want to pick the highest version that won't crash the game
   - Otherwise consult
     [this](https://github.com/Radk6/MC-Optimization-Guide/blob/main/java-n-stuff/java-things.md)
   - Using non-LTS bulids are stupid cause that is no longer being updated
2. Java Bulids
   - GraalVM EE - starts slow, then gets faster. Should ONLY be used for RSG
     (SeedQueue)
   - Adoptium Temurin - Always use instead
   - Anything else is basically irrelevant

3. Java Garbage Collector (shenandoah, zgc + zgenerational (generational is
   default by v24+), zgc, g1gc)
   - 24+ `-XX:+UseZGC`, ZGenerational became default
   - 21-23 `-XX:+UseZGC -XX:+ZGenerational`
   - 11-20 `-XX:+UseZGC`
   - 8 `-XX:+UseG1GC`
   - If you are feeling spicy you can try Shenandoah. YMMV, but it would mostly
     be just slightly less than ZGC.
     - `-XX:+UseShenandoahGC`
4. Java Flags
   - Only in Java 25, `-XX:+UseCompactObjectHeaders` is free optimization
   - `-XX:+AlwaysPreTouch` allocates all memory upfront, useful for like large
     (128GB) heap sizes, but slower startup.
   - `-XX:+UseTransparentHugePages` **if** transparent huge pages are enabled in
     linux.
   - `-XX:NmethodSweepActivity=1` This option controls the aggressiveness of the
     nmethod sweeping activity in the JVM. It affects the frequency and
     intensity of sweeping unused compiled code.
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

### Jemalloc

- just add `jemalloc.sh` at the very start of a "wrapper command"

### Heap Size

- Always set the minimum and the maximum as the same.
- Allocating 6G (or 6144MB), should work most of the time.
  - [this](https://vazkii.notion.site/A-semi-technical-explanation-of-why-you-shouldn-t-allocate-too-much-RAM-to-Minecraft-78e7bd41ba6646de8d1c55c033674bce)
    says don't allocate too much
  - but [this](https://exa.y2k.diy/garden/jvm-args/) says it doesn't matter if
    you have a good gc (usually java 21+ with ZGenerational)

### Multiplayer

- if you have problem of unable to join in 1.16.4-1.16.5 use
  [this](https://github.com/MCTeamPotato/MultiOfflineFix/releases)
- if you want to make servers use [e4mc](https://modrinth.com/mod/e4mc) or
  [e4mcbiat](https://github.com/DuncanRuns/e4mcbiat/)
  - if you need udp like bedrock edition, use [playit.gg](https://playit.gg/)
- if you're too lazy to setup an offline server get something like offlinelan

### Neoforge and Wayland

- This [issue](https://github.com/neoforged/NeoForge/issues/393) says you need
  to add this flag to make it work
  - `-Dfml.earlyprogresswindow=false`

### Extra resources

- https://exa.y2k.diy/garden/jvm-args/ <--- really reccommend to read
  - https://notes.highlysuspect.agency/blog/managing_java/
- https://github.com/Radk6/MC-Optimization-Guide <- has some mod specific java
  flags if you need em. and also general tips
- https://github.com/DataDalton/Minecraft-Performance-Guide/blob/main/Java%20Arguments/README.md
  <- some people don't like this cause it's outdated
- https://noflags.sh/
