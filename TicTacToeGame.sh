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
	#If my turn then would like choose letter X or letter O (UC3).
	if [ $tossCheck -eq 1 ]
	then
		echo -e "Its The Player Turn \n"	
		read -p "Choose What You Want X Or O : " playerChoice
		if [[ "$playerChoice" -eq "X" || "$playerChoice" -eq "x" ]]
		then 
			computerChoice=O
		elif [[ "$playerChoice" -eq "O" || "$playerChoice" -eq o ]]
		then 
			computerChoice=X
		fi
	echo -e "\nPlayer Choose The Option : $playerChoice \n"
	echo -e "Computer Choose the Option : $computerChoice \n"		
	fi
	#If computer turn then randomly choose letter X or letter O (UC3).
	if [ $tossCheck -eq 2 ]
	then
		echo -e "Its The Computer Turn \n"
		compCheck=$(($RANDOM%2+1))
		if [ $compCheck -eq 1 ]
		then
			computerChoice=O
			playerChoice=X	
		elif [ $compCheck -eq 2 ]
		then 
			computerChoice=X
			playerChoice=O
		fi
	echo -e "Computer Choose the Option : $computerChoice \n"			
	echo -e "Player Choose The Option : $playerChoice \n"
	fi			
}

#Main Code
tossPlay
resetBoard
