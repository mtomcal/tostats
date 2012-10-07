Db = require('./db')
UserModel = new Db.Schema
  username:String,
  user_id:
    type: String,
    unique: true,
  fans: Number,
  reputation: Number,

UserModel.path('username').validate (v) ->

UserModel.path('user_id').validate (v) ->

UserModel.path('fans').validate (v) ->

UserModel.path('reputation').validate (v) ->

module.exports = Db.Model.register 'UserModel', UserModel
