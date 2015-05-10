#|--------------------------------------------------------------------------
#| AporaGames Leaderboard configuration
#|--------------------------------------------------------------------------
#|
#|  You can pass various options to the calls leaders, allLeaders, aroundMe,
#|   membersFromScoreRange, membersFromRankRange and rankedInList. Valid options are:
#|
#|    * withMemberData - true or false to return the optional member data.
#|    * pageSize - An integer value to change the page size for that call.
#|    * membersOnly - true or false to return only the members without their score and rank.
#|    * sortBy - Valid values for sortBy are score and rank.
#|
#|

module.exports =

  pageSize              : 25
  reverse               : false
  memberKey             : 'member'
  rankKey               : 'rank'
  scoreKey              : 'score'
  memberDataKey         : 'member_data'
  memberDataNamespace   : 'member_data'

