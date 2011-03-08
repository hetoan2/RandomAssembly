lhz r3,12(r29)

.set count,0x81647000
.set store,0x81647004

stwu r1,-80(r1)			#allocate room for r14-r31
stmw r14,8(r1)			#load r14-r31 into stackframe

lis r17,count@h
ori r17,r17,count@l
lwz r16,0(r17)
lis r18,store@h
ori r18,r18,store@l

addi r15,r16,1
stw r15,0(r17)
add r18,r16,r18
lbz r30,-1(r18)
cmpw r3,r30				#prevents doubletapping by double execution bug
bne norm
li r3,00
norm:
stb r3,0(r18)

lmw r14,8(r1)			#read registers r14 to r31 from stack 
addi r1,r1,80			#free stackframe
