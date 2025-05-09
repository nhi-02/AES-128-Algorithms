// aes.h
#ifndef AES_H
#define AES_H

#include <stdint.h>

void AES128_encrypt(uint32_t* input, const uint32_t* key, uint32_t* output);

#endif