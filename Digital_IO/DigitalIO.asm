//Assembly program to interface LED’s, RELAY, BUZZER and SWITCH to 8051. 
//Written by Rutuparn Pawar     
//Created on 11 Sept 2019

/*
* PIN CONNECTIONS
* 
* Function      Port/Pin
* SW1           P0.0
* SW2           P0.1
* LED ARRAY     P1
* RELAY         P0.2
* BUZZER        P0.3
*
* NOTE : 
* 1) The following switch logic has been implemented
*    <CASE>   SW1  SW2    LED ARRAY        RELAY   BUZZER      
*      1       0    0     Flashing         OFF     OFF          
*      2       0    1     Chasing L->R     OFF     ON           
*      3       1    0     Chasing L<-R     ON      OFF
*      4       1    1     BCD count        ON      ON
*
* 2) RELAY & BUZZER pin logic has been inverted since PNP transistors have been used 
*/

///////////////////////////////--ASSEMBLY PROGRAM--/////////////////////////////////////////
SW1 equ P0.0
SW2 equ P0.1
LED equ P1
RELAY equ P0.2
BUZZER equ P0.3

ORG 0000H
    MOV TMOD,#01H     ;Set Timer 0 in 16 bit timer mode (DELAY subroutine)
	
	SETB SW1         ;Configuring pin 1 of port 0 as Input      
	SETB SW2         ;Configuring pin 2 of port 0 as Input 
	
	SETB RELAY         ;Relay off
	SETB BUZZER        ;Buzzer off
	
//////////////////////////////////--MAIN LOOP--////////////////////////////////////////////	

    MAIN:JNB SW1,CASE_TWO
	      CASE_FOUR:JNB SW2,CASE_THREE 
		            ACALL FOUR                 ;CASE 4
		            SJMP MAIN		 
	    
		 CASE_THREE:ACALL THREE            
                    SJMP MAIN                  ;CASE 3
		            		 
		 CASE_TWO:JNB SW2,CASE_ONE             ;CASE 1
		          ACALL TWO
			      SJMP MAIN	
			 
         CASE_ONE:ACALL ONE                    ;CASE 2
                  SJMP MAIN
			
	    
//////////////////////////////////--SUBROUTINES--//////////////////////////////////////////

	ONE: SETB RELAY               ;Relay off
	     SETB BUZZER              ;Buzzer off
		   
	     MOV LED,#00H
	     ACALL DELAY
	     MOV LED,#0FFH
	     ACALL DELAY
		 RET   

	TWO:SETB RELAY            ;Relay off 
	    CLR BUZZER            ;Buzzer on
			 
	    MOV R1,#8             ;Counter
        MOV A,#80H            ;Loading Acc with 1000 0000 
			 
		L3:ACALL DELAY
		   MOV LED,A
		   RR A
		   DJNZ R1,L3
	    RET
			 
    THREE:CLR RELAY              ;Relay on
	      SETB BUZZER            ;Buzzer off
	
	      MOV R1,#8             ;Counter
          MOV A,#01H            ;Loading Acc with 0000 0001 
		  L4:ACALL DELAY
		     MOV LED,A
		     RL A
			 DJNZ R1,L4
	      RET
	
	FOUR:CLR RELAY                  ;Relay on
	     CLR BUZZER                 ;Buzzer on
	
	     MOV R2,#10                 ;Counter 
	     MOV A,#00H                 ;Acc goes from  0000 0000 to 0000 1001 (Decimal 0-9)
	     L5:DA A
		    MOV LED,A
			INC A
	        ACALL DELAY
		    DJNZ R2,L5
		 RET   
	
	DELAY: MOV R0,#14               ;Counter 
	       L2:MOV TH0,#00H
	          MOV TL0,#00H
		      SETB TR0
		      L1: JNB TF0,L1
			  CLR TF0
			  CLR TR0
		      DJNZ R0,L2
		   RET
END	

/////////////////////////////////////////--EOF--////////////////////////////////////////////////