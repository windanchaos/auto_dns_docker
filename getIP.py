from urllib2 import urlopen

new_ip = urlopen('http://ip.42.pl/raw').read()
f = open('/root/oldip.txt', 'r')
old_ip_line=f.readlines()
f.close()
for ip in old_ip_line:
    old_ip=ip
if new_ip != old_ip:
    f = open('/root/newip.txt', 'w')
    f.write(new_ip)
    f.flush()
    f.close()
