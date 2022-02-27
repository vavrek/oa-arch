## Open Assistant - Arch Linux Version
Open Source Voice Assistant - Make Your Own Minds

## Description
Open Assistant is an open source voice assistant able to complete operating system tasks using spoken commands.

Written in Python, Open Assistant uses a number of bash shell scripts and is able to function entirely offline. 

Speech recognition and updating language model files is enabled locally, without internet access. 

Commands and vocal recordings never leave the machine. 

100% user privacy.

## Video Demonstrations
Version 0.00:
[https://youtu.be/-7Vh1ny9FsQ](https://youtu.be/-7Vh1ny9FsQ)

Version 0.11:
[https://youtu.be/_zBjn_LgiZM](https://youtu.be/_zBjn_LgiZM)

Version 0.21 with TP-Link Kasa LB130 and HS300:
[https://youtu.be/D99V9Ge9IaE](https://youtu.be/D99V9Ge9IaE)

## Installation
Install ``git`` and ``yay`` if not already present on your system:
```
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```
From your home directory, download and unzip the Open Assistant source code:
```
cd ~ && wget https://gitlab.com/open-assistant/oa-arch/-/archive/main/oa-arch-main.zip && unzip oa-arch-main.zip
```
Rename the directory to "oa" and enter it:
```
mv oa-arch-main oa && cd oa;
```
Make all contained shell scripts and Python modules executable:
```
find ./ -name "*.sh" -exec chmod +x {} \; find ./ -name "*.py" -exec chmod +x {} \;
```
Install required packages:
```
sudo pacman -S flite gobject-introspection gstreamer gst-plugins-base-libs perl python3 xclip xdotool
```
```
pip install requests gobject
```
Use ``yay`` to install ``pocketsphinx``, ``sphinxbase``, and ``cmuclmtk``:
```
yay pocketsphinx && yay sphinxbase && yay cmuclmtk
``` 
KDE / Konsole users will also require ``qt-gstreamer``:
```
yay qt-gstreamer
```

## Usage
From within the Open Assistant directory, type:
```
./oa.sh
```
If you see **Stella: Listening**, Open Assistant is properly installed and running.

Congratulations. :)

Say **Hello Stella** and listen for a response.

If there is no response, be sure to check your microphone and speaker levels.

You can also try a recording test:
```
./mic-test.sh
```
Vocal commands and abilities are found in: ``minds/stella/abilities/commands.json``

After changing the commands file, reset OA, say **Update Commands**, then reset again. 

User specific configuration is located in: ``oa.sh``

## Support
Need help? Feel free to submit an issue or send an email:

[info@openassistant.org](mailto:info@openassistant.org)

## Contributing
Open Assistant is a unique and valuable project which would epecially benefit anyone disabled, young, or elderly, as well as those of us to take a break from traditional mouse and keyboard, from time to time.

The combination of keyboard, mouse, and microphone is quite powerful.

Make computing more convenient, fun, private, and accessible!

Hack away, friends! :)

## Roadmap
Include a local language model toolkit, so Open Assistant will not require internet access to update commands. (COMPLETE!)

Offline speech dictation. (Under current development: New demo video coming soon!)

Compile installation steps listed above into one ``install-arch.sh`` script, then create various install scrips for other distributions, such as ``install-debian.sh``, ``install-bsd.sh``, etc.

Map vocal commands to all available keyboard shortcuts and key characters.

Generate specific command files for common Window Managers.

Create package installers and get Open Assistant into all popular repositories.

GUI design using Kivy.

Android app development.

## Authors and acknowledgment
Andrew Vavrek, Clayton Hobbs, George Antohi, Jezra, Jonathan Kulp

## License
GPL V.3
