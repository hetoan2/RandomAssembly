.set write_address,0x81633000	#where to store the ascii
#change ASCII to store on line 36!!!

.set length,end1-start1
.set blr,0x4E800020
.set numlines,(length+4)/8+(length%8==0)*-1

.int 0XC0000000
.int numlines

start1:
stwu r1,-80(r1)			#allocate room for r14-r31
stmw r14,8(r1)			#load r14-r31 into stackframe
mflr r14

lis r31,write_address@h
ori r31,r31,write_address@l
li r20,0				#reset counter

restart:
bl 0x04					#load next line's address into LR
asm_start:
mflr r30				#move LR to r30
mtlr r14

addi r30,r30,lut_start-asm_start
lbzx r29,r20,r30
cmpwi r29,0
beq finish

stbx r29,r20,r31
addi r20,r20,1
b restart

lut_start:
.ascii "insert your text in between these quotation marks!"
.byte 0					#adds a 0 to end it off
.balign 4,0				#in case it doesn't end evenly

finish:
lmw r14,8(r1)			#read registers r14 to r31 from stack 
addi r1,r1,80	

end1:
.int blr
.balignl 8,0
