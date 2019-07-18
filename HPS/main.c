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
#include "hps_0.h"

#define HW_REGS_BASE ( 0xff200000 )
#define HW_REGS_SPAN ( 0x00100000 )
#define WRITE_MEM_OFFSET ( 0x00040000 )
#define READ_MEM_OFFSET ( 0x00080000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )

int main() {

	void *virtual_base;
	int fd;
	void *fpga_data_in_addr;
	void *fpga_data_out_addr;

	// map the address space for the LED registers into user space so we can interact with them.
	// we'll actually map in the entire CSR span of the HPS since we want to access various registers within that span

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

	void *start_address = virtual_base + 0x00000030;
	void *completed_address = virtual_base + 0x00000010;
	void *reset_address = virtual_base + 0x00000020;

	fpga_data_in_addr = virtual_base + WRITE_MEM_OFFSET;
	fpga_data_out_addr = virtual_base + READ_MEM_OFFSET;

	int i=0;
	int sequences = 4;
	int windowSize = 1024;
    FILE *sample_data_file, *input_text_file, *output_text_file;
    sample_data_file = fopen("sample_data","r");
    input_text_file = fopen("input.txt","w");
    output_text_file = fopen("output.txt","w");

    if(sample_data_file == NULL || input_text_file == NULL || output_text_file == NULL)
    {
      printf("Error!");
      return 1;
    }

    //Resetting
    *(char *)(start_address) = 0;
    *(char *)(reset_address) = 1;
    *(char *)(reset_address) = 0;

    int8_t num;
    printf("Started Writing\n");
    while(i < windowSize*sequences)
    {
//        num = rand() % 256 - 128;
        fread(&num, sizeof(int8_t), 1, sample_data_file);
        *(int8_t *)(fpga_data_in_addr + i) = num;
        fprintf(input_text_file, "%d\n", num);
        i++;
    }
    fclose(sample_data_file);
    fclose(input_text_file);
    printf("Writing Completed \n");

    i=0;
    printf("\n");

    struct timeval t1, t2;
    *(char *)(start_address) = 1;
    gettimeofday(&t1, NULL);
//    *(char *)(start_address) = 0;
//    printf("Reading sequences ***\n");
    while(*(uint8_t *)(completed_address) != 1);
    gettimeofday(&t2, NULL);
    double elapsedTime = (t2.tv_usec - t1.tv_usec);
    printf("Elapsed time %.0f usec\n", elapsedTime);

    while(i < windowSize*sequences) {
        int8_t val = *(int8_t *)(fpga_data_out_addr +  i);
        fprintf(output_text_file, "%d\n", val);
//        printf("%d ", val);
        i++;
    }
    printf("\n\n");
    fclose(output_text_file);
    // wait 100ms
    usleep( 1000 );

	if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
		printf( "ERROR: munmap() failed...\n" );
		close( fd );
		return( 1 );
	}

	close( fd );

	return( 0 );
}
