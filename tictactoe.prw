#Include "PROTHEUS.CH"
//baseado em algoritmo para python compartilhado no github
User function tictactoe()

Local oFont1 := TFont():New("MS Sans Serif",,020,,.T.,,,,,.F.,.F.)
Local oDlg

Private oBtn1
Private obtn2
Private oBtn3
Private oBtn4
Private oBtn5
Private oBtn6
Private oBtn7
Private oBtn8
Private oBtn9
Private cBtn1 := " "
Private cbtn2 := " "
Private cBtn3 := " "
Private cBtn4 := " "
Private cBtn5 := " "
Private cBtn6 := " "
Private cBtn7 := " "
Private cBtn8 := " "
Private cBtn9 := " "

Private player   := "X" 
Private opponent := "O"

//matriz com as posições sem jogadas. Pode ser usado para testar o movimento do adversario
//informando as jogadas no tabuleiro
Private aBoard := {;
   { '_', '_', '_' },;
	{ '_', '_', '_' },;
	{ '_', '_', '_' };
}

//matriz com os numeros nas posiçoes. 
Private aBBase := {;
   { '1', '2', '3' },;
	{ '4', '5', '6' },;
	{ '7', '8', '9' };
}


  DEFINE MSDIALOG oDlg TITLE "Tic Tac Toe" FROM 000, 000  TO 260, 270 COLORS 0, 16777215 PIXEL

    @ 013, 009 BUTTON oBtn1 prompt cBtn1 SIZE 037, 033 OF oDlg PIXEL FONT oFont1 PIXEL action MoveXO(@aBoard,1)
    @ 013, 047 BUTTON obtn2 prompt cBtn2 SIZE 037, 033 OF oDlg PIXEL FONT oFont1 PIXEL action MoveXO(@aBoard,2)   
    @ 013, 084 BUTTON oBtn3 prompt cBtn3 SIZE 037, 033 OF oDlg PIXEL FONT oFont1 PIXEL action MoveXO(@aBoard,3)  
    @ 046, 009 BUTTON oBtn4 prompt cBtn4 SIZE 037, 033 OF oDlg PIXEL FONT oFont1 PIXEL action MoveXO(@aBoard,4)
    @ 046, 047 BUTTON oBtn5 prompt cBtn5 SIZE 037, 033 OF oDlg PIXEL FONT oFont1 PIXEL action MoveXO(@aBoard,5)  
    @ 046, 084 BUTTON oBtn6 prompt cBtn6 SIZE 037, 033 OF oDlg PIXEL FONT oFont1 PIXEL action MoveXO(@aBoard,6)  
    @ 079, 009 BUTTON oBtn7 prompt cBtn7 SIZE 037, 033 OF oDlg PIXEL FONT oFont1 PIXEL action MoveXO(@aBoard,7)  
    @ 079, 047 BUTTON oBtn8 prompt cBtn8 SIZE 037, 033 OF oDlg PIXEL FONT oFont1 PIXEL action MoveXO(@aBoard,8)  
    @ 079, 084 BUTTON oBtn9 prompt cBtn9 SIZE 037, 033 OF oDlg PIXEL FONT oFont1 PIXEL action MoveXO(@aBoard,9)  


  ACTIVATE MSDIALOG oDlg CENTERED

Return                        

Static function ResetGame()
Local x       :=1
//matriz com as posições sem jogadas. Pode ser usado para testar o movimento do adversario
//informando as jogadas no tabuleiro
Local aBoard2 :=  {;
                  { '_', '_', '_' },;
                  { '_', '_', '_' },;
	               { '_', '_', '_' };
                  }

aBoard        := aClone(aBoard2)
//limpa objetos da janela
for x:=1 to 9
   &("oBtn"+Strzero(x,1)+":cCaption") := ""
   &("oBtn"+Strzero(x,1)+":enable()")
   &("oBtn"+Strzero(x,1)+":refresh()")
next x

RETURN

Static function MoveXO(aBoard,nPos)
Local cMov      :=0
Local cmsg      :=""
Local i         :=0
Local j         :=0
Local nConta    :=0
Local aPos      :={1,2,3,1,2,3,1,2,3}
Local cPos      :=Strzero(nPos,1)
Local aBestMove :={}
if cPos $ "1*2*3"
   nL1 := 1
elseif cPos $ "4*5*6"
   nL1 := 2
elseif cPos $ "7*8*9"
   nL1 := 3
endif 
nC1 := aPos[nPos]


if aBoard[nL1][nC1] == "_"
   aBoard[nL1][nC1] :="X"
   &("cBtn"+cPos)   := "X"
   &("oBtn"+cPos+":cCaption") :=&("cBtn"+cPos)
   &("oBtn"+cPos+":disable()")
   &("oBtn"+cPos+":refresh()")
else
   Return
endif
//procura pelo melhor movimento a ser feito pelo adversario
aBestMove := findabestMove(aBoard)

if aBestMove[1] <> -1
      aBoard[aBestMove[1]][aBestMove[2]]:="O"
      cMov := aBBase[aBestMove[1]][aBestMove[2]]
      &("cBtn"+cMov) := "O"
      &("oBtn"+cMov+":cCaption") :=&("cBtn"+cMov)
      &("oBtn"+cMov+":disable()")
      &("oBtn"+cMov+":refresh()")


      evaluate(aBoard,@cMsg)
      if !empty(cMsg)
          alert(cMsg)
          ResetGame()
      endif   
endif

for i:=1 to 3
   for j:=1 to 3
      if aBoard[i][j]  == "_"
         nConta++
      endif
   next j 
next i 
if nConta == 0
   Alert("Empate!")
   ResetGame()
endif

RETURN

static function isMovesLeft(aBoard)
Local i:=0
Local j:=0
	for i:=1 to 3
		for j:=1 to 3
			if (aBoard[i][j] == '_') 
				return .t.
         endif
      next j
   next i         
return .f.

Static function evaluate(b,cMsg) 
Local nScore:=0
Local row:=0
Local col:=0
//	verifica vitorias na horizontal
	for row:=1 to 3	
		if (b[row][1] == b[row][2] .and. b[row][2] == b[row][3]) 
			if (b[row][1] == player) 
				nScore:= 10
            cMsg:="X venceu!"
			elseif (b[row][1] == opponent) 
				nScore:=-10
            cMsg:="O venceu!"
         endif
      endif
   next row         

//verifica vitorias na vertical
	for col:=1 to 3	
		if (b[1][col] == b[2][col] .and. b[2][col] == b[3][col]) 
		
			if (b[1][col] == player) 
				nScore:= 10
            cMsg:="X venceu!"
			elseif (b[1][col] == opponent) 
				nScore:=-10
            cMsg:="O venceu!"
         endif
      endif
   next col         

//verifica vitorias nas diagonais
	if (b[1][1] == b[2][2] .and. b[2][2] == b[3][3]) 
	
		if (b[1][1] == player) 
			nScore:= 10
         cMsg:="X venceu!"
		elseif (b[1][1] == opponent) 
			nScore:=-10
         cMsg:="O venceu!"
      endif
   endif      

	if (b[1][3] == b[2][2] .and. b[2][2] == b[3][1]) 
	
		if (b[1][3] == player) 
   		nScore:= 10
         cMsg:="X venceu!"
		elseif (b[1][3] == opponent) 
			nScore:=-10
         cMsg:="O venceu!"
      endif   
   endif   
//se for empate, nScore retorna 0
return nScore

//funcao da teoria dos jogos. Retorna todas as possibilidades possíveis
Static Function minimax(aBoard, depth, lMax) 
Local cMsg   :=""
Local nScore := evaluate(aBoard,@cMsg)
Local i      :=0
Local j      :=0
Local nBest  :=0


//se venceu pela pontuação maximizada
	if (nScore == 10) 
		return nScore
   endif   

//se venceu pela pontuação minimizada
	if (nScore == -10) 
		return nScore
   endif   

//se não houver movimentos a fazer
	if !isMovesLeft(aBoard)
		return 0
   endif   

//movimentação pela maximização
if (lMax)
	   nBest := -1000

      //todas as celulas transversais
      for i:=1 to 3
         for j:=1 to 3
               
            //se a celula não teve jogada
            if (aBoard[i][j]=='_') 
                  
              //atribui o movimento
               aBoard[i][j] := player

               //chama a recursividade pela maximização
               nBest := max( nBest, minimax(aBoard,	depth + 1, .f.) )

              //	 desfaz movimento
               aBoard[i][j] := '_'
            endif
      next j
      next i         
      Return nBest

//se for movimento pela minimização
else 
		nBest := 1000

      //todas as celulas transversais
		for i:=1 to 3
			for j:=1 to 3
			
            // se a celula não teve jogada
				if (aBoard[i][j] == '_') 
				
               //atribui movimento
					aBoard[i][j] := opponent

               //chama a recursividade de minimização
					nBest := min(nBest, minimax(aBoard, depth + 1, .f.))

               //desfaz o movimento
					aBoard[i][j] := '_'
            endif
         next j
      next i         
		return nBest
endif

//funcao q retorna o melhor movimento para o computador
static function findabestMove(aBoard) 
Local i         :=0
Local j         :=0
Local nBestVal   := -1000
Local aBestMove := {-1, -1}
Local nMoveVal  :=0

//verifica todas as transversais e roda a minimização para todas as posições q ainda nao foram selecionadas no jogo
	for i :=1 to 3
		for j:=1 to 3
		
         //se ainda não teve jogada nessa posição
			if (aBoard[i][j] == '_') 
			
            //grava o movimento
				aBoard[i][j] := player

            //seleciona a minimizaççao
				nMoveVal := minimax(aBoard, 0, .f.)

            //desfaz o movimento
				aBoard[i][j] := '_'

            //se for o melhor movimento a ser feito, registre
				if (nMoveVal > nBestVal) 			
					aBestMove := {i, j}
					nBestVal := nMoveVal
            endif
         endif      
      next j
   next i      

return aBestMove
