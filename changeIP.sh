#!/bin/bash
#设置环境变量
python /root/getIP.py
source /etc/profile
newIP=`sed -n 1p /root/newip.txt`
old_IP=`sed -n 1p /root/oldip.txt`
#多ip的情况下排除不解析的ip
if [[ ${newIP} != ${old_IP} ]] && [[ -n ${newIP} ]] && [[ ${newIP} != "117.173.87.60" ]]
then
    #RecordId 需要自己去定义
    python ali.py -u http://alidns.aliyuncs.com Action=UpdateDomainRecord RecordId=XXXXXXXXXXXX RR=chd Type=A Value=${newIP} |xargs curl >> /root/dns_log.log
	echo -e >> dns_log.log
    python ali.py -u http://alidns.aliyuncs.com Action=UpdateDomainRecord RecordId=XXXXXXXXXXXX RR=ftp Type=A Value=${newIP}|xargs curl >> /root/dns_log.log
	echo -e `date` >> /root/dns_log.log
    echo ${newIP} > /root/oldip.txt
else
	echo `date` 'IP No Change: ' ${old_IP} >> /root/ip_logs.log
fi