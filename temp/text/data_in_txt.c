#include <stdio.h>
#include <stdlib.h>


int main() {
  FILE *fp = fopen("dataOut.txt", "r");
  FILE *fp2 = fopen("ControlOut.txt", "r");

  int arrLen = 30;
  int arr[arrLen];

  for(int iter = 0; iter < arrLen; iter++) {
    int thisRandInt = 0;
    int internalLoopCounter = 0;
    while(1) {
      int thisDataBit;
      int thisControlBit;
      fscanf(fp, "%d", &thisDataBit);
      fscanf(fp2, "%d", &thisControlBit);
      thisRandInt += thisDataBit<<internalLoopCounter;
      internalLoopCounter += 1;
      if (thisControlBit == 1) break;
    }
    arr[iter] = thisRandInt;
    printf("%d\n", thisRandInt);
  }

  fclose(fp);
  fclose(fp2);
  return 0;
}
