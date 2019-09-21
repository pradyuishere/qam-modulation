#include <stdio.h>
#include <stdlib.h>

void writeToFileData(FILE *fp, int *arr, int arrLen) {
  for (int iter = 0; iter < arrLen; iter ++) {
    fprintf(fp, "%d ", arr[iter]);
  }
}

void writeToFileControl(FILE *fp, int *arr, int arrLen) {
  for (int iter = 0; iter < arrLen; iter ++) {
    fprintf(fp, "%d ", arr[iter]);
  }
}

int main() {
  int bitCount = 8;

  FILE *fp1 = fopen("binDataOut.txt", "w");

  FILE *fp2 = fopen("ControlOut.txt", "w");

  int completeSignalArr[bitCount];
  int bitstreamArr[bitCount];

  FILE *fp = fopen("asciiData.txt", "r");

  //printf("before while loop\n");
  while(1) {
    //printf("In while loop\n");
    int thisRandInt = fgetc(fp);
    if(thisRandInt == -1) break;
    //printf("%d\n", thisRandInt);
    for (int iter2 = 0; iter2 < bitCount; iter2++) {
      completeSignalArr[iter2] = thisRandInt%2;
      thisRandInt = thisRandInt>>1;
      if(iter2 != bitCount-1) {
        bitstreamArr[iter2] = 0;
      } else {
        bitstreamArr[iter2] = 1;
      }
    }
    writeToFileData(fp1, completeSignalArr, bitCount);
    writeToFileControl(fp2, bitstreamArr, bitCount);
  }
  fclose(fp1);
  fclose(fp2);

  return 0;
}
