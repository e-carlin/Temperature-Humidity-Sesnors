// Sample RFM69 sender/node sketch, with ACK and optional encryption, and Automatic Transmission Control
// Sends periodic messages of increasing length to gateway (id=1)
// It also looks for an onboard FLASH chip, if present
// **********************************************************************************
// Copyright Felix Rusu 2016, http://www.LowPowerLab.com/contact
// **********************************************************************************
// License
// **********************************************************************************
// This program is free software; you can redistribute it 
// and/or modify it under the terms of the GNU General    
// Public License as published by the Free Software       
// Foundation; either version 3 of the License, or        
// (at your option) any later version.                    
//                                                        
// This program is distributed in the hope that it will   
// be useful, but WITHOUT ANY WARRANTY; without even the  
// implied warranty of MERCHANTABILITY or FITNESS FOR A   
// PARTICULAR PURPOSE. See the GNU General Public        
// License for more details.                              
//                                                        
// Licence can be viewed at                               
// http://www.gnu.org/licenses/gpl-3.0.txt
//
// Please maintain this license information along with authorship
// and copyright notices in any redistribution of this code
// **********************************************************************************
#include <RFM69.h>         //get it here: https://www.github.com/lowpowerlab/rfm69
#include <RFM69_ATC.h>     //get it here: https://www.github.com/lowpowerlab/rfm69
#include "DHT.h"

//*********************************************************************************************
//************ IMPORTANT SETTINGS - YOU MUST CHANGE/CONFIGURE TO FIT YOUR HARDWARE ************
//*********************************************************************************************
#define NODEID        2    //must be unique for each node on same network (range up to 254, 255 is used for broadcast)
#define NETWORKID     100  //the same on all nodes that talk to each other (range up to 255)
#define GATEWAYID     1
//Match frequency to the hardware version of the radio on your Moteino (uncomment one):
#define FREQUENCY     RF69_915MHZ
#define ENCRYPTKEY    "sampleEncryptKey" //exactly the same 16 characters/bytes on all nodes!
 //********** DHT Sensor stuff 
#define DHTPIN   4    // what digital pin we're connected to
#define DHTTYPE DHT22   // DHT 22
// Initialize DHT sensor.
// Note that older versions of this library took an optional third parameter to
// tweak the timings for faster processors.  This parameter is no longer needed
// as the current DHT reading algorithm adjusts itself to work on faster procs.
DHT dht(DHTPIN, DHTTYPE);
//**********************
//*********************************************************************************************
//Auto Transmission Control - dials down transmit power to save battery
//Usually you do not need to always transmit at max output power
//By reducing TX power even a little you save a significant amount of battery power
//This setting enables this gateway to work with remote nodes that have ATC enabled to
//dial their power down to only the required level (ATC_RSSI)
#define ENABLE_ATC    //comment out this line to disable AUTO TRANSMISSION CONTROL
#define ATC_RSSI      -80
//*********************************************************************************************

//e-carlin: I think this should be 9600 (atleast for macs)
//#define SERIAL_BAUD   115200
#define SERIAL_BAUD 9600
#define LED           9 // Moteinos have LEDs on D9

char buff[20]; //Do we need this?
//***** maybe we want an ACK but I don't think so******//
boolean requestACK = false;

RFM69_ATC radio;

void setup() {
  Serial.begin(SERIAL_BAUD);
  dht.begin();
  radio.initialize(FREQUENCY,NODEID,NETWORKID);
  radio.encrypt(ENCRYPTKEY);

//Auto Transmission Control - dials down transmit power to save battery (-100 is the noise floor, -90 is still pretty good)
//For indoor nodes that are pretty static and at pretty stable temperatures (like a MotionMote) -90dBm is quite safe
//For more variable nodes that can expect to move or experience larger temp drifts a lower margin like -70 to -80 would probably be better
//Always test your ATC mote in the edge cases in your own environment to ensure ATC will perform as you expect
radio.enableAutoPower(ATC_RSSI);

  char buff[50];
  sprintf(buff, "\nTransmitting at %d Mhz...", FREQUENCY);
  Serial.println(buff);


#ifdef ENABLE_ATC
  Serial.println("RFM69_ATC Enabled (Auto Transmission Control)\n");
#endif
}

void Blink(byte PIN, int DELAY_MS)
{
  pinMode(PIN, OUTPUT);
  digitalWrite(PIN,HIGH);
  delay(DELAY_MS);
  digitalWrite(PIN,LOW);
}

long counter = 0;
void loop() {
  delay(2000);
 
//********* e-carlin our node won't be recieving any packets so no need for this either ***********
  // check for any received packets
  // if (radio.receiveDone())
  // {
  //   Serial.print('[');Serial.print(radio.SENDERID, DEC);Serial.print("] ");
  //   for (byte i = 0; i < radio.DATALEN; i++)
  //     Serial.print((char)radio.DATA[i]);
  //   Serial.print("   [RX_RSSI:");Serial.print(radio.RSSI);Serial.print("]");

  //   if (radio.ACKRequested())
  //   {
  //     radio.sendACK();
  //     Serial.print(" - ACK sent");
  //   }
  //   Blink(LED,3);
  //   Serial.println();
  // }
  //******************************************************************

      Serial.print("Sending packet num ");
      Serial.println(counter);

      // Wait a few seconds between measurements.
  delay(2000);

  // Reading temperature or humidity takes about 250 milliseconds!
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
  float h = dht.readHumidity();
  // Read temperature as Celsius (the default)
  float t = dht.readTemperature();
  // Read temperature as Fahrenheit (isFahrenheit = true)
  float f = dht.readTemperature(true);

  // Check if any reads failed and exit early (to try again).
  if (isnan(h) || isnan(t) || isnan(f)) {
    Serial.println("Failed to read from DHT sensor!");
    return;
  }

  // Compute heat index in Fahrenheit (the default)
  float hif = dht.computeHeatIndex(f, h);
  // Compute heat index in Celsius (isFahreheit = false)
  float hic = dht.computeHeatIndex(t, h, false);

//  Serial.print("Humidity: ");
//  Serial.print(h);
//  Serial.print(" %\t");
//  Serial.print("Temperature: ");
//  Serial.print(t);
//  Serial.print(" *C ");
//  Serial.print(f);
//  Serial.print(" *F\t");
//  Serial.print("Heat index: ");
//  Serial.print(hic);
//  Serial.print(" *C ");
//  Serial.print(hif);
//  Serial.println(" *F");
/*
{
  "pi": 3.141,
  "happy": true,
  "name": "Niels",
  "nothing": null,
  "answer": {
    "everything": 42
  },
  "list": [1, 0, 2],
  "object": {
    "currency": "USD",
    "value": 42.99
  }
}
*/

char payload[100];
char tempFaren[6];
char humidity[6];
/* 4 is mininum width, 2 is precision; float value is copied onto str_temp*/
dtostrf(f, 4, 2, tempFaren);
dtostrf(h, 4, 2, humidity);
sprintf(payload,"{ \"farenheit\" : %s, \"humidity\" : %s }", tempFaren,humidity);
Serial.print("Sending ");
Serial.println(payload);


     if (radio.sendWithRetry(GATEWAYID, payload, strlen(payload)))
       Serial.print(" ok!");
      else Serial.print(" nothing...");
    Serial.println();
    Blink(LED,3);

    counter++;
  }

