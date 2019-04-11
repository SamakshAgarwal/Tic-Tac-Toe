class MultiPlayerGameLogic {
  String displayString;
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
  static List<int> playerState = [2, 2, 2, 2, 2, 2, 2, 2, 2];
  static bool playerDecider = true;
  static bool gameOver = false;
  String player;
  String gameLogic(int index) {
    if (playerDecider) {
      playerState[index] = 0;
      playerDecider = !playerDecider;
      player = 'Player 2 move';
    } else {
      playerState[index] = 1;
      playerDecider = !playerDecider;
      player = 'Player 1 move';
    }
    checkResult();
    return player;
  }

  bool absorbStatus(int i) {
    if (playerState[i] == 2) {
      return false;
    } else {
      return true;
    }
  }

  String imageProvider(int index) {
    if (playerState[index] == 1) {
      return 'assets/x.png';
    } else if (playerState[index] == 0) {
      return 'assets/o.png';
    } else {
      return 'assets/transparent.png';
    }
  }

  void checkResult() {
    for (int i = 0; i < 8; i++) {
      if (playerState[winConditions[(i * 3) + 0]] ==
              playerState[winConditions[(i * 3) + 1]] &&
          playerState[winConditions[(i * 3) + 0]] ==
              playerState[winConditions[(i * 3) + 2]] &&
          playerState[winConditions[(i * 3) + 0]] != 2) {
        if (playerState[winConditions[(i * 3) + 0]] == 0) {
          player = 'Player 1 wins';
        } else {
          player = 'Player 2 wins';
        }
        gameOver = true;
      }
    }
  }

  bool containerTouchDisabler() {
    if (gameOver) {
      return true;
    } else {
      return false;
    }
  }

  void gameReset() {
    playerState = [2, 2, 2, 2, 2, 2, 2, 2, 2];
    player = '';
    playerDecider = true;
    gameOver = false;
  }

  List playerStateProvider(){
    return playerState;
  }
}
