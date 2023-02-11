//气压测量速率(sample/sec),Background 模式使用
#define  PM_RATE_1          (0<<4)      //1 measurements pr. sec.
#define  PM_RATE_2          (1<<4)      //2 measurements pr. sec.
#define  PM_RATE_4          (2<<4)      //4 measurements pr. sec.           
#define  PM_RATE_8          (3<<4)      //8 measurements pr. sec.
#define  PM_RATE_16         (4<<4)      //16 measurements pr. sec.
#define  PM_RATE_32         (5<<4)      //32 measurements pr. sec.
#define  PM_RATE_64         (6<<4)      //64 measurements pr. sec.
#define  PM_RATE_128        (7<<4)      //128 measurements pr. sec.
 
//气压重采样速率(times),Background 模式使用
#define PM_PRC_1            0       //Sigle         kP=524288   ,3.6ms
#define PM_PRC_2            1       //2 times       kP=1572864  ,5.2ms
#define PM_PRC_4            2       //4 times       kP=3670016  ,8.4ms
#define PM_PRC_8            3       //8 times       kP=7864320  ,14.8ms
#define PM_PRC_16           4       //16 times      kP=253952   ,27.6ms
#define PM_PRC_32           5       //32 times      kP=516096   ,53.2ms
#define PM_PRC_64           6       //64 times      kP=1040384  ,104.4ms
#define PM_PRC_128          7       //128 times     kP=2088960  ,206.8ms
 
//温度测量速率(sample/sec),Background 模式使用
#define  TMP_RATE_1         (0<<4)      //1 measurements pr. sec.
#define  TMP_RATE_2         (1<<4)      //2 measurements pr. sec.
#define  TMP_RATE_4         (2<<4)      //4 measurements pr. sec.           
#define  TMP_RATE_8         (3<<4)      //8 measurements pr. sec.
#define  TMP_RATE_16        (4<<4)      //16 measurements pr. sec.
#define  TMP_RATE_32        (5<<4)      //32 measurements pr. sec.
#define  TMP_RATE_64        (6<<4)      //64 measurements pr. sec.
#define  TMP_RATE_128       (7<<4)      //128 measurements pr. sec.
 
//温度重采样速率(times),Background 模式使用
#define TMP_PRC_1           0       //Sigle
#define TMP_PRC_2           1       //2 times
#define TMP_PRC_4           2       //4 times
#define TMP_PRC_8           3       //8 times
#define TMP_PRC_16          4       //16 times
#define TMP_PRC_32          5       //32 times
#define TMP_PRC_64          6       //64 times
#define TMP_PRC_128         7       //128 times
 
//SPL06_MEAS_CFG
#define MEAS_COEF_RDY       0x80
#define MEAS_SENSOR_RDY     0x40        //传感器初始化完成
#define MEAS_TMP_RDY        0x20        //有新的温度数据
#define MEAS_PRS_RDY        0x10        //有新的气压数据
 
#define MEAS_CTRL_Standby               0x00    //空闲模式
#define MEAS_CTRL_PressMeasure          0x01    //单次气压测量
#define MEAS_CTRL_TempMeasure           0x02    //单次温度测量
#define MEAS_CTRL_ContinuousPress       0x05    //连续气压测量
#define MEAS_CTRL_ContinuousTemp        0x06    //连续温度测量
#define MEAS_CTRL_ContinuousPressTemp   0x07    //连续气压温度测量
 
//FIFO_STS
#define SPL06_FIFO_FULL     0x02
#define SPL06_FIFO_EMPTY    0x01
 
//INT_STS
#define SPL06_INT_FIFO_FULL     0x04
#define SPL06_INT_TMP           0x02
#define SPL06_INT_PRS           0x01
 
//CFG_REG
#define SPL06_CFG_T_SHIFT   0x08    //oversampling times>8时必须使用
#define SPL06_CFG_P_SHIFT   0x04
 
#define SP06_PSR_B2     0x00        //气压值
#define SP06_PSR_B1     0x01
#define SP06_PSR_B0     0x02
#define SP06_TMP_B2     0x03        //温度值
#define SP06_TMP_B1     0x04
#define SP06_TMP_B0     0x05
 
#define SP06_PSR_CFG    0x06        //气压测量配置
#define SP06_TMP_CFG    0x07        //温度测量配置
#define SP06_MEAS_CFG   0x08        //测量模式配置
 
#define SP06_CFG_REG    0x09
#define SP06_INT_STS    0x0A
#define SP06_FIFO_STS   0x0B
 
#define SP06_RESET      0x0C
#define SP06_ID         0x0D
 
#define SP06_COEF       0x10        //-0x21
#define SP06_COEF_SRCE  0x28
 
static float _kT,_kP;
static float _Temp,_Press;
 
uint8_t spl06_init(void)
{
    uint8_t coef[18];
    uint8_t id;
 
    if(spl06_write_reg(SP06_RESET,0x89))
    {
        puts("spl06 reset  fail\r\n");
        return 1;
    }
 
    id = spl06_read_reg(SP06_ID);
    if(id != 0x10)
    {
        puts("sol06 id error !!!\r\n");
    }
 
    //delay_ms(200);        //复位后系数准备好需要至少40ms
 
    spl06_read_buffer(SP06_COEF,coef,18);
    _C0 = ((int16_t)coef[0]<<4 ) + ((coef[1]&0xF0)>>4);
    _C0 = (_C0&0x0800)?(0xF000|_C0):_C0;
    _C1 = ((int16_t)(coef[1]&0x0F)<<8 ) + coef[2];
    _C1 = (_C1&0x0800)?(0xF000|_C1):_C1;
    _C00 = ((int32_t)coef[3]<<12 ) + ((uint32_t)coef[4]<<4 ) + (coef[5]>>4);
    _C10 = ((int32_t)(coef[5]&0x0F)<<16 ) + ((uint32_t)coef[6]<<8 ) + coef[7];
    _C00 = (_C00&0x080000)?(0xFFF00000|_C00):_C00;
    _C10 = (_C10&0x080000)?(0xFFF00000|_C10):_C10;
    _C01 = ((int16_t)coef[8]<<8 ) + coef[9];
    _C11 = ((int16_t)coef[10]<<8 ) + coef[11];
    _C11 = (_C11&0x0800)?(0xF000|_C11):_C11;
    _C20 = ((int16_t)coef[12]<<8 ) + coef[13];
    _C20 = (_C20&0x0800)?(0xF000|_C20):_C20;
    _C21 = ((int16_t)coef[14]<<8 ) + coef[15];
    _C21 = (_C21&0x0800)?(0xF000|_C21):_C21;
    _C30 = ((int16_t)coef[16]<<8 ) + coef[17];
    _C30 = (_C30&0x0800)?(0xF000|_C30):_C30;
 
    spl06_config_pressure(PM_RATE_128,PM_PRC_64);
    spl06_config_temperature(PM_RATE_8,TMP_PRC_8);
 
    spl06_start(MEAS_CTRL_ContinuousPressTemp); //启动连续的气压温度测量
    delay_ms(20);
 
    return 0;
}
 
void spl06_start(uint8_t mode)
{
    spl06_write_reg(SP06_MEAS_CFG, mode);
}
 
void spl06_config_temperature(uint8_t rate,uint8_t oversampling)
{
    switch(oversampling)
    {
        case TMP_PRC_1:
            _kT = 524288;
            break;
        case TMP_PRC_2:
            _kT = 1572864;
            break;
        case TMP_PRC_4:
            _kT = 3670016;
            break;
        case TMP_PRC_8:
            _kT = 7864320;
            break;
        case TMP_PRC_16:
            _kT = 253952;
            break;
        case TMP_PRC_32:
            _kT = 516096;
            break;
        case TMP_PRC_64:
            _kT = 1040384;
            break;
        case TMP_PRC_128:
            _kT = 2088960;
            break;
    }
 
    spl06_write_reg(SP06_TMP_CFG,rate|oversampling|0x80);   //温度每秒128次测量一次
    if(oversampling > TMP_PRC_8)
    {
        uint8_t temp = spl06_read_reg(SP06_CFG_REG);
        spl06_write_reg(SP06_CFG_REG,temp|SPL06_CFG_T_SHIFT);
    }
}
 
void spl06_config_pressure(uint8_t rate,uint8_t oversampling)
{
    switch(oversampling)
    {
        case PM_PRC_1:
            _kP = 524288;
            break;
        case PM_PRC_2:
            _kP = 1572864;
            break;
        case PM_PRC_4:
            _kP = 3670016;
            break;
        case PM_PRC_8:
            _kP = 7864320;
            break;
        case PM_PRC_16:
            _kP = 253952;
            break;
        case PM_PRC_32:
            _kP = 516096;
            break;
        case PM_PRC_64:
            _kP = 1040384;
            break;
        case PM_PRC_128:
            _kP = 2088960;
            break;
    }
 
    spl06_write_reg(SP06_PSR_CFG,rate|oversampling);
    if(oversampling > PM_PRC_8)
    {
        uint8_t temp = spl06_read_reg(SP06_CFG_REG);
        spl06_write_reg(SP06_CFG_REG,temp|SPL06_CFG_P_SHIFT);
    }
}
 
int32_t spl06_get_pressure_adc()
{
    uint8_t buf[3];
    int32_t adc;
 
    spl06_read_buffer(SP06_PSR_B2,buf,3);
    adc = (int32_t)(buf[0]<<16) + (buf[1]<<8) + buf[2];
    adc = (adc&0x800000)?(0xFF000000|adc):adc;
 
    return adc;
}
 
int32_t spl06_get_temperature_adc()
{
    uint8_t buf[3];
    int32_t adc;
 
    spl06_read_buffer(SP06_TMP_B2,buf,3);
    adc = (int32_t)(buf[0]<<16) + (buf[1]<<8) + buf[2];
 
    return adc;
}
 
void spl06_update_pressure()
{
    float Traw_src, Praw_src;
    float qua2, qua3;
 
    Traw_src = _kT * _raw_temp;
    Praw_src = _kP * _raw_press;
 
    //计算温度
    _Temp = 0.5f*_C0 + Traw_src * _C1;
 
    //计算气压
    qua2 = _C10 + Praw_src * (_C20 + Praw_src* _C30);
    qua3 = Traw_src * Praw_src * (_C11 + Praw_src * _C21);
    _Press = _C00 + Praw_src * qua2 + Traw_src * _C01 + qua3;
}
 
void spl06_update()
{
    _raw_temp = spl06_get_temperature_adc();
    _raw_press = spl06_get_pressure_adc();
    spl06_update_pressure();
}
 
float spl06_get_temperature()
{
    return _Temp;
}
 
float spl06_get_pressure()
{
    return _Press;
}
 
uint8_t spi2_write_reg(uint8_t reg_addr,uint8_t reg_val)
{
    spi2_read_write_byte(reg_addr&0x7f);
    spi2_read_write_byte(reg_val);
 
    return 0;
}
 
uint8_t spi2_read_reg(uint8_t reg_addr)
{
    spi2_read_write_byte(reg_addr|0x80);
    return spi2_read_write_byte(0xff);
}
uint8_t spi2_read_reg_buffer(uint8_t reg_addr,void *buffer,uint16_t len)
{
    uint8_t *p = buffer;
    uint16_t i;
 
    spi2_read_write_byte(reg_addr|0x80);
    for(i=0;i<len;i++)
    {
        *p++= spi2_read_write_byte(0xff);
    }
 
    return 0;
}