## Open Assistant - Arch Linux Version
Open Source Voice Assistant - Make Your Own Minds

## Description
Open Assistant is an open source voice assistant able to complete operating system tasks using spoken commands.

Written in Python, Open Assistant also uses a number of bash shell scripts, and is able to function offline. 

Internet access is only needed to update the language model when the commands file is changed or for downloading information, such as news or weather. 

Vocal recordings never leave the machine.

## Video Demonstrations
Version 0.00:
[https://youtu.be/-7Vh1ny9FsQ](https://youtu.be/-7Vh1ny9FsQ)

Version 0.11:
[https://youtu.be/_zBjn_LgiZM](https://youtu.be/_zBjn_LgiZM)

Version 0.21 with TP-Link Kasa LB130 and HS300:
[https://youtu.be/D99V9Ge9IaE](https://youtu.be/D99V9Ge9IaE)

## Installation
Open a terminal and download the Open Assistant source code archive:
```
wget https://gitlab.com/open-assistant/oa-arch/-/archive/main/oa-arch-main.zip
```
Unzip the package:
```
unzip oa-arch-main.zip
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
sudo pacman -S flite gobject-introspection gstreamer gst-plugins-base-libs pip python3 swig xclip xdotool
```
```
pip install requests gobject
```
Install ``git`` and ``yay`` if needed:
```
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```
Use ``yay`` to install ``pocketsphinx``:
```
yay pocketsphinx sphinxbase
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
Vocal commands and actions are found in: `minds/stella/config/commands.json`

User specific configuration is located in: `oa.sh`

## Support
Become a patron! https://www.patreon.com/openassistant

Need help? Feel free to submit an issue or send an email:

[info@openassistant.org](info@openassistant.org)

## Contributing
Hack away, friends! :)

Open Assistant is a unique and valuable project which could benefit anyone disabled, young, or elderly.

Let's make computing more fun, convenient, private, and accessible!

## Roadmap
Currently working to include a local language model toolkit, so OA will not require internet access to update commands. 

A comprehensive mapping of voice commands to all available keyboard shortcuts needs to be completed.

Offline speech dictation is under development, with a new video demo coming soon.

Porting to all common Linux distributions, GUI design, and creating convenient package installers are all on the list.

One small step at a time...

## Authors and acknowledgment
Andrew Vavrek, Clayton G. Hobbs, Jezra, Jonathan Kulp

## License
GPL V.3
