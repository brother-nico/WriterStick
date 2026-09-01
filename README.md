# WriterStick

A plug-and-play writerdeck setup for the Raspberry Pi OS, designed to launch FocusWriter upon startup. It can be run with a monitor, mouse and keyboard attached to the Raspberry Pi device, or accessed remotely to commit the full writerdeck experience to one device and your access point of choice.

This guide also walks you through setting up Raspberry Pi Connect. (I've personally used this setup to circumvent strict installation restrictions on work devices, so I don't have to carry an additional device to write my books on during breaks.)

Screen sharing (for typing your work) is officially supported on the following devices, which use Wayland by default:
- Raspberry Pi 4
- Raspberry Pi 5
- Raspberry Pi 400
- Raspberry Pi 500

Alternatively, you can use the below models by overriding the hardware detection script that forces X11 architecture. This is an unofficial workaround to run Wayland on the older hardware.

- Raspberry Pi Zero 2 W
- Raspberry Pi 3 Model A+

## Setup Overview

1. Install Raspberry Pi OS
2. Enable Raspberry Pi Connect
3. Download and run `writerstick-setup.sh` on your Raspberry Pi.
4. Enable fullscreen on FocusWriter via F11.
5. Optional: Set up Syncthing to sync work across devices.


## Step 1: Install Raspberry Pi OS

Download [Raspberry Pi Imager](https://www.raspberrypi.com/software/) from the official website. 

Install on a device with an SD card reader. Then, insert the microSD card you'll use with your Raspberry Pi into the reader.

Run Raspberry Pi Imager. Pick your device, than the recommended OS, and the microSD card as your storage.

Follow setup steps from there.

Once the OS is flashed to the microSD card, eject it, then insert it into your Raspberry Pi device. (This guide presumes you have a monitor, mouse, and keyboard connected for setup. They won't be required if you leave it running somewhere and remote access in with another device, like a laptop.)

Start it up, then follow the steps to set up the OS.


## Step 2: Enable Raspberry Pi Connect

Visit [https://id.raspberrypi.com/sign-up](https://id.raspberrypi.com/sign-up) in a web browser on any computer, and fill out the form to register for a Raspberry Pi ID.

Open a terminal on your Raspberry Pi. Run the following commands, one by one:
`sudo apt update`
`sudo apt upgrade`
`sudo apt install rpi-connect`

Once installation is complete, reboot your device.

`sudo reboot`

Once you do so, you will see a new icon on the desktop for Raspberry Pi Connect.

Click on the icon and select "**Sign In**." You will be redirected to a webpage where you can sign in with your Raspberry Pi ID.

Name your device, click "**Create device and sign in**." This connects your Raspberry Pi to your Raspberry Pi ID, allowing remote access via [https://connect.raspberrypi.com](https://connect.raspberrypi.com).

If you want, you can continue the rest of this installation via Remote Access.

These instructions were adapted from the [Raspberry Pi Connect project here](https://projects.raspberrypi.org/en/projects/raspberry-pi-connect). I've linked it if you need another reference point.


## Step 3: Download and run `writerstick-setup.sh` on your Raspberry Pi.

Download `writerstick-setup.sh` from this repository to your Raspberry Pi.

Then, open a terminal in the folder you downloaded it to.

Type or paste in `bash writerstick-setup.sh` and hit enter.

**IMPORTANT: Do not run the bash script with sudo (e.g. sudo bash writerstick-setup). Otherwise, it will write the autostart file to /root/.config/autostart and run for the root user, not your current user which was set up as part of Pi OS install.**

The script calls sudo itself when needed. It'll also give you a warning if you try to run it with a sudo command--don't just ignore the warning!

### What Happens When I Run This Shell Script?
- First, it updates system package lists, then installs FocusWriter.
- Then, it will enable auto-login, skipping login prompt and loading you directly into the desktop.
- Last, it will configure FocusWriter to launch on startup.
  
The .sh file has notes within the script if you'd like to review the steps and associated commands there.


## Step 4: Enable Fullscreen on FocusWriter via F11

Open FocusWriter.

Enable fullscreen distraction mode by hitting F11.

Close FocusWriter.

FocusWriter remembers the state you left it in, so autostart will now open it in fullscreen.

Once you do so, reboot your system via `sudo reboot` or through the system GUI.

If all works as intended, your system should start up, then open FocusWriter automatically, in fullscreen mode.

With [Raspberry Pi Connect](https://connect.raspberrypi.com/sign-in), you can leave this device running, and while it's connected to the internet, access it through a browser of your choice.
Toggling fullscreen on your browser reproduces the writerdeck environment, although there is some latency due to the remote access.


## (Optional) Step 5: Set up Syncthing

FocusWriter saves its files to a folder of your choice on local storage. The easiest way to ensure your work is backed up or can be accessed on other devices is to set up Syncthing.

To do so, toggle off Fullscreen, then follow the [Getting Started guide here.](https://docs.syncthing.net/intro/getting-started.html)

# That's It

Your WriterStick is ready to go.

If this setup helps you write more and focus on your craft, consider checking out my work as an author on [www.nicolashornyak.com](www.nicolashornyak.com).
