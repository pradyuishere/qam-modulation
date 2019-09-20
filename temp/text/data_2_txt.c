#include <stdio.h>
#include <stdlib.h>

void writeToFileData(int *arr, int arrLen) {
  FILE *fp = fopen("dataOut.txt", "w");
  for (int iter = 0; iter < arrLen; iter ++) {
    fprintf(fp, "%d ", arr[iter]);
  }
  fclose(fp);
}

void writeToFileControl(int *arr, int arrLen) {
  FILE *fp = fopen("ControlOut.txt", "w");
  for (int iter = 0; iter < arrLen; iter ++) {
    fprintf(fp, "%d ", arr[iter]);
  }
  fclose(fp);
}

int main() {
  int iterations = 30;
  int bitCount = 8;

  int completeSignalArr[iterations*bitCount];
  int bitstreamArr[iterations*bitCount];

  for(int iter = 0; iter < iterations; iter++) {
    int thisRandInt = rand()%256;
    printf("%d\n", thisRandInt);
    for (int iter2 = 0; iter2 < bitCount; iter2++) {
      completeSignalArr[iter*bitCount + iter2] = thisRandInt%2;
      thisRandInt = thisRandInt>>1;
      if(iter2 != bitCount-1) {
        bitstreamArr[iter*bitCount+iter2] = 0;
      } else {
        bitstreamArr[iter*bitCount+iter2] = 1;
      }
    }
  }

  writeToFileData(completeSignalArr, iterations*bitCount);
  writeToFileControl(bitstreamArr, iterations*bitCount);

  return 0;
}
