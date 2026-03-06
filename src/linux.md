# Linux

> the operating system that runs the world.

---

## what is linux

linux is an open source operating system kernel created by Linus Torvalds in 1991. it's the foundation of most servers, android phones, supercomputers, and developer machines.

**kernel** → the core of the OS, manages hardware, memory, processes
**distro** → kernel + software bundle (Ubuntu, Debian, Arch, etc)
**shell** → interface to talk to the kernel (bash, zsh, fish)

---

## linux file system

everything in linux is a file. the file system starts at `/` (root)

```
/
├── bin/       → essential binaries (ls, cp, mv)
├── boot/      → bootloader, kernel
├── dev/       → device files (disks, USB)
├── etc/       → system config files
├── home/      → user home directories
│   └── user/  → your home (~)
├── lib/       → shared libraries
├── media/     → mounted media (USB drives)
├── mnt/       → temporary mounts
├── opt/       → optional software
├── proc/      → virtual filesystem, process info
├── root/      → root user's home
├── run/       → runtime data
├── sbin/      → system binaries (for root)
├── srv/       → service data
├── sys/       → kernel/hardware info
├── tmp/       → temporary files (cleared on reboot)
├── usr/       → user programs and data
│   ├── bin/   → user binaries
│   ├── lib/   → user libraries
│   └── local/ → locally installed software
└── var/       → variable data (logs, databases)
    ├── log/   → system logs
    └── www/   → web server files
```

---

## navigation

```bash
pwd                  # print working directory
ls                   # list files
ls -la               # list all with details
ls -lh               # human readable sizes
cd /path/to/dir      # change directory
cd ~                 # go to home
cd ..                # go up one level
cd -                 # go to previous directory
tree                 # display directory tree
tree -L 2            # limit depth to 2
```

---

## file operations

```bash
# create
touch file.txt           # create empty file
mkdir folder             # create directory
mkdir -p a/b/c           # create nested directories

# copy
cp file.txt backup.txt   # copy file
cp -r folder/ backup/    # copy directory recursively

# move/rename
mv file.txt new.txt      # rename
mv file.txt /path/       # move to directory

# delete
rm file.txt              # delete file
rm -r folder/            # delete directory
rm -rf folder/           # force delete (careful!)
rmdir folder/            # delete empty directory

# view files
cat file.txt             # print file content
less file.txt            # paginated view (q to quit)
more file.txt            # older paginator
head file.txt            # first 10 lines
head -n 20 file.txt      # first 20 lines
tail file.txt            # last 10 lines
tail -f file.txt         # follow file (live logs)
tail -n 50 file.txt      # last 50 lines

# find files
find . -name "*.txt"                    # find by name
find . -type f -name "*.log"            # files only
find . -type d -name "src"             # directories only
find . -mtime -7                        # modified last 7 days
find . -size +100M                      # files over 100MB
find /etc -name "*.conf" 2>/dev/null   # suppress errors

# locate (faster, uses database)
sudo updatedb
locate filename

# which/where
which python3            # path of binary
whereis python3          # all related paths
```

---

## text processing

```bash
# grep - search text
grep "error" file.txt            # search in file
grep -r "error" .                # search recursively
grep -i "error" file.txt         # case insensitive
grep -n "error" file.txt         # show line numbers
grep -v "error" file.txt         # invert (lines NOT matching)
grep -c "error" file.txt         # count matches
grep -E "error|warn" file.txt    # regex (extended)
grep -A 2 "error" file.txt       # 2 lines after match
grep -B 2 "error" file.txt       # 2 lines before match

# sed - stream editor
sed 's/old/new/' file.txt        # replace first occurrence
sed 's/old/new/g' file.txt       # replace all
sed -i 's/old/new/g' file.txt   # edit in place
sed '5d' file.txt                # delete line 5
sed '/pattern/d' file.txt        # delete matching lines
sed -n '5,10p' file.txt          # print lines 5-10

# awk - text processing
awk '{print $1}' file.txt        # print first column
awk '{print $1, $3}' file.txt    # print columns 1 and 3
awk -F: '{print $1}' /etc/passwd # use : as delimiter
awk 'NR==5' file.txt             # print line 5
awk '$3 > 100' file.txt          # filter by column value
awk '{sum += $1} END {print sum}' file.txt  # sum column

# cut
cut -d: -f1 /etc/passwd          # cut by delimiter
cut -c1-10 file.txt              # cut by character position

# sort
sort file.txt                    # alphabetical
sort -n file.txt                 # numerical
sort -r file.txt                 # reverse
sort -u file.txt                 # unique
sort -k2 file.txt                # sort by column 2

# uniq
uniq file.txt                    # remove consecutive duplicates
uniq -c file.txt                 # count occurrences
sort file.txt | uniq             # remove all duplicates

# wc
wc -l file.txt                   # count lines
wc -w file.txt                   # count words
wc -c file.txt                   # count bytes

# tr
echo "hello" | tr 'a-z' 'A-Z'  # uppercase
echo "hello world" | tr -d ' '  # delete spaces

# pipes
cat file.txt | grep "error" | sort | uniq -c | sort -rn
```

---

## permissions

```bash
# view permissions
ls -la
# -rwxr-xr-x  1 user group  4096 Jan 1 file.txt
#  ↑↑↑↑↑↑↑↑↑
#  │││││││││
#  │└──┤└──┤└── other permissions
#  │   └── group permissions
#  └── owner permissions
#  
# r = read (4), w = write (2), x = execute (1)

# chmod - change permissions
chmod 755 file.txt       # rwxr-xr-x
chmod 644 file.txt       # rw-r--r--
chmod 600 file.txt       # rw------- (private)
chmod +x script.sh       # add execute permission
chmod -w file.txt        # remove write permission
chmod -R 755 folder/     # recursive

# common permission numbers
# 777 = rwxrwxrwx (everyone can do everything)
# 755 = rwxr-xr-x (owner full, others read+execute)
# 644 = rw-r--r-- (owner read+write, others read only)
# 600 = rw------- (owner only)
# 700 = rwx------ (owner only, with execute)

# chown - change owner
chown user file.txt
chown user:group file.txt
chown -R user:group folder/

# chgrp - change group
chgrp group file.txt

# special permissions
chmod u+s file       # setuid - run as owner
chmod g+s dir        # setgid - inherit group
chmod +t dir         # sticky bit - only owner can delete
```

---

## processes

```bash
# view processes
ps aux               # all processes
ps aux | grep nginx  # filter processes
top                  # interactive process viewer
htop                 # better interactive viewer
pgrep nginx          # find process by name
pidof nginx          # find PID by name

# manage processes
kill PID             # send SIGTERM (graceful)
kill -9 PID          # send SIGKILL (force)
kill -15 PID         # send SIGTERM explicitly
killall nginx        # kill by name
pkill nginx          # kill by name (pattern)

# background/foreground
command &            # run in background
jobs                 # list background jobs
fg %1                # bring job 1 to foreground
bg %1                # send job 1 to background
ctrl+z               # pause current process
ctrl+c               # kill current process

# process priority
nice -n 10 command   # run with lower priority (10)
renice 10 -p PID     # change priority of running process

# system resource usage
free -h              # memory usage
df -h                # disk space
du -sh folder/       # folder size
du -sh *             # size of all items in current dir
iostat               # disk I/O stats
vmstat               # virtual memory stats
```

---

## users and groups

```bash
# user management
whoami               # current user
id                   # user ID, group info
who                  # logged in users
w                    # who and what they're doing
last                 # login history

useradd username              # create user
useradd -m -s /bin/bash user  # with home dir and bash
passwd username               # set password
usermod -aG group user        # add user to group
userdel username              # delete user
userdel -r username           # delete with home dir

# group management
groupadd groupname
groupdel groupname
groups username               # list user's groups

# sudo
sudo command          # run as root
sudo -i               # root shell
sudo su               # switch to root
su username           # switch to user
visudo                # edit sudoers safely

# /etc/passwd structure
# username:password:UID:GID:comment:home:shell
cat /etc/passwd

# /etc/group structure
# groupname:password:GID:members
cat /etc/group
```

---

## networking

```bash
# view network info
ip addr               # IP addresses (modern)
ip link               # network interfaces
ip route              # routing table
ifconfig              # older way
hostname              # machine hostname
hostname -I           # IP address

# test connectivity
ping google.com              # ping
ping -c 4 google.com         # 4 packets only
traceroute google.com        # trace route
tracepath google.com         # similar to traceroute
mtr google.com               # real-time traceroute

# DNS
nslookup google.com          # DNS lookup
dig google.com               # detailed DNS info
dig google.com MX            # MX records
host google.com              # simple lookup
cat /etc/hosts               # local hostname mapping
cat /etc/resolv.conf         # DNS servers

# ports and connections
ss -tulnp                    # listening ports (modern)
netstat -tulnp               # older way
lsof -i :80                  # what's using port 80
nmap localhost               # port scan local
nmap -p 80,443 example.com   # scan specific ports

# download
curl https://example.com     # fetch URL
curl -O https://example.com/file.zip  # download file
curl -X POST -d '{"key":"val"}' -H "Content-Type: application/json" url
wget https://example.com/file.zip
wget -r https://example.com  # recursive download

# firewall (ufw)
ufw status
ufw enable
ufw disable
ufw allow 80
ufw allow 22/tcp
ufw deny 3306
ufw allow from 192.168.1.0/24
ufw delete allow 80
```

---

## SSH

```bash
# connect
ssh user@host
ssh -p 2222 user@host          # custom port
ssh -i key.pem user@host       # with key file

# key management
ssh-keygen -t ed25519 -C "email"     # generate key
cat ~/.ssh/id_ed25519.pub            # view public key
ssh-copy-id user@host                # copy key to server
ssh-add ~/.ssh/id_ed25519            # add to agent

# config file (~/.ssh/config)
Host myserver
    HostName 192.168.1.100
    User ubuntu
    IdentityFile ~/.ssh/mykey
    Port 22

# then just: ssh myserver

# SCP - secure copy
scp file.txt user@host:/path/        # local to remote
scp user@host:/path/file.txt .       # remote to local
scp -r folder/ user@host:/path/      # directory

# SFTP
sftp user@host
> ls
> get file.txt
> put file.txt
> exit

# SSH tunneling
ssh -L 8080:localhost:80 user@host   # local port forward
ssh -R 8080:localhost:80 user@host   # remote port forward
ssh -D 1080 user@host                # SOCKS proxy
```

---

## package management

```bash
# apt (debian/ubuntu)
sudo apt update              # update package list
sudo apt upgrade             # upgrade all packages
sudo apt install package     # install
sudo apt remove package      # remove
sudo apt purge package       # remove with config files
sudo apt autoremove          # remove unused packages
sudo apt autoclean           # clean package cache
apt search keyword           # search packages
apt show package             # package info
apt list --installed         # list installed

# add ppa
sudo add-apt-repository ppa:user/repo
sudo add-apt-repository --remove ppa:user/repo

# dpkg
dpkg -i package.deb          # install .deb file
dpkg -l                      # list installed
dpkg -r package              # remove
dpkg -s package              # status

# snap
snap install package
snap remove package
snap list

# pip (python)
pip install package
pip install -r requirements.txt
pip list
pip freeze > requirements.txt
pip uninstall package
```

---

## system info

```bash
uname -a             # kernel info
uname -r             # kernel version
lsb_release -a       # distro info
cat /etc/os-release  # OS info
hostnamectl          # system info

# hardware
lscpu                # CPU info
lsmem                # memory info
lspci                # PCI devices
lsusb                # USB devices
lsblk                # block devices (disks)
fdisk -l             # disk partitions
df -h                # disk usage
free -h              # memory usage
sensors              # temperature (lm-sensors)

# logs
journalctl           # systemd logs
journalctl -f        # follow logs
journalctl -u nginx  # logs for specific service
journalctl --since "1 hour ago"
cat /var/log/syslog  # system log
cat /var/log/auth.log # auth log
dmesg                # kernel messages
```

---

## systemd (service management)

```bash
# service control
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
systemctl reload nginx       # reload config without restart
systemctl status nginx
systemctl enable nginx       # start on boot
systemctl disable nginx
systemctl is-active nginx
systemctl is-enabled nginx

# list services
systemctl list-units
systemctl list-units --type=service
systemctl list-units --failed

# create a service
sudo nano /etc/systemd/system/myapp.service

[Unit]
Description=My Application
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/app
ExecStart=/usr/bin/python3 app.py
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl enable myapp
sudo systemctl start myapp
```

---

## environment variables

```bash
# view
env                  # all environment variables
echo $PATH           # specific variable
echo $HOME
echo $USER
echo $SHELL

# set temporarily
export KEY=value
export PATH=$PATH:/new/path

# set permanently (add to ~/.bashrc or ~/.profile)
echo 'export KEY=value' >> ~/.bashrc
source ~/.bashrc

# unset
unset KEY

# important variables
$PATH     → directories to search for binaries
$HOME     → home directory
$USER     → current username
$SHELL    → current shell
$PWD      → current directory
$EDITOR   → default editor
$LANG     → system language
```

---

## shell scripting

```bash
#!/bin/bash

# variables
NAME="abhishek"
echo "hello $NAME"

# input
read -p "enter your name: " name
echo "hello $name"

# if/else
if [ "$name" = "abhishek" ]; then
    echo "welcome"
elif [ "$name" = "other" ]; then
    echo "hello other"
else
    echo "who are you?"
fi

# numeric comparison
if [ $age -gt 18 ]; then echo "adult"; fi
# -eq equal, -ne not equal
# -gt greater than, -lt less than
# -ge greater or equal, -le less or equal

# file checks
if [ -f "file.txt" ]; then echo "file exists"; fi
if [ -d "folder" ]; then echo "directory exists"; fi
if [ -r "file" ]; then echo "readable"; fi
if [ -w "file" ]; then echo "writable"; fi
if [ -x "file" ]; then echo "executable"; fi
if [ -s "file" ]; then echo "not empty"; fi

# loops
for i in 1 2 3 4 5; do
    echo $i
done

for file in *.txt; do
    echo "processing $file"
done

while [ $count -lt 10 ]; do
    echo $count
    ((count++))
done

# functions
greet() {
    local name=$1
    echo "hello $name"
}
greet "abhishek"

# exit codes
command && echo "success" || echo "failed"
if [ $? -eq 0 ]; then echo "success"; fi

# arrays
arr=(one two three)
echo ${arr[0]}       # one
echo ${arr[@]}       # all elements
echo ${#arr[@]}      # length

# string operations
str="hello world"
echo ${#str}         # length
echo ${str:0:5}      # substring
echo ${str/world/there}  # replace

# redirect
command > file.txt    # stdout to file
command >> file.txt   # append stdout
command 2> error.txt  # stderr to file
command &> all.txt    # both to file
command < input.txt   # stdin from file
command 2>/dev/null   # discard errors
```

---

## cron jobs

```bash
# edit crontab
crontab -e

# crontab syntax
# minute hour day month weekday command
# 0-59   0-23 1-31 1-12  0-7

# examples
0 * * * * command          # every hour
0 0 * * * command          # every midnight
0 0 * * 0 command          # every sunday midnight
*/5 * * * * command        # every 5 minutes
0 9 * * 1-5 command        # weekdays at 9am
0 0 1 * * command          # first of month

# special strings
@reboot command            # on startup
@daily command             # once a day
@weekly command            # once a week
@monthly command           # once a month

# list crontabs
crontab -l

# remove
crontab -r
```

---

## disk management

```bash
# view disks
lsblk                # list block devices
fdisk -l             # list partitions
df -h                # disk space usage
du -sh /path/        # directory size
du -sh * | sort -h   # sorted sizes

# mount
mount /dev/sdb1 /mnt/usb
umount /mnt/usb

# /etc/fstab - auto mount on boot
# device  mountpoint  fstype  options  dump  pass

# check filesystem
fsck /dev/sda1       # check and repair
e2fsck /dev/sda1     # for ext filesystems

# format
mkfs.ext4 /dev/sdb1  # format as ext4
mkfs.vfat /dev/sdb1  # format as FAT32
```

---

## compression

```bash
# tar
tar -czf archive.tar.gz folder/      # create compressed
tar -xzf archive.tar.gz              # extract
tar -xzf archive.tar.gz -C /path/   # extract to path
tar -tzf archive.tar.gz             # list contents
tar -czf - folder/ | ssh user@host 'cat > archive.tar.gz'

# options: c=create x=extract z=gzip j=bzip2 f=file v=verbose

# zip/unzip
zip -r archive.zip folder/
zip archive.zip file1 file2
unzip archive.zip
unzip archive.zip -d /path/
unzip -l archive.zip              # list contents

# gzip
gzip file.txt                     # compress (replaces original)
gzip -d file.txt.gz               # decompress
gunzip file.txt.gz                # same as above
gzip -k file.txt                  # keep original
```

---

## security basics

```bash
# check open ports
ss -tulnp
nmap -sV localhost

# check who's logged in
who
w
last
lastb                # failed logins

# check sudo access
sudo -l

# fail2ban (block brute force)
sudo apt install fail2ban
sudo systemctl enable fail2ban

# ufw firewall
ufw enable
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 80/tcp
ufw allow 443/tcp
ufw status verbose

# file integrity
md5sum file.txt
sha256sum file.txt

# check running services
systemctl list-units --type=service --state=running

# audit log
ausearch -m login     # search audit logs
```

---

## performance tuning

```bash
# monitor
top                  # process monitor
htop                 # better process monitor
iotop                # disk I/O monitor
nethogs              # per-process bandwidth
iftop                # network bandwidth
glances              # all-in-one monitor

# load average
uptime               # 1, 5, 15 min averages
# load average 1.0 on single core = 100% CPU

# memory
free -h
vmstat 1             # every second
cat /proc/meminfo

# disk
iostat -x 1          # disk stats every second
iotop                # per-process disk I/O

# optimize
swapoff -a           # disable swap (if enough RAM)
echo 1 > /proc/sys/vm/drop_caches  # clear cache
ulimit -n 65535      # increase open file limit
```

---

```
=^._.^= learn linux by using linux
```
