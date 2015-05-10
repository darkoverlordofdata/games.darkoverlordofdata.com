###
 * Scoring strategies
###
##
#

module.exports = class Scoring

  ###
   * All scores allowed
  ###
  @anyScore: (member, currentScore, score, memberData, leaderboardOptions) ->
    true
  ###
   * Only post a higher score
  ###
  @highScore: (member, currentScore, score, memberData, leaderboardOptions) ->
    return true if !currentScore?
    return true if score > currentScore
    false

  ###
   * Only post a lower score
  ###
  @lowScore: (member, currentScore, score, memberData, leaderboardOptions) ->
    return true if !currentScore?
    return true if score < currentScore
    false
