*----------------------------------------------------------------------
* Programmer: 
* Class Account: 
* Assignment or Title: 
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

	lineout header
	lineout space
	lineout prompt
	linein	date
	
	cvta2	date,#2
	subq.l	#1,D0		
	move.l	D0,D1		
	mulu	#10,D0		
	lea	array,A0	
	adda.l	D0,A0		
	move.l	(A0)+,month	
	move.l	(A0)+,month+4	
	move.l	(A0),month+8	
	lea	month,A1
	lea	length,A2	
	mulu	#4,D1		
				
	adda.l	D1,A2		
	adda.l	(A2),A1		
	move.b	#' ',(A1)+	
	move.b	date+3,(A1)	
	move.b	date+4,1(A1)	
	stripp	(A1),#2		
	adda.l	D0,A1		
	move.b	#',',(A1)+	
	move.b	#' ',(A1)+	
	move.b	date+6,(A1)+	
	move.b	date+7,(A1)+	
	move.b	date+8,(A1)+	
	move.b	date+9,(A1)+	
	move.b	#'.',(A1)+	
	clr.b	(A1)		
	lineout space
	lineout	result
	
        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
header:	dc.b	'..............',0
prompt:	dc.b	'Enter a date in the form MM/DD/YYYY',0
date:	ds.b	80
result:	dc.b	'The date entered is '
month:	ds.b	20
array:	dc.b	'January   ','February  ','March     ','April     ','May       ','June      '
	dc.b	'July      ','August    ','September ','October   ','November  ','December  '
length:	dc.l	7,8,5,5,3,4,4,6,9,7,8,8
space:	dc.b	' ',0
				
				* Your storage declarations go 
				* HERE
        end
