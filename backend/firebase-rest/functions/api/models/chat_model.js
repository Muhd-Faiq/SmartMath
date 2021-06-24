// Author: Jumail
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 5 Jun 2021

'use strict'

const Model = require('./model')

// Here, we are implementing the class with Singleton design pattern

class ChatModel extends Model {
    constructor() {
        super('chat')
        if (this.instance) return this.instance
        ChatModel.instance = this
    }
}

module.exports = new ChatModel()