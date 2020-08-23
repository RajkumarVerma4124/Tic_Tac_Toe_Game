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
	
	tossPlay
	printBoard
	playGame
}

#As a Player would like to see the board so player can choose the valid cells during his turn(UC4).
function printBoard(){
	echo -e "\n****Tic Tac Toe****"
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
		if [[ "$playerChoice" == X || "$playerChoice" == x ]]
		then 
			computerChoice=O
		elif [[ "$playerChoice" == O || "$playerChoice" == o ]]
		then 
			computerChoice=X
		else
			echo -e "\nYou Have Entered The InCorrect Letter Your Chance Is Gone Tossing Again"
			tossPlay
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

#To Change The Turns After Every Move
function playerTurnsChange(){
	i=$1
	checkWinner
	tossCheck=$i

	if [ $totalMovesLeft -eq 0 ]
	then
		exit
	else
		playGame
	fi
}

#To Play The Game Between Computer And Player
function playGame(){
	if [ $tossCheck -eq  1 ]
	then
		read -p "Player Turns Now, Enter The Position Between 0 To 8 : " positionCheck
		if [ "${playBoard[$positionCheck]}" == "_" -a  $positionCheck -lt 9  ] 
		then
	 		playBoard[$positionCheck]=$playerChoice 
			totalMovesLeft=$(($totalMovesLeft-1))
			printBoard
			playerTurnsChange 2	
		else
		 	echo -e "\nThe Place Is Alredy Filled, Choose Another Position Or You Have Entered The Wrong Position[B"
			printBoard
			playGame
		fi
	fi
	#On Computer getting its turn the computer will play like me (UC6).
	if [ $tossCheck -eq  2 ]
	then
		echo -e "\nComputer Turns Now Selcting Position"
		positionCheck=$(($RANDOM % 8 + 1))
		if [ "${playBoard[$positionCheck]}" == "_" ] 
		then
		 	playBoard[$positionCheck]=$computerChoice 
			totalMovesLeft=$(($totalMovesLeft-1))
			printBoard
			playerTurnsChange 1	
		else
		 	echo -e "\nThe Place Is Already Filled Choose Another Position"
			printBoard
			playGame
			fi
	fi

	
}

#Determining after every move the winner or the tie or change the turn(UC5).
function checkBoard(){
	i1=$1
	i2=$2
	i3=$3

	if [ "${playBoard[$i1]}" != "_" ]
	then
		if [[ "${playBoard[$i1]}" == "${playBoard[$i2]}" && "${playBoard[$i2]}" == "${playBoard[$i3]}" && "${playBoard[$i3]}" == "${playBoard[$i1]}" ]]
		then
			winnerPlayer=${playBoard[$i1]} 
			if [ "$winnerPlayer" ==  "$playerChoice" ]
			then
				echo -e "\nPlayer With Letter $winnerPlayer Wins The Game "
				echo -e "\nDo You Want To Play Again"
				while true
				do
					echo "1.Play Again"
					echo "2.Exit"
					read -p "Enter Your Choice : " choice
					case $choice in
					"1") resetBoard ;;	
					"2") exit ;;
					esac	
				done
			else
				echo "Computer With Letter $winnerPlayer Wins The Game "
				computerPlay=$(($RANDOM % 2 + 1))
				if [ $computerPlay -eq 1 ]
				then
					echo "Computer Wants To Play Again"
					resetBoard
				else
					exit
				fi
			fi
		elif [[ $totalMovesLeft -eq 0 ]]
		then
			echo -e "\nGame Ties Between The Player And Computer The Board Resets"
			resetBoard
		fi		
	fi
}

#Checking The Winner After Every Move(UC5).
function checkWinner(){
	if [ $totalMovesLeft -lt 5 ]
	then
		checkBoard 0 1 2
		checkBoard 3 4 5
		checkBoard 6 7 8
		checkBoard 0 4 8
		checkBoard 2 4 6
		checkBoard 0 3 6
		checkBoard 1 4 7
		checkBoard 2 5 8	
	fi
}

#Main Code
resetBoard


