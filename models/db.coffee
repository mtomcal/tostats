mongoose = require('mongoose')
Schema = mongoose.Schema

env = process.env.NODE_ENV

connection =
  'default':     'mongodb://localhost/tostats',
  'development': 'mongodb://localhost/tostats',
  'testing':     'mongodb://localhost/tostats-testing',
  'production':  'mongodb://localhost/tostats',

if !env then env = 'default'
mongoose.connect(connection[env])

Validator = require('validator').Validator
validator = new Validator
validator.error = (msg) ->
  return false

exports.Validator = validator

exports.Schema = Schema

exports.Model =
  register: (name, model) ->
    return mongoose.model(name, model)
  ,fetch: (name) ->
    return mongoose.model(name)

