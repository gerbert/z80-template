#include <stdio.h>
#include "main.h"

extern int print_me(void);

static void nmi_isr(void) __critical __interrupt
{
    __asm__("nop");
}

int main(void)
{
    return print_me();
}
