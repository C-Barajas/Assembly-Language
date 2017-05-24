*----------------------------------------------------------------------
* Programmer: Christian Barajas
* Class Account: masc0226
* Assignment or Title: Program #3
* Filename: prog3.s
* Date completed:  11-20-2015
*----------------------------------------------------------------------
* Problem statement: Gives change for given amount of money
* Input: User inputs an amount of currency in dollars
* Output: Appropriate list of bills and coins equal to amount inputted
* Error conditions tested: User inputs of invalid amount or symbols
* Included files: 
* Method and/or pseudocode: Change Calculator
* References: 
*----------------------------------------------------------------------
*
        ORG     $0
        DC.L    $3000           * Stack pointer value after a reset
        DC.L    start           * Program counter value after a reset
        ORG     $3000           * Start at location 3000 Hex
*
*----------------------------------------------------------------------
*
#minclude /home/ma/cs237/bsvc/iomacs.s
#minclude /home/ma/cs237/bsvc/evtmacs.s
*
*----------------------------------------------------------------------
*
* Register use
*
*----------------------------------------------------------------------
*
start:  initIO                  * Initialize (required for I/O)
	setEVT			* Error handling routines
*	initF			* For floating point macros only	

	lineout header
	lineout space
	
input:	lineout prompt
	linein 	buffer
	stripp	buffer,D0
	lea	buffer,A0
	
	TST.w	D0		* checks if input is empty
	BLE	invalid
	cmpi.b	#8,D0		* checks if input string is <= 8
	BHI 	invalid
	
	move.l	D0,D1		* make copy of input into D1
	subq.l	#3,D1		* subtract 3 to get decimal point from right
	adda.l	D1,A0		* A0 should now point to decimal point
	cmpi.b	#'.',(A0)	* checks input for decimal point /  and if 
	BNE	invalid		* A0 is pointing to a decimal point else invalid entry
	
	subq.l	#1,D1
	move.b	1(A0),(A0)	* shifts first digit in cents left 1
	move.b	2(A0),1(A0)	* shifts second digit in cents left 1
				* decimal point is now gone
	lea	buffer,A1
	move.l	D0,D2		* second copy of input into D2
	subq.l	#2,D2
check:	cmpi.b	#'0',(A1)	* cheks if each digit of input is an integer 0-9
	BLO	invalid		* invalid entry if a digit is something other than an integer
	cmpi.b	#'9',(A1)+	* checks input for valid entry, integers 0-9
	BHI	invalid
	DBRA	D2,check	* if a digit passes continues looping for rest of digits
	
	move.l	D0,D3		* third copy of input into D3
	subq.l	#3,D3		* gets number of bytes for conversion
	cvta2	buffer,D3	* convert input into two's-compliment
	cmpi.l	#$00007FFF,D0	* checks in input <= 32767.99(maximum value accepted)
	BGT	invalid		* if input > 32767.99, then invalid entry
	
	move.l	#5,D4		* amount of times to loop for dollar denominations
	lea	divs,A2
	lea	mods,A3
	move.l	D0,D5		* fourth copy of input into D5
dollar:	divu	(A3)+,D5	* divides input by first mod then points A3 to next mod
	move.w	D5,(A2)+
	swap 	D5
	ext.l	D5
	DBRA	D4,dollar	* decriments D4 then continues loop until D4 is 0
	
	move.l	#4,D6		* amount of times to loop for cent denominations
	move.b	(A0),(A2)	* moves first digit of cents 
	move.b	1(A0),1(A2)	* moves second digit of cents
	cvta2	(A2),#2		* converts cents into two's-compliment
cents:	divu	(A3)+,D0	* divides cents of input by first mod then A3 points to next mod
	move.w	D0,(A2)+
	swap	D0
	ext.l	D0
	DBRA	D6,cents	decriments D6 then continues to loop through until D6 is 0
	
	lineout	space
	lineout	result
	clr.l	D0		
	clr.l	D1
	move.l	#11,D7		* amount of denominations total moved into D3
	lea	divs,A4
	lea	array,A5
print:	lea	change,A6
	subq.l	#1,D7
	move.w	(A4),D0
	move.w	(A4)+,D1
	cvt2a	(A6),#4
	stripp	(A6),#4
	TST.w	D1		* tests if words stored in divs are 0
	BLE	next		* if a divs is <= 0 then goto next
	adda.l	D0,A6		* points A6 to memory after divs
	move.b	(A5)+,(A6)+	* moves 1st character of denomination string
	move.b	(A5)+,(A6)+	* moves 2nd " " " "
	move.b	(A5)+,(A6)+	* moves 3rd " " " "
	move.b	(A5)+,(A6)+	* moves 4th " " " "
	move.b	(A5)+,(A6)+	* moves 5th " " " "
	move.b	(A5)+,(A6)+	* moves 6th " " " "
	move.b	(A5)+,(A6)+	* moves 7th " " " "
	move.b	(A5)+,(A6)+	* moves 8th " " " "
	move.b	#0,(A6)+	* null terminate
	lineout	change
	TST.w	D7
	BNE	print
	
	BRA	done
	
next:	adda.l	#8,A5
	TST.w	D7
	BEQ	done
	BRA	print
	
invalid:lineout	space
	lineout	error
	BRA	input
	
done:


				* Your code goes HERE


        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
header:	dc.b	'Program #3, Christian Barajas, masc0226',0
prompt:	dc.b	'Enter an amount in U.S. Dollars (no $ sign):',0
buffer:	ds.b	80
error:	dc.b	'Sorry, invalid entry.',0
result:	dc.b	'That amount is:',0
change:	ds.b	20
array:	dc.b	' x $100 ',' x $50  ',' x $20  ',' x $10  ',' x $5   ',' x $1   '
	dc.b	' x 50c  ',' x 25c  ',' x 10c  ',' x 5c   ',' x 1c   '
mods:	dc.w	100,50,20,10,5,1,50,25,10,5,1,0		* #s to divide for bill/cents checking
divs:	ds.w	12					* storage for divisibal results

space:	dc.b	' ',0
			
				* Your storage declarations go 
				* HERE
        end
