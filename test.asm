addi x9, x0, 0
addi x10, x0, 800
addi x11, x0, 1600
addi x1, x0, 100
beq x1, x0, 44
lw x2, 0(x9)
lw x3, 0(x10)
addi x9, x9, 8
addi x10, x10, 8
add x4, x2, x3
slli x4, x4, 4
sw x4,0(x11)
addi x11, x11, 8
addi x1, x1, -1
jal x0, -40
addi x20, x0, 100
