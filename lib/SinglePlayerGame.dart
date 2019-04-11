// X(1) is cpu
// O(0) is player

class SinglePlayerGameLogic {
  List<int> winConditions = [
    0,
    1,
    2,
    0,
    4,
    8,
    0,
    3,
    6,
    3,
    4,
    5,
    6,
    7,
    8,
    1,
    4,
    7,
    2,
    5,
    8,
    2,
    4,
    6
  ];
  //List<int> playerState = MultiPlayerGameLogic().playerStateProvider();
  bool gameOver(List playerState) {
    for (int i = 0; i < 9; i++) {
      if (playerState[0] == 2) return false;
    }
    return true;
  }

  int evaluate(List playerState) {
    print('evaluate() $playerState');

    for (int i = 0; i < 8; i++) {
      if (playerState[winConditions[(i * 3) + 0]] ==
              playerState[winConditions[(i * 3) + 1]] &&
          playerState[winConditions[(i * 3) + 0]] ==
              playerState[winConditions[(i * 3) + 2]] &&
          playerState[winConditions[(i * 3) + 0]] != 2) {
        if (playerState[winConditions[(i * 3) + 0]] == 1) {
          return 100;
        } else {
          return -100;
        }
      }
    }

    for (int i = 0; i < 8; i++) {
      if (playerState[winConditions[(i * 3) + 0]] ==
              playerState[winConditions[(i * 3) + 1]] ||
          playerState[winConditions[(i * 3) + 0]] ==
              playerState[winConditions[(i * 3) + 2]]) {
        if (playerState[winConditions[(i * 3) + 0]] != 2) {
          if (playerState[winConditions[(i * 3) + 0]] == 1) {
            return 10;
          } else {
            return -10;
          }
        }
      }
    }

    for (int i = 0; i < 8; i++) {
      if (playerState[winConditions[(i * 3) + 0]] == 1 ||
          playerState[winConditions[(i * 3) + 1]] == 1 ||
          playerState[winConditions[(i * 3) + 2]] == 1) {
        return 1;
      } else if (playerState[winConditions[(i * 3) + 0]] == 0 ||
          playerState[winConditions[(i * 3) + 1]] == 0 ||
          playerState[winConditions[(i * 3) + 2]] == 0) {
        return -1;
      }
    }

    return 0;
  }

  int minimax(List playerState, int depth, bool isMax) {
    List<int> availableMoves = generateAvailableMoves(playerState);

    int bestScore = (isMax)?-50000:50000;
    int currentScore;
    int moveIndex = -1;

    if(availableMoves.isEmpty || depth==0){
      bestScore = evaluate(playerState);
    }
    else{
      for(int i in availableMoves){
        playerState[i] = (isMax)?1:0;
        if(isMax){
          currentScore = minimax(playerState, depth-1, !isMax);
          if(currentScore>bestScore){
            bestScore = currentScore;
            moveIndex = i;
          }
        }
        else{
          currentScore = minimax(playerState, depth-1, !isMax);
          if(currentScore<bestScore){
            bestScore = currentScore;
            moveIndex = i;
          }
        }
        playerState[i] = 2;
      }
    }
    return moveIndex;
  }

  List<int> generateAvailableMoves(List playerState) {
    List<int> available = [];
    if (evaluate(playerState) == 100 || evaluate(playerState) == -100) {
      return available;
    } else {
      for (int i = 0; i < 9; i++) {
        if (playerState[i] == 2) {
          available.add(i);
        }
      }
    }

    return available;
  }

  int findBestMove(List playerState) {
    /*int bestValue = -10000;
    int moveIndex = -1;

    for (int i = 0; i < 9; i++) {
      if (playerState[i] == 2) {
        playerState[i] = 1;

        int moveValue = minimax(playerState, 2, true);

        playerState[i] = 2;
        if (moveValue > bestValue) {
          moveIndex = i;
        }
      }
    }

    return moveIndex;*/
    return minimax(playerState, 4, false);
  }
}
