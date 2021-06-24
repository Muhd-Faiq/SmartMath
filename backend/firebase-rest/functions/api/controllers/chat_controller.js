// Author: Jumail 
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 5 Jun 2021

'use strict'

const Controller = require('./controller')
const chatModel = require('../models/chat_model')

const chatController = new Controller(chatModel)
module.exports = chatController.router