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
#include <DHT.h>
#include <LowPower.h> //get library from: https://github.com/lowpowerlab/lowpower
                      //writeup here: http://www.rocketscream.com/blog/2011/07/04/lightweight-low-power-arduino-library/
//***** USB port BAUD *****
#define SERIAL_BAUD 9600 //9600 seems to work not really sure what it actually means

//******* LED **************
#define LED 9 // Moteinos have LEDs on D9

//***** RFM69 definitions ********************************
#define NODEID        2    //must be unique for each node on same network (range up to 254, 255 is used for broadcast)
#define NETWORKID     100  //the same on all nodes that talk to each other (range up to 255)
#define GATEWAYID     1
#define FREQUENCY     RF69_915MHZ
#define ENCRYPTKEY    "sampleEncryptKey" //exactly the same 16 characters/bytes on all nodes!
//Auto Transmission Control - dials down transmit power to save battery
//Usually you do not need to always transmit at max output power
//By reducing TX power even a little you save a significanadt amount of battery power
//This setting enables this gateway to work with remote nodes that have ATC enabled to
//dial their power down to only the required level (ATC_RSSI)
#define ENABLE_ATC    //comment out this line to disable AUTO TRANSMISSION CONTROL
#define ATC_RSSI      -80
//***** maybe we want an ACK but I don't think so******//
boolean requestACK = false;
RFM69_ATC radio;

//********** DHT22 definitions ************************
#define DHTTYPE DHT22   // DHT 22
#define NUM_CONNECTED_PINS 1
int SENSOR_PINS[] = {16}; //The digital pins sensors are connected to
// Initialize DHT sensor.
//DHT dht(SENSOR_PINS[0], DHTTYPE);
//DHT DHT_LIST[] = {dht};
//DHT DHT_LIST[] = {dht};
DHT* DHT_LIST[NUM_CONNECTED_PINS];

void setup() {
  //Start serial port
  Serial.begin(SERIAL_BAUD);

  //Start DHT22's
  for (int i = 0; i < NUM_CONNECTED_PINS; i++) {

//    DHT_LIST[i] = DHT(SENSOR_PINS[i], DHTTYPE);
//    DHT_LIST[i].begin();

  }
  
  radio.initialize(FREQUENCY, NODEID, NETWORKID);
  radio.encrypt(ENCRYPTKEY);


  //Auto Transmission Control - dials down transmit power to save battery (-100 is the noise floor, -90 is still pretty good)
  //For indoor nodes that are pretty static and at pretty stable temperatures (like a MotionMote) -90dBm is quite safe
  //For more variable nodes that can expect to move or experience larger temp drifts a lower margin like -70 to -80 would probably be better
  //Always test your ATC mote in the edge cases in your own environment to ensure ATC will perform as you expect
  radio.enableAutoPower(ATC_RSSI);
}

void Blink(byte PIN, int DELAY_MS)
{
  pinMode(PIN, OUTPUT);
  digitalWrite(PIN, HIGH);
  delay(DELAY_MS);
  digitalWrite(PIN, LOW);
}

// Retrieves the voltage in miniVolts, doesn't require additional hardware
long readVcc() {
  // Read 1.1V reference against AVcc
  // set the reference to Vcc and the measurement to the internal 1.1V reference
  ADMUX = _BV(REFS0) | _BV(MUX3) | _BV(MUX2) | _BV(MUX1);

  delay(2); // Wait for Vref to settle
  ADCSRA |= _BV(ADSC); // Start conversion
  while (bit_is_set(ADCSRA, ADSC)); // measuring

  uint8_t low  = ADCL; // must read ADCL first - it then locks ADCH
  uint8_t high = ADCH; // unlocks both

  long result = (high << 8) | low;

  result = 1125300L / result; // Calculate Vcc (in mV); 1125300 = 1.1*1023*1000
  return result; // Vcc in millivolts
}

int i;
void loop() {

  //Read each sensor and send data
  for (i = 0; i < NUM_CONNECTED_PINS; i++) {

    float h = DHT_LIST[i].readHumidity();
    float t = DHT_LIST[i].readTemperature();
    float f = DHT_LIST[i].readTemperature(true);
    long v = readVcc();

    //If failed to read then just skip this pin
    if (isnan(h) || isnan(t) || isnan(f) || isnan(v)) {
      continue;
    }

      /* Send the reading */
    char payload[100];
    char tempFaren[6];
    char humidity[6];

    /* This is necessary for sending float in char[] packet */
    //4 is mininum width, 2 is precision
    dtostrf(f, 4, 2, tempFaren);
    dtostrf(h, 4, 2, humidity);

    sprintf(payload, "{ \"farenheit\" : %s, \"humidity\" : %s, \"sensor ID\" : %d, \"voltage\" : %ld }", tempFaren, humidity,  SENSOR_PINS[i], v);

    Serial.println(payload);


    if (radio.sendWithRetry(GATEWAYID, payload, strlen(payload)))
      Serial.print(" ok!");
    else Serial.print(" nothing...");
      Serial.println();
    Blink(LED, 3);
    
  }

    delay(1000);
    //Power down the radio
//    radio.sleep();
    //Sleep the device for xS
//    LowPower.powerDown(SLEEP_8S, ADC_OFF, BOD_OFF);
}
