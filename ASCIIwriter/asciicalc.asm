.set textlocation,0x80120000	#change this location to your address!
.long 0x42000000,textlocation>>7<<7&0xFF000000
.long textlocation<<7>>7|0x06000000,end-start
start:
.ascii "your text here"
.byte 0
end:
.balign 8
.long 0xE0000000,0x80008000