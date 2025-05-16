// Có 4 lỗi trong file này từ dòng 51-92


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>


#include <fcntl.h>
#include <stdint.h>
#include <math.h>

#include "./FPGA_Driver.c"


#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

/// Địa chỉ kênh ghi
#define START_BASE_PHYS	 		 	(0x0000000 >> 2)
									
#define PLAINTEXT0_BASE_PHYS	 	(0x0000004 >> 2)
#define PLAINTEXT1_BASE_PHYS	 	(0x0000008 >> 2)
#define PLAINTEXT2_BASE_PHYS	 	(0x000000C >> 2)
#define PLAINTEXT3_BASE_PHYS	 	(0x0000010 >> 2)
								
#define KEY0_BASE_PHYS	 			(0x0000014 >> 2)
#define KEY1_BASE_PHYS	 			(0x0000018 >> 2)
#define KEY2_BASE_PHYS	 			(0x000001C >> 2)
#define KEY3_BASE_PHYS	 			(0x0000020 >> 2)
							
/// Địa chỉ kênh đọc                
#define VALID_BASE_PHYS	 		 	(0x0000000 >> 2)
								
#define CIPHERTEXT0_BASE_PHYS	 	(0x0000004 >> 2)
#define CIPHERTEXT1_BASE_PHYS	 	(0x0000008 >> 2)
#define CIPHERTEXT2_BASE_PHYS	 	(0x000000C >> 2)
#define CIPHERTEXT3_BASE_PHYS	 	(0x0000010 >> 2)

int main() {
    
    unsigned char* membase;
    if (fpga_open() == 0)
        exit(1);

    fpga.dma_ctrl = MY_IP_info.dma_mmap;
    membase = (unsigned char*)MY_IP_info.ddr_mmap;

    uint32_t key[4] = {  // fix lỗi từ đây đến hết
        0x54686174, 
        0x73206D79, 
        0x204B756E, 
        0x67204675  
    };

    uint32_t plaintext[4] = {
        0x54776F20,
        0x4F6E6520,
        0x4E696E65,
        0x2054776F 
    };

    uint32_t output[4];
	
	*(MY_IP_info.pio_32_mmap + PLAINTEXT0_BASE_PHYS) = plaintext[0];
	*(MY_IP_info.pio_32_mmap + PLAINTEXT1_BASE_PHYS) = plaintext[1];
	*(MY_IP_info.pio_32_mmap + PLAINTEXT2_BASE_PHYS) = plaintext[2];
	*(MY_IP_info.pio_32_mmap + PLAINTEXT3_BASE_PHYS) = plaintext[3];

	*(MY_IP_info.pio_32_mmap + KEY3_BASE_PHYS) = key[0];
	*(MY_IP_info.pio_32_mmap + KEY1_BASE_PHYS) = key[1];
	*(MY_IP_info.pio_32_mmap + KEY2_BASE_PHYS) = key[2];
	*(MY_IP_info.pio_32_mmap + KEY0_BASE_PHYS) = key[3];
			
	*(MY_IP_info.pio_32_mmap + START_BASE_PHYS) = 1;
	
	while(1){
		if(*(MY_IP_info.pio_32_mmap + VALID_BASE_PHYS) == 1){
			printf("Done Encryption!\n");
			break;
		}
	}

	
	printf("Ciphertext = %08x %08x %08x %08x\n", *(MY_IP_info.pio_32_mmap + CIPHERTEXT0_BASE_PHYS), *(MY_IP_info.pio_32_mmap + CIPHERTEXT1_BASE_PHYS), *(MY_IP_info.pio_32_mmap + CIPHERTEXT2_BASE_PHYS), *(MY_IP_info.pio_32_mmap + CIPHERTEXT3_BASE_PHYS));

    return 0;
}