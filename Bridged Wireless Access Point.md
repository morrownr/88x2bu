## Bridged Wireless Access Point

A bridged wireless access point setup works within an existing
ethernet network to extend the network to WiFi capable computers
and devices in areas where the WiFi signal is weak or otherwise
does not meet expectations.

This document is for WiFi adapters based on the following chipsets
```
rtl8812bu, rtl8822bu
```
2021-02-03

Foreword: This setup can really push the data. It is FAST! See the
iperf3 test data at the end of this document.

##### Tested Setup

- Raspberry Pi 4B (4gb)

- Raspberry Pi OS (2021-01-11) (32 bit)

- Raspberry Pi Onboard WiFi disabled

- USB WiFi Adapter based on the rtl8812bu chipset

- WiFi Adapter Driver - https://github.com/morrownr/88x2bu

- Ethernet connection providing internet
	- Ethernet cables are CAT 6
	- Internet is Fiber-optic at 1 GHz up and 1 GHz down

##### Steps

1. Disable Raspberry Pi onboard WiFi.

Note: Disregard if not installing to Raspberry Pi hardware.
```
$ sudo nano /boot/config.txt
```
Add
```
dtoverlay=disable-wifi
```
-----

2. Install the driver for the WiFi adapter.

Follow the instructions at this site

https://github.com/morrownr/88x2bu

-----

3. Change driver options (to allow full speed operation.)
```
$ sudo nano /etc/modprobe.d/88x2bu.conf
```
```
rtw_vht_enable=2      (enable 80 Mhz channel width - 80211AC support)
rtw_switch_usb_mode=1 (enable USB 3 support)
```
-----

4. Update system.
```
$ sudo apt update

$ sudo apt full-upgrade

$ sudo reboot
```
-----

5. Install needed package.
```
$ sudo apt install hostapd
```
-----

6. Enable the wireless access point service and set it to start
   when your Raspberry Pi boots.
```
$ sudo systemctl unmask hostapd

$ sudo systemctl enable hostapd
```
-----

7. Add a bridge network device named br0 by creating a file using
   the following command, with the contents below.
```
$ sudo nano /etc/systemd/network/bridge-br0.netdev
```
File contents
```
[NetDev]
Name=br0
Kind=bridge
```
-----

8. Determine the names of the network interfaces.
```
$ ip link show
```
Note: If the interface names are not eth0 and wlan0, then the
interface names used in your system will have to replace eth0
and wlan0 during the remainder of this document.

-----

9. Bridge the Ethernet network with the wireless network, first
   add the built-in Ethernet interface ( eth0 ) as a bridge
   member by creating the following file.
```
$ sudo nano /etc/systemd/network/br0-member-eth0.network
```
File contents
```
[Match]
Name=eth0

[Network]
Bridge=br0
```
-----

10. Enable the systemd-networkd service to create and populate
    the bridge when your Raspberry Pi boots.
```
$ sudo systemctl enable systemd-networkd
```
-----

11. Block the eth0 and wlan0 interfaces from being
    processed, and let dhcpcd configure only br0 via DHCP.
```
$ sudo nano /etc/dhcpcd.conf
```
Add the following line above the first interface xxx line, if any
```
denyinterfaces wlan0 eth0
```
Go to the end of the file and add the following line
```
interface br0
```
-----

12. To ensure WiFi radio is not blocked on your Raspberry Pi,
    execute the following command.
```
$ sudo rfkill unblock wlan
```
-----

13. Create the hostapd configuration file.
```
$ sudo nano /etc/hostapd/hostapd.conf
```
File contents
```
# hostapd.conf
# https://w1.fi/hostapd/
# 2g, 5g, 80211n, 80211ac

# change the interface name to match your system, if necessary
interface=wlan0
bridge=br0
driver=nl80211
ctrl_interface=/var/run/hostapd
ctrl_interface_group=0

# change as desired
ssid=pi

# change as desired
wpa_passphrase=raspberry

# change as needed
country_code=US

ieee80211d=1
ieee80211h=1

# 2g (b/g/n)
#hw_mode=g
#channel=6

# 5g (a/n/ac)
hw_mode=a
channel=36
#channel=149

macaddr_acl=0
auth_algs=3
ignore_broadcast_ssid=0
wmm_enabled=1
wpa=2
wpa_key_mgmt=WPA-PSK
wpa_pairwise=CCMP
rsn_pairwise=CCMP

# IEEE 802.11n related configuration
ieee80211n=1

# 8812bu/8812au/8814au/8811cu/8811au
# 2g
#ht_capab=[SHORT-GI-20][MAX-AMSDU-7935][DSSS_CCK-40]
# 5g
ht_capab=[HT40+][SHORT-GI-20][SHORT-GI-40][MAX-AMSDU-7935]

# IEEE 802.11ac related configuration
# 5g
ieee80211ac=1

# 8812bu/8812au/8814au/8811cu/8811au
# 5g
vht_capab=[MAX-A-MPDU-LEN-EXP3][MAX-MPDU-11454][SHORT-GI-80][HTC-VHT]

# 5g
vht_oper_chwidth=1
vht_oper_centr_freq_seg0_idx=42
#vht_oper_centr_freq_seg0_idx=155

#
# end of hostapd.conf
```
-----

14. Establish conf file and log file locations.
```
$ sudo nano /etc/default/hostapd
```
Add to bottom of file
```
DAEMON_CONF="/etc/hostapd/hostapd.conf"
DAEMON_OPTS="-d -K -f /home/pi/hostapd.log"
```
-----

15. Reboot the system.

$ sudo reboot

-----

16. Enjoy!

-----

##### iperf3 results
```
$ iperf3 -c 192.168.1.40
Connecting to host 192.168.1.40, port 5201
[  5] local 192.168.1.83 port 60420 connected to 192.168.1.40 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  58.1 MBytes   487 Mbits/sec    0   1.19 MBytes       
[  5]   1.00-2.00   sec  65.0 MBytes   545 Mbits/sec    0   1.46 MBytes       
[  5]   2.00-3.00   sec  65.0 MBytes   545 Mbits/sec    0   1.46 MBytes       
[  5]   3.00-4.00   sec  65.0 MBytes   545 Mbits/sec    0   1.46 MBytes       
[  5]   4.00-5.00   sec  65.0 MBytes   545 Mbits/sec    0   1.54 MBytes       
[  5]   5.00-6.00   sec  63.8 MBytes   535 Mbits/sec    0   1.54 MBytes       
[  5]   6.00-7.00   sec  63.8 MBytes   535 Mbits/sec    0   1.54 MBytes       
[  5]   7.00-8.00   sec  63.8 MBytes   535 Mbits/sec    0   1.71 MBytes       
[  5]   8.00-9.00   sec  62.5 MBytes   524 Mbits/sec    0   1.71 MBytes       
[  5]   9.00-10.00  sec  63.8 MBytes   535 Mbits/sec    0   1.71 MBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   636 MBytes   533 Mbits/sec    0             sender
[  5]   0.00-10.01  sec   634 MBytes   531 Mbits/sec                  receiver

iperf Done.

```
Note: The Raspi 4b is overclocked to 2.0 GHz.


