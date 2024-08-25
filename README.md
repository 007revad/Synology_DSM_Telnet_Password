# Synology DSM Recovery Telnet Password

<a href="https://github.com/007revad/Synology_DSM_Telnet_Password/releases"><img src="https://img.shields.io/github/release/007revad/Synology_DSM_Telnet_Password.svg"></a>
<a href="https://hits.seeyoufarm.com"><img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2F007revad%2FSynology_DSM_Telnet_Passwordh&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=views&edge_flat=false"/></a>
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/paypalme/007revad)
[![](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86)](https://github.com/sponsors/007revad)
[![committers.top badge](https://user-badge.committers.top/australia/007revad.svg)](https://user-badge.committers.top/australia/007revad)

### Description

Synology DSM Recovery Telnet Password of the Day generator

If a DSM update fails the boot loader will enable telnet to make it possible to recover from the failed DSM update. The DSM recovery telnet password was originally blank. Later Synology changed it to 101-0101

If a blank password or 101-0101 does not work you need to either contact Synology Support for the 'password of the day', or you can run this script which will show you the 'password of the day'.

The script can run on a Synology NAS or any computer or NAS that has bash.

### Options

You can run the script with --day=X and --month=Y to get the telnet password for day X of month Y.
```
Usage: dsm_telnet_password.sh [options]

Options:
      --day=      Set the day to calculate password from
                  If --day= is used you must also use --month=
                  Day must be numeric. e.g. --day=24
      --month=    Set the month to calculate password from
                  If --month= is used you must also use --day=
                  Month must be numeric. e.g. --month=9
  -h, --help      Show this help message
  -v, --version   Show the script version
```

### Screen shots

<br>

Script on Windows with WSL
<p align="left"><img src="images/windows2.png"></p>

<br>

Script on Synology NAS
<p align="left"><img src="images/dsm2.png"></p>

<br>

v1.0.2 run with --day and --month options
<p align="left"><img src="images/options.png"></p>
