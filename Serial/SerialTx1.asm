// Assembly program for transmitting Name and ID as data via serial communication to pc 
// Written by Rutuparn Pawar     
// Created on 16 Oct 2019

//////////////////////////////////////////////////////////////////////////////////////
ORG 0500H
SERIAL_DATA: DB "RUTUPARN PAWAR ID:312052",0

ORG 0000H    
MOV SCON,#50H                 
MOV TMOD,#20H  
MOV TH1,#0FDH     
SETB TR1


 
 MAIN:MOV DPTR,#SERIAL_DATA     
      L:CLR A
        MOVC A,@A+DPTR
        ACALL SEND
        INC DPTR
		CJNE A,#0,L
      SJMP MAIN

SEND:MOV SBUF,A 
     HERE: JNB TI,HERE       
     CLR TI
     RET 

////////////////////////////////////////////////////////////////////////////////////
END 