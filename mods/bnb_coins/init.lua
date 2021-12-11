bnb_coins = {}

bnb_coins.get_player_coins = function(name)
    local player = minetest.get_player_by_name(name)
    local meta = player:get_meta()
    local coins = meta:get_int("coins")
    return coins
end

bnb_coins.set_player_coins = function(name, amount)
    local player = minetest.get_player_by_name(name)
    local meta = player:get_meta()
    local coins = meta:set_int("coins", amount)
end

bnb_coins.add_player_coins = function(name, amount)
    bnb_coins.set_player_coins(name, bnb_coins.get_player_coins(name) + amount)
end

bnb_coins.remove_player_coins = function(name, amount)
    bnb_coins.set_player_coins(name, bnb_coins.get_player_coins(name) - amount)
end

--HUD things
minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local coins = tostring(bnb_coins.get_player_coins(name))
    player:hud_add({
        hud_elem_type = "text",
        position = {x = 0.1, y = 0.9},
        offset = {x = 0, y = 0},
        text = "Coins: " .. coins,
        number = 0xf4b41b,
        alignment = {x = 0, y = 0},
        --scale = {x = 350, y = 350},
    })
    player:hud_add({
        hud_elem_type = "image",
        position = {x = 0.1, y = 0.9},
        offset = {x = (#coins * 4.2)+46, y = 0},
        text = "coin.png",
        number = 0xFFFFFF,
        alignment = {x = 0, y = 0},
        scale = {x = 2, y = 2},
    })
end)

local time = 0
minetest.register_globalstep(function(dtime)
    time = time + dtime
    if time >= 1 then
        time = 0
        for _, player in ipairs(minetest.get_connected_players()) do
            local name = player:get_player_name()
            local coins = tostring(bnb_coins.get_player_coins(name))
            player:hud_change(0, "text", "Coins: " .. coins)
            player:hud_change(1, "offset", {x = (#coins * 4.2)+46, y = 0})
        end
    end
end)
--for dev only
minetest.register_chatcommand("scoins", {
    description = "Set your coins",
    func = function(name, amount)
        bnb_coins.set_player_coins(name, amount)
    end
})