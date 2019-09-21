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
  FILE *fp = fopen("dataFile.txt", "r");
  
}
