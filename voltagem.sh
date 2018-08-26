#!/bin/bash
#
CHAVE=keydweet.io
IP=seuipzabbixproxy
#
DATA=$(date)
#
TEMP1=$(/root/mede.py | grep = | awk -F "==" '{print $2}')
TEMP2=$(echo $TEMP1 | sed $'s/[^[:print:]\t]//g')
TEMP3=$(/root/mede.py | grep = | awk -F "==" '{print $2}')
TEMP4=$(echo $TEMP3 | sed $'s/[^[:print:]\t]//g')
#
TEMP5=$(/root/mede.py | grep = | awk -F "==" '{print $3}')
TEMP6=$(echo $TEMP5 | sed $'s/[^[:print:]\t]//g')
TEMP7=$(/root/mede.py | grep = | awk -F "==" '{print $3}')
TEMP8=$(echo $TEMP7 | sed $'s/[^[:print:]\t]//g')
#
TEMPCHUMBO=$(echo "scale=2;(($TEMP4+$TEMP2)/2)" | bc)
TEMPLITIO=$(echo "scale=2;(($TEMP8+$TEMP6)/2)" | bc)
#
TEMPCHUMBOx=$(echo "scale=0;(($TEMP4+$TEMP2)/2)" | bc)
TEMPLITIOx=$(echo "scale=0;(($TEMP4+$TEMP2)/2)" | bc)
#
a=20
b=35
#
if [ $TEMPCHUMBOx -lt $a ]
then
   echo 'TEMPCHUMBO é menor que 20!'
elif [ $TEMPCHUMBOx -gt $b ]
then
   echo 'TEMPCHUMBO é maior que 35!'
else
	/usr/bin/zabbix_sender -z $IP -p 10051 -s NETBOOK -k bateria.chumbo -o $TEMPCHUMBO
	echo $TEMPCHUMBO > /tmp/voltagemchumbo.txt
fi

if [ $TEMPLITIOx -lt $a ]
then
   echo 'TEMPLITIO é menor que 20!'
elif [ $TEMPLITIOx -gt $b ]
then
   echo 'TEMPLITIO é maior que 35!'
else
	/usr/bin/zabbix_sender -z $IP -p 10051 -s NETBOOK -k bateria.litio -o $TEMPLITIO
	echo $TEMPLITIO > /tmp/voltagemlitio.txt
fi


echo $DATA - CHUMBO: $TEMPCHUMBO - LITIO: $TEMPLITIO >> /root/medicoes.txt
echo $DATA - CHUMBO: $TEMPCHUMBO - LITIO: $TEMPLITIO
#
chmod 777 /tmp/voltagem*.txt
#cp /var/www/html/index1.html /var/www/html/indexok.html
#sed -i "s/DATA/$DATA/" /var/www/html/indexok.html
#sed -i "s/VOLTAGEMLITIO/$TEMPLITIO/" /var/www/html/indexok.html
#sed -i "s/VOLTAGEMCHUMBO/$TEMPCHUMBO/" /var/www/html/indexok.html
#cp /var/www/html/indexok.html /var/www/html/index.html
wget "https://dweet.io/dweet/for/$CHAVE?vlitiototal=$TEMPLITIO&vchumbototal=$TEMPCHUMBO -O /dev/null"
