#!/usr/bin/env python
from TOSSIM import Tossim
from random import *
from TestNetworkMsg import *
import sys
import socket

enable_main=1;
if enable_main:
	def main():
		rssi_level=sys.argv[1]
		eme_181=sys.argv[2]
		eme_153=sys.argv[3]
		eme_152=sys.argv[4]
		eme_155=sys.argv[5]
		eme_182=sys.argv[6]
		eme_253=sys.argv[7]
		eme_252=sys.argv[8]
		eme_255=sys.argv[9]
		return {'y0':rssi_level, 'y1':eme_181, 'y2':eme_153, 'y3':eme_152, 'y4':eme_155, 'y5':eme_182, 'y6':eme_253, 'y7':eme_252, 'y8':eme_255}
		rssi_level=int(main()['y0'])
	eme_L1H_181=main()['y1'] #In Slot Stealing, emergency status is '1' if the emergency exists, '0' otherwise.
	eme_LRL_153=main()['y2']
	eme_LRH_152=main()['y3']
	eme_L2H_155=main()['y4']
	eme_L1H_182=main()['y5']
	eme_LRL_253=main()['y6']
	eme_LRH_252=main()['y7']
	eme_L2H_255=main()['y8']

else:
	rssi_level=-20;
	eme_L1H_181 = '1'; # emergency flow 1 for tank 1
	eme_LRL_153 = '1';
	eme_LRH_152 = '1';
	eme_L2H_155 = '1';
	eme_L1H_182 = '1'; # emergency flow 1 for tank 2
	eme_LRL_253 = '1';
	eme_LRH_252 = '1';
	eme_L2H_255 = '1';

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_address = ('localhost', 10032)
sock.connect(server_address)
try:
	message  = eme_L1H_181 + ',' + eme_LRL_153 + ','+ eme_LRH_152 + ','+ eme_L2H_155 + ',' + eme_L1H_182 + ',' + eme_LRL_253 + ',' + eme_LRH_252 + ',' + eme_L2H_255;
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