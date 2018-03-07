'use strict'

const gameApi = require('./api.js')
const gameUi = require('./ui.js')
const getFormFields = require('../../lib/get-form-fields.js')
const gameLogic = require('./game-logic.js')
const gameIndex = require('./index.js')

const onSignUp = function (event) {
  event.preventDefault()
  const data = getFormFields(this)
  gameApi.signUp(data)
    .then(gameUi.onSignUpSuccess)
    .catch(gameUi.onError)
  console.log('data is ', data)
}

const onSignIn = function (event) {
  event.preventDefault()
  const data = getFormFields(this)
  console.log('onSignIn is running')
  gameApi.signIn(data)
    .then(gameUi.onSignInSuccess)
    .catch(gameUi.onSignInFailure)
}

const onChangePassword = function (event) {
  event.preventDefault()
  const data = getFormFields(event.target)
  gameApi.changePassword(data)
    .then(gameUi.changePasswordSuccess)
    .catch(gameUi.changePasswordFailure)
}

const onSignOut = function (event) {
  event.preventDefault()
  const data = getFormFields(event.target)
  gameApi.signOut(data)
    .then(gameUi.signOutSuccess)
    .catch(gameUi.signOutFailure)
}

const onNewGame = function (event) {
  event.preventDefault()
  const data = getFormFields(event.target)
  gameLogic.endGame()
  gameApi.newGame(data)
    .then(gameUi.newGameSuccess)
    .catch(gameUi.newGameFailure)
  gameLogic.boardReset(gameLogic.currentBoard)
  gameLogic.currentBoard = []
  gameLogic.currentPlayer = gameLogic.playerX
  gameLogic.over = false
  console.log('this is the onNewGame array ', gameLogic.currentBoard)
}

const onClickCell = function (event) {
  event.preventDefault()
  const cellIndex = event.data.cellIndex
  const cellClass = event.data.cellClass
  // const data = getFormFields(event.target)
  gameLogic.playerMove(cellIndex, gameLogic.currentBoard)
  // maybe I need to update the board explicitly here?
  // gameLogic.updateCurrentBoard()
  console.log('this is the array during onClickCell', gameLogic.currentBoard, 'over is', gameLogic.over)
  gameApi.updateGameCell(cellIndex, gameLogic.currentBoard[cellIndex])
  gameUi.cellClickSuccess(event.data, cellIndex, cellClass)
}

const onGetGames = function (event) {
  event.preventDefault()
  // const data = getFormFields(event.target)
  gameApi.getGames()
    .then(gameUi.getGamesSuccess)
}

const addHandlers = () => {
  $('#sign-up').on('submit', onSignUp)
  $('#sign-in').on('submit', onSignIn)
  $('#change-password').on('submit', onChangePassword)
  $('#sign-out').on('submit', onSignOut)
  $('#new-game-button').on('click', onNewGame)
  $('.cell-zero').on('click', {cellIndex: 0, cellClass: '.cell-zero'}, onClickCell)
  $('.cell-one').on('click', {cellIndex: 1, cellClass: '.cell-one'}, onClickCell)
  $('.cell-two').on('click', {cellIndex: 2, cellClass: '.cell-two'}, onClickCell)
  $('.cell-three').on('click', {cellIndex: 3, cellClass: '.cell-three'}, onClickCell)
  $('.cell-four').on('click', {cellIndex: 4, cellClass: '.cell-four'}, onClickCell)
  $('.cell-five').on('click', {cellIndex: 5, cellClass: '.cell-five'}, onClickCell)
  $('.cell-six').on('click', {cellIndex: 6, cellClass: '.cell-six'}, onClickCell)
  $('.cell-seven').on('click', {cellIndex: 7, cellClass: '.cell-seven'}, onClickCell)
  $('.cell-eight').on('click', {cellIndex: 8, cellClass: '.cell-eight'}, onClickCell)
  $('.get-games-button').on('click', onGetGames)
}

module.exports = {
  onSignUp,
  addHandlers,
  onSignIn,
  onChangePassword,
  onSignOut,
  onNewGame,
  onClickCell,
  onGetGames
}
