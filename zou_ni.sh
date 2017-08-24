#sudo apt-get update
if [ $# != 2 ];then
	echo "run user pass"
	exit
fi
sudo apt-get install -y pptpd
sudo sed 's/#localip 192.168.0/localip 192.168.0/g' -i /etc/pptpd.conf
sudo sed 's/#remoteip 192.168.0/remoteip 192.168.0/g' -i /etc/pptpd.conf
sudo echo "$1 pptpd "$2" *">>/etc/ppp/chap-secrets
sudo service pptpd restart
sudo sed 's/#ms-dns 10.0.0.1/ms-dns 8.8.8.8/g' -i /etc/ppp/pptpd-options
sudo sed 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' -i /etc/sysctl.conf
sudo iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE
sudo sysctl -p
sudo service pptpd restart

echo "now open 1723 and 47 on firewall"
