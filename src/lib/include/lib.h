#ifndef LIB_H
#define LIB_H

#ifdef __cplusplus
extern "C" {
#endif

/* Return the canonical answer used by unit tests. */
int lib_get_answer(void);

/* Simple utility: add two integers. */
int lib_add(int a, int b);

/* Simple utility: multiply two integers. */
int lib_mul(int a, int b);

#ifdef __cplusplus
}
#endif

#endif /* LIB_H */
