*----------------------------------------------------------------------
* Programmer: Christian Barajas
* Class Account: masc0226
* Assignment or Title: Program #4
* Filename: reverse.s
* Date completed:  12-10-2015
*----------------------------------------------------------------------
* Problem statement: 
* Input: 
* Output: 
* Error conditions tested: 
* Included files: prog4.s
* Method and/or pseudocode:  void reverse(char *in, char *out, int count){ 
*				if (count == 0) return;
*				reverse (in+1,out,--count);
*				*(out+count) = *in;
*				}
*				
* References: 
*----------------------------------------------------------------------
*
* Register use
*
* D1 = adress of &in
* D2 = adress of &out
* D3 = count
* A0 = &in
* A1 = &out
*----------------------------------------------------------------------
*
start:  
*	initF			* For floating point macros only	

	ORG	  $7000

reverse:link	  A6,#0
	movem.l   D1/A0-A1,-(SP)
	movea.l	  8(A6),A0
	movea.l	  12(A6),A1
	move.w	  16(A6),D1
	
	cmpi.b	  #0,D1		* if(count == 0)
	BEQ	  done		* return;
	adda.l	  #1,A0		* reverse(in+1)
	subq.l	  #1,D1		* reverse(--count)
	move.w	  D1,-(SP)	* pushes D1 onto stack
	PEA	  (A1)		* load A1 to stack
	PEA	  (A0)		* load A0 to stack
	JSR	  reverse	* reverse inside reverse
	movea.l	  (SP),A0	* move A0 from stack
	movea.l	  4(SP),A1	* move A1 from stack
	move.w	  8(SP),D1	* move D1 from stack
	adda.l	  #10,SP	* removes variables from stack
	
	subq.l	  #1,A0
	addq.l	  #1,D1
	adda.l	  D1,A1		* (out+count)
	move.b	  (A0),(A1)	* (out+count) = *in
done:	movem.l	  (SP)+,D1/A0-A1
	unlk	  A6
	RTS
	end


				* Your code goes HERE


        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations

			
				* Your storage declarations go 
				* HERE
        end
