### 88x2bu ( 88x2bu.ko )

### Linux Driver for the RealTek RTL8812BU and RTL8822BU Chipsets.

- Driver Version: v5.8.7.4 (Realtek)
- Plus updates from the Linux community

### Supported Features:

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

### Supported Linux Distributions:

- Ubuntu - https://ubuntu.com/
- Mint - https://linuxmint.com/
- Raspberry Pi OS - https://www.raspberrypi.org/

### Tested Linux Distributions:

- Mint 20
- Mint 19.3
- Ubuntu 20.10
- Ubuntu 20.04
- Ubuntu 18.04
- Raspberry Pi OS (08-20-2020) (32 bit and 64 bit)

### Tested Hardware:

- EDUP EP-AC1605GS WiFi Adapter 1300Mbps USB 3.0 High Gain Wireless Adapter:
  https://www.amazon.com/gp/product/B07Q56K68T

## Supported Devices:

* ASUS AC1300 USB-AC55 B1
* ASUS U2
* Dlink - DWA-181
* Dlink - DWA-182
* Edimax EW-7822ULC
* Edimax EW-7822UTC
* EDUP EP-AC1605GS
* NetGear A6150
* TP-Link Archer T3U
* TP-Link Archer T3U Plus
* TP-Link Archer T4U V3
* TRENDnet TEW-808UBM
* Numerous additional products that are based on the supported chipsets

### DKMS:

This driver can be installed using DKMS. DKMS is a system utility which will automatically recompile and install a kernel module when a new kernel is installed. To make use of DKMS, install the `dkms` package. On Debian (based) systems, such as Ubuntu and Mint, installation is accomplished like this:
```
$ sudo apt-get update
```
```
$ sudo apt-get install dkms
```

Note: The installation of `dkms` in Mint or Ubuntu will result in the installation of the various development tools and required headers, if not previously installed, so no additional action is necessary on these distros.

### Installation of the Driver:

Note: The installation instructions I am providing are for the novice user. Experienced users are welcome to alter the installation to meet their needs.

Note: The quick way to open a terminal in Mint or Ubuntu: Ctrl+Alt+T (hold down on the Ctrl and Alt keys then press the T key.)

Note: My technique is to create a folder in my home directory to hold source packages. I call it `src`.

Create a folder to hold the downloaded driver file by first opening a terminal (Ctrl+Alt+T).

In the terminal, create the folder to hold the driver file:
```
$ mkdir src
```
With your browser:

Get the latest version of the driver from: `https://github.com/morrownr/88x2bu`

Download the driver by clicking on the green `Code` button then click on `Download ZIP` and save `88x2bu-5.8.7.4.zip` in your `src` folder.

Unzip `88x2bu-5.8.7.4.zip` by double clicking on it followed by selecting `Extract` twice in the archiver utility.

A folder called `88x2bu-5.8.7.4` should be created.

Open a terminal (Ctrl+Alt+T) and enter the driver folder:
```
$ cd ~/src/88x2bu-5.8.7.4
```
Note: The Raspberry PI OS running on Raspberry Pi hardware requires additional steps. See Raspberry Pi section further down.

Execute the following commands:
```
$ sudo ./dkms-install.sh
```
```
$ sudo reboot
```

### Removal of the Driver:

Open a terminal in the directory with the source code and execute the following commands:
```
$ sudo ./dkms-remove.sh
```
```
$ sudo reboot
```

### AP Mode (WiFi Hotspot Test):

- Tested good.


### Monitor Mode:

- Tested good.


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
15:38:31  ... $ sudo aireplay-ng --test wlan0
15:38:31  Trying broadcast probe requests...
15:38:31  Injection is working!
15:38:32  Found 1 AP

15:38:32  Trying directed probe requests...
15:38:32  8C:59:73:FE:8B:F5 - channel: 36 - 'myAPname'
15:38:32  Ping (min/avg/max): 0.826ms/4.058ms/6.667ms Power: -35.77
15:38:32  30/30: 100%
```


### Driver Options:

A file called `88x2bu.conf` will be installed in `/etc/modeprob.d` by default.

Location: `/etc/modprobe.d/88x2bu.conf`

To change driver options, edit `88x2bu.conf` with a text editor.

Example:
```
$ sudo nano /etc/modprobe.d/88x2bu.conf
```

The options are as follows:


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

### Raspberry Pi OS - Additional Installation Instructions:

Install the required packages:
```
$ sudo apt-get install -y raspberrypi-kernel-headers bc build-essential
```
Open a terminal (Ctrl+Alt+T) and enter the driver folder:
```
$ cd ~/src/88x2bu-5.8.7.4
```
Turn off I386 support:
```
$ sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
```
For Raspberry Pi OS (32 bit), turn on ARM support:
```
$ sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g' Makefile
```
For Raspberry Pi OS (64 bit), turn on ARM64 support:
```
$ sed -i 's/CONFIG_PLATFORM_ARM64_RPI = n/CONFIG_PLATFORM_ARM64_RPI = y/g' Makefile
```
Execute the following commands:
```
$ sudo ./dkms-install.sh
```
```
$ sudo reboot
```
