# kdeskrooge-docker

This package (and the Docker image you can build from it) will help
you if you use the personal-finances manager "Skrooge" on multiple
laptops/PCs and need to be sure it's the same version of Skrooge
everyone (to avoid DB inconsistencies if they all store the DB to a
shared location).

This is a Dockerfile and start script for a container I use to run the
Fedora-42, Fedora-43 and other versions of Skrooge, including latest
versions built from source, the personal finances manager software for
KDE. The image is based on a Fedora base image, and I use this to run,
on various OS and laptops, the same version of Skrooge that I am using
on my main PC, which happens to run Fedora.

To build the image, use:

```bash
docker build -t kdeskrooge .
```

Then start the application once and exit:

```bash
./start.sh
```

After this, adjust the configuration files:

`skrooge_config/Trolltech.conf`:

```
[Qt]
style=Breeze
```

`skrooge_config/kdeglobals`:

```
[Colors:Button]
BackgroundNormal=49,54,59
ForegroundNormal=239,240,241

[Colors:View]
BackgroundNormal=35,38,41
ForegroundNormal=239,240,241

[Colors:Window]
BackgroundNormal=49,54,59
ForegroundNormal=239,240,241

[General]
ColorScheme=Breeze Dark
Name=Breeze Dark
shadeSortColumn=true

[KDE]
contrast=4

[WM]
activeBackground=49,54,59
activeForeground=239,240,241
inactiveBackground=49,54,59
inactiveForeground=127,140,141
```

For Japanese font support, also do as follows:

`skrooge_config/Trolltech.conf`:

```
[Qt]
style=Fusion

[QtGui]
DefaultFont=Noto Sans CJK JP,10,-1,5,50,0,0,0,0,0
Font=Noto Sans CJK JP,10,-1,5,50,0,0,0,0,0
Palette\active=#ffffff, #31363b, #454c54, #3b4045, #1c1f22, #2a2e32, #ffffff, #ffffff, #ffffff, #232629, #31363b, #141719, #3daee9, #ffffff, #2980b9, #7f8c8d, #31363b, #000000, #31363b, #fcfcfc
Palette\disabled=#6e7175, #31363b, #454c54, #3b4045, #1c1f22, #2a2e32, #6e7175, #ffffff, #6e7175, #232629, #31363b, #141719, #31363b, #6e7175, #234257, #404648, #31363b, #000000, #31363b, #fcfcfc
Palette\inactive=#ffffff, #31363b, #454c54, #3b4045, #1c1f22, #2a2e32, #ffffff, #ffffff, #ffffff, #232629, #31363b, #141719, #224e65, #ffffff, #2980b9, #7f8c8d, #31363b, #000000, #31363b, #fcfcfc
```

`skrooge_config/fontconfig/fonts.conf`:

```
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <!-- Set default fonts with Japanese support -->
  <alias>
    <family>sans-serif</family>
    <prefer>
      <family>Noto Sans CJK JP</family>
      <family>VL Gothic</family>
      <family>IPAGothic</family>
    </prefer>
  </alias>
  <alias>
    <family>serif</family>
    <prefer>
      <family>Noto Serif JP</family>
      <family>IPAMincho</family>
    </prefer>
  </alias>
  <alias>
    <family>monospace</family>
    <prefer>
      <family>Noto Sans Mono CJK JP</family>
      <family>VL Gothic</family>
    </prefer>
  </alias>
</fontconfig>
```
