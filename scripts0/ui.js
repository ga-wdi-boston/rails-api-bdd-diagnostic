'use strict'

const store = require('./store')
const gameLogic = require('./game-logic.js')

const onSignUpSuccess = function (data) {
  console.log('signed up, data is ', data)
  $('#sign-up-message').text('Signed up!')
  $('#sign-up').text('Signed up!')
}

const onError = function () {
  console.log('something went wrong')
  $('#sign-up-message').text('error on sign up')
}

const onSignInSuccess = function (data) {
  $('#top-message').text('Signed In Successfully')
  $('#sign-in-message').css('background-color', 'green')
  // $('#sign-in').hide()
  $('.change-password-button').show()
  $('.sign-out').show()
  $('.new-game-button').show()
  $('#sign-in-box').modal('hide')
  $('#modal-button').hide()
  $('.get-games-button').show()
  $('.tic-tac-toe').show()
  $('#sign-out-message').text('')
  console.log(data)
  store.user = data.user
  console.log('Signed in')
}

const onSignInFailure = function (error) {
  console.log(error)
  $('#sign-in-message').text('Error on logging in')
  $('#sign-in-message').css('font-size', '48px')
  $('#sign-up-message').text('')
}

const changePasswordSuccess = function (data) {
  $('#top-message').text('')
  $('#change-message').text('change success!')
  $('#change-message').css('font-size', '48px').css('font-weight', 'bold').css('text-align', 'center')
  $('#change-password-modal').modal('hide')
  $('#bottom-message').text('change success!')
  console.log('change success!')
}

const changePasswordFailure = function (error) {
  $('#change-message').text('Error on change password')
  $('#change-message').css('font-size', '48px')
  $('#bottom-message').text('change error!')
  console.log(error)
}

const signOutSuccess = function (data) {
  $('#top-message').text('')
  $('#sign-out-message').text('Successfully signed out!')
  $('#sign-out-message').css('font-size', '48px')
  $('.game-board').hide()
  $('.tic-tac-toe').hide()
  $('.change-password-button').hide()
  $('.sign-out').hide()
  $('.new-game-button').hide()
  $('.get-games-button').hide()
  $('#modal-button').show()
  $('#sign-in-message').text('')
  $('#new-game-message').text('')
  $('.get-games-message').text('')
  $('#bottom-message').text('')
}

const signOutFailure = function (data) {
  $('#top-message').text('')
  $('#sign-out-message').text('error on sign out')
  $('#sign-out-message').css('font-size', '48px')
}

const newGameSuccess = function (data) {
  $('#top-message').text('')
  $('#new-game-message').text('Successfully created a new game!')
  $('#new-game-message').css('font-size', '18px')
  $('.game-board').show()
  store.game = data.game
}

const newGameFailure = function (data) {
  $('#new-game-message').text('error on create game')
  $('#new-game-message').css('font-size', '48px')
}

const cellClickSuccess = function (data, index, cellClass) {
  $(cellClass).text(gameLogic.currentBoard[index])
  console.log(store.game, store.user)
  // store.game = data.game
}

const getGamesSuccess = function (data) {
  $('#top-message').text('')
  $('.get-games-message').text('games played ' + data.games.length)
}

module.exports = {
  onSignUpSuccess,
  onError,
  onSignInSuccess,
  onSignInFailure,
  changePasswordSuccess,
  changePasswordFailure,
  signOutSuccess,
  signOutFailure,
  newGameSuccess,
  newGameFailure,
  cellClickSuccess,
  getGamesSuccess
}
