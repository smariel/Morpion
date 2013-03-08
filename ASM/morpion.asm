;						BT next		BT prev		BT val		Autres		Pas de BP
START:
	LDA BP			;2	1111 1110	1111 1101	1111 1011	1101 1111	1111 1111
	ADD ONE			;1	1111 1111	1111 1110	1111 1100	1110 0000	0000 0000C
	JCC BPDETECT		;1	JUMP		JUMP		JUMP		JUMP		0000 0000
	JCC START		;1													JUMP
							
BPDETECT:
	NOT			;1	0000 0000	0000 0001	0000 0011	0001 1111
	ADD ALLONE		;1	1111 1111	0000 0000C	0000 0010C	0001 1110C
	JCC BT_NEXT		;1	JUMP		0000 0000	0000 0010	0001 1110
	ADD ALLONE		;1			1111 1111	0000 0001C	0001 1101C
	JCC BT_PREV		;1			JUMP		0000 0001	0001 1101
	JCC BT_VAL		;1 					JUMP		JUMP

;						Position 3 joueur 0
BT_VAL:		
	LDA POS			;2	accu		= MEM[pos]
	STA AFF_POSVAL		;1	AFF[val]	= accu
	LDA JOUEUR		;2	accu		= MEM[joueur]
	STA AFF_J		;1	AFF[joueur]	= accu
	NOT			;1	accu		= !accu
	STA JOUEUR		;1	MEM[joueur]	= accu
	JCC START		;1	retour

;						Position 2		Position 8
BT_NEXT:		
	LDA POS			;2	0000 0010		0000 1000
	ADD ONE			;1	0000 0011		0000 1001
	STA POS			;1	MEM[pos]=accu		MEM[pos]=accu
	ADD VAL_247		;1	1111 1010		0000 0000C
	JCC SENDPOS		;1	JUMP			0000 0000	
	STA POS			;1  				MEM[pos]=accu
	JCC SENDPOS		;1				JUMP

;					Position 3		Position 0
BT_PREV:			;	1111 1111		1111 1111
	ADD ONE			;1	0000 0000C		0000 0000C
	LDA POS			;2	0000 0011C		0000 0000C
	ADD ALLONE		;1	0000 0010C		1111 1111C
	JCC START		;1	0000 0010		1111 1111
	STA POS			;1	MEM[pos]=accu		MEM[pos]=accu
	ADD ONE			;1	0000 0011		0000 0000C
	JCC SENDPOS		;1	JUMP			0000 0000
	ADD VAL_8		;1				0000 1000
	STA POS			;1				MEM[pos]=accu
	JCC SENDPOS		;1				JUMP
			
SENDPOS:	
	LDA POS			;1	accu	= MEM[pos]
	STA AFF_POSMOD		;1	AFF[pos]=accu
	JCC START		;1	retour

; données mémoire

; ALLONE	= 1111 1111
; ZERO		= 0000 0000
; ONE		= 0000 0001
; VAL_247	= 1111 0111
; VAL_8		= 0000 1000
; POS		= 0000 0000
; JOUEUR	= 0000 0000
			
; 44 instructions + 7 données = 51 octets
			
			
