#include <ESP8266WiFi.h>
#include <PubSubClient.h>

// LED
#define PIN_LED_RED     14
#define PIN_LED_YELLOW  13
#define PIN_LED_GREEN   12

// button
#define PIN_BUTTON      4
#define DEBOUNCE_TIME 2000 // milliseconds
volatile int button_a_count = 0;
volatile unsigned long count_prev_time;

ICACHE_RAM_ATTR void button_a_isr() {
  if (millis() - count_prev_time > DEBOUNCE_TIME)
  {
    count_prev_time = millis();
    button_a_count++;
  }
}

const char* ssid = "EMLI_TEAM_17";
const char* password = "embeddedlinux";

const char* mqtt_server = "192.168.10.1";
const char* MQTT_TOPIC_RED = "Remote/Red";
const char* MQTT_TOPIC_YELLOW = "Remote/Yellow";
const char* MQTT_TOPIC_GREEN = "Remote/Green";
const char* MQTT_TOPIC_BUTTON = "Remote/Button";

WiFiClient espClient;
PubSubClient client(espClient);

void setup_wifi() {
  delay(10);
  // We start by connecting to a WiFi network
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  randomSeed(micros());

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void callback(char* topic, byte* payload, unsigned int length) {
  // Handle incoming MQTT messages
  payload[length] = '\0';
  String result = String((char*)payload);

  if (strcmp(topic, MQTT_TOPIC_RED) == 0) {
    if (result == "1") {
      digitalWrite(PIN_LED_RED, HIGH);
    } else if (result == "0") {
      digitalWrite(PIN_LED_RED, LOW);
    }
  }
  if (strcmp(topic, MQTT_TOPIC_YELLOW) == 0) {
    if (result == "1") {
      digitalWrite(PIN_LED_YELLOW, HIGH);
    } else if (result == "0") {
      digitalWrite(PIN_LED_YELLOW, LOW);
    }
  }
  if (strcmp(topic, MQTT_TOPIC_GREEN) == 0) {
    if (result == "1") {
      digitalWrite(PIN_LED_GREEN, HIGH);
    } else if (result == "0") {
      digitalWrite(PIN_LED_GREEN, LOW);
    }
  }
}

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    // Create a random client ID
    String clientId = "ESP8266Client-";
    clientId += String(random(0xffff), HEX);
    // Attempt to connect
    if (client.connect(clientId.c_str(), "my_user", "my_password")) {
      Serial.println("connected");
      // Once connected, publish an announcement...
      client.publish("anton", "hello world");
      // ... and resubscribe
      client.subscribe(MQTT_TOPIC_RED);
      client.subscribe(MQTT_TOPIC_YELLOW);
      client.subscribe(MQTT_TOPIC_GREEN);
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

void setup() {
  Serial.begin(115200);
  delay(10);

  // LEDs
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, LOW);
  pinMode(PIN_LED_RED, OUTPUT);
  digitalWrite(PIN_LED_RED, LOW);
  pinMode(PIN_LED_YELLOW, OUTPUT);
  digitalWrite(PIN_LED_YELLOW, LOW);
  pinMode(PIN_LED_GREEN, OUTPUT);
  digitalWrite(PIN_LED_GREEN, LOW);

  // button
  pinMode(PIN_BUTTON, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(PIN_BUTTON), button_a_isr, RISING);

  setup_wifi();
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  if (button_a_count > 0){
    client.publish(MQTT_TOPIC_BUTTON, "1");
    button_a_count = 0;
  }
}