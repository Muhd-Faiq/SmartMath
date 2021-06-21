// Author: Jumail 
// Email: jumail@utm.my
// Github:  github.com/jumail-utm
// Update: 5 Jun 2021

'use strict'

const Controller = require('./controller')
const submissionModel = require('../models/submission_model')

const submissionController = new Controller(submissionModel)
module.exports = submissionController.router