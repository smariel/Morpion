NOR ALLONE		<= START
ADD 0x78
ADD ONE
JCC BPDETECT
JCC START
NOR ZERO		<= BPDETECT
ADD ALLONE
JCC BT_NEXT
ADD ALLONE
JCC BT_PREV
JCC BT_OK
NOR ALLONE		<= BT_OK
ADD POS
STA 0xBB
NOR ALLONE
ADD JOUEUR
NOR ZERO
STA JOUEUR
STA 0xB9
JCC START
NOR ALLONE		<= BT_NEXT
ADD POS
ADD ONE	
STA POS
ADD VAL_247
JCC SENDPOS		
STA POS	
JCC SENDPOS	
ADD ONE			<= BT_PREV
LDA POS
ADD ALLONE
JCC START
STA POS
ADD ONE
JCC SENDPOS
ADD VAL_8
STA POS
JCC SENDPOS
NOR ALLONE		<= SENDPOS
ADD POS
STA 0xBA
JCC START 		<= end
VAR ALLONE		:= 0xFF
VAR ZERO		:= 0x00
VAR ONE			:= 0x01
VAR VAL_247		:= 0xF7
VAR VAL_8		:= 0x08
VAR POS			:= 0x00
VAR JOUEUR		:= 0x00