#include <stdio.h>
#include <wiringPi.h>

int clkCounter;
int rstCounter;
int dataInCounter;
int dataInChangeCounter;
int dataInChangeCount = 1000;

void generateClk(clkPin) {
  clkCounter = (clkCounter + 1)%2;
  digitalWrite(clkPin, clkCounter);
}

int rstFunc(rstPin) {
  if (rstCounter < rstCount) {
    rstCounter += 1;
    digitalWrite(rstPin, 0);
    return 0;
  } else {
    digitalWrite(rstPin, 1);
    return 1;
  }
}

int dataWriteFunc(dataInPin0, dataInPin1) {
  dataInChangeCounter += 1;
  if (dataInChangeCounter == dataInChangeCount) {
    dataInChageCounter = 0;

    dataInCounter += 1;
    if (dataInCounter == 4) {
      dataInCounter = 0;
    }
    digitalWrite(dataInPin0, dataInCounter%2);
    int tempInt = dataInCounter/2;
    digitalWrite(dataInPin1, tempInt%2);
  }
}

int dataReadFunc(dataOutPin0, dataOutPin1) {
  return digitalRead(dataOutPin0) + digitalRead(dataOutPin1) << 1;
}

void saveDataReadToFile(int dataReadArr[], int dataReadArrSize) {
  FILE *fp = fopen("dataRead.txt", "a");
  for (int iter = 0; iter < dataReadArrSize; iter ++) {
    fprintf(fp, "%d, ", dataReadArr[iter]);
  }
}

void saveDataWrittenToFile(int dataWrittenArr[], int dataReadArrSize) {
  FILE *fp = fopen("dataWritten.txt", "a");
  for (int iter = 0; iter < dataReadArrSize; iter ++) {
    fprintf(fp, "%d, ", dataReadArr[iter]);
  }
}

int main(void) {
  wiringPiSetupPhys();

  int clkPin = 0;
  int rstPin = 0;
  int dataInPin0 = 0;
  int dataInPin1 = 0;
  int dataOutPin0 = 0;
  int dataOutPin1 = 0;
  int dataRead;

  int dataReadArrSize = 1000;
  int dataReadArr[dataReadArrSize];
  int dataWrittenArr[dataReadSize];
  int dataReadArrIndex = 0;


  pinmode(clkPin, OUTPUT);
  pinmode(rstPin, OUTPUT)
  pinmode(dataInPin0, OUTPUT);
  pinmode(dataInPin1, OUTPUT);
  pinmode(dataOutPin0, INPUT);
  pinmode(dataOutPin1, INPUT);

  while(1) {
    generateClk(clkPin);
    rstFunc(rstPin);
    dataWriteFunc(dataInPin0, dataInPin1);
    dataRead = dataReadFunc(dataOutPin0, dataOutPin1);
    dataWrittenArr[dataReadArrIndex] = dataInCounter;
    dataReadArr[dataReadArrIndex] = dataRead;
    dataReadArrIndex += 1;

    if (dataReadArrIndex == dataReadArrSize) {

    }
  }

  return 0;
}
