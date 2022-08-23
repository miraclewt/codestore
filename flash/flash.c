#include "stm32f10x.h"

#define  STARTADDR  0x08010000                
volatile FLASH_Status FLASHStatus = FLASH_COMPLETE;      //Flash����״̬����

/****************************************************************
*Name:		ReadFlashNBtye
*Function:	���ڲ�FLASH��ȡN�ֽڵ�����
*Input:		ReadAddress:���ݵ�ַ(ƫ�Ƶ�ַ)
					ReadBuf:����ָ��
					ReadNum:��ȡ�ֽ���
*Output:	��ȡ�Ľ��  
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
*Function:	���ڲ�Flashд��32λ����
*Input:		WriteAddress:���ݵ�ַ(ƫ�Ƶ�ַ)
					WriteData:д�������
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
