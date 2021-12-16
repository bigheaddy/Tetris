initalize: nop
addi $20 $0 20
sw $20 2668($0)
addi $25 $0 1
sll  $29 $25 $20     
addi $30 $0 456
addi $8 $0 0 # score
addi $11 $0 0 # rotate times

addi $20 $0 101 # 'e'
addi $21 $0 97 # 'a'
addi $22 $0 115 # 's'
addi $23 $0 100 # 'd'
addi $24 $0 119 # 'w'

loop:input $10
beq $10 $20 main # start game
j loop


main:jal checkstatus
j checkline
endCheckline:nop

getNewShape:lw $5 0($29)
addi $9 $0 0
beq $5 $9 Lshape # 0
addi $9 $9 1
beq $5 $9 cube # 1
addi $9 $9 1
beq $5 $9 oneshape # 2
addi $9 $9 1
beq $5 $9 flash # 3
addi $9 $9 1
beq $5 $9 mountain # 4
addi $9 $9 1
beq $5 $9 VLshape # 5
addi $9 $9 1
beq $5 $9 Vflash # 6
j getNewShape


downloop:nop #main loop!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

keyboard:addi $9 $0 1
lw $28 2668($0)
sll $9 $9 $28
minusOne:addi $9 $9 -1

addi $17 $0 112 # 'p' --- pause/ continue
addi $13 $0 107 # 'k' --- speedup
addi $12 $0 114 # 'r' ---- reset
addi $10 $0 0
input $10
beq $10 $22 speedup
beq $10 $21 left
beq $10 $23 right
beq $10 $24 rotate
beq $10 $17 pause
beq $10 $13 higherSpeed
beq $10 $12 reset
bgt $9 $0 minusOne


naturalDown:j down
naturalDownOver:j downloop #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

needdown_check:lw $18 2666($0)
addi $18 $18 1
sw $18 2666($0)
addi $15 $0 2
bgt $18 $15 needdown
j keyboard

needdown:sw $0 2666($0)
j down


pause:addi $10 $0 0
addi $17 $0 112
input $10
beq $10 $17 keyboard
j pause

higherSpeed:lw $17 2668($0)
addi $17 $17 -1
sw $17 2668($0)
j keyboard


down: nop #  ============= natural down ======================

sw $0 256($1)
sw $0 256($2)
sw $0 256($3)
sw $0 256($4)
addi $1 $1 10
addi $2 $2 10
addi $3 $3 10
addi $4 $4 10
addi $16 $16 10
j clash
endClash:sw $5 256($1)
sw $5 256($2)
sw $5 256($3)
sw $5 256($4)
jal write
j naturalDownOver


clash:lw $7 256($1)
beq $7 $0 clash2
j downMend

clash2:lw $7 256($2)
beq $7 $0 clash3
j downMend

clash3:lw $7 256($3)
beq $7 $0 clash4
j downMend

clash4:lw $7 256($4)
beq $7 $0 clashReturn
j downMend
clashReturn:j endClash

downMend:nop
addi $1 $1 -10
addi $2 $2 -10
addi $3 $3 -10
addi $4 $4 -10
addi $16 $16 -10
sw $5 256($1)
sw $5 256($2)
sw $5 256($3)
sw $5 256($4)
j main

speedup: nop #  ============= speedup down ======================
sw $0 256($1)
sw $0 256($2)
sw $0 256($3)
sw $0 256($4)
addi $1 $1 10
addi $2 $2 10
addi $3 $3 10
addi $4 $4 10
addi $16 $16 10

j speedupclash
endspeedupClash:sw $5 256($1)
sw $5 256($2)
sw $5 256($3)
sw $5 256($4)
jal write
j keyboard

speedupclash:lw $7 256($1)
beq $7 $0 speedupclash2
j downMend

speedupclash2:lw $7 256($2)
beq $7 $0 speedupclash3
j downMend

speedupclash3:lw $7 256($3)
beq $7 $0 speedupclash4
j downMend

speedupclash4:lw $7 256($4)
beq $7 $0 speedupclashReturn
j downMend
speedupclashReturn:j endspeedupClash



left:nop #  ============= left ======================
sw $0 256($1)
sw $0 256($2)
sw $0 256($3)
sw $0 256($4)
addi $1 $1 -1
addi $2 $2 -1
addi $3 $3 -1
addi $4 $4 -1
addi $16 $16 -1

j leftclash
endleftClash:sw $5 256($1)
sw $5 256($2)
sw $5 256($3)
sw $5 256($4)
jal write
j needdown_check


leftclash:lw $7 256($1)
beq $7 $0 leftclashLEFTBOUNDcheck1 # no other object in the left
j leftMend
leftclashLEFTBOUNDover1:j leftclash2

leftclash2:lw $7 256($2)
beq $7 $0 leftclashLEFTBOUNDcheck2
j leftMend
leftclashLEFTBOUNDover2:j leftclash3

leftclash3:lw $7 256($3)
beq $7 $0 leftclashLEFTBOUNDcheck3
j leftMend
leftclashLEFTBOUNDover3:j leftclash4

leftclash4:lw $7 256($4)
beq $7 $0 leftclashLEFTBOUNDcheck4
j leftMend
leftclashLEFTBOUNDover4:j leftclashReturn
leftclashReturn:j endleftClash

leftclashLEFTBOUNDcheck1:addi $18 $1 0
j leftboundcheckBEGIN
leftclashLEFTBOUNDcheck2:addi $18 $2 0
j leftboundcheckBEGIN
leftclashLEFTBOUNDcheck3:addi $18 $3 0
j leftboundcheckBEGIN
leftclashLEFTBOUNDcheck4:addi $18 $4 0
leftboundcheckBEGIN:addi $17 $0 -1
beq $18 $17 leftMend # if $1 == -1
addi $25 $0 199
leftcheckloop:addi $17 $17 10
beq $18 $17 leftMend # if $ == 19, 29, 39, ...,199
bgt $25 $17 leftcheckloop #if $17 < $25(199)

beq $18 $1 leftclashLEFTBOUNDover1
beq $18 $2 leftclashLEFTBOUNDover2
beq $18 $3 leftclashLEFTBOUNDover3
beq $18 $4 leftclashLEFTBOUNDover4


leftMend:nop
addi $1 $1 1
addi $2 $2 1
addi $3 $3 1
addi $4 $4 1
addi $16 $16 1
sw $5 256($1)
sw $5 256($2)
sw $5 256($3)
sw $5 256($4)
j endleftClash


right:nop #  ============= right ======================
sw $0 256($1)
sw $0 256($2)
sw $0 256($3)
sw $0 256($4)
addi $1 $1 1
addi $2 $2 1
addi $3 $3 1
addi $4 $4 1
addi $16 $16 1
j rightclash
endrightClash:sw $5 256($1)
sw $5 256($2)
sw $5 256($3)
sw $5 256($4)
jal write
j needdown_check


rightclash:lw $7 256($1)
beq $7 $0 rightclashLEFTBOUNDcheck1
j rightMend
rightclashLEFTBOUNDover1:j rightclash2

rightclash2:lw $7 256($2)
beq $7 $0 rightclashLEFTBOUNDcheck2
j rightMend
rightclashLEFTBOUNDover2:j rightclash3

rightclash3:lw $7 256($3)
beq $7 $0 rightclashLEFTBOUNDcheck3
j rightMend
rightclashLEFTBOUNDover3:j rightclash4

rightclash4:lw $7 256($4)
beq $7 $0 rightclashLEFTBOUNDcheck4
j rightMend
rightclashLEFTBOUNDover4:j rightclashReturn
rightclashReturn:j endrightClash


rightclashLEFTBOUNDcheck1:addi $18 $1 0
j rightboundcheckBEGIN
rightclashLEFTBOUNDcheck2:addi $18 $2 0
j rightboundcheckBEGIN
rightclashLEFTBOUNDcheck3:addi $18 $3 0
j rightboundcheckBEGIN
rightclashLEFTBOUNDcheck4:addi $18 $4 0
rightboundcheckBEGIN:addi $17 $0 -10
beq $18 $17 rightMend # if $1 == -10
addi $25 $0 190
rightcheckloop:addi $17 $17 10
beq $18 $17 rightMend # if $ == 10,20,...,190
bgt $25 $17 rightcheckloop #if $17 < $25(190)

beq $18 $1 rightclashLEFTBOUNDover1
beq $18 $2 rightclashLEFTBOUNDover2
beq $18 $3 rightclashLEFTBOUNDover3
beq $18 $4 rightclashLEFTBOUNDover4


rightMend:nop
addi $1 $1 -1
addi $2 $2 -1
addi $3 $3 -1
addi $4 $4 -1
sw $5 256($1)
sw $5 256($2)
sw $5 256($3)
sw $5 256($4)
j endrightClash



checkline:nop #  ============= checkline ======================
addi $27 $0 255
addi $28 $0 456
checkNewLine:addi $28 $28 -10
bgt $27 $28 endCheckline

checkCurrLine:addi $25 $28 10 

addi $26 $28 0
checkNewBlock:nop
lw $7 0($26)
beq $7 $0 checkNewLine
addi $26 $26 1
bgt $25 $26 checkNewBlock
j eraseLine


eraseLine:nop
addi $8 $8 1 # erase 1 score, speedup 2x
nop #score plus plus +++++++++++++++++++++++++++++++++++++++++++++++
addi $26 $25 -1 # reverse iterator
eraseLineload:lw $7 -10($26)
sw $7 0($26)
addi $26 $26 -1
bgt $26 $27 eraseLineload
jal write
j checkline

saveInitial:sw $5 256($1)
sw $5 256($2)
sw $5 256($3)
sw $5 256($4)
sw $0 2666($0)
jal write


rotate:nop #  ============= rotate ======================
addi $11 $11 1 # times++
lw $15 3300($5) #tempx1
lw $19 3310($5) #tempy1
sw $0 256($1)
sw $0 256($2)
sw $0 256($3)
sw $0 256($4)
j judgeTimes
rotateFAIL:sw $5 256($1)
sw $5 256($2)
sw $5 256($3)
sw $5 256($4)
j needdown_check


judgeTimes:nop
beq $11 $0 ratatefuntion0 # times == 0
addi $12 $0 1
beq $11 $12 ratatefuntion1 # times == 1
addi $12 $12 1
beq $11 $12 ratatefuntion2 # times == 2
addi $12 $12 1
beq $12 $11 ratatefuntion3 # times == 3

ratatefuntion0:nop
addi $14 $0 0 # newPI calculating...
addi $14 $19 0
add $14 $14 $19
add $14 $14 $19
add $14 $14 $19
add $14 $14 $15 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $1
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3000($0) # if $1 rotate success, save its new value to Addr3000 temply

addi $14 $0 0 #check $2 beging...
lw $15 3320($5) #tempx2
lw $19 3330($5) #tempy2
addi $14 $0 0 # newPI calculating...
addi $14 $19 0
add $14 $14 $19
add $14 $14 $19
add $14 $14 $19
add $14 $14 $15 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $2
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3001($0) # if $2 rotate success, save its new value to Addr3000 temply

addi $14 $0 0 #check $3 beging...
lw $15 3340($5) #tempx3
lw $19 3350($5) #tempy3
addi $14 $0 0 # newPI calculating...
addi $14 $19 0
add $14 $14 $19
add $14 $14 $19
add $14 $14 $19
add $14 $14 $15 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $3
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3002($0) # if $3 rotate success, save its new value to Addr3000 temply

addi $14 $0 0 #check $4 beging...
lw $15 3360($5) #tempx4
lw $19 3370($5) #tempy4
addi $14 $0 0 # newPI calculating...
addi $14 $19 0
add $14 $14 $19
add $14 $14 $19
add $14 $14 $19
add $14 $14 $15 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $4
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3003($0) # if $4 rotate success, save its new value to Addr3000 temply

sw $0 256($1)
sw $0 256($2)
sw $0 256($3)
sw $0 256($4)
lw $1 3000($0) # load those new address from Dmem
lw $2 3001($0)
lw $3 3002($0)
lw $4 3003($0)
sw $5 256($1)
sw $5 256($2)
sw $5 256($3)
sw $5 256($4)
jal write
j needdown_check # rotate successfully




ratatefuntion1:nop
addi $14 $0 0 # newPI calculating...
addi $14 $14 12
add $14 $14 $19
sub $14 $14 $15
sub $14 $14 $15
sub $14 $14 $15
sub $14 $14 $15 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $1
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3000($0) # if $1 rotate success, save its new value to Addr3000 temply

addi $14 $0 0 #check $2 beging...
lw $15 3320($5) #tempx2
lw $19 3330($5) #tempy2
addi $14 $0 0 # newPI calculating...
addi $14 $0 12
add $14 $14 $19
sub $14 $14 $15
sub $14 $14 $15
sub $14 $14 $15
sub $14 $14 $15 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $2
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3001($0) # if $2 rotate success, save its new value to Addr3000 temply

addi $14 $0 0 #check $3 beging...
lw $15 3340($5) #tempx3
lw $19 3350($5) #tempy3
addi $14 $0 0 # newPI calculating...
addi $14 $0 12
add $14 $14 $19
sub $14 $14 $15
sub $14 $14 $15
sub $14 $14 $15
sub $14 $14 $15 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $3
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3002($0) # if $3 rotate success, save its new value to Addr3000 temply

addi $14 $0 0 #check $4 beging...
lw $15 3360($5) #tempx4
lw $19 3370($5) #tempy4
addi $14 $0 0 # newPI calculating...
addi $14 $0 12
add $14 $14 $19
sub $14 $14 $15
sub $14 $14 $15
sub $14 $14 $15
sub $14 $14 $15 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $4
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3003($0) # if $4 rotate success, save its new value to Addr3000 temply

sw $0 256($1)
sw $0 256($2)
sw $0 256($3)
sw $0 256($4)
lw $1 3000($0) # load those new address from Dmem
lw $2 3001($0)
lw $3 3002($0)
lw $4 3003($0)

sw $5 256($1)
sw $5 256($2)
sw $5 256($3)
sw $5 256($4)
jal write
j needdown_check # rotate successfully

ratatefuntion2:nop
addi $14 $0 0 # newPI calculating...
addi $14 $0 15
sub $14 $14 $19
sub $14 $14 $19
sub $14 $14 $19
sub $14 $14 $19
sub $14 $14 $15 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $1
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3000($0) # if $1 rotate success, save its new value to Addr3000 temply

addi $14 $0 0 #check $2 beging...
lw $15 3320($5) #tempx2
lw $19 3330($5) #tempy2
addi $14 $0 0 # newPI calculating...
addi $14 $0 15
sub $14 $14 $19
sub $14 $14 $19
sub $14 $14 $19
sub $14 $14 $19
sub $14 $14 $15 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $2
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3001($0) # if $2 rotate success, save its new value to Addr3000 temply

addi $14 $0 0 #check $3 beging...
lw $15 3340($5) #tempx3
lw $19 3350($5) #tempy3
addi $14 $0 0 # newPI calculating...
addi $14 $0 15
sub $14 $14 $19
sub $14 $14 $19
sub $14 $14 $19
sub $14 $14 $19
sub $14 $14 $15 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $3
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3002($0) # if $3 rotate success, save its new value to Addr3000 temply

addi $14 $0 0 #check $4 beging...
lw $15 3360($5) #tempx4
lw $19 3370($5) #tempy4
addi $14 $0 0 # newPI calculating...
addi $14 $0 15
sub $14 $14 $19
sub $14 $14 $19
sub $14 $14 $19
sub $14 $14 $19
sub $14 $14 $15 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $4
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3003($0) # if $4 rotate success, save its new value to Addr3000 temply

sw $0 256($1)
sw $0 256($2)
sw $0 256($3)
sw $0 256($4)
lw $1 3000($0) # load those new address from Dmem
lw $2 3001($0)
lw $3 3002($0)
lw $4 3003($0)
sw $5 256($1)
sw $5 256($2)
sw $5 256($3)
sw $5 256($4)
jal write
j needdown_check # rotate successfully

ratatefuntion3:nop
addi $11 $0 -1 # reset times = 0
addi $14 $0 0 # newPI calculating...
addi $14 $0 3
add $14 $14 $15
add $14 $14 $15
add $14 $14 $15
add $14 $14 $15
sub $14 $14 $19 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $1
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3000($0) # if $1 rotate success, save its new value to Addr3000 temply

addi $14 $0 0 #check $2 beging...
lw $15 3320($5) #tempx2
lw $19 3330($5) #tempy2
addi $14 $0 0 # newPI calculating...
addi $14 $0 3
add $14 $14 $15
add $14 $14 $15
add $14 $14 $15
add $14 $14 $15
sub $14 $14 $19 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $2
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3001($0) # if $2 rotate success, save its new value to Addr3000 temply

addi $14 $0 0 #check $3 beging...
lw $15 3340($5) #tempx3
lw $19 3350($5) #tempy3
addi $14 $0 0 # newPI calculating...
addi $14 $0 3
add $14 $14 $15
add $14 $14 $15
add $14 $14 $15
add $14 $14 $15
sub $14 $14 $19 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $3
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3002($0) # if $3 rotate success, save its new value to Addr3000 temply

addi $14 $0 0 #check $4 beging...
lw $15 3360($5) #tempx4
lw $19 3370($5) #tempy4
addi $14 $0 0 # newPI calculating...
addi $14 $0 3
add $14 $14 $15
add $14 $14 $15
add $14 $14 $15
add $14 $14 $15
sub $14 $14 $19 # new pi calculate over
lw $6 2200($14)
add $6 $6 $16 # new temp $4
lw $26 256($6)
bgt $26 $0 rotateFAIL # new rotate location has sth, rotate fail
sw $6 3003($0) # if $4 rotate success, save its new value to Addr3000 temply

sw $0 256($1)
sw $0 256($2)
sw $0 256($3)
sw $0 256($4)
lw $1 3000($0) # load those new address from Dmem
lw $2 3001($0)
lw $3 3002($0)
lw $4 3003($0)
sw $5 256($1)
sw $5 256($2)
sw $5 256($3)
sw $5 256($4)
jal write
j needdown_check # rotate successfully





Lshape:addi $5 $0 1 # L shape [success rotate test!]
addi $1 $0 -4
addi $2 $0 4
addi $3 $0 5
addi $4 $0 6
addi $16 $0 -17 # currentXY's index
j saveInitial

cube:addi $5 $0 2 #cube shape [success]
addi $1 $0 -6
addi $2 $0 -5
addi $3 $0 4
addi $4 $0 5
addi $16 $0 -17
j saveInitial


oneshape:addi $5 $0 3 # I shape [success]
addi $1 $0 -25
addi $2 $0 -15
addi $3 $0 -5
addi $4 $0 5
addi $16 $0 -27 # currentXY's index
j saveInitial

flash:addi $5 $0 4 # flash shape [success]
addi $1 $0 -16
addi $2 $0 -6
addi $3 $0 -5
addi $4 $0 5
addi $16 $0 -17 # currentXY's index
j saveInitial

mountain:addi $5 $0 5 # flash shape [success]
addi $1 $0 -15
addi $2 $0 -5
addi $3 $0 -4
addi $4 $0 5
addi $16 $0 -17 # currentXY's index
j saveInitial

VLshape:addi $5 $0 6 # flash shape [success]
addi $1 $0 4
addi $2 $0 5
addi $3 $0 -5
addi $4 $0 -15
addi $16 $0 -17 # currentXY's index
j saveInitial

Vflash:addi $5 $0 7 # flash shape [success]
addi $1 $0 4
addi $2 $0 -6
addi $3 $0 -5
addi $4 $0 -15
addi $16 $0 -17 # currentXY's index
j saveInitial

write:addi $27 $0 256    
add $26 $29 $0
store: lw $28 0($27)
sw $28 0($26)
addi $26 $26 1
addi $27 $27 1
bgt $30 $27 store
jr $31

checkstatus:addi $17 $0 9
islive:lw $13 256($17)
bgt $13 $0 gameover
addi $17 $17 -1
bgt $17 $0 islive # check die or live
j higherSpeed2xcheck
higherSpeed2xOver:jr $31

higherSpeed2xcheck:addi $13 $0 5
lw $17 2669($0)
sub $17 $8 $17
beq $13 $17 higherSpeed2x # everytime add 5 points, speed 2x
j higherSpeed2xOver

higherSpeed2x:lw $17 2668($0)
addi $17 $17 -2
sw $17 2668($0)
sw $8 2669($0)
j higherSpeed2xOver


gameover:addi $17 $0 114 #'r' ---- reset
addi $10 $0 0
input $10
beq $10 $17 reset
j gameover

reset:addi $17 $0 200
resetVal:sw $0 256($17)
addi $17 $17 -1
bgt $17 $0 resetVal
jal write
addi $17 $0 20
sw $17 2668($0)
addi $8 $0 0
j main
