#include <stdio.h>
#include <wiringPi.h>
#include <stdlib.h>

int clkCounter;

int rstCounter;
int rstCount = 1000;

int dataInCounter;
int dataInChangeCounter;
int dataInChangeCount = 2000;

int binDataOutCounter = 0;

void generateClk(int clkPin) {
  clkCounter = (clkCounter + 1)%2;
  digitalWrite(clkPin, clkCounter);
}

void readControlSignalToArray( int* arr, int arrLen) {
  FILE *fData = fopen("ControlOut.txt", "r");
  for (int iter = 0; iter < arrLen; iter ++) {
    int tempInt;
    fscanf(fData, "%d", &tempInt);
    arr[iter] = tempInt;
  }
  fclose(fData);
}

void readBinDataOutToArray( int* arr, int arrLen) {
  FILE *fData = fopen("binDataOut.txt", "r");
  for (int iter = 0; iter < arrLen; iter ++) {
    int tempInt;
    fscanf(fData, "%d", &tempInt);
    arr[iter] = tempInt;
  }
  fclose(fData);
}

int rstFunc(int rstPin) {
  if (rstCounter < rstCount) {
    rstCounter += 1;
    digitalWrite(rstPin, 0);
    return 0;
  } else {
    digitalWrite(rstPin, 1);
    return 1;
  }
}

int dataWriteFunc(int* dataArr, int* controlArr, int arrLen, int dataInPin0, int dataInPin1) {
  dataInChangeCounter += 1;
  if (dataInChangeCounter == dataInChangeCount) {
    dataInChangeCounter = 0;

    digitalWrite(dataInPin0, dataArr[binDataOutCounter]);
    digitalWrite(dataInPin1, controlArr[binDataOutCounter]);
    binDataOutCounter += 1;
    if (binDataOutCounter == arrLen) binDataOutCounter = 0;
	  printf("dataInPin0 : %d, dataInPin1 : %d\n", dataArr[binDataOutCounter], controlArr[binDataOutCounter]);
  }
}

int dataReadFunc(int dataOutPin0, int dataOutPin1) {
	 if (dataInChangeCounter == dataInChangeCount-1)
	printf("digitalRead(dataOutPin0) : %d, digitalRead(dataOutPin1) : %d\n", digitalRead(dataOutPin0), digitalRead(dataOutPin1));
  return digitalRead(dataOutPin0) + (digitalRead(dataOutPin1) << 1);
}

void saveDataReadToFile(int dataReadArr[], int dataReadArrSize) {
  FILE *fp = fopen("dataRead.txt", "a");
  for (int iter = 0; iter < dataReadArrSize; iter ++) {
    fprintf(fp, "%s", dataReadArr[iter]);
  }
  fclose(fp);
}


int main(void) {

  FILE *fData = fopen("textfile.txt", "rb");
  fseek(fData, 0, SEEK_END);
  long fsize = ftell(fData);
  fclose(fData);

  int binDataArr[fsize];
  int controlOutArr[fsize];

  readControlSignalToArray(controlOutArr, arrLen);
  readBinDataOutToArray(binDataArr, arrLen);

  wiringPiSetupPhys();

  int clkPin = 12;
  int rstPin = 15;
  int dataInPin0 = 26;
  int dataInPin1 = 35;
  int dataOutPin0 = 40;
  int dataOutPin1 = 36;
  int dataRead;

  int dataReadArrSize = 1000;
  int dataReadArr[dataReadArrSize];
  int dataWrittenArr[dataReadArrSize];
  int dataReadArrIndex = 0;

  int tempDataRead = 0;
  int tempDataPower = 0;

  pinMode(clkPin, OUTPUT);
  pinMode(rstPin, OUTPUT);
  pinMode(dataInPin0, OUTPUT);
  pinMode(dataInPin1, OUTPUT);
  pinMode(dataOutPin0, INPUT);
  pinMode(dataOutPin1, INPUT);

  while(1) {
    generateClk(clkPin);

    delayMicroseconds(10);
    rstFunc(rstPin);

    dataWriteFunc(binDataArr, controlOutArr, dataReadArrSize, dataInPin0, dataInPin1);
    //Read data from digital pins
    if (dataInChangeCounter = dataInChangeCount/2) {
      int dataBitTemp = digitalRead(dataOutPin0);
      int controlBitTemp = digitalRead(dataOutPin1);
      tempDataRead += dataBitTemp << tempDataPower;
      tempDataPower += 1;
      if(controlBitTemp == 1) {
        dataReadArr[dataReadArrIndex] = dataRead;
        dataReadArrIndex += 1;
        tempDataPower = 0;
      }

      if (dataReadArrIndex >= dataReadArrSize) {
    		dataReadArrIndex = 0;
    		saveDataReadToFile(dataReadArr, dataReadArrSize);
  		}
    }
  }

  return 0;
}
