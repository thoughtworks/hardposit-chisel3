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
#define START_OFFSET ( 0x00005000 )
#define COMPLETED_OFFSET ( 0x00006000 )
#define WRITE_MEMORY_OFFSET ( 0x00004000 )
#define READ_MEMORY_OFFSET ( 0x00008000 )
#define RESET_OFFSET ( 0x00007000 )
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

	//void *num1_address = virtual_base + NUM1_OFFSET;
	//void *num2_address = virtual_base + NUM2_OFFSET;
	void *result_address = virtual_base + RESULT_OFFSET;
	void *start_address = virtual_base + START_OFFSET;
	void *completed_address = virtual_base + COMPLETED_OFFSET;
	void *read_memory_address = virtual_base + READ_MEMORY_OFFSET;
	void *write_memory_address = virtual_base + WRITE_MEMORY_OFFSET;
	void *reset_address = virtual_base + RESET_OFFSET;

    *(int8_t *)(reset_address) = 0;
    *(int8_t *)(reset_address) = 1;
//    usleep(1000);
    *(int8_t *)(start_address) = 0;
    *(int8_t *)(reset_address) = 0;

    *(int16_t *)(write_memory_address) = 0x4000;
    *(int16_t *)(write_memory_address + 2) = 0x5000;
    *(int16_t *)(write_memory_address + 4) = 0x5800;
    *(int16_t *)(write_memory_address + 6) = 0x6000;
    *(int16_t *)(write_memory_address + 8) = 0x6200;
    *(int16_t *)(write_memory_address + 10) = 0x6400;
    *(int16_t *)(write_memory_address + 12) = 0x6600;
    *(int16_t *)(write_memory_address + 14) = 0x6800;
    *(int16_t *)(write_memory_address + 16) = 0x6900;
    *(int16_t *)(write_memory_address + 18) = 0x9600;


    *(int8_t *)(start_address) = 1;

    struct timeval t1, t2;
    gettimeofday(&t1,NULL);
    while(*(int8_t *)(completed_address) == 0);
    gettimeofday(&t2,NULL);

    for(int i=0; i<18; i=i+2) {
        printf("write memory location %d : %d \n",i,*(int16_t *)(write_memory_address + i));
    }
        printf("\n\n");

    for(int i=0; i<18; i=i+2) {
        printf("read memory location %d : %d \n",i,*(int16_t *)(read_memory_address + i));
    }
        printf("\n\n");

//    printf("Num1: %d\nNum2: %d\nResult: %d\n", *(int8_t *)(memory_address), *(int8_t *)(memory_address + 1), sum);
    printf("Result: %d\n", *(int16_t *)(read_memory_address + 20) );
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
