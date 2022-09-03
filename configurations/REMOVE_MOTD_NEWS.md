# Remove MOTD News

Useful [forum post](https://askubuntu.com/questions/1252659/why-does-my-ssh-login-include-what-looks-like-a-promotion-for-a-techrepublic-art).

Essentially just enter root and run `sudo sed -i -e 's/ENABLED=1/ENABLED=0/' /etc/default/motd-news`