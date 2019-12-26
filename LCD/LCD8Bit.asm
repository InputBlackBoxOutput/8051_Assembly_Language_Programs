//Assembly program to interface 2 line 16 character lcd display in 8 bit mode
//Written by Rutuparn Pawar     
//Created on 24 Sept 2019

/*
PIN CONNECTIONS
Function        Port/Pin
LCD DATA        P1
RS              P2.0
RW              P2.1
EN              P2.2

WHAT IS DISPLAYED ON LCD
LINE 1 -> WELCOME
LINE 2 -> TO ASSEMBLY
*/
/////////////////////////////////- ASSEMBLY PROGRAM -///////////////////////////////
LCD EQU P1
RS EQU P2.0
RW EQU P2.1
EN EQU P2.2

////////////////////////////- LCD CONFIG/DISPLAY DATA -///////////////////////////
ORG 0300H
	CONFIG : DB 38H,0EH,01H,06H,84H,0
	STRING_ONE : DB "WELCOME",0
	STRING_TWO : DB "TO ASSEMBLY",0


//////////////////////////////////////- MAIN -/////////////////////////////////////
ORG 0000H
	    
		MOV DPTR,#CONFIG
		L1:CLR A
		   MOVC A,@A+DPTR
		   ACALL COMMAND
		   INC DPTR
		   JZ SEND_ONE
		   SJMP L1
		
		SEND_ONE:MOV DPTR,#STRING_ONE          ;Display 1st line
		         L2:CLR A
		            MOVC A,@A+DPTR
					JZ SEND_TWO
		            ACALL DISPLAY
		            INC DPTR
				    SJMP L2
					 
		SEND_TWO:MOV A,#0C0H                   ; Display 2nd line
		         ACALL COMMAND
				 MOV DPTR,#STRING_TWO
		         L3:CLR A
		            MOVC A,@A+DPTR
					JZ LOOP
		            ACALL DISPLAY
		            INC DPTR
				    SJMP L3
					
		LOOP:SJMP LOOP


///////////////////////////////////- SUBROUTINES -/////////////////////////////////
//Subroutine to send commands to LCD
COMMAND:MOV LCD,A
        ACALL DELAY
		
		CLR RS
		CLR RW
		SETB EN
		NOP
		CLR EN
		RET
	
//Subroutine to send display data to LCD	
DISPLAY:MOV LCD,A
        ACALL DELAY
		
		SETB RS
		CLR RW
		SETB EN
		NOP
		CLR EN
		RET

//Subroutine to generate 1.64 milli-second delay
DELAY:MOV TMOD,#01H              
      MOV TH0,#0FAH
	  MOV TL0,#19H
	  SETB TR0
	  L:JNB TF0,L
	  CLR TF0
	  CLR TR0
	  RET

/////////////////////////////////////////////////////////////////////////////////////////////////
END