// Author: Jumail
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 5 Jun 2021

'use strict'

const Model = require('./model')

// Here, we are implementing the class with Singleton design pattern

class ActivityModel extends Model {
    constructor() {
        super('activity')
        if (this.instance) return this.instance
        ActivityModel.instance = this
    }
}

module.exports = new ActivityModel()