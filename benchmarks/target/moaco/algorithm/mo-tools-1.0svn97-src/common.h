#ifndef   	LIBMISC_COMMON_H_
# define   	LIBMISC_COMMON_H_

#if __GNUC__ >= 3
#define MAX(x,y) \
       ({ typeof (x) _x__ = (x);        \
           typeof (y) _y__ = (y);       \
         _x__ > _y__ ? _x__ : _y__; })
#define MIN(x,y) \
       ({ typeof (x) _x__ = (x);        \
           typeof (y) _y__ = (y);       \
         _x__ < _y__ ? _x__ : _y__; })
#endif 

#ifndef DEBUG
#define DEBUG 0
#endif

#if DEBUG >= 1
#define DEBUG1(X) X;(void)0
#else  
#define DEBUG1(X) (void)0
#endif

#if DEBUG >= 2
#define DEBUG2(X) X;(void)0
#else  
#define DEBUG2(X) (void)0
#endif

#if DEBUG >= 3
#define DEBUG3(X) X;(void)0
#else  
#define DEBUG3(X) (void)0
#endif

#if DEBUG >= 4
#define DEBUG4(X) X;(void)0
#else  
#define DEBUG4(X) (void)0
#endif

#define DEBUG2_PRINT(...) DEBUG2 (fprintf (stderr, __VA_ARGS__))

#define DEBUG2_FUNPRINT(...) \
    do { DEBUG2_PRINT ("%s(): ", __FUNCTION__); \
         DEBUG2_PRINT (__VA_ARGS__); } while(0)

#if DEBUG >= 1
#ifndef MALLOC_CHECK_
#define MALLOC_CHECK_ 3
#endif
#endif

#include <stdbool.h>
#ifndef TRUE
#define TRUE  true
#define FALSE false
#endif

#include "gcc_attribs.h"

typedef unsigned long ulong;
typedef long long longlong;
#endif 	    /* !LIBMISC_COMMON_H_ */
