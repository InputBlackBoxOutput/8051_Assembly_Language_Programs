// Assembly program to transmit data via serial communication to pc 
// Written by Rutuparn Pawar     
// Created on 16 Oct 2019

//////////////////////////////////////////////////////////////////////////////////////
ORG 0000H    
MOV SCON,#50H                 
MOV TMOD,#20H  
MOV TH1,#0FDH     
SETB TR1

 L:  MOV A ,#'W'    
     ACALL SEND 
     MOV A ,#'E'    
     ACALL SEND 
 	 MOV A,#'L'    
 	 ACALL SEND 
     MOV A,#'C'    
     ACALL SEND 
     MOV A ,#'O'    
     ACALL SEND 
     MOV A ,#'M'    
     ACALL SEND 
     MOV A,#'E' 
     ACALL SEND 
 
     MOV A,#' '    
     ACALL SEND
 
     MOV A ,#'T'    
     ACALL SEND 
     MOV A ,#'O'    
     ACALL SEND 
 
     MOV A,#' '    
     ACALL SEND

     MOV A ,#'C'      
     ACALL SEND    
     MOV A ,#'O'    
     ACALL SEND    
     MOV A,#'D'    
     ACALL SEND    
     MOV A,#'I'    
     ACALL SEND    
     MOV A ,#'N'    
     ACALL SEND    
     MOV A ,#'G'    
     ACALL SEND 
     MOV A ,#' '    
     ACALL SEND 
     SJMP L

SEND:MOV SBUF,A 
     HERE: JNB TI,HERE       
     CLR TI
     RET 

////////////////////////////////////////////////////////////////////////////////////
END 