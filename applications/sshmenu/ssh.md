setting up sshmenu

apt install fzf 

# create a file: ~/.ssh/servers.txt
    template: servername user@ip-address

# create a script in /etc/sshmenu/sshmenu.sh and make it execuatable


# create symlink
sudo ln -s /etc/sshmenu/sshmenu.sh /usr/local/bin/sshmenu
