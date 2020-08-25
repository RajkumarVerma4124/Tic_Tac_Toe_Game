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
		 	echo -e "\nThe Place Is Alredy Filled, Choose Another Position Or You Have Entered The Wrong Position"
			printBoard
			playGame
		fi
	fi
	#On Computer getting its turn the computer will play like me (UC6).
	if [ $tossCheck -eq  2 ]
	then
		compPlayToWin $computerChoice
		compPlayToWin $playerChoice
		checkCorner
		checkCenter
		checkSides
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
				playNextGame	
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
			echo -e "\nGame Ties Between The Player And Computer."
			echo -e "\nDo You Want To Play Again"
			playNextGame
		fi		
	fi
}

#Function To Define That Player Want To Play Next Game Or Not
function playNextGame(){
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

#Passing The Winning Or Blocking Position 
function playBoardPosition(){
		i=$1
                playBoard[$i]=$computerChoice
                totalMovesLeft=$(($totalMovesLeft-1))
                printBoard
                playerTurnsChange 1

}

#First thing I do is check checkif I can win then play that move(UC7),check if my Opponent can win then play to block it(UC8).
function winPlay(){
	i1=$1
	i2=$2
	i3=$3
	checkCompWin=$4

	if [[ "${playBoard[$i1]}" == "${playBoard[$i2]}" && "${playBoard[$i1]}" != "_" && "${playBoard[$i3]}" == "_" && "${playBoard[$i1]}" == "$checkCompWin" ]]
        then
		playBoardPosition $i3
          	fi

        if [[ "${playBoard[$i1]}" == "${playBoard[$i3]}" && "${playBoard[$i1]}" != "_" && "${playBoard[$i2]}" == "_" && "${playBoard[$i1]}" == "$checkCompWin" ]]
        then
		playBoardPosition $i2
          	fi
        
	if [[ "${playBoard[$i3]}" == "${playBoard[$i2]}" && "${playBoard[$i3]}" != "_" && "${playBoard[$i1]}" == "_" && "${playBoard[$i2]}" == "$checkCompWin" ]]
        then
		playBoardPosition $i1
          fi
}

#Checking Possibility For Winning Positions For Computer
function compPlayToWin(){
	checkPlayer=$1	
	winPlay 0 1 2 $checkPlayer
	winPlay 3 4 5 $checkPlayer
	winPlay 6 7 8 $checkPlayer
	winPlay 0 4 8 $checkPlayer
	winPlay 2 4 6 $checkPlayer
	winPlay 0 3 6 $checkPlayer
	winPlay 1 4 7 $checkPlayer
	winPlay 2 5 8 $checkPlayer
}

#If neither of us are winning then checking and taking one of the available corners
function checkCorner(){
	i=0

	if [ "${playBoard[0]}" == "_" ]
	then 	
		cornerLeft[$(($i+1))]=0
	fi
		
	if [ "${playBoard[2]}" == "_" ] 
	then 	
		cornerLeft[$(($i+1))]=2
	fi
	
	if [ "${playBoard[6]}" == "_" ]
	then 
		cornerLeft[$(($i+1))]=6
	fi
	 
	if [ "${playBoard[8]}" == "_" ] 
	then 
		cornerLeft[$(($i+1))]=8	
	fi

	length=${#cornerLeft[*]}
	if [ $length -eq 0 ]
	then
		return
	elif [ $length -eq 1 ]
	then
		playBoard[${cornerLeft[*]}]=$computerChoice
		totalMovesLeft=$((totalMovesLeft-1))
		printBoard
		playerTurnsChange 1
	else
		playBoard[${cornerLeft[$(($RANDOM % length + 1))]}]=$computerChoice
		totalMovesLeft=$((totalMovesLeft-1))
		printBoard
		playerTurnsChange 1
	fi
}

#Choice if the corners are not available then take the Centre(UC10).
function checkCenter() {
	if [ "${playBoard[4]}" == "_" ] 
	then 
		playBoard[4]=$computerChoice
		totalMovesLeft=$((totalMovesLeft-1))
		printBoard
		playerTurnsChange 1
	fi
}

#Lastly any of the side if corner and centre is not available(UC11).
function checkSides(){
	i=0

	if [ "${playBoard[1]}" == "_" ]
	then 	
		sidesLeft[$(($i+1))]=1
	fi
		
	if [ "${playBoard[3]}" == "_" ] 
	then 	
		sidesLeft[$(($i+1))]=3
	fi
	
	if [ "${playBoard[5]}" == "_" ]
	then 
		sidesLeft[$(($i+1))]=5
	fi
	 
	if [ "${playBoard[7]}" == "_" ] 
	then 
		sidesLeft[$(($i+1))]=7	
	fi

	length=${#sidesLeft[*]}
	if [ $length -eq 0 ]
	then
		return
	elif [ $length -eq 1 ]
	then
		playBoard[${sidesLeft[*]}]=$computerChoice
		totalMovesLeft=$((totalMovesLeft-1))
		printBoard
		playerTurnsChange 1
	else
		playBoard[${sidesLeft[$(($RANDOM % length + 1))]}]=$computerChoice
		totalMovesLeft=$((totalMovesLeft-1))
		printBoard
		playerTurnsChange 1
	fi
}

#Main Code
resetBoard



