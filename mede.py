#!/usr/bin/python

import time
import serial
 
# Iniciando conexao serial
comport = serial.Serial('/dev/ttyACM0', 9600, timeout=10)
# comport = serial.Serial('/dev/arduino', 9600, timeout=1) # Setando timeout 1s para a conexao

PARAM_CARACTER='t'
PARAM_ASCII=str(chr(116))       # Equivalente 116 = t

# Time entre a conexao serial e o tempo para escrever (enviar algo)
time.sleep(2) # Entre 1.5s a 2s

#comport.write(PARAM_CARACTER)
comport.write(PARAM_ASCII)

VALUE_SERIAL=comport.readline()

print '%s' % (VALUE_SERIAL)

# Fechando conexao serial
comport.close()
