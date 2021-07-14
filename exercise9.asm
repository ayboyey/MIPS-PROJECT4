.data 

						
order_A: 	.space		500							
value_A: 	.space		500
order_B: 	.space		500
value_B: 	.space		500


size:		.asciiz		"\nInput the size of vectors: "
introA:		.asciiz		"Input the Vector A\n"
introB: 	.asciiz		"Input the Vector B\n"
result:		.asciiz		"\nThe scalar product is: "


.text 

start:
		li		$v0, 4			
		la		$a0, size
		syscall

		li		$v0, 5
		syscall

		addi		$a1, $v0, 0			
		
		# read & store vector A
		li		$v0, 4
		la		$a0, introA
		syscall

		addi		$a2, $zero, 0					
		addi		$t1, $zero, 0		
		addi		$t2, $zero, 0		

		jal		loopA

		# read & store vector B
		li		$v0, 4
		la		$a0, introB
		syscall
	
		addi		$a2, $zero, 0				
		addi		$t1, $zero, 0		
		addi		$t2, $zero, 0		

		jal		loopB
		
		# final result
		li		$v0, 4			
		la		$a0, result
		syscall
		
		addi		$a2, $0, 0		
		addi		$s1, $0, 0		
		addi		$s2, $0, 0		
		addi		$s3, $0, 0		
		addi		$s4, $0, 0		
		addi		$a3, $0, 0		

		jal		scalarProduct	
		
		# display final result
		li		$v0, 1
		addi		$a0, $a3, 0
		syscall

exit:		
		li		$v0, 10			
		syscall			

goBack:
		jr		$ra			
			
loopA:						
		bge		$a2, $a1, goBack	
		
		# read value
		li		$v0, 5
		syscall

		addi		$a3, $v0, 0		
		addi		$a2, $a2, 1		
	
		beqz		$a3, ifA		
			
		li		$t4, 1			
		sw		$t4, order_A($t1)	
		sw		$a3, value_A($t2)	

		addi		$t1, $t1, 4		
		addi		$t2, $t2, 4								

		j		loopA

ifA:			
		sw		$a3, order_A($t1)	
		addi		$t1, $t1, 4					
		j		loopA

loopB:						
		bge		$a2, $a1, goBack	



		# read value
		li		$v0, 5
		syscall

		addi		$a3, $v0, 0		
		addi		$a2, $a2, 1		

		beqz		$a3, ifB		

		li		$t4, 1			
		sw		$t4, order_B($t1)	
		sw		$a3, value_B($t2)	

		addi		$t1, $t1, 4		
		addi		$t2, $t2, 4							

		j		loopB

ifB:			
		sw		$a3, order_B($t1)	 
		addi		$t1, $t1, 4					
		j		loopB		
		
scalarProduct:	
		bge		$a2, $a1, goBack	

		lw		$s4, order_A($s1)	
		lw		$s3, order_B($s5)	

		addi		$a2, $a2, 1		

vectorA:			
		beqz		$s4, zeroA		
		 
		lw		$t6, value_A($s2)	
				
		addi		$s2, $s2, 4		
		addi		$s1, $s1, 4		
	
		j		vectorB			

zeroA:			
		addi		$t6, $0, 0		
		addi		$s1, $s1, 4		
		
vectorB:		
		beqz		$s3, zeroB		

		lw		$t7, value_B($s6)	
		
		addi		$s7, $s7, 4		
		addi		$s5, $s5, 4		

		j		solution

zeroB:			
		addi		$t7, $0, 0		
		addi		$s5, $s5, 4		

		j		scalarProduct
		
solution:		
		mul		$t6, $t7, $t6		
		add		$a3, $a3, $t6				

		j		scalarProduct


		
