/*
This program demonstrate how to use hps communicate with FPGA through light AXI Bridge.
uses should program the FPGA by GHRD project before executing the program
refer to user manual chapter 7 for details about the demo
*/


#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/time.h>
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"

#define HW_REGS_BASE ( 0xff200000 )
#define HW_REGS_SPAN ( 0x00100000 )
#define NUM1_OFFSET ( 0x00001000 )
#define NUM2_OFFSET ( 0x00002000 )
#define RESULT_OFFSET ( 0x00003000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )

int main() {
	void *virtual_base;
	int fd;

	if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) {
		printf( "ERROR: could not open \"/dev/mem\"...\n" );
		return( 1 );
	}

	virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, HW_REGS_BASE );

	if( virtual_base == MAP_FAILED ) {
		printf( "ERROR: mmap() failed...\n" );
		close( fd );
		return( 1 );
	}

	void *num1_address = virtual_base + NUM1_OFFSET;
	void *num2_address = virtual_base + NUM2_OFFSET;
	void *result_address = virtual_base + RESULT_OFFSET;

    *(float *)(num1_address) = 4.57;
    *(float *)(num2_address) = 35.23;

//    usleep(1000*1000);

    printf("Num1: %f\nNum2: %f\nResult: %f\n", *(float *)(num1_address), *(float *)(num2_address), *(float *)(result_address));

	if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
		printf( "ERROR: munmap() failed...\n" );
		close( fd );
		return( 1 );
	}

	close( fd );

	return( 0 );
}
