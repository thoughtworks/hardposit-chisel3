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
#include <stdint.h>

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

	printf("virtual base %p \nvalue %d \n", virtual_base + 0, *(int *) virtual_base);
	if( virtual_base == MAP_FAILED ) {
		printf( "ERROR: mmap() failed...\n" );
		close( fd );
		return( 1 );
	}

	void *num1_address = virtual_base + NUM1_OFFSET;
	void *num2_address = virtual_base + NUM2_OFFSET;
	void *result_address = virtual_base + RESULT_OFFSET;
    printf("%d \n",  *(int8_t *)(result_address));
    struct timeval t1, t2;
    gettimeofday(&t1,NULL);
    *(int8_t *)(num1_address) = 0x64;
    *(int8_t *)(num2_address) = 0xAF;
    int8_t sum = *(int8_t *)(result_address);
    gettimeofday(&t2,NULL);

    printf("Num1: %d\nNum2: %d\nResult: %d\n", *(int8_t *)(num1_address), *(int8_t *)(num2_address), sum);
    long start_time = t1.tv_sec*1000000 + t1.tv_usec;
    long end_time = t2.tv_sec*1000000 + t2.tv_usec;
    printf("time required : %ld\n", end_time - start_time );
	if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
		printf( "ERROR: munmap() failed...\n" );
		close( fd );
		return( 1 );
	}

	close( fd );

	return( 0 );
}
