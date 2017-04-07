int inPin = A0;
int outPin = 12;
int value = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(outPin, OUTPUT);
}

void loop() {
  value = analogRead(inPin);
  if (value>100){
    digitalWrite(outPin,HIGH);
  }
  else{
    digitalWrite(outPin,LOW);
  }
}
