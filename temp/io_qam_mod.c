#include <stdio.h>
#include <wiringPi.h>
#include <stdlib.h>

int clkCounter;
int rstCounter;
int rstCount = 1000;
int dataInCounter;
int dataInChangeCounter;
int dataInChangeCount = 2000;

void generateClk(int clkPin) {
  clkCounter = (clkCounter + 1)%2;
  digitalWrite(clkPin, clkCounter);
}

int rstFunc(int rstPin) {
  if (rstCounter < rstCount) {
    rstCounter += 1;
    digitalWrite(rstPin, 0);
    return 0;
  } else {
	  //printf("In else \n");
    digitalWrite(rstPin, 1);
    return 1;
  }
}

int dataWriteFunc(int dataInPin0, int dataInPin1) {
  dataInChangeCounter += 1;
  if (dataInChangeCounter == dataInChangeCount) {
    dataInChangeCounter = 0;
    dataInCounter = rand()%4;

    //dataInCounter += 1;
   // if (dataInCounter == 4) {
  //    dataInCounter = 0;
//    }
    digitalWrite(dataInPin0, dataInCounter%2);
    int tempInt = dataInCounter/2;
    digitalWrite(dataInPin1, tempInt%2);
	printf("dataInPin0 : %d, dataInPin1 : %d\n", dataInCounter%2, tempInt%2);
  }
}

int dataReadFunc(int dataOutPin0, int dataOutPin1) {
	 if (dataInChangeCounter == dataInChangeCount-1) 
	printf("digitalRead(dataOutPin0) : %d, digitalRead(dataOutPin1) : %d\n", digitalRead(dataOutPin0), digitalRead(dataOutPin1));
  return digitalRead(dataOutPin0) + (digitalRead(dataOutPin1) << 1);
}

void saveDataReadToFile(int dataReadArr[], int dataReadArrSize) {
  FILE *fp = fopen("dataRead.txt", "a");
  //printf("%d, ", dataReadArrSize);
  for (int iter = 0; iter < dataReadArrSize; iter ++) {
    fprintf(fp, "%d,", dataReadArr[iter]);
    //printf("%d, ", dataReadArr[iter]);
  }
  fclose(fp);
}

void saveDataWrittenToFile(int dataWrittenArr[], int dataReadArrSize) {
  FILE *fp = fopen("dataWritten.txt", "a");
  for (int iter = 0; iter < dataReadArrSize; iter ++) {
    fprintf(fp, "%d,", dataWrittenArr[iter]);
  }
  fclose(fp);
}

int main(void) {
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


  pinMode(clkPin, OUTPUT);
  pinMode(rstPin, OUTPUT);
  pinMode(dataInPin0, OUTPUT);
  pinMode(dataInPin1, OUTPUT);
  pinMode(dataOutPin0, INPUT);
  pinMode(dataOutPin1, INPUT);

  while(1) {
    generateClk(clkPin);
    //printf("After Generate clk\n");
    delayMicroseconds(10);
    rstFunc(rstPin);
    //printf("After rst func\n");
    dataWriteFunc(dataInPin0, dataInPin1);
    //printf("After data write func\n");
    dataRead = dataReadFunc(dataOutPin0, dataOutPin1);
    //printf("After data read func\n");
    //printf("dataReadArrIndex : %d\n", dataReadArrIndex);
    dataWrittenArr[dataReadArrIndex] = dataInCounter;
    //printf("After data written to dataWrittenArr\n");
    dataReadArr[dataReadArrIndex] = dataRead;
    //printf("After data written to dataReadArr\n");
    dataReadArrIndex += 1;

    if (dataReadArrIndex >= dataReadArrSize) {
		dataReadArrIndex = 0;
		//printf("dataReadArrIndex Start\n");
		saveDataWrittenToFile(dataWrittenArr, dataReadArrSize);
		saveDataReadToFile(dataReadArr, dataReadArrSize);
		//printf("dataReadArrIndex End\n");		
    }
  }

  return 0;
}
