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

typedef __uint8_t uint8_t;

int LLVMFuzzerTestOneInput(const uint8_t *seed, size_t size) {
  // B1
  int i = 0;
  int file_status = 1;
  const char* buffer = (const char*)(seed);
  if (size > 0) {
    // B2
    i++;
    if (buffer != NULL) {
      // B3
      i *= 2;
      if(strnlen(buffer, size) < 1) { 
        //B4
        printf("Hum?\n"); 
        exit(1);
      }
      //B5
      i *= 3;

      // if and else merged B6 set file status, B7 print
      if (seed[0] == '0') {
        // B6
        file_status = 45;
        printf("Looks like a zero to me!\n");
      } 
      else {
        file_status = i;
        printf("A non-zero value? How quaint!\n");
      }
      i += 5;
    }
    // B7
    // fclose(fp); 
  }
  else {
    // B8
    file_status = i;
    exit(2); 
  }

  int j;
  for (j=0; j < 5000; j++) { // B9
    i = j;
  }
  // B10
  printf("%d\n", i);
  printf("%d\n", file_status);

  exit(0);

}
