#ifdef __cplusplus
extern "C" {
#endif

#define PERL_NO_GET_CONTEXT /* we want efficiency */
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

static unsigned long xs_fib(unsigned long n) {
  if (n == 0 || n == 1) {
    return 1;
  } else {
    return xs_fib(n-2) + xs_fib(n-1);
  }
}

#ifdef __cplusplus
} /* extern "C" */
#endif

#define NEED_newSVpvn_flags
#include "ppport.h"

MODULE = Fib    PACKAGE = Fib

PROTOTYPES: DISABLE

unsigned long xs_fib(unsigned long n);
