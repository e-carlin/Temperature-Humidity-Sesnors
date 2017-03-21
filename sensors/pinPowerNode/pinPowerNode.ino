// **********************************************************************************
// Copyright Felix Rusu 2016, http://www.LowPowerLab.com/contact
// Modified by Evan Carlin, https://github.com/e-carlin/museum_monitoring_sensors
// **********************************************************************************
// License
// **********************************************************************************
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
//#define SERIAL_BAUD 9600 //Just for testing. 9600 seems to work, not really sure what it actually means

//******* LED **************
#define LED 9 // Moteinos have LEDs on D9

//***** RFM69 definitions ********************************
#define NODEID        4    //must be unique for each node on same network (range up to 254, 255 is used for broadcast)
#define NETWORKID     100  //Don't change this. The same on all nodes that talk to each other (range up to 255)
#define GATEWAYID     1 //Don't change this. Same for all nodes in the network
#define FREQUENCY     RF69_915MHZ
#define ENCRYPTKEY    "sampleEncryptKey" //exactly the same 16 characters/bytes on all nodes!
#define MAX_PACKET_SIZE 61 //The maximum number of bytes in a packet
//Auto Transmission Control - dials down transmit power to save battery
//Usually you do not need to always transmit at max output power
//By reducing TX power even a little you save a significanadt amount of battery power
//This setting enables this gateway to work with remote nodes that have ATC enabled to
//dial their power down to only the required level (ATC_RSSI)
#define ENABLE_ATC    //comment out this line to disable AUTO TRANSMISSION CONTROL
#define ATC_RSSI      -80
RFM69_ATC radio;

//********** DHT22 definitions ************************
#define DHTTYPE DHT22
int SENSOR_PIN = 16; //A2 => Digital 16
int POWER_PIN = 19; //A5 = Digital 19
DHT dht(SENSOR_PIN, DHTTYPE);

//******** LowPower definitions ***********
#include <avr/wdt.h>
#define Reset_AVR() wdt_enable(WDTO_15MS); while(1) {} //This resets the chip
#define SLEEP_TIME 15 //SLEEP_TIME *8 = number of seconds between transmissions

/*
* Initializes radio and DHT22
*/                                                     //Used in cases where a reading was NAN
void setup() {
  //For printing when testing
  //Start serial port
  //Serial.begin(SERIAL_BAUD);
  
  //Initialize the radio
  radio.initialize(FREQUENCY, NODEID, NETWORKID);
  radio.encrypt(ENCRYPTKEY);

  // Initialize sensor
  dht.begin();

  //Auto Transmission Control - dials down transmit power to save battery (-100 is the noise floor, -90 is still pretty good)
  //For indoor nodes that are pretty static and at pretty stable temperatures (like a MotionMote) -90dBm is quite safe
  //For more variable nodes that can expect to move or experience larger temp drifts a lower margin like -70 to -80 would probably be better
  //Always test your ATC mote in the edge cases in your own environment to ensure ATC will perform as you expect
  radio.enableAutoPower(ATC_RSSI);
}

/*
* Blinks the LED on pin for DELAY_MS miliseconds
*/
void Blink(byte PIN, int DELAY_MS)
{
  pinMode(PIN, OUTPUT);
  digitalWrite(PIN, HIGH);
  delay(DELAY_MS);
  digitalWrite(PIN, LOW);
}

/*
* Retrieves the voltage in miniVolts, doesn't require additional hardware
*/
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

/*
* The device loops through this taking a reading, transmitting, sleeping, then repeat...
*/
void loop() {
  char payload[MAX_PACKET_SIZE]; //Packet we will place readings in and send
    char tempFaren[6]; //
  char humidity[6];

  //Turn on power to the pin and let it stabilize before reading
  pinMode(POWER_PIN, OUTPUT);
  digitalWrite(POWER_PIN, HIGH);
  delay(800);
   
  //Take the readings    
  float h = dht.readHumidity();
  float t = dht.readTemperature(true);  //true => temp. in farenheit
  long v = readVcc();
  
  //Turn of power to the DHT22
  digitalWrite(POWER_PIN, LOW);
  
  //If failed to read sensor or voltage then send notice and reset
  if (isnan(h)|| isnan(t) || isnan(v)) {
    Blink (LED, 1000); //Let someone watching now there was a problem
    sprintf(payload, "{ \"error\" : \"A reading was NAN\","); //Copy values to the packet

    //Try sending the packet
    // If no ACK is received try once more
    if(!radio.sendWithRetry(GATEWAYID, payload, strlen(payload))){
      radio.send(GATEWAYID, payload, strlen(payload)); //No ACK so try again
    }

    //Reset the device
    Reset_AVR();
  }

  /* The reading was successful. Build the packet and send! */

  //This is necessary for copying floats to a char[]
  //4 is mininum width, 2 is precision
  dtostrf(t, 4, 2, tempFaren);
  dtostrf(h, 4, 2, humidity);

  //Build packet
  sprintf(payload, "{\"temp\" : %s, \"hum\" : %s, \"volt\" : %d, ", tempFaren, humidity, v);
  
    //Try sending the packet
    // If no ACK is received try once more
    if(!radio.sendWithRetry(GATEWAYID, payload, strlen(payload))){
      radio.send(GATEWAYID, payload, strlen(payload)); //No ACK so try again
    }

  //A little flash to show we transmitted
  Blink(LED, 3);

  //Power down
  radio.sleep();
  //Need to loop becasue max sleep for powerDown is only 8s
  for(int i=0; i<SLEEP_TIME; i++){
    LowPower.powerDown(SLEEP_4S, ADC_OFF, BOD_OFF);
  }
}




