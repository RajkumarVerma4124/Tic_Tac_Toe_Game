#!/bin/bash 
echo -e "Welcome To The Tic Tac Toe Game Program Hope You Win From Computer \n"

#variables
totalMovesLeft=9

#As a Player starting fresh with resetting the board(UC1).
function resetBoard(){
	echo "====================="
	echo "    Game started"
	playBoard=(_ _ _ _ _ _ _ _ _)
	echo "====================="  

}

#As a Player would like to see the board so player can choose the valid cells during his turn
function printBoard(){
	echo "****Tic Tac Toe****"
	echo  "  ---------"
	echo  "|  " ${playBoard[0]} ${playBoard[1]} ${playBoard[2]} "  |" 
	echo  "  ---------"
	echo  "|  " ${playBoard[3]} ${playBoard[4]} ${playBoard[5]} "  |"  
	echo  "  ---------"
	echo  "|  " ${playBoard[6]} ${playBoard[7]} ${playBoard[8]} "  |"  
	echo  "  ---------"

	echo -e "\nEnter the number in this format"
	echo  " " "---------"
	echo " |" " "0" "1" "2"  |  "
	echo  " " "---------"
	echo " |" " "3" "4" "5"  |  "
	echo  " " "---------"
	echo " |" " "6" "7" "8"  |  "
	echo  " " "---------"
}

#As a Player begin with a toss to check who plays first(UC2).
function tossPlay(){
	tossCheck=$(($RANDOM % 2 + 1))	
	#If my turn then would like choose letter X or letter O (UC3).
	if [ $tossCheck -eq 1 ]
	then
		echo -e "Its The Player Turn \n"	
		read -p "Choose What You Want X Or O : " playerChoice
		if [[ "$playerChoice" == "X" || "$playerChoice" == "x" ]]
		then 
			computerChoice=O
		elif [[ "$playerChoice" == "O" || "$playerChoice" == "o" ]]
		then 
			computerChoice=X
		else
			echo "Enter The Correct Letter"
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

function playerTurnsChange(){
	i=$1
	tossCheck=$i

	if [ $totalMovesLeft -eq 0 ]
	then
		exit
	else
		playGame
	fi
}

function playGame(){
	if [ $tossCheck -eq  1 ]
	then
		read -p "Player Enter The Position Between 0 To 8 : " positionCheck
		if [ "${playBoard[$positionCheck]}" == "_" -a  $positionCheck -lt 9  ] 
		then
	 		playBoard[$positionCheck]=$playerChoice 
			totalMovesLeft=$(($totalMovesLeft-1))
			printBoard
			playerTurnsChange 2	
		else
		 	echo "The Place Is Alredy Filled, Choose Another Position Or You Have Entered The Wrong Position[B"
			printBoard
			playGame
		fi
	fi
	
	if [ $tossCheck -eq  2 ]
	then
		read -p "Computer Enter The Position Between 0 To 8 : " positionCheck
		if [ "${playBoard[$positionCheck]}" == "_" -a  $positionCheck -lt 9 ] 
		then
		 	playBoard[$positionCheck]=$computerChoice 
			totalMovesLeft=$(($totalMovesLeft-1))
			printBoard
			playerTurnsChange 1	
		else
		 	echo "The Place Is Already Filled Choose Another Position Or You Have Entered The Wrong Position"
			printBoard
			playGame
			fi
	fi

	
}

#Main Code

resetBoard
tossPlay
printBoard
playGame

