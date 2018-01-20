/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

 #include <stdio.h>
 #include "platform.h"
 #include "xil_types.h"
 #include "xstatus.h"
 #include "xil_io.h"
 #define base 0x44A00000
 #define slv0 0
 #define slv1 4
 #define slv2 8
 #define slv3 12
 #define slv4 16
 #define slv5 20
 #define slv6 24
 #define slv7 28
 #define slv8 32
 #define slv9 36
 
 #define write(baseAddr, regOff, data)\
   Xil_Out32((baseAddr) + (regOff) , (u32)(data))
 #define read(baseAddr, regOff) \
   Xil_In32((baseAddr), + (regOff))
 
 void print(char *str);
 
 int main()
 {
    init_platform();
 

    //SMART PARKING
    write(base, slv2, 0x00000000);
    write(base, slv2, 0x00000047);
    write(base, slv2, 0x00000046);
    write(base, slv2, 0x00000065);
    write(base, slv2, 0x00000046);
    write(base, slv2, 0x00000065);
    write(base, slv2, 0x00000046);
    write(base, slv2, 0x00000065);
    write(base, slv2, 0x00000046);
    write(base, slv2, 0x00000065);
    write(base, slv2, 0x00000046);
    write(base, slv2, 0x00000065);
    write(base, slv2, 0x00000046);
    write(base, slv2, 0x00000055);
    write(base, slv2, 0x00000046);
    write(base, slv2, 0x00000065);
    write(base, slv2, 0x00000046);
    write(base, slv2, 0x00000047);
    write(base, slv2, 0x00000046);
    write(base, slv2, 0x00000000);

    write(base, slv1, 0x000056CE);
    write(base, slv0, 0x00000001);
    write(base, slv0, 0x00000000);
 
    //WATERING SYSTEM
    write(base, slv3, 0x000004C8); //clock 1224
    write(base, slv4, 0x0000000A); //data 10
    write(base, slv5, 0x0000003C); //Temp 
    write(base, slv6, 0x00000010); //command

    //SECURITY SYSTEM
    write(base, slv7, 0x00000000); //door
    write(base, slv8, 0x00000000); //window
    write(base, slv9, 0x00000000); //command

    write(base, slv9, 0x00000047); //#
    write(base, slv9, 0x00000082); //A
    write(base, slv9, 0x00000055); //*
    write(base, slv9, 0x00000062); //1
    write(base, slv9, 0x00000065); //2
    write(base, slv9, 0x00000066); //3
    write(base, slv9, 0x00000069); //4
    write(base, slv9, 0x00000054); //*
    write(base, slv9, 0x00000069); //4
    write(base, slv9, 0x00000066); //3
    write(base, slv9, 0x00000065); //2
    write(base, slv9, 0x00000062); //1
    write(base, slv9, 0x00000047); //#

    //Armed
    
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    
    
    write(base, slv9, 0x00000046); //#
    write(base, slv9, 0x00000083); //A
    write(base, slv9, 0x00000054); //*
    write(base, slv9, 0x00000063); //1
    write(base, slv9, 0x00000046); //#

    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    write(base, slv9, 0x00000020); //#
    
    write(base, slv7, 0x00000001); //door
    write(base, slv9, 0x00000047); //#
    write(base, slv9, 0x00000062); //1
    write(base, slv9, 0x00000065); //2
    write(base, slv9, 0x00000066); //3
    write(base, slv9, 0x00000069); //4
    write(base, slv9, 0x00000046); //#
    

 
    cleanup_platform();
    return 0;
 }