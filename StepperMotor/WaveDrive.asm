//Assembly program to rotate stepper motor in wave drive stepping (360 Degree CW and ACW)
//Written by Rutuparn Pawar     
//Created on 6 Nov 2019

/*
PIN CONNECTIONS
Function         Port/Pin
STEPPER MOTOR    P2.0 - P2.3
*/

//////////////////////////////////////////////////////////////////////////////////////////
ORG 0000H 

STEPPER EQU P2

	MOV A,#11H
	MAIN: MOV R0,#48
		  L1:RL A
		     MOV STEPPER,A
		     ACALL DELAY
		     DJNZ R0,L1
		  
		  MOV R0,#48 
		  L2:RR A
		     MOV STEPPER,A
		     ACALL DELAY
		     DJNZ R0,L2

	      SJMP MAIN 
	

DELAY:MOV TMOD,#01H 
	  MOV R0,#7
	  
	  L:MOV TH0,#00H 
	    MOV TL0,#00H 
	    SETB TR0 
	    HERE: JNB TF0,HERE 
	    CLR TF0           
	    CLR TR0          
	    DJNZ R0,L      
	    RET 
//////////////////////////////////////////////////////////////////////////////////////////
END
