//Assembly program to interface 2 line 16 character lcd display in 4 bit mode
//Written by Rutuparn Pawar     
//Created on 24 Sept 2019

/*
PIN CONNECTIONS
Function        Port/Pin
LCD DATA        P0    (First 4 Port0 Pins)
RS              P1.0
RW              P1.1
EN              P1.2

WHAT IS DISPLAYED ON LCD
LINE 1 - <My Name>
LINE 2 - <My ID>
*/

/////////////////////////////////- ASSEMBLY PROGRAM -///////////////////////////////
LCD EQU P0
RS EQU P1.0
RW EQU P1.1
EN EQU P1.2

/////////////////////////////- LCD CONFIG/DISPLAY DATA -///////////////////////////
ORG 0300H
	CONFIG : DB 28H,0EH,01H,06H,84H,0
	STRING_ONE : DB "Rutuparn",0
    STRING_TWO : DB "312052",0

//////////////////////////////////////- MAIN -/////////////////////////////////////
ORG 0000H
	    
		MOV DPTR,#CONFIG
		L1:CLR A
		   MOVC A,@A+DPTR
		   ACALL COMMAND
		   INC DPTR
		   JZ SEND_ONE
		   SJMP L1
		
		SEND_ONE:MOV DPTR,#STRING_ONE             ;Display line 1
		         L2:CLR A
		            MOVC A,@A+DPTR
		            ACALL DISPLAY
		            INC DPTR
		            JZ SEND_TWO
				    SJMP L2
					 
		SEND_TWO:MOV A,#0C0H                      ;Display line 2
		         ACALL COMMAND
				 MOV DPTR,#STRING_TWO
		         L3:CLR A
		            MOVC A,@A+DPTR
		            ACALL DISPLAY
		            INC DPTR
		            JZ LOOP
				    SJMP L3
					
		LOOP:SJMP LOOP

//////////////////////////////////- SUBROUTINES -//////////////////////////////////
//Subroutine to send comands to LCD
COMMAND:MOV R1,A
        ANL A,#0F0H
		SWAP A
		MOV LCD,A
		
		CLR RS
		CLR RW
		SETB EN
		NOP
		CLR EN
		
		MOV R1,A
        ANL A,#0FH
		MOV LCD,A
		
		CLR RS
		CLR RW
		SETB EN
		NOP
		CLR EN
		
		ACALL DELAY
		RET

//Subroutines to send display data to LCD
DISPLAY:MOV R1,A
        ANL A,#0F0H
		SWAP A
		MOV LCD,A
		
		SETB RS
		CLR RW
		SETB EN
		NOP
		CLR EN
		
		MOV R1,A
        ANL A,#0FH
		MOV LCD,A
		
		SETB RS
		CLR RW
		SETB EN
		NOP
		CLR EN
		
		ACALL DELAY
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
	  
//////////////////////////////////////////////////////////////////////////////////////////////
END