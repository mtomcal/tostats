Bot = require 'ttapi'
UserModel = require '../models/UserModel'
SongModel = require '../models/SongModel'
Q = require "q"

module.exports = class TT
  constructor: ->
    @bot = new Bot('rjrUjpaILOwAfMejyuOZiInT','50709286aaa5cd107f000398','4e16479214169c128d049d90')

  loadOnEvents: =>
    @bot.on 'endsong', (data) =>
      @saveEndSong(data)

  saveEndSong: (data) =>
    user_id = data.room.metadata.current_dj
    current_song = data.room.metadata.current_song

    Q.all([
      @fetchUserName(user_id),
      @fetchFans(user_id),
      @fetchRep(user_id)
    ])
    .then (results) ->
      user = new UserModel
        username: results[0],
        user_id: user_id,
        fans: results[1],
        reputation: results[2]
      song = new SongModel
        track_name: current_song.metadata.song,
        artist: current_song.metadata.artist,
        song_id: current_song._id,
        user_id: user_id,
        votes: data.room.metadata.upvotes,
        listeners: data.room.metadata.listeners,
        date_played: new Date(),
      song.save (err) ->
        if err 
          console.log "[Song Save Err]" + err
      UserModel.findOne {"user_id": user.user_id}, (err, userDoc) ->
        if err or !userDoc
          user.save (err) ->
            if err
              console.log "[Song Save Err]" + err
        else
          userDoc.fans = user.fans
          userDoc.reputation = user.reputation
          userDoc.save (err) ->
            if err
              console.log "[User Save Err]" + err

  fetchUserName: (userId) =>
    defer = Q.defer()
    @_fetchProfile userId, (data) ->
      defer.resolve data.name
    return defer.promise

  fetchRep: (userId) =>
    defer = Q.defer()
    @_fetchProfile userId, (data) ->
      defer.resolve data.points
    return defer.promise

  fetchFans: (userId) =>
    defer = Q.defer()
    @_fetchProfile userId, (data) ->
      defer.resolve data.fans
    return defer.promise

  _fetchProfile: (userId, cb) =>
    @bot.getProfile(userId, cb)

  _dbSave: (user, song) =>
    console.log user
    console.log song
    
    



