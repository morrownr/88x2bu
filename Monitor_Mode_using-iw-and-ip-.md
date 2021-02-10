### Monitor Mode using ```iw``` and ```ip```

2021-02-09

-----
##### Enter Monitor Mode

Start by making sure the system recognizes the WiFi interface
```
$ iw dev
```
Note: The output shows the WiFi interface name and the current mode among other things. The interface name may be something like `wlx00c0cafre8ba` and is required for the below commands. The interface name `wlan0` will be used in the instructions below but you need to substitute your interface name.


Take the interface down
```
$ sudo ip link set wlan0 down
```

Set monitor mode
```
$ sudo iw wlan0 set monitor control
```

Bring the interface up
```
$ sudo ip link set wlan0 up
```

Verify the mode has changed
```
$ iw dev
```
-----

##### Revert to Managed Mode

Take the interface down
```
$ sudo ip link set wlan0 down
```

Set managed mode
```
$ sudo iw wlan0 set type managed
```

Bring the interface up
```
$ sudo ip link set wlan0 up
```

Verify the mode has changed
```
$ iw dev
```
-----

##### Change MAC Address before entering Monitor Mode

Take down things that might interfere
```
$ sudo airmon-ng check kill
```
Check the WiFi interface name
```
$ iw dev
```
Take the interface down
```
$ sudo ip link set dev wlan0 down
```
Change the MAC address
```
$ sudo ip link set dev wlan0 address <your new mac address>
```
Set monitor mode
```
$ sudo iw wlan0 set monitor control
```
Bring the interface up
```
$ sudo ip link set dev wlan0 up
```
Verify the MAC address and mode has changed
```
$ iw dev
```
