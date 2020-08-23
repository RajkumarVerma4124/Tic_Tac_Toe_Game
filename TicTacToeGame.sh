#!/bin/bash 
echo -e "Welcome To The Tic Tac Toe Game Program Hope You Win From Computer \n"

#As a Player starting fresh with resetting the board(UC1).
function resetBoard(){
	echo "====================="
	echo "Game started"
	resetBoard=(_ _ _ _ _ _ _ _ _)
	echo "====================="  
}

#Main Code
resetBoard
