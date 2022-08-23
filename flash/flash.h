#ifndef __FLASH_H
#define __FLASH_H

#include "stm32f10x.h"	



int ReadFlashNBtye(uint32_t ReadAddress, uint8_t *ReadBuf, int32_t ReadNum);
void WriteFlashOneWord(uint32_t WriteAddress,uint32_t WriteData1, uint32_t WriteData2);


#endif
