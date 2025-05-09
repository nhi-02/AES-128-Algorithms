#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include "aes.h"

static void test_encrypt_cbc(void);

int main(void)
{
    test_encrypt_cbc();
    return 0;
}

static void test_encrypt_cbc(void)
{
    uint32_t key[4] = {
        0x54686174, 
        0x73206D79, 
        0x204B756E, 
        0x67204675  
    };

    uint32_t plaintext[4] = {
        0x54776F23,
        0x4F6E6520,
        0x4E696E65,
        0x2054776F 
    };

    uint32_t output[4];

    printf("Key: ");
    for (int i = 0; i < 4; i++) {
        printf("%08x ", key[i]);
    }
    printf("\n");

    printf("Plaintext: ");
    for (int i = 0; i < 4; i++) {
        printf("%08x ", plaintext[i]);
    }
    printf("\n");

    AES128_encrypt(plaintext, key, output);

    printf("Output: ");
    for (int i = 0; i < 4; i++) {
        printf("%08x ", output[i]);
    }
    printf("\n");
}