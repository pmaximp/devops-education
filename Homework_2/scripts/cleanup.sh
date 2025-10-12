#!/bin/bash

echo "### Cleaning up system... ###"

sudo apt-get autoremove -y
sudo apt-get clean -y

sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /var/tmp/*
sudo rm -rf /tmp/*

sudo rm -f /root/.bash_history
sudo rm -f /home/*/.bash_history

echo "### Cleanup completed ###"
