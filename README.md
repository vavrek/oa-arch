# oa-arch

## Open Assistant
Open Source Voice Assistant - Make Your Own Minds

Arch Linux Version

## Description
Open Assistant is an open source voice assistant prototype able to complete operating system tasks using vocal commands.

Written in Python, Open Assistant uses a number of shell scripts, and is able to function offline. 

Internet access is only needed for updating the commands file (language model) and for downloading information, such as news or weather. Vocal recordings never leave the machine.

## Video Demonstrations
Version 0.00: 
 [https://youtu.be/-7Vh1ny9FsQ](https://youtu.be/-7Vh1ny9FsQ)

Version 0.11: 
 [https://youtu.be/_zBjn_LgiZM](https://youtu.be/_zBjn_LgiZM)

Version 0.21 with TP-Link Kasa LB130 and HS300:
 [https://youtu.be/D99V9Ge9IaE](https://youtu.be/D99V9Ge9IaE)

## Installation
Download and unzip the OA source code archive into a directory of your choice.

Make files `oa.sh` and `oa.py` executable with the command:

    `chmod +x oa.*`

Install required packages:

    `sudo pacman -S aplay flite gobject-introspection gstreamer lib32-gst-plugins-base xclip xdotool`

    `pip3 python-requests python-gobject`

    `yay pocketsphinx` 

    (install `yay` with `pacman` if needed to access the [AUR](https://aur.archlinux.org))

## Usage
From within the OA directory, type:

    `./oa.sh`

If you see `Stella: Listening`, Open Assistant is properly installed and running.

Say `Hello Stella` and listen for a response.

If there is no response, check your microphone and speaker levels.

All voice commands and actions can be found in:

    `minds/stella/config/commands.json`

User specific configuration is located in:

    `oa.sh`

## Support
Feel free to submit an issue or an email message for help:

    [info@openassistant.org](info@openassistant.org)

## Contributing
Hack away! 

This is a unique and valuable project which could benefit anyone disabled, young, or elderly.

Let's make computing more fun, convenient, and accessible.

## Authors and acknowledgment
Andrew Vavrek, Clayton G. Hobbs, Jezra, Jonathan Kulp

## License
GPL V.3
