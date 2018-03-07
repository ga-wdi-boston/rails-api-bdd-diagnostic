'use strict'

const gameApi = require('./api.js')

let currentBoard = []

const playerX = 'X'
const playerO = 'O'
let currentPlayer = playerX
let oppositePlayer
const otherPlayer = function () {
  if (currentPlayer === playerX) {
    oppositePlayer = playerO
  } else {
    oppositePlayer = playerX
  }
}

const endGame = function () {
  $('.cell-zero').text('')
  $('.cell-one').text('')
  $('.cell-two').text('')
  $('.cell-three').text('')
  $('.cell-four').text('')
  $('.cell-five').text('')
  $('.cell-six').text('')
  $('.cell-seven').text('')
  $('.cell-eight').text('')
  console.log('endGame is being called from somewhere')
}

// this function switches between X and O
const changePlayer = function () {
  if (currentPlayer === playerX) {
    currentPlayer = playerO
  } else {
    currentPlayer = playerX
  }
}

let over

const winChecker = function (array, i) {
  if (over !== true && ((array[0] === array[1] && array[1] === array[2] && array[0] !== undefined) ||
    (array[0] === array[4] && array[4] === array[8] && array[0] !== undefined) ||
    (array[0] === array[3] && array[3] === array[6] && array[0] !== undefined) ||
    (array[1] === array[4] && array[4] === array[7] && array[1] !== undefined) ||
    (array[2] === array[5] && array[5] === array[8] && array[2] !== undefined) ||
    (array[3] === array[4] && array[4] === array[5] && array[3] !== undefined) ||
    (array[6] === array[7] && array[7] === array[8] && array[6] !== undefined) ||
    (array[2] === array[4] && array[4] === array[6] && array[2] !== undefined))) {
    otherPlayer()
    $('#new-game-message').text(oppositePlayer + ' wins!')
    console.log('a win was detected and over = true')
    $('.game-board').hide()
    boardReset()
    over = true
    gameApi.updateGameOver(true)
    console.log('winChecker thinks over is', over)
  } else if (array[0] == null ||
            array[1] == null ||
            array[2] == null ||
            array[3] == null ||
            array[4] == null ||
            array[5] == null ||
            array[6] == null ||
            array[7] == null ||
            array[8] == null) {
    console.log('move pushed to array: ', array)
    $('#new-game-message').text(currentPlayer + ', take your turn!')
    over = false
  } else {
    $('#new-game-message').text('tie')
    gameApi.updateGameOver()
    over = true
  }
}

/* this is in reference to the events function in onClickCell
updateCurrentBoard = function () {
  currentBoard[i] = currentPlayer
}
*/

const pushMove = function (i, board) {
  if ((currentBoard[i] === 'X') || (currentBoard[i] === 'O')) {
    $('#new-game-message').text('sorry! this space is already occupied!')
    console.log('script thinks array[i] has X or O, board is', board)
  } else if ((board[i] === 'X') || (board[i] === 'O')) {
    $('#new-game-message').text('sorry! this space is already occupied!')
  } else if (over === true) {
    $('#new-game-message').text('the game is over')
    board = []
    console.log('pushMove thinks over is true')
  } else {
    board[i] = currentPlayer
    $('#new-game-message').text(currentPlayer + ', take your turn!')
    changePlayer()
  }
  console.log(board, ' end of pushMove function')
}

// this next function places an X or O in a specified space on the board
const playerMove = function (i, board) {
  pushMove(i, board)
//  console.log('board after pushMove: ', board)
  console.log('beginning of player move array', board)
  // debugger
  winChecker(board, i)
}

const boardReset = function (board) {
  board = []
  currentBoard = [board]
  over = false
  currentPlayer = playerX
  console.log('boardReset is getting called, this is the board', board, currentBoard)
}

module.exports = {
  boardReset,
  playerX,
  playerO,
  currentPlayer,
  currentBoard,
  winChecker,
  changePlayer,
  pushMove,
  playerMove,
  endGame,
  over
}
