## Open Assistant - Arch Linux Version
Open Source Voice Assistant - Make Your Own Minds

## Description
Open Assistant is an open source voice assistant able to complete operating system tasks using spoken commands.

Written in Python, Open Assistant also uses a number of bash shell scripts, and is able to function and update language model files entirely offline. 

Commands and vocal recordings never leave the machine.

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
Make all contained shell scripts executable:
```
find ./ -name "*.sh" -exec chmod +x {} \;
```
Install required packages:
```
sudo pacman -S flite gobject-introspection gstreamer gst-plugins-base-libs python3 xclip xdotool
```
```
pip install requests gobject
```
Use ``yay`` to install ``pocketsphinx`` and ``sphinxbase``:
```
yay pocketsphinx
```
```
yay sphinxbase
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
Vocal commands and actions are found in: `minds/stella/abilities/commands.json`

After changing the commands file, reset OA, say **Update Commands**, then reset again. 

User specific system configuration is located in: `oa.sh`

## Support
Need help? Feel free to submit an issue or send an email:

[info@openassistant.org](info@openassistant.org)

## Contributing
Open Assistant is a unique and valuable project which could benefit anyone disabled, young, or elderly.

Let's make computing more fun, convenient, private, and accessible!

Hack away, friends! :)

## Roadmap
Currently working to include a local language model toolkit, so OA will not require internet access to update commands. (COMPLETED!)

A comprehensive mapping of voice commands to all available keyboard shortcuts needs to be accomplished.

Offline speech dictation is under active development, with a new video demo of this coming soon.

Porting to all common Linux distributions, Window Managers, GUI design, and creating convenient package installers are all on the todo list.

One small step at a time...

## Authors and acknowledgment
Andrew Vavrek, Clayton Hobbs, George Antohi, Jezra, Jonathan Kulp

## License
GPL V.3
