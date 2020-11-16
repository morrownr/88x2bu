### 88x2bu ( 88x2bu.ko )

### Linux Driver for the RealTek RTL8812BU and RTL8822BU Chipsets.

- Driver Version: v5.8.7.4 (Realtek)
- Plus updates from the Linux community

### Features:

- IEEE 802.11 b/g/n/ac WiFi compliant
- 802.1x, WEP, WPA TKIP and WPA2 AES/Mixed mode for PSK and TLS (Radius)
- WPS - PIN and PBC Methods
- IEEE 802.11b/g/n/ac Client mode
- Wireless security for WEP, WPA TKIP, WPA2 AES PSK and WPA3-SAE Personal
- Site survey scan and manual connect
- WPA/WPA2 TLS client
- Power saving mode
- LED control
- USB mode control
- AP Mode (WiFi Hotspot)
- WiFi-Direct
- Monitor mode
- Packet Injection (needs testing, please report results in `Issues`)

### Supported Kernels:

- Kernels: 2.6.24 ~ 5.8 (Realtek)
- Kernels: 5.9

### Tested Linux Distributions:

- Mint 20
- Mint 19.3
- Ubuntu 20.10
- Ubuntu 20.04
- Ubuntu 18.04
- Raspberry Pi OS (08-20-2020) (ARM 32 bit and ARM 64 bit)

### Download Locations for Tested Linux Distributions:

- Ubuntu - https://ubuntu.com/
- Mint - https://linuxmint.com/
- Raspberry Pi OS - https://www.raspberrypi.org/

### Tested Hardware:

- EDUP EP-AC1605GS WiFi Adapter 1300Mbps USB 3.0 High Gain Wireless Adapter:
  https://www.amazon.com/gp/product/B07Q56K68T

- FIDECO 6B21-AC1200M WiFi Adapter - AC1200 Dual Band:
  https://www.amazon.co.uk/gp/product/B08523KPP9

## Supported Devices:

* ASUS AC1300 USB-AC55 B1
* ASUS U2
* Dlink - DWA-181
* Dlink - DWA-182
* Edimax EW-7822ULC
* Edimax EW-7822UTC
* EDUP EP-AC1605GS
* FIDECO 6B21-AC1200M
* NetGear A6150
* TP-Link Archer T3U
* TP-Link Archer T3U Plus
* TP-Link Archer T4U V3
* TRENDnet TEW-808UBM
* Numerous additional products that are based on the supported chipsets

### Installation of the Driver:

Note: The installation instructions that I am providing are for the novice user. Experienced users are welcome to alter the installation to meet their needs.

Note: The installation instructions require that your system has access to the internet. I realize that you expect the adapter supported by this driver to provide your internet access but there are many ways to enable temporary internet access depending on your hardware and situation.

Note: The installation instructions require the use of the terminal. The quick way to open a terminal: Ctrl+Alt+T (hold down on the Ctrl and Alt keys then press the T key.)

Note: The installation instructions make use of DKMS. DKMS is a system utility which will automatically recompile and install a kernel module when a new kernel is installed. DKMS is provided by and maintained by Dell.

Note: It is recommended that you do not delete the driver directory after installation as the directory contains documentation (README.md) and scripts that you may need in the future.

Step 1: Open a terminal (Ctrl+Alt+T)

Step 2: Update the system:
```
$ sudo apt-get update
```
Step 3: Install the required packages: (select the option for the OS you are using)

Option for Ubuntu or Linux Mint:
```
$ sudo apt-get install -y dkms git
```
Option for Raspberry Pi OS:
```
$ sudo apt-get install -y raspberrypi-kernel-headers bc build-essential dkms git
```
Step 4: Create a directory to hold the downloaded driver:

Note: My technique is to create a directory in my home directory called `src`.
```
$ mkdir src
```
Step 5: Move to the newly created directory:
```
$ cd ~/src
```
Step 6: Download the driver:
```
$ git clone https://github.com/morrownr/88x2bu.git
```
Step 7: Move to the newly created driver directory:
```
$ cd ~/src/88x2bu
```
Step 8: Run the installation script and reboot: (select the option for the OS you are using)

Option for Ubuntu or Linux Mint:

Run installation script and reboot:
```
$ sudo ./install-driver.sh
$ sudo reboot
```
Note: The installation for Ubuntu or Linux Mint is complete

Option for Raspberry Pi OS: (select either the second or third option but not both)

Turn off I386 support:
```
$ sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
```
Option for Raspberry Pi OS (32 bit), turn on ARM support:
```
$ sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g' Makefile
```
Option for Raspberry Pi OS (64 bit), turn on ARM64 support:
```
$ sed -i 's/CONFIG_PLATFORM_ARM64_RPI = n/CONFIG_PLATFORM_ARM64_RPI = y/g' Makefile
```
Run installation script and reboot:
```
$ sudo ./install-driver.sh
$ sudo reboot
```
Note: The installation for Raspberry Pi OS is complete

### Removal of the Driver:

Step 1: Open a terminal (Ctrl+Alt+T)

Step 2: Move to the driver directory:
```
$ cd ~/src/88x2bu
```
Step 3: Run the removal script and reboot:
```
$ sudo ./remove-driver.sh
$ sudo reboot
```

### Entering Monitor Mode with 'iw' and 'ip':

Start by making sure the system recognizes the Wi-Fi interface:
```
$ sudo iw dev
```

The output shows the Wi-Fi interface name and the current mode among other things. The interface name will be something like `wlx00c0cafre8ba` and is required for the below commands. I will use `wlan0` as the interface name but you need to substitute your interface name.

Take the interface down:
```
$ sudo ip link set wlan0 down
```

Set monitor mode:
```
$ sudo iw wlan0 set monitor control
```

Bring the interface up:
```
$ sudo ip link set wlan0 up
```

Verify the mode has changed:
```
$ sudo iw dev
```

### Reverting to Managed Mode with 'iw' and 'ip':

Take the interface down:
```
$ sudo ip link set wlan0 down
```

Set managed mode:
```
$ sudo iw wlan0 set type managed
```

Bring the interface up:
```
$ sudo ip link set wlan0 up
```

Verify the mode has changed:
```
$ sudo iw dev
```

### Packet Injection:

Install the `aircrack-ng` package:
```
$ sudo apt-get install aircrack-ng
```
Open a terminal and execute the following:
```
$ sudo airmon-ng check kill
```
Determine the interface name:
```
$ sudo iw dev
```
Note: Do not use `airmon-ng` to enter Monitor Mode as it appears to be broken.

Note: Replace `wlan0` with your interface name.

Take the interface down:
```
$ sudo ip link set wlan0 down
```
Set monitor mode:
```
$ sudo iw wlan0 set monitor control
```
Bring the interface up:
```
$ sudo ip link set wlan0 up
```
Verify the mode has changed:
```
$ sudo iw dev
```
Run a test:
```
$ sudo aireplay-ng --test wlan0
```

Example of a successful test:
```
15:38:31  $ sudo aireplay-ng --test wlan0
15:38:31  Trying broadcast probe requests...
15:38:31  Injection is working!
15:38:32  Found 1 AP

15:38:32  Trying directed probe requests...
15:38:32  8C:59:73:FE:8B:F5 - channel: 36 - 'APname'
15:38:32  Ping (min/avg/max): 0.826ms/4.058ms/6.667ms Power: -35.77
15:38:32  30/30: 100%
```

### Driver Options:

A file called `88x2bu.conf` will be installed in `/etc/modeprob.d` by default.

Location: `/etc/modprobe.d/88x2bu.conf`

This file will be read and applied to the driver on each system boot.

To change the driver options, there are two options:

Option 1: Edit `88x2bu.conf` with a text editor using a terminal interface.

Example:
```
$ sudo nano /etc/modprobe.d/88x2bu.conf
```
Option 2: From the driver directory, run the `./edit-options.sh` script:
```
$ sudo ./edit-options.sh
```
The driver options are as follows:


USB mode options: ( rtw_switch_usb_mode )
```
  0 = no switch (default)
  1 = switch from usb 2.0 to usb 3.0
  2 = switch from usb 3.0 to usb 2.0
```
  Note: When changing USB options, a cold boot is recommended.


Log level options: ( rtw_drv_log_level )
```
  0 = NONE (default)
  1 = ALWAYS
  2 = ERRORS
  3 = WARNINGS
  4 = INFO
  5 = DEBUG
  6 = MAX
```
  Note: View RTW log entries by running the following in a terminal:
  ```
  $ sudo dmesg
  ```


LED control options: ( rtw_led_ctrl )
```
  0 = Always off
  1 = Normal blink (default)
  2 = Always on
```

### Information about USB 3 support:

USB 3 support is off by default as there can be problems with older USB 3 ports, however, almost all USB 3 ports on modern systems work well so turning USB 3 support on should work fine for almost everyone and the difference in performance can be large as can be seen in the data from the tests that I have conducted:


```
USB 3 support turned off (driver v5.8.7.2)
 (average Bitrate = 255 Mbits/sec)

Transfer     Bitrate
30.9 MBytes   260 Mbits/sec
29.5 MBytes   247 Mbits/sec
32.6 MBytes   273 Mbits/sec
30.6 MBytes   256 Mbits/sec
30.4 MBytes   255 Mbits/sec
28.3 MBytes   238 Mbits/sec
```

```
USB 3 support turned on (driver v5.8.7.2)
 (average Bitrate = 411 Mbits/sec)

Transfer     Bitrate
48.8 MBytes   409 Mbits/sec
47.5 MBytes   398 Mbits/sec
51.2 MBytes   430 Mbits/sec
48.8 MBytes   409 Mbits/sec
50.0 MBytes   419 Mbits/sec
47.5 MBytes   398 Mbits/sec
```

```
USB 3 support turned on (driver v 5.8.7.4)
 (average Bitrate = 552 Mbits/sec)

Transfer     Bitrate         Retr
66.2 MBytes   556 Mbits/sec    0
62.5 MBytes   524 Mbits/sec    0
67.5 MBytes   566 Mbits/sec    0
66.2 MBytes   556 Mbits/sec    0
65.0 MBytes   545 Mbits/sec    0
67.5 MBytes   566 Mbits/sec    0
```

See what your USB mode is:

```
$ lsusb -t
```
```
USB 2 =  480M
USB 3 = 5000M
```

### ----------------------------- Various Tidbits of Information -----------------------------


### How to disable onboard WiFi on Raspberry Pi 3B, 3B+, 3A+, 4B and Zero W.

Add the following line to /boot/config.txt:
```
dtoverlay=disable-wifi
```


### How to forget a saved wifi network on a Raspberry Pi

1. Edit wpa_supplicant.conf:
```
$ sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
```
2. Delete the relevant wifi network block (including the 'network=' and opening/closing braces.

3. Press ctrl-x followed by 'y' and enter to save the file.

4. Reboot


### Recommended Router Settings for WiFi:

Note: These are general recommendations based on years of experience but may not apply to your situation so testing to see if any help fix your problem is recommended.

Security: Use WPA2-AES. Do not use WPA or WPA2 mixed mode or TKIP.

Channel Width for 2.4G: Use 20 MHz. Do not use 40 MHz or 20/40 automatic.

Channels for 2.4G: Use 1 or 6 or 11. Do not use automatic channel selection.

Mode for 2.4G: Use G/N or B/G/N. Do not use N only.

Network names: Do not set the 2.4G Network and the 5G Network to the same name. Many routers come with both networks set to the same name.

Power Saving: Set to off. This can help in some situations. If you try turning it off and you see no improvement then set it back to on so as to save electricity.

After making these changes, reboot the router.


### Set regulatory domain to correct setting in OS:

Check the current setting:
```
$ sudo iw reg get
```

If you get 00, that is the default and may not provide optimal performance.

Find the correct setting here: http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2

Set it temporarily:
```
$ sudo iw reg set US
```
Note: Substitute your country code if not the United States.

Set it permanently:
```
$ sudo nano /etc/default/crda

Change the last line to read:

REGDOMAIN=US
```
