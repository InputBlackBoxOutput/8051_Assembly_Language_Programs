//Assembly program to rotate stepper motor in half drive stepping (360 Degree CW and ACW)
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

MAIN: MOV R0,#12
	  L1:MOV STEPPER,#99H
		 ACALL DELAY 
		 MOV STEPPER,#88H 
		 ACALL DELAY 
		 MOV STEPPER,#0CCH 
		 ACALL DELAY 
		 MOV STEPPER,#44H 
		 ACALL DELAY 
		 MOV STEPPER,#66H 
		 ACALL DELAY 
		 MOV STEPPER,#22H 
		 ACALL DELAY 
		 MOV STEPPER,#33H 
		 ACALL DELAY 
		 MOV STEPPER,#11H 
		 ACALL DELAY 
	     DJNZ R0,L1 
      
      MOV R0,#12
	  L2:MOV STEPPER,#11H
		 ACALL DELAY 
		 MOV STEPPER,#33H 
		 ACALL DELAY 
		 MOV STEPPER,#22H 
		 ACALL DELAY 
		 MOV STEPPER,#66H 
		 ACALL DELAY 
		 MOV STEPPER,#44H 
		 ACALL DELAY 
		 MOV STEPPER,#0CCH 
		 ACALL DELAY 
		 MOV STEPPER,#88H 
		 ACALL DELAY 
		 MOV STEPPER,#99H 
		 ACALL DELAY 
	     DJNZ R0,L2 

	  SJMP MAIN   

DELAY:MOV TMOD,#01H 
	  MOV R0,#07 
	  
	  L:MOV TH0,#00H 
	    MOV TL0,#00H 
	    SETB TR0 
	    HERE: JNB TF0,HERE 
	    CLR TF0           
	    CLR TR0          
	    DJNZ R0,L      
	    RET  
///////////////////////////////////////////////////////////////////////////////////////
END
