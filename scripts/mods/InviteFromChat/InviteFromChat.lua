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

  local da_bois = {}
  for i, friend in ipairs(friend_names) do
    if friends_list[friend] ~= nil then
      table.insert(da_bois, friends_list[friend])
    end
  end

  if #da_bois == 0 then
    mod:echo("%s was not found in your friends list", table.concat(friend_names, ", "))
    return
  end

  -- Create steam lobby
  local lobby = Network.create_steam_lobby("private", 4)
  for i, boi in ipairs(da_bois) do
    Friends.invite(boi, lobby)
  end

  mod:echo("Invites sent to %s!", table.concat(friend_names, ", "))
end)

