/*
  Copyright 2014 Google LLC All rights reserved.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/


/*
   american fuzzy lop - a trivial program to test the build
   --------------------------------------------------------

   Written and maintained by Niki Gitinabard <nikign@google.com>
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int calc_factorial(int file_lines_count){// B28
    int output_value = 1;
    for (int i = 1; i < file_lines_count; i++){
        output_value *= i;
    }
    
    return output_value;
}

int main(int argc, char** argv) {
  // B12
  char buf[128];
  char* filename;
  filename = argv[1];
  FILE *fp;
   /* opening file for reading */
  fp = fopen(filename , "r");
  int i = 0;
  int file_status = 1;
  int file_lines_count = 0;
  if (fp != NULL) {
    i++;
    while (fgets(buf, 128, fp) != NULL) {// B13
      
      file_lines_count++;
      i += 5;
    }
    // B14
    fclose(fp); 
  }
  else {
    // B15
    file_status = i;
    exit(2); 
  }

  // B14
  int j;
  for (j=0; j < file_lines_count; j++) { // B16
    printf("line %d out of %d", j, file_lines_count);
  }
  // B17
  switch (file_lines_count)
  {
    case 0:{ // B26
        printf("file was empty");
        break;
    }
    case 1:{ // B27
        printf("such a small file!");
        break;
    }
    default:{ // B18, B19
        int factorial = calc_factorial(file_lines_count);
        // B29
        printf("The factorial of the lines of input is %d", factorial);
    }
  }
//   B30
  exit(0);

}
