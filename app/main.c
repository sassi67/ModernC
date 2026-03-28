#include <stdio.h>
#include "lib.h"

int main(void)
{
    int answer = lib_get_answer();
    printf("Lib answer: %d\n", answer);

    /* small demo of utilities */
    printf("2 + 3 = %d\n", lib_add(2, 3));
    printf("4 * 5 = %d\n", lib_mul(4, 5));

    return 0;
}
