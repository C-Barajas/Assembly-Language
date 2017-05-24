*----------------------------------------------------------------------
* Programmer: 
* Class Account: 
* Assignment or Tit
* Filename: 
* Date completed: 
*----------------------------------------------------------------------
* Problem statement: 
* Input: 
* Output: 
* Error conditions tested: 
* Included files: 
* Method and/or pseudocode: 
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

	
	lineout	header
	lineout	space
	lineout	prompt
	linein	date
	
	cvta2	date,#2		
	move.l	D0,D1		
	clr.l	D0
	cvta2	date+3,#2
	move.l	D0,D2	
	clr.l	D0
	cvta2	date+6,#4
	move.l	D0,D3		
	clr.l	D4
	
	add.b	#14,D4		
	sub.l	D1,D4
	divu.w	#12,D4
	and.l	#$00001111,D4	
	
	sub.l	D4,D3		
	mulu	#12,D4
	subq.l	#2,D4
	add.l	D4,D1		
	
	mulu	#31,D1		
	divu.w	#12,D1
	swap 	D1
	clr.w	D1
	swap 	D1
	add.l	D3,D2		
	
	move.l	D3,D5	
	divu.w	#4,D5
	swap	D5
	clr.w	D5
	swap	D5
	add.l	D5,D2		
	move.l	D3,D5
	divu.w	#100,D5	
	swap	D5
	clr.w	D5
	swap	D5
	sub.w	D5,D2		
	divu.w	#400,D3		
	swap	D3
	clr.w	D3
	swap	D3
	add.w	D3,D2		
	add.l	D1,D2		
				
	divu.w	#7,D2		
	clr.w	D2
	swap	D2		
	
	move.l	D2,D6		
	mulu	#12,D2	
	lea	array,A0	
	adda.l	D2,A0		
	move.l	(A0)+,day	
	move.l	(A0)+,day+4	
	move.l	(A0),day+8	
	lea	day,A1		
	lea	length,A2	
	mulu	#4,D6		
				
	adda.l	D6,A2		
	adda.l	(A2),A1		
	
	move.b	#'.',(A1)+	
	
	clr.b	(A1)
	lineout space
	lineout result
	
        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
header:	dc.b	'.......',0
prompt:	dc.b	'Enter a date (MM/DD/YYYY):',0
date:	ds.b	81
result:	dc.b	'That day is a '
day:	ds.b	20
array:	dc.b	'Sunday      ','Monday      ','Tuesday     ','Wednesday   ','Thursday    '
	dc.b	'Friday      ','Saturday    '
length:	dc.l	6,6,7,9,8,6,8


space:	dc.b	' ',0 

				* Your storage declarations go 
				* HERE
        end
