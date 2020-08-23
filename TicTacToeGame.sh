#!/bin/bash 
echo -e "Welcome To The Tic Tac Toe Game Program Hope You Win From Computer \n"

#As a Player starting fresh with resetting the board(UC1).
function resetBoard(){
	echo "====================="
	echo "Game started"
	resetBoard=(_ _ _ _ _ _ _ _ _)
	echo "====================="  
}

#As a Player begin with a toss to check who plays first(UC2).
function tossPlay(){
	tossCheck=$(($RANDOM % 2 + 1))	
	if [ $tossCheck -eq 1 ]
	then
		echo -e "Its The Player Turn \n"	
		
	fi
	
	if [ $tossCheck -eq 2 ]
	then
		echo -e "Its The Computer Turn \n"
	fi			
}

#Main Code
tossPlay
resetBoard
