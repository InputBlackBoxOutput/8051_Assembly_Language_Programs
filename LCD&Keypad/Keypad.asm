//Assembly program to interface 4x4 Keypad and an LCD
//Written by Rutuparn Pawar     
//Created on 24 Sept 2019

/*
PIN CONNECTIONS
Function        Port/Pin
LCD DATA            P3
LCD RS              P2.0
LCD RW              P2.1
LCD EN              P2.2
KEYPAD ROWS         P1
KEYPAD COLUMNS      P0
*/

/////////////////////////////////////////////////////////////////////////////////////////////////////
LCD    EQU P3
RS     EQU P2.0
RW     EQU P2.1
EN     EQU P2.2

//KEYPAD
ROWS EQU P1     	;P1.0-P1.3 connected to rows
COLS EQU P0 		;P0.0-P0.3 connected to column

//////////////////////////////////////////////////////////////////////////////////////////////////////
ORG 0000H
MOV A,#38H 			
ACALL COMMAND 	
MOV A,#0EH 			
ACALL COMMAND 		
K3:MOV a,#01H 		
ACALL COMMAND 		
MOV A,#06H 			
ACALL COMMAND 		
MOV A,#80H 			
ACALL COMMAND 		

MOV DPTR,#LINE
N1:CLR A
MOVC A,@ A+DPTR
ACALL DISPLAY
INC DPTR
JZ L1
AJMP N1

L1: MOV A,#0C0H
ACALL COMMAND
MOV A,#'I'
ACALL DISPLAY
MOV A,#'D'
ACALL DISPLAY
ACALL DISPLAY
MOV A,#':'
ACALL DISPLAY
MOV A,#0CAH 			   
ACALL COMMAND 			   

////////////////////////////////////////////////////////////////////////////////////////////////////////
MOV R4,#00
MOV COLS,#0FFh 			   

K1:MOV ROWS,#00H 		   
   MOV A,COLS 				   
   ANL A,#00001111B 		   
   CJNE A,#00001111B,K1 	   

K2:ACALL DELAY 		   
   MOV A,COLS 				   
   ANL A,#00001111B 		   
   CJNE A,#00001111B,OVER 	   
   SJMP K2 				   

OVER:ACALL DELAY 		   
     MOV A,COLS 				   
     ANL A,#00001111B 		   
     CJNE A,#00001111B,OVER1    
     SJMP K2 				   

OVER1:MOV ROWS,#11111110B 
      MOV A,COLS 				   
      ANL A,#00001111B 		   
      CJNE A,#00001111B,ROW0 	   
      MOV ROWS,#11111101B 	   
      
      MOV A,COLS 				   
      ANL A,#00001111B 		   
      CJNE A,#00001111B,ROW1 	   
      MOV ROWS,#11111011B 	   
      
      MOV A,COLS 				   
      ANL A,#00001111B 		   
      CJNE A,#00001111B,ROW2 	   
	  MOV ROWS,#11110111B 	   

	  MOV A,COLS 				   
	  ANL A,#00001111B 		   
	  CJNE A,#00001111B,ROW3 	   
	  LJMP K2 				   

ROW0:MOV DPTR,#KCODE0 	   
     SJMP FIND 				   

ROW1:MOV DPTR,#KCODE1 	   
     SJMP FIND 				   

ROW2:MOV DPTR,#KCODE2     
     SJMP FIND 				   

ROW3:MOV DPTR,#KCODE3 	   

FIND:RRC A 			   
     JNC MATCH 				   
     INC DPTR 				   
     SJMP FIND

MATCH:CLR A 			   
      MOVC A,@A+DPTR 			   
      MOV R5,A 				   
      ACALL LCD1 				   
      INC R4
	  CJNE R4,#05,K1
	  MOV A,#01H 				   
      ACALL COMMAND 			   
      LJMP K3


//////////////////////////////////////////////////////////////////////////////////////////////
LCD1:MOV A,R5
	 ACALL DISPLAY
	 RET

COMMAND:ACALL DELAY 	        
		MOV LCD,A 				
		CLR RS 					
		CLR RW 					

		SETB EN 				
		NOP
		CLR EN 					
		RET

DISPLAY:ACALL DELAY 	        
        MOV LCD,A 				
		SETB RS 				
		CLR RW 					

		SETB EN 				
		NOP                      
		CLR EN 					
		RET


DELAY: MOV R2,#0FH
	   AGAIN1: MOV R3,#0F0H
       AGAIN2: NOP
       DJNZ R3,AGAIN2
       DJNZ R2,AGAIN1
       RET

///////////////////////////////////////////////////////////////////////////////////////////////
ORG 0500H
LINE: DB" RUTUPARN ",0
KCODE0: DB '0','1','2','3'
KCODE1: DB '4','5','6','7'
KCODE2: DB '8','9','A','B'
KCODE3: DB 'C','D','E','F'

///////////////////////////////////////////////////////////////////////////////////////////////
END