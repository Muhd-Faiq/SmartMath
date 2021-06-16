// Author: Jumail 
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 5 Jun 2021

'use strict'

const Controller = require('./controller')
const activityModel = require('../models/activity_model')

const activityController = new Controller(activityModel)
module.exports = activityController.router