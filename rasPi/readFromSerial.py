#!/usr/bin/python

# A simple script to read incoming data from a usb port
# and print it to the console
import pytz # sudo easy_install --upgrade pytz
import serial, time, requests, json
from datetime import datetime
#initialization and open the port

#possible timeout values:
#    1. None: wait forever, block call
#    2. 0: non-blocking mode, return immediately
#    3. x, x is bigger than 0, float allowed, timeout block call

#Assign a URL variable for cleanliness
# url = 'http://ec2-54-202-217-172.us-west-2.compute.amazonaws.com/api/v1/readings'
# url = 'http://localhost:3000/api/v1/readings'
url = 'http://lelooska.org/sensors/api/v1/readings'

ser = serial.Serial()
# This port will be different of different machines check correct port with
# $ python -m serial.tools.list_ports
# ser.port = "/dev/cu.usbserial-DN01Q8E0" #For mini-USB cable
# ser.port = "/dev/cu.usbserial-A5058SOW" #For FTDI cable
# ser.port = "/dev/ttyUSB0" #For raspi mini-usb cable
ser.port = "/dev/moteino" #There is a symlink in /etc/udev/rules.d/99-usb-serial.rules that looks for the Moteino product info and creates this symlink
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


#Try to open the serial port
while not ser.isOpen():
    try: 
        ser.open()
    except IOError, e:
        print "'message' : 'Problem opening serial port' \n 'error' : " + str(e)
        time.sleep(1) #Sleep for one second 
        continue

#The serial port is open
if ser.isOpen():
    print "Serial port is open. Waiting for data..."
    while True: #We caught an error. We assume it won't happen next time so just naively try the same code again
        try:
            ser.flushInput() #flush input buffer, discarding all its contents
            ser.flushOutput()#flush output buffer, aborting current output and discard all that is in buffer
            # time.sleep(0.5)  #give the serial port sometime to receive the data

            #**** This is the main loop ****
            #Loop around waiting for input data and sending it to the web
            while True:
                #Read in input from USB port (the gateway moteino is attached via USB)
                response = ser.readline()

                #Only print responses with an actual message in them
                if response != "":
                    #Set up a properly formatted timesatmp
                    dateString = '%Y/%m/%d %H:%M:%S'
                    dateString = str(datetime.now(pytz.timezone('US/Pacific')))
                    response = response.rstrip()

                    response += " \"timeStamp\"  : \"" + dateString + "\"}"
                    j = json.loads(response)
                    #Send the response to the web
                    r = requests.post(url,
                        headers={'Authorization' : 'rasPiAuth..0246', 'Content-type': 'application/json'},
                        data = json.dumps(j))
                    #Print the results for testing purposes
                    #TODO: Remove
                    print r
                    print r.content

        #We caught an error somewhere in reading from USB and posting to web
        except Exception, e:
            print "We caught an error! : " + str(e)
            try: 
                #Try to post the error to the website for easy to view logging
                r = requests.post(url,
                headers={'Authorization' : 'rasPiAuth..0246', 'Content-type': 'application/json'}, 
                data = {'error': str(e)})
                print r
                print r.content
                #Go to the start of the loop and try again
                continue

            #There was an error trying to POST the error message so don't post this time
            except Exception, e:
                print "'message' : 'Caught an error trying to POST another error to website,\n 'error' : "+str(e)
                #Go back to start of reading in loop
                continue

ser.close()



