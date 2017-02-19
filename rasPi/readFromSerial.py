#!/usr/bin/python

# A simple script to read incoming data from a usb port
# and print it to the console

import serial, time, requests, json
from datetime import datetime
#initialization and open the port

#possible timeout values:
#    1. None: wait forever, block call
#    2. 0: non-blocking mode, return immediately
#    3. x, x is bigger than 0, float allowed, timeout block call

ser = serial.Serial()
# This port will be different of different machines check correct port with
# $ python -m serial.tools.list_ports
ser.port = "/dev/cu.usbserial-DN01Q8E0" #For mini-USB cable
#ser.port = "/dev/cu.usbserial-A5058SOW" #For FTDI cable
# ser.port = "/dev/ttyUSB0" #For raspi mini-usb cable
ser.baudrate = 9600
ser.bytesize = serial.EIGHTBITS #number of bits per bytes
ser.parity = serial.PARITY_NONE #set parity check: no parity
ser.stopbits = serial.STOPBITS_ONE #number of stop bits
# ser.timeout = None          #block read
ser.timeout = 1            #non-block read
#ser.timeout = 2              #timeout block read
ser.xonxoff = False     #disable software flow control
ser.rtscts = False     #disable hardware (RTS/CTS) flow control
ser.dsrdtr = False       #disable hardware (DSR/DTR) flow control

try: 
    print("Opening serial port and waiting for data")
    ser.open()
except Exception, e:
    print "error open serial port: " + str(e)
    exit()

if ser.isOpen():

    try:
        ser.flushInput() #flush input buffer, discarding all its contents
        ser.flushOutput()#flush output buffer, aborting current output and discard all that is in buffer
        time.sleep(0.5)  #give the serial port sometime to receive the data

        

        numOfLines = 0

        while True:
            response = ser.readline()
            #Only print responses with an actual message in them
            if response != "":
                #TODO: Strip \n from response
                dateString = '%Y/%m/%d %H:%M:%S'
                dateString = str(datetime.now())
                response = response.rstrip()
                response += " \"timeStamp\"  : \"" + dateString + "\"}"
                print(response)
                j = json.loads(response)
                if(j["sID"] == 19):
                    print("\n")
                # r = requests.post('http://ec2-54-202-217-172.us-west-2.compute.amazonaws.com/api/v1/readings',
                #     headers = {'Content-type': 'application/json'}, 
                #     data = json.dumps(j))
                # r = requests.post('http://localhost:3000/api/v1/readings',
                #     headers = {'Content-type': 'application/json'}, 
                #     data = json.dumps(j))
                # print r
                # print r.content


            
    except Exception, e1:
        print "error communicating...: " + str(e1)
        ser.close()

else:
    print "cannot open serial port "

ser.close()



