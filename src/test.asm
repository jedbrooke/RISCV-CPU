.data
var: 0
.text
;assume each register is initialized to its index number
;rtypes
START:
add x0 x0 x0
add x1 x2 x3
sub x1 x2 x3
sll x1 x2 x3
xor x1 x2 x3
srl x1 x2 x3
sra x1 x2 x3
or x1 x2 x3
and x1 x2 x3

;itypes arithmetic
addi x1 x2 1
slli x1 x2 1
xori x1 x2 1
srli x1 x2 1
srai x1 x2 1
ori x1 x2 1
andi x1 x2 1

;load and store byte
sb x30  0(x0)
lb x1  0(x0)

;none of these branches should be taken
addi x1 x0 1
beq x1 x0 START
bne x0 x0 START
blt x0 x0 START
bge x0 x1 START
bltu x0 x0 START
bgeu x0 x1 START

;all of these branches should be taken
beq x0 x0 NEXT1
add x0 x0 x0
NEXT1:
bne x0 x1 NEXT2
add x0 x0 x0
NEXT2:
blt x0 x1 NEXT3
add x0 x0 x0
NEXT3:
bge x0 x0 NEXT4
add x0 x0 x0
NEXT4:
bltu x0 x1 NEXT5
add x0 x0 x0
NEXT5:
bgeu x0 x0 NEXT6
add x0 x0 x0
NEXT6:
;jump back to start
jal x0 START