#include <assert.h>
#include <errno.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

extern "C" {
  // Functon defined by benchmarks as entry point
  int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size);
  // KLEE's internal functions
  void klee_make_symbolic(void *addr, size_t nbytes, const char *name);
}
// Input buffer.
size_t kleeInputSize = 4096;

int main(int argc, char **argv)
{
  if (sizeof(argv) <= 0){
    printf("You need to pass input size as an argument.");
    exit(1);
  }
  kleeInputSize = atoi(argv[1]);
  uint8_t *KleeInputBuf = (uint8_t *)malloc(kleeInputSize * sizeof(uint8_t));
  printf("kleeInputSize: %zu\n", kleeInputSize);

  klee_make_symbolic(KleeInputBuf, kleeInputSize, "KleeInputBuf");
  int result = LLVMFuzzerTestOneInput(KleeInputBuf, kleeInputSize);

  free(KleeInputBuf);
  return result;
}
