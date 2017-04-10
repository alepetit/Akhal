int inPin = A0;
int outPin = 12;
int sensPin = 7;
int value = 0;
int cpt;

void setup() {
  // put your setup code here, to run once:
  pinMode(outPin, OUTPUT);
  pinMode(sensPin, OUTPUT);
  cpt = 0;
}

void loop() {
  if (cpt>2000){
    digitalWrite(sensPin,HIGH);
    digitalWrite(outPin,LOW);
    cpt++;}
  else if (cpt>=4000){
    cpt=0;}
  else{
    digitalWrite(sensPin,LOW);
    digitalWrite(outPin,HIGH);
    cpt++;}
    
  /*
  value = analogRead(inPin);
  if (value>100){
    digitalWrite(outPin,HIGH);
  }
  else{
    digitalWrite(outPin,LOW);
  }*/
}
