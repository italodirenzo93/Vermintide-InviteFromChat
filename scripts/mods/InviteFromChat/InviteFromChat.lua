local mod = get_mod("InviteFromChat")

--[[
  Get the user's friends list as a table of name->id
]]
local function get_friends_list()
  local friends_list = {}

  local num_friends = Friends.num_friends()

  for i = 1, num_friends do
    local friend_id = Friends.id(i)
    local friend_name = Friends.name(friend_id)
    friends_list[friend_name] = friend_id
  end

  return friends_list
end

-- Command help description
local CMD_INVITE_HELP = [[
  Invite the specified players to join your lobby.
  Usage: /invite <player_name> <player_name> <...>
]]

mod:command("invite", CMD_INVITE_HELP, function (...)
  local friend_names = {...}
  if #friend_names == 0 then
    mod:echo("No friends specified.")
    return
  end

  local friends_list = get_friends_list()

  -- Find the specified friends in the user's friends list
  local friends_to_invite = {}
  local friends_not_found = {}
  for i, friend in ipairs(friend_names) do
    if friends_list[friend] ~= nil then
      table.insert(friends_to_invite, friends_list[friend])
    else
      table.insert(friends_not_found, friends_list[friend])
    end
  end

  -- Inform the user of friends that were not found in the friends list
  if #friends_not_found > 0 then
    local tense = "was"
    if #friends_not_found > 1 then
      tense = "were"
    end
    mod:echo("%s %s not found in friends list", table.concat(friends_not_found, ", "), tense)
  end

  -- Create steam lobby
  if #friends_to_invite > 0 then
    local lobby = Network.create_steam_lobby("private", #friends_to_invite)
    for i, friend in ipairs(friends_to_invite) do
      Friends.invite(friend, lobby)
    end
  else
    mod:echo("Invites sent to %s!", table.concat(friend_names, ", "))
  end
end)

