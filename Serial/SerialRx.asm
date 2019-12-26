// Assembly program to recieve data via serial communication and send it to port 2 
// Written by Rutuparn Pawar     
// Created on 16 Oct 2019

////////////////////////////////////////////////////////////////////////////////////
ORG 0000H    
MOV SCON,#50H                                     
MOV TMOD,#20H   
MOV TH1,#0FDH   
 
L: JNB RI,L      
   MOV A, SBUF    
   MOV P2, A    
   CLR RI    
   SJMP L
   
////////////////////////////////////////////////////////////////////////////////////
END          
