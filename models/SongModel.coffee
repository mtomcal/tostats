Db = require('./db')
SongModel = new Db.Schema
  track_name: String,
  artist: String,
  user_id: 
    type: String,
    unique: true
  song_id:
    type: String,
    unique: true
  votes: Number,
  listeners: Number,
  date_played: Date


SongModel.path('track_name').validate (v) ->

SongModel.path('artist').validate (v) ->

SongModel.path('user_id').validate (v) ->

SongModel.path('votes').validate (v) ->

SongModel.path('date_played').validate (v) ->

module.exports = Db.Model.register 'SongModel', SongModel
