#include "stm32f10x.h"

#define  STARTADDR  0x08010000                
volatile FLASH_Status FLASHStatus = FLASH_COMPLETE;      //Flash操作状态变量

/****************************************************************
*Name:		ReadFlashNBtye
*Function:	从内部FLASH读取N字节的数据
*Input:		ReadAddress:数据地址(偏移地址)
					ReadBuf:数据指针
					ReadNum:读取字节数
*Output:	读取的结果  
****************************************************************/
int ReadFlashNBtye(uint32_t ReadAddress, uint8_t *ReadBuf, int32_t ReadNum) 
{
        int DataNum = 0;
		ReadAddress = (uint32_t)STARTADDR + ReadAddress; 
        while(DataNum < ReadNum) 
		{
           *(ReadBuf + DataNum) = *(__IO uint8_t*) ReadAddress++;
           DataNum++;
        }
        return DataNum;
}

/****************************************************************
*Name:		WriteFlashOneWord
*Function:	向内部Flash写入32位数据
*Input:		WriteAddress:数据地址(偏移地址)
					WriteData:写入的数据
*Output:	NULL 	
****************************************************************/

void WriteFlashOneWord(uint32_t WriteAddress,uint32_t WriteData1, uint32_t WriteData2)
{
	FLASH_UnlockBank1();
	FLASH_ClearFlag(FLASH_FLAG_EOP | FLASH_FLAG_PGERR | FLASH_FLAG_WRPRTERR); 
    FLASHStatus = FLASH_ErasePage(STARTADDR);

	if(FLASHStatus == FLASH_COMPLETE)
	{
		FLASHStatus = FLASH_ProgramWord(STARTADDR + WriteAddress, WriteData1);    //
		FLASHStatus = FLASH_ProgramWord(STARTADDR + WriteAddress + 4, WriteData2);                      
		//FLASHStatus = FLASH_ProgramWord(StartAddress+8, 0x87650000);                   
	}
	FLASH_LockBank1();
} 
