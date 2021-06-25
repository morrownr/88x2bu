##### [Click for USB WiFi Adapter Information for Linux](https://github.com/morrownr/USB-WiFi)

-----

### 88x2bu ( 88x2bu.ko ) :rocket:

### Linux Driver for USB WiFi Adapters that are based on the RTL8812BU and RTL8822BU Chipsets

- v5.8.7.4 (Realtek) (2020-09-22)
- Plus updates from the Linux community

### Features

- IEEE 802.11 b/g/n/ac WiFi compliant
- 802.1x, WEP, WPA TKIP and WPA2 AES/Mixed mode for PSK and TLS (Radius)
- IEEE 802.11b/g/n/ac Client mode
  * Support wireless security for WEP, WPA TKIP and WPA2 AES PSK
  * Support site survey scan and manual connect
  * Support power saving mode
- Supported interface modes:
  * IBSS
  * Managed
  * AP (see *Bridged Wireless Access Point* located in the main directory of this repo)
  * Monitor
  * P2P-client
  * P2P-GO
- USB mode control
- Log level control
- LED control
- Power saving control
- VHT control (allows 80 MHz channel width in AP mode)
- SU Beamformee and MU Beamformee control
- SU Beamformer control

A FAQ is available at the end of this document.

### Compatible CPUs

- x86, amd64
- ARM, ARM64

### Compatible Kernels

- Kernels: 2.6.24 - 5.8 (Realtek)
- Kernels: 5.9 - 5.12 (community support)

### Tested Linux Distributions

- Arch Linux (kernel 5.4)
- Arch Linux (kernel 5.9)

- Fedora (kernel 5.11)

- Linux Mint 20.1 (Linux Mint based on Ubuntu) (kernel 5.4)
- Linux Mint 20   (Linux Mint based on Ubuntu) (kernel 5.4)
- Linux Mint 19.3 (Linux Mint based on Ubuntu) (kernel 5.4)

- LMDE 4 (Linux Mint based on Debian) (kernel 4.19)

- Manjaro 20.1 (kernel 5.9)

- Raspberry Pi OS (2021-01-11) (ARM 32 bit) (kernel 5.10)
- Raspberry Pi Desktop (x86 32 bit) (kernel 4.9)

- Ubuntu 20.10 (kernel 5.8)
- Ubuntu 20.04 (kernel 5.4)
- Ubuntu 18.04 (kernel 5.4)

### Download Locations for Tested Linux Distributions

- [Arch Linux](https://www.archlinux.org)
- [Fedora](https://getfedora.org)
- [Linux Mint](https://www.linuxmint.com)
- [Manjaro](https://manjaro.org)
- [Raspberry Pi OS](https://www.raspberrypi.org)
- [Ubuntu](https://www.ubuntu.com)

### Tested Hardware

- [EDUP EP-AC1605GS WiFi Adapter 1300Mbps USB 3.0 High Gain Wireless Adapter](https://www.amazon.com/gp/product/B07Q56K68T) (single-state)

- [FIDECO 6B21-AC1200M WiFi Adapter - AC1200 Dual Band](https://www.amazon.co.uk/gp/product/B08523KPP9)

- [Cudy WU1400 AC 1300Mbps USB 3.0 WiFi Adapter](https://www.amazon.com/Cudy-WU1200-AC1200Mbps-Wireless-Compatible/dp/B07Q9KY4NT) (single-state)

### Compatible Devices

* ASUS AC1300 USB-AC55 B1
* ASUS U2
* Cudy WU1400 (single-state)
* Dlink - DWA-181
* Dlink - DWA-182
* Edimax EW-7822ULC
* Edimax EW-7822UTC
* EDUP EP-AC1605GS (single state)
* FIDECO 6B21-AC1200M
* NetGear A6150
* TP-Link Archer T3U
* TP-Link Archer T3U Plus
* TP-Link Archer T4U V3
* TRENDnet TEW-808UBM
* Numerous additional products that are based on the supported chipsets

Warning: Beware of "multi-state" USB WiFi adapters. Some USB WiFi adapters have proprietary Windows drivers onboard. When plugged in, they act like a flash drive or CDROM and on Windows will attempt to start installing the Windows driver. That won't work on Linux or MAC or any other non-Windows OS so the adapter sits there in flash drive or CDROM mode. The problem is that the state of the adapter has to be changed for the adapter to show up as the device that you expect, in this case, a WiFi adapter. Most modern Linux distributions ship with a utility called "usb-modeswitch" that will handle this issue for you if it has the correct information for your adapter. It is a good utility but if you buy adapters that are "multi-state," that is one more potential headache you may have to deal with when something goes wrong. Often you can indentify adapters that are "multi-state" as they are advertised as "free driver" or "free installation driver." If you are looking to buy a USB WiFi adapter for use on Linux, MAC OS, *NIX or anything besides Windows, it is a good idea to seek out single-state adapters.

Note: Some adapter makers change the chipsets in their products while keeping the same model number so please check to confirm that the product you plan to buy has the chipset you are expecting.

### Installation Information

The installation instructions are for the novice user. Experienced users are welcome to alter the installation to meet their needs.

Temporary internet access is required for installation. There are numerous ways to enable temporary internet access depending on your hardware and situation. [One method is to use tethering from a phone.](https://www.makeuseof.com/tag/how-to-tether-your-smartphone-in-linux). Another method to enable temporary internet access is to keep a [wifi adapter that uses an in-kernel driver](https://github.com/morrownr/USB-WiFi) in your toolkit.

You will need to use the terminal interface. The quick way to open a terminal: Ctrl+Alt+T (hold down on the Ctrl and Alt keys then press the T key)

DKMS is used for the installation. DKMS is a system utility which will automatically recompile and install this driver when a new kernel is installed. DKMS is provided by and maintained by Dell.

It is recommended that you do not delete the driver directory after installation as the directory contains information and scripts that you may need in the future.

There is no need to disable Secure Mode to install this driver. If Secure Mode is properly setup on your system, this installation will support it.

### Installation Steps

Step 1: Open a terminal (Ctrl+Alt+T)

Step 2: Update the system (select the option for the OS you are using)
```
    Option for Debian based distributions such as Ubuntu, Linux Mint, Kali and the Raspberry Pi OS

    $ sudo apt-get update
```
```
    Option for Arch based distributions such as Manjaro

    $ sudo pacman -Syu
```
```
    Option for Fedora based distributions

    # sudo dnf -y update
```
Step 3: Install the required packages (select the option for the OS you are using)
```
    Option for Raspberry Pi OS

    $ sudo apt-get install -y raspberrypi-kernel-headers bc build-essential dkms git
```
```
    Option for Debian, Kali or Linux Mint Debian Edition (LMDE)

    $ sudo apt-get install -y linux-headers-$(uname -r) build-essential dkms git libelf-dev
```
```
    Option for Ubuntu (all flavors) or Linux Mint

    $ sudo apt-get install -y dkms git
```
```
    Options for Arch or Manjaro

    1) if using pacman

    $ sudo pacman -S --noconfirm linux-headers dkms git
```
Note: If you are asked to choose a provider, make sure to choose the one that corresponds to your version of the linux kernel (for example, ```linux510-headers``` for Linux kernel version 5.10) if you install the incorrect version, you'll have to uninstall it and reinstall the correct version.
```
    2) if using an AUR helper like paru or yay

    $ paru -S rtl8814au-dkms-git
```
Note: Make sure to uninstall any existing driver installations from other installation method. If the installation fails and its cause is related to AUR's BUILDPKG script, please address the issue first to the package maintainer at https://aur.archlinux.org/packages/rtl8814au-dkms-git/.

```
    Option for Fedora

    # sudo dnf -y install git dkms kernel-devel kernel-debug-devel
```
Step 4: Create a directory to hold the downloaded driver

```bash
$ mkdir ~/src
```
Step 5: Move to the newly created directory
```bash
$ cd ~/src
```
Step 6: Download the driver
```bash
$ git clone https://github.com/morrownr/88x2bu.git
```
Step 7: Move to the newly created driver directory
```bash
$ cd ~/src/88x2bu
```
Step 8: Warning: this step only applies if you are installing to Raspberry Pi *hardware*.

Run a preparation script
```
    Option for 32 bit operating systems to be installed to Raspberry Pi hardware

    $ ./raspi32.sh
```
```
    Option for 64 bit operating systems to be installed to Raspberry Pi hardware

    $ ./raspi64.sh
```
Step 9: Run the installation script (For automated builds, use _NoPrompt_ as an option)
```bash
$ sudo ./install-driver.sh [NoPrompt]
```
Step 10: Reboot
```bash
$ sudo reboot
```

### Driver Options

A file called `88x2bu.conf` will be installed in `/etc/modeprob.d` by default.

`/etc/modprobe.d/88x2bu.conf`

This file will be read and applied to the driver on each system boot.

To edit the driver options file, run the `edit-options.sh` script.
```bash
$ sudo ./edit-options.sh
```
Documentation for Driver Options is included in the file `88x2bu.conf`.

### Removal of the Driver

Note: This script should be used in the following situations:

- the driver is no longer needed
- a fresh start with default settings is needed
- a new version of the driver needs to be installed
- a major operating system upgrade is going to be applied

Note: This script removes everything that has been installed, with the exception
of the packages installed in Step 3, including the directory that contains the
downloaded source.

Step 1: Open a terminal (Ctrl+Alt+T)

Step 2: Move to the driver directory
```bash
$ cd ~/src/88x2bu
```
Step 3: Run the removal script
```bash
$ sudo ./remove-driver.sh
```
Step 4: Reboot
```bash
$ sudo reboot
```
### Recommended WiFi Router/ Access Point Settings

Note: These are general recommendations, some of which may not apply to your specific situation.

Security: Set WPA2-AES. Do not set WPA2 mixed mode or WPA or TKIP.

Channel width for 2.4G: Set 20 MHz fixed width. Do not use 40 MHz or 20/40 automatic.

Channels for 2.4G: Set channel 1 or 6 or 11 depending on the congestion at your location. Do not set automatic channel selection.

Mode for 2.4G: For best performance, set "N only" if you no longer use B or G capable devices.

Network names: Do not set the 2.4G Network and the 5G Network to the same name. Note: Unfortunately many routers come with both networks set to the same name.

Channels for 5G: Not all devices are capable of using DFS channels. It may be necessary to set a fixed channel in the range of 36 to 48 or 149 to 161 in order for all of your devices to work on 5g. (for US, other countries may vary)

Best location for the wifi router/ access point: Near center of apartment or house, at least a couple of feet away from walls, in an elevated location.

Check congestion: There are apps available for smart phones that allow you to check the congestion levels on wifi channels. The apps generally go by the name of WiFi Analyzer or something similar.

After making and saving changes, reboot the router.


### Set regulatory domain to correct setting in OS

Check the current setting
```bash
$ sudo iw reg get
```

If you get 00, that is the default and may not provide optimal performance.

Find the correct setting here: http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2

Set it temporarily
```bash
$ sudo iw reg set US
```
Note: Substitute your country code if you are not in the United States.

Set it permanently
```bash
$ sudo nano /etc/default/crda

Change the last line to read:

REGDOMAIN=US
```

### Recommendations regarding USB

- Moving your USB WiFi adapter to a different USB port has been known to fix a variety of problems. Problems include WiFi going on and off as well as connections coming and going.

- If connecting your USB WiFi adapter to a desktop computer, use the USB ports on the rear of the computer. Why? The ports on the rear are directly connected to the motherboard which will reduce problems with interference and disconnection that can happen with front ports that use cables.

- If your USB WiFi adapter is USB 3 capable then plug it into a USB 3 port.

- Avoid USB 3.1 Gen 2 ports if possible as almost all currently available adapters have been tested with USB 3.1 Gen 1 (aka USB 3) and not with USB 3.1 Gen 2.

- If you use an extension cable and your adapter is USB 3 capable, the cable needs to be USB 3 capable.

- Some USB WiFi adapters require considerable electrical current and push the capabilities of the power available via USB port. One example is devices that use the Realtek 8814au chipset. Using a powered multiport USB extension can be a good idea in cases like this.


### How to disable onboard WiFi on Raspberry Pi 3B, 3B+, 3A+, 4B and Zero W.

Add the following line to /boot/config.txt
```
dtoverlay=disable-wifi
```

### How to forget a saved WiFi network on a Raspberry Pi

1. Edit wpa_supplicant.conf
```bash
$ sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
```
2. Delete the relevant WiFi network block (including the 'network=' and opening/closing braces.

3. Press ctrl-x followed by 'y' and enter to save the file.

4. Reboot

-----

### FAQ:

Question: Does WPA3 work with this driver?

Answer: No, WPA3 does not work with this driver. If you need an AC class adapter
that does support WPA3, I suggest an Alfa AWUS036ACM (mt7612u chipset) but there
are other adapters based on the mt7612u chipset available at various price points.
Be aware that WPA3 support is not fully in place in all Linux distros currently.
More than driver support is required for WPA3 support. You can get more information
and links at the following site:

https://github.com/morrownr/USB-WiFi


Question: What interface combinations does this driver support?

Answer: None. Realtek out-of-kernel drivers, including this driver, do not
support interface combinations. If you need support for interface combinations,
I suggest adapters based on the Mediatek chipsets. You can get more information
and links at the following site:

https://github.com/morrownr/USB-WiFi


Question: What extended features does this driver support?

Answer: None. For extended features, you need an adapter that uses Mediatek or
Atheros drivers. You can get more information and links at the following site:

https://github.com/morrownr/USB-WiFi


Question: I bought two rtl88x2bu adapters and am planning to run one of them as an AP and another as a WiFi client. How do I set that up?

Answer: You can't. Realtek drivers do not support more than one adapter with the same chipset in the same computer. However, testing has shown that the Mediatek drivers do support more than one adapter with the same chipset in the same computer. I recommend adapters with the mt7612u chipset if you are looking for AC 1200+ adapters. You can get more information and links at the following site:

https://github.com/morrownr/USB-WiFi

Question: Why do you recommend Mediatek based adapters when you maintain this repo for a Realtek driver?

Answer: Many Linux users already have adapters based on Realtek chipsets. This repo is for Linux users to support their existing adapters but my STRONG recommendation is for Linux users to seek out solutions based on Mediatek, Intel or Atheros chipsets and drivers. If users are looking at a USB solution, Mediatek and Atheros based adapters are the best solution. If users want a PCIe, mPCIe, SDIO or other implementation then Intel, Mediatek or Atheros are good solutions. Realtek based USB adapters are not a good solution because Realtek does not follow Linux Wireless standards for USB WiFi adapters. Realtek drivers are problematic in many ways. You have been WARNED. For information about usb wifi adapters:

https://github.com/morrownr/USB-WiFi

-----
