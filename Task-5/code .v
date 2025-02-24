#include <ch32v00x.h>

#define TRIG_PIN GPIO_Pin_2
#define ECHO_PIN GPIO_Pin_3
#define TRIG_PORT GPIOD
#define ECHO_PORT GPIOD

#define BUZZER_PIN GPIO_Pin_4
#define BUZZER_PORT GPIOD

void GPIO_Config(void) {
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOD, ENABLE);

    GPIO_InitTypeDef GPIO_InitStructure;

    GPIO_InitStructure.GPIO_Pin = TRIG_PIN;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(TRIG_PORT, &GPIO_InitStructure);

    GPIO_InitStructure.GPIO_Pin = ECHO_PIN;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
    GPIO_Init(ECHO_PORT, &GPIO_InitStructure);

    GPIO_InitStructure.GPIO_Pin = BUZZER_PIN;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_Init(BUZZER_PORT, &GPIO_InitStructure);
}

uint32_t get_distance() {
    uint32_t duration, distance;

    // Send a 10us pulse to trigger the ultrasonic sensor
    GPIO_SetBits(TRIG_PORT, TRIG_PIN);
    Delay_Us(10);
    GPIO_ResetBits(TRIG_PORT, TRIG_PIN);

    // Wait for the echo signal to go HIGH
    while (GPIO_ReadInputDataBit(ECHO_PORT, ECHO_PIN) == RESET);

    // Measure the duration of the HIGH pulse
    duration = 0;
    while (GPIO_ReadInputDataBit(ECHO_PORT, ECHO_PIN) == SET) {
        duration++;
        Delay_Us(1);
        
        // Prevent infinite loop if no valid signal is received
        if (duration > 30000) {  
            return 0;  // Return 0 if no object is detected
        }
    }

    // Convert duration to distance (in cm)
    distance = (duration * 0.0343) / 2;

    // Ignore noisy readings beyond 200 cm
    if (distance > 200) {
        return 0;
    }

    return distance;
}

void buzzer_alert(uint32_t distance) {
    if (distance == 0) {  // No object detected
        GPIO_ResetBits(BUZZER_PORT, BUZZER_PIN);
        return;
    }

    if (distance < 10) {  // Close object: Continuous beep
        GPIO_SetBits(BUZZER_PORT, BUZZER_PIN);
        Delay_Ms(500);
    } else if (distance >= 10 && distance <= 30) {  // Medium range: Beep intermittently
        GPIO_SetBits(BUZZER_PORT, BUZZER_PIN);
        Delay_Ms(500);
        GPIO_ResetBits(BUZZER_PORT, BUZZER_PIN);
        Delay_Ms(500);
    } else {  // Far object: No sound
        GPIO_ResetBits(BUZZER_PORT, BUZZER_PIN);
    }
}

int main(void) {
    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);
    SystemCoreClockUpdate();
    Delay_Init();
    GPIO_Config();

    while (1) {
        uint32_t distance = get_distance();
        buzzer_alert(distance);
        Delay_Ms(500);
    }
}
#include "ch32fun.h"
#include <stdio.h>

int main()
{
	SystemInit();

	// Enable GPIOs
	funGpioInitAll();
	
	funPinMode( PD0, GPIO_Speed_10MHz | GPIO_CNF_OUT_PP );
	funPinMode( PD4, GPIO_Speed_10MHz | GPIO_CNF_OUT_PP );
	funPinMode( PD6, GPIO_Speed_10MHz | GPIO_CNF_OUT_PP );
	funPinMode( PC0, GPIO_Speed_10MHz | GPIO_CNF_OUT_PP );

	while(1)
	{
		funDigitalWrite( PD0, FUN_HIGH );
		funDigitalWrite( PD4, FUN_HIGH );
		funDigitalWrite( PD6, FUN_HIGH );
		funDigitalWrite( PC0, FUN_HIGH );
		Delay_Ms( 1000 );
		funDigitalWrite( PD0, FUN_LOW );
		funDigitalWrite( PD4, FUN_LOW );
		funDigitalWrite( PD6, FUN_LOW );
		funDigitalWrite( PC0, FUN_LOW );
		Delay_Ms( 1000 );
	}
}
