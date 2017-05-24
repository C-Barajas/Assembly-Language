*----------------------------------------------------------------------
* Programmer: Christian Barajas
* Class Account: masc0226
* Assignment or Title: Program #4
* Filename: prog4.s
* Date completed:  12-10-2015
*----------------------------------------------------------------------
* Problem statement: 
* Input: 
* Output: 
* Error conditions tested: 
* Included files: reverse.s
* Method and/or pseudocode: 
* References: 
*----------------------------------------------------------------------
*
reverse: EQU	$7000
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
* D1 = count
* A0 = (out+count)
*----------------------------------------------------------------------
*
start:  initIO                  * Initialize (required for I/O)
	setEVT			* Error handling routines
*	initF			* For floating point macros only	

	lineout header
	lineout	prompt
	linein	in
	
	move.l	D0,D1		
	move.w	D1,-(SP)
	LEA	out,A0
	subq.l	#1,A0	
	PEA	(A0)
	PEA	in
	JSR	reverse
	adda.l	#10,SP		* remove variables from stack
	LEA	out,A0
	adda.l	D1,A0
	move.b	#0,(A0)		* null terminate
	
	lineout space
	lineout	result
	lineout	out
	



				* Your code goes HERE


        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
header:	dc.b	'Program #4, Christian Barajas, masc0226',0
prompt:	dc.b	'Enter a string:',0
in:	ds.b	80
out:	ds.b	80
result:	dc.b	'Here is the string backwards:',0

space:	dc.b	' ',0
			
				* Your storage declarations go 
				* HERE
        end
