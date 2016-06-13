#!/usr/bin/env python
from TOSSIM import Tossim
from random import *
from TestNetworkMsg import *
import sys
import socket

enable_main=0;
if enable_main:
	def main():
		rssi_level=sys.argv[1]
		emergency_sensor_181=sys.argv[2]
		emergency_sensor_153=sys.argv[3]
		emergency_sensor_152=sys.argv[4]
		emergency_sensor_155=sys.argv[5]
		return {'y0':rssi_level, 'y1':emergency_sensor_181, 'y2':emergency_sensor_153, 'y3':emergency_sensor_152, 'y4':emergency_sensor_155}
	rssi_level=int(main()['y0'])
	emergency_L1H_181=main()['y1']
	emergency_LRL_153=main()['y2']
	emergency_LRH_152=main()['y3']
	emergency_L2H_155=main()['y4']
	
	emergency_L1H_181= '1'; #In PS, emergency always exists, indicated by '1'.
	emergency_LRL_153= '1';
	emergency_LRH_152= '1';
	emergency_L2H_155= '1';
	emergency_L1H_182= '1';
	emergency_LRL_253= '1';
	emergency_LRH_252= '1';
	emergency_L2H_255= '1';
else:
	rssi_level=-20;
	emergency_L1H_181 = '1'; # emergency flow 1 for tank 1
	emergency_LRL_153 = '1';
	emergency_LRH_152 = '1';
	emergency_L2H_155 = '1';
	
	emergency_L1H_182 = '1'; # emergency flow 1 for tank 2
	emergency_LRL_253 = '1';
	emergency_LRH_252 = '1';
	emergency_L2H_255 = '1';

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_address = ('localhost', 10031)
sock.connect(server_address)
try:
	message  = emergency_L1H_181 + ',' + emergency_LRL_153 + ','+ emergency_LRH_152 + ','+ emergency_L2H_155 + ',' + emergency_L1H_182 + ',' + emergency_LRL_253 + ',' + emergency_LRH_252 + ',' + emergency_L2H_255;
	#message  = '0, 0, 0, 0, 0, 0, 0, 0'
	sock.sendall(message)
	amount_received = 0	
	amount_expected = len(message)
	while amount_received < amount_expected:
		data = sock.recv(90)
		if data:
			amount_received += len(data)
			#print >>sys.stderr, 'received "%s"' % data
			print data
finally:
    sock.close()


