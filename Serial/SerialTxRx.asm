// Assembly program to recieve data via serial communication and send it back to the PC
// Written by Rutuparn Pawar     
// Created on 16 Oct 2019

 ORG 0000H
 MOV TMOD,#20H             
 MOV TH1,#0FAH             ;Baud rate = 4800
 MOV SCON,#50H            

 SETB TR1                  

 HERE1: JNB RI ,HERE1        
 MOV A,SBUF                
 CLR RI                    

 MOV P2,A

 MOV SBUF,A                  
 HERE2: JNB TI ,HERE2       
 CLR TI                     
 
 SJMP HERE1                                   
 END