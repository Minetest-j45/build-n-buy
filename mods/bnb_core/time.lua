bnb_core.time = {}

bnb_core.reset_time = function(player)
    bnb_core.time[player:get_player_name()] = 0
end

bnb_core.save_time = function(player)
    local meta = player:get_meta()
    local time = bnb_core.time[player:get_player_name()]
    meta:set_int("time", time)
end

bnb_core.get_time = function(player)
    local meta = player:get_meta()
    local time = meta:get_int("time")
    if not bnb_core.time[player:get_player_name()] then
        bnb_core.time[player:get_player_name()] = 0
    end
    local max = math.max(time, bnb_core.time[player:get_player_name()])
    return max or 0--to be used for when player just logged in but also when player is playing so needs to be the biggest
end

minetest.register_on_joinplayer(function(player)
    local time = bnb_core.get_time(player)
    bnb_core.time[player:get_player_name()] = time
end)

minetest.register_on_newplayer(function(player)
    bnb_core.reset_time(player)
end)

minetest.register_on_leaveplayer(function(player)
    bnb_core.save_time(player)
end)

minetest.register_on_shutdown(function()
    for _,player in ipairs(minetest.get_connected_players()) do
        bnb_core.save_time(player)
    end
end)

local etime = 0
minetest.register_globalstep(function(dtime)
    etime = etime + dtime
    if etime >= 1 then
        for _,player in ipairs(minetest.get_connected_players()) do
            bnb_core.time[player:get_player_name()] = bnb_core.time[player:get_player_name()] + 1
        end
        etime = 0
    end
end)
