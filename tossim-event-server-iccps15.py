#!/usr/bin/env python
from TOSSIM import Tossim
from random import *
from TestNetworkMsg import *
import sys
import socket
import os
import time

enable_main=1;
if enable_main:
	def main():
		rssi_level=sys.argv[1]
		return {'y0':rssi_level}
	rssi_level=int(main()['y0'])
else:
	rssi_level=-20;
t = Tossim([])
t.addChannel('printf', sys.stdout)
t.addChannel("DataFeedback", sys.stdout)

r = t.radio()
L=list()
for channel_1 in [22, 23, 24, 25, 26]:
	channel=channel_1
	rssi_strength=rssi_level
	neignbour_strength=-20;
	sync_rssi_strength=-10	
	for sender in [181, 153, 152, 155, 154, 170, 171, 162, 172, 160, 163, 173, 161, 169, 157, 180, 182, 253, 252, 255, 254, 175, 108]:
		for receiver in [181, 153, 152, 155, 154, 170, 171, 162, 172, 160, 163, 173, 161, 169, 157, 180, 182, 253, 252, 255, 254, 175, 108]:
			r.add(sender, receiver, neignbour_strength, channel_1)
	r.add(181, 170, rssi_strength, channel_1)
	r.add(170, 181, rssi_strength, channel_1)
	r.add(181, 171, rssi_strength, channel_1)
	r.add(171, 181, rssi_strength, channel_1)
	
	r.add(153, 170, rssi_strength, channel_1)
	r.add(170, 153, rssi_strength, channel_1)
	r.add(153, 171, rssi_strength, channel_1)
	r.add(171, 153, rssi_strength, channel_1)
	
	r.add(152, 171, rssi_strength, channel_1)
	r.add(171, 152, rssi_strength, channel_1)
	r.add(152, 162, rssi_strength, channel_1)
	r.add(162, 152, rssi_strength, channel_1)
	
	r.add(155, 162, rssi_strength, channel_1)
	r.add(162, 155, rssi_strength, channel_1)
	r.add(155, 172, rssi_strength, channel_1)
	r.add(172, 155, rssi_strength, channel_1)
	
	r.add(154, 162, rssi_strength, channel_1)
	r.add(162, 154, rssi_strength, channel_1)
	r.add(154, 172, rssi_strength, channel_1)
	r.add(172, 154, rssi_strength, channel_1)
	
	r.add(170, 160, rssi_strength, channel_1)
	r.add(160, 179, rssi_strength, channel_1)
	r.add(170, 163, rssi_strength, channel_1)
	r.add(163, 170, rssi_strength, channel_1)

	r.add(170, 160, rssi_strength, channel_1)
	r.add(160, 179, rssi_strength, channel_1)
	r.add(170, 163, rssi_strength, channel_1)
	r.add(163, 170, rssi_strength, channel_1)
	
	r.add(171, 160, rssi_strength, channel_1)
	r.add(160, 171, rssi_strength, channel_1)
	r.add(171, 163, rssi_strength, channel_1)
	r.add(163, 171, rssi_strength, channel_1)
	
	r.add(162, 163, rssi_strength, channel_1)
	r.add(163, 162, rssi_strength, channel_1)
	r.add(162, 173, rssi_strength, channel_1)
	r.add(173, 162, rssi_strength, channel_1)	
	
	r.add(160, 161, rssi_strength, channel_1)
	r.add(161, 160, rssi_strength, channel_1)
	r.add(160, 169, rssi_strength, channel_1)
	r.add(169, 160, rssi_strength, channel_1)
	
	r.add(163, 161, rssi_strength, channel_1)
	r.add(161, 163, rssi_strength, channel_1)
	r.add(163, 169, rssi_strength, channel_1)
	r.add(169, 163, rssi_strength, channel_1)
	
	r.add(172, 173, rssi_strength, channel_1)
	r.add(173, 172, rssi_strength, channel_1)
	r.add(172, 163, rssi_strength, channel_1)
	r.add(163, 172, rssi_strength, channel_1)
	
	r.add(173, 161, rssi_strength, channel_1)
	r.add(161, 173, rssi_strength, channel_1)
	r.add(173, 169, rssi_strength, channel_1)
	r.add(169, 173, rssi_strength, channel_1)
	
	r.add(170, 157, rssi_strength, channel_1)
	r.add(157, 170, rssi_strength, channel_1)
	r.add(171, 157, rssi_strength, channel_1)
	r.add(157, 171, rssi_strength, channel_1)
	
	r.add(162, 180, rssi_strength, channel_1)
	r.add(180, 162, rssi_strength, channel_1)
	r.add(172, 180, rssi_strength, channel_1)
	r.add(180, 172, rssi_strength, channel_1)

	r.add(170, 175, rssi_strength, channel_1)
	r.add(175, 170, rssi_strength, channel_1)
	r.add(171, 175, rssi_strength, channel_1)
	r.add(175, 171, rssi_strength, channel_1)
	
	r.add(162, 108, rssi_strength, channel_1)
	r.add(108, 162, rssi_strength, channel_1)
	r.add(172, 108, rssi_strength, channel_1)
	r.add(108, 172, rssi_strength, channel_1)

	r.add(182, 170, rssi_strength, channel_1)
	r.add(170, 182, rssi_strength, channel_1)
	r.add(182, 171, rssi_strength, channel_1)
	r.add(171, 182, rssi_strength, channel_1)
	
	r.add(253, 170, rssi_strength, channel_1)
	r.add(170, 253, rssi_strength, channel_1)
	r.add(253, 171, rssi_strength, channel_1)
	r.add(171, 253, rssi_strength, channel_1)
	
	r.add(252, 171, rssi_strength, channel_1)
	r.add(171, 252, rssi_strength, channel_1)
	r.add(252, 162, rssi_strength, channel_1)
	r.add(162, 252, rssi_strength, channel_1)
	
	r.add(255, 162, rssi_strength, channel_1)
	r.add(162, 255, rssi_strength, channel_1)
	r.add(255, 172, rssi_strength, channel_1)
	r.add(172, 255, rssi_strength, channel_1)

	r.add(254, 162, rssi_strength, channel_1)
	r.add(162, 254, rssi_strength, channel_1)
	r.add(254, 172, rssi_strength, channel_1)
	r.add(172, 254, rssi_strength, channel_1)
	
	for sensor in [181, 153, 152, 155, 154, 170, 171, 162, 172, 160, 163, 173, 161, 169, 157, 180, 182, 253, 252, 255, 254, 175, 108]:
		r.add(sensor, 0, sync_rssi_strength, channel_1)
		r.add(0, sensor, sync_rssi_strength, channel_1)


for node in [0, 181, 153, 152, 155, 154, 170, 171, 162, 172, 160, 163, 173, 161, 169, 157, 180, 182, 253, 252, 255, 254, 175, 108]:
	m = t.getNode(node);
	for channel in [22, 23, 24, 25, 26]:
		if channel==22:
			noise = open("noise_chan22_110.txt", "r")
			lines = noise.readlines()
		elif channel==23:
			noise = open("noise_chan23_110.txt", "r")
			lines = noise.readlines()
		elif channel==24:
			noise = open("noise_chan24_110.txt", "r")
			lines = noise.readlines()
		elif channel==25:
			noise = open("noise_chan25_110.txt", "r")
			lines = noise.readlines()
		elif channel==26:
			noise = open("noise_chan26_110.txt", "r")
			lines = noise.readlines()
		for line in lines:
			strrr = line.strip()
			if (strrr != ""):
				val = int(strrr)
				m.addNoiseTraceReading(val, channel)
		m.createNoiseModel(channel);
	m.turnOn()
	m.bootAtTime(0)
	#print "Booting ", node, " at time ", str(0)

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_address = ('localhost', 10032)
print >>sys.stderr, 'starting up on %s port %s' % server_address
sock.bind(server_address)
sock.listen(1)

#while (t.time() <= 97656250): # slot 0 for synchronization (not the focus of contribution for iccps15 though), the rest for real simulation
#	t.runNextEvent()

run_count = 1;
#flag bit for all 14 flows: 8 emergency flows + 2 regular flows + 4 actuation flows, 0 means not received.

while True:
    connection, client_address = sock.accept()
    try:
        #print >>sys.stderr, 'Client call, No.', run_count
        while True:
            data = connection.recv(30)
            if data:
            	emergency_input = [int(x) for x in str(data).split(',')]
            	#eme_L1H_181 + ',' + eme_LRL_153 + ','+ eme_LRH_152 + ','+ eme_L2H_155 + ',' + eme_L1H_182 + ',' + eme_LRL_253 + ',' + eme_LRH_252 + ',' + eme_L2H_255;
            	
            	if run_count % 49 == 0:
            		m = t.getNode(181);
            		m.enableIdle();
            	
            	#print emergency_input
            	if emergency_input[0] == 0:
            		m = t.getNode(181);
            		m.enableIdle(); #enable idle and sensor 181 will skip all send commands to emulate "emergency not existing"
            	else:
            		m = t.getNode(181);	
            		m.disableIdle();
            	
            	if emergency_input[1] == 0:
            		m = t.getNode(153);
            		m.enableIdle(); #disable idle, and sensor 181 can conduct any send commands
            	else:
            		m = t.getNode(153);	
            		m.disableIdle();
            	
            	if emergency_input[2] == 0:
            		m = t.getNode(152);
            		m.enableIdle();
            	else:
            		m = t.getNode(152);	
            		m.disableIdle();
            	
            	if emergency_input[3] == 0:
            		m = t.getNode(155);
            		m.enableIdle();
            	else:
            		m = t.getNode(155);	
            		m.disableIdle();
            	
            	if emergency_input[4] == 0:
            		m = t.getNode(182);
            		m.enableIdle();
            	else:
            		m = t.getNode(182);	
            		m.disableIdle();
            	
            	if emergency_input[5] == 0:
            		m = t.getNode(253);
            		m.enableIdle();
            	else:
            		m = t.getNode(253);	
            		m.disableIdle();
            	
            	if emergency_input[6] == 0:
            		m = t.getNode(252);
            		m.enableIdle();
            	else:
            		m = t.getNode(252);	
            		m.disableIdle();
            	
            	if emergency_input[7] == 0:
            		m = t.getNode(255);
            		m.enableIdle();
            	else:
            		m = t.getNode(255);	
            		m.disableIdle();
       		            		
            	rcvedlist = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            	while (t.time() <= 97656250*run_count): # here the 100000000 represents 10ms
            		rcved = t.runNextEvent()
            		if rcved == 2:
            			rcvedlist[0] = 1; # flow 1 has been received through the WSN
            		elif rcved == 4:
            			rcvedlist[1] = 1; # flow 2 has been received through the WSN
            		elif rcved == 8:
            			rcvedlist[2] = 1;
            		elif rcved == 16:
            			rcvedlist[3] = 1;
            		elif rcved == 32:
            			rcvedlist[4] = 1;
            		elif rcved == 64:
            			rcvedlist[5] = 1;
            		elif rcved == 128:
            			rcvedlist[6] = 1;
            		elif rcved == 256:
            			rcvedlist[7] = 1;
            		elif rcved == 512:
            			rcvedlist[8] = 1;
            		elif rcved == 1024:
            			rcvedlist[9] = 1;
            		elif rcved == 2048:
            			rcvedlist[10] = 1;
            		elif rcved == 4096:
            			rcvedlist[11] = 1;
            		elif rcved == 8192:
            			rcvedlist[12] = 1;
            		elif rcved == 16384:
            			rcvedlist[13] = 1; # flow 14 has been received through the WSN
        		#print rcvedlist
            	run_count = run_count + 1;
            	reception = str(rcvedlist[0]) + ',' + str(rcvedlist[1]) + ',' + str(rcvedlist[2]) + ',' + str(rcvedlist[3]) + \
            	',' + str(rcvedlist[4]) + ',' + str(rcvedlist[5]) + ',' + str(rcvedlist[6]) + ',' + str(rcvedlist[7]) + \
            	',' + str(rcvedlist[8]) + ',' + str(rcvedlist[9]) + ',' + str(rcvedlist[10]) + ',' + str(rcvedlist[11]) + \
            	',' + str(rcvedlist[12]) + ',' + str(rcvedlist[13]);
            	#print reception
            	connection.sendall(reception)
            else:
            	break
    finally:
        connection.close()