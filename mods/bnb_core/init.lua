bnb_core = {}
bnb_core.play_pos = {x = 0, y = 101, z = 0}
bnb_core.shop_pos = {x = 0, y = 301, z = 0}
bnb_core.building_min = {x = -11, y = 102, z = -3}
bnb_core.building_max = {x = -5, y = 105, z = 3}
bnb_core.demo_min = {x = 5, y = 102, z = -3}
bnb_core.demo_max = { x = 11, y = 105, z = 3}
bnb_core.spawnmin = {x = -5, y = -2, z = -5}
bnb_core.spawnmax = {x = 5, y = 8, z = 5}
bnb_core.arenamin = {x = -19, y = 100, z = -11}
bnb_core.arenamax = {x = 19, y = 109, z = 11}
bnb_core.shopmin = {x = -27, y = 300, z = -29}
bnb_core.shopmax = {x = 21, y = 300, z = 20}

local mod_storage = minetest.get_mod_storage()--must be called at load time

bnb_core.tp_build = function(player)
    player:set_pos(bnb_core.play_pos)
end

bnb_core.start = function(player)
    bnb_core.tp_build(player)
    bnb_coins.add_player_coins(player:get_player_name(), 25)
end

bnb_core.tp_shop = function(player)
    player:set_pos(bnb_core.shop_pos)
end

bnb_core.finished = function()
    local same = true
    local all_air = true
    for x = bnb_core.building_min.x, bnb_core.building_max.x do
    for y = bnb_core.building_min.y, bnb_core.building_max.y do
    for z = bnb_core.building_min.z, bnb_core.building_max.z do
        local pos = {x = x, y = y, z = z}
        local node = minetest.get_node(pos)
        local pos_demo = {x = x+16, y = y, z = z}
        local node_demo = minetest.get_node(pos_demo)
        if node.name ~= node_demo.name then
            same = false
        end
        if node_demo.name ~= "air" then
            all_air = false
        end
    end
    end
    end
    if same and all_air == false then
        return true
    else
        return false
    end
end

bnb_core.complete = function(complete, player)
    local pname = player:get_player_name()
    if complete then
        bnb_coins.add_player_coins(pname, 50)
        --set demo area and building area to air
        for x = bnb_core.demo_min.x, bnb_core.demo_max.x do
        for y = bnb_core.demo_min.y, bnb_core.demo_max.y do
        for z = bnb_core.demo_min.z, bnb_core.demo_max.z do
            local pos = {x = x, y = y, z = z}
            minetest.set_node(pos, {name = "air"})
        end
        end
        end

        for x = bnb_core.building_min.x, bnb_core.building_max.x do
        for y = bnb_core.building_min.y, bnb_core.building_max.y do
        for z = bnb_core.building_min.z, bnb_core.building_max.z do
            local pos = {x = x, y = y, z = z}
            minetest.set_node(pos, {name = "air"})
        end
        end
        end
        minetest.chat_send_player(pname, minetest.colorize("#71aa34", "You have completed the building!"))
        --place schem for new demo
    else
        minetest.chat_send_player(pname, minetest.colorize("#71aa34", "Either your build is not the same as the demo or the demo isnt ready yet. Please try building again or wait for the demo to be ready."))
    end
end

local punching = false
minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
    --minetest.chat_send_all("Punched nodepos: "..pos.x.." "..pos.y.." "..pos.z)
    if punching then
        return
    end
    punching = true
    minetest.after(0.1, function()
        punching = false
    end)
    if puncher:get_wielded_item().name == "bnb_nodes:stick" then return end
    local node_pos = pointed_thing.under
    if node_pos.x >= bnb_core.building_min.x and node_pos.x <= bnb_core.building_max.x and node_pos.z >= bnb_core.building_min.z and node_pos.z <= bnb_core.building_max.z and node_pos.y >= bnb_core.building_min.y and node_pos.y <= bnb_core.building_max.y then
            --give puncher the node
            local nodename = node.name
            puncher:get_inventory():add_item("main", nodename)
            minetest.set_node(node_pos, {name = "air"})
    elseif node_pos.x >= bnb_core.demo_min.x and node_pos.x <= bnb_core.demo_max.x and node_pos.z >= bnb_core.demo_min.z and node_pos.z <= bnb_core.demo_max.z and node_pos.y >= bnb_core.demo_min.y and node_pos.y <= bnb_core.demo_max.y then
            minetest.chat_send_player(puncher:get_player_name(), minetest.colorize("#71aa34", "This is the demo you need to replicate!"))
    elseif node.name:find("bnb_nodes:shop_") then
        local selling = node.name:gsub("shop_", "")
        local coins = bnb_coins.get_player_coins(puncher:get_player_name())
        if coins >= 1 then
            bnb_coins.remove_player_coins(puncher:get_player_name(), 1)
            puncher:get_inventory():add_item("main", selling)
        else
            minetest.chat_send_player(puncher:get_player_name(), minetest.colorize("#71aa34", "You don't have enough coins!"))
        end
    else
        return false
    end
end)

minetest.register_on_joinplayer(function(player)
    local placed_already = mod_storage:get_int("placed_already")
    if placed_already == 0 then
        mod_storage:set_int("placed_already", 1)
        --emerge to place schems
        minetest.emerge_area(bnb_core.spawnmin, bnb_core.spawnmax, function(blockpos, action, remaining)
            if remaining == 0 then
                bnb_schems.place(bnb_core.spawnmin, "spawn", 0, nil, true)
            end
        end)
        minetest.emerge_area(bnb_core.arenamin, bnb_core.arenamax, function(blockpos, action, remaining)
            if remaining == 0 then
                bnb_schems.place(bnb_core.arenamin, "arena", 0, nil, true)
            end
        end)
        minetest.emerge_area(bnb_core.shopmin, bnb_core.shopmax, function(blockpos, action, remaining)
            if remaining == 0 then
                bnb_schems.place(bnb_core.shopmin, "shop", 0, nil, true)
            end
        end)
    end

    player:hud_set_hotbar_image("gui_hotbar.png")
    player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
    player:set_properties({
        mesh = "character.b3d",
        visual = "mesh",
        visual_size = {x=1, y=1},
        collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
        stepheight = 0.6,
        eye_height = 1.47,
        textures = {"bob_skin.png"},
    })
    minetest.sound_play("bg_music", {to_player = player:get_player_name(), gain = 0.6, loop = true})
end)


--new hand texture
minetest.register_item(":", {
    type = "none",
    wield_image = "wieldhand.png",
    wield_scale = {x=1,y=1,z=2.5},
})
--passive income
local timer = 0
minetest.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer >= 10 then
        timer = 0
        for _, player in ipairs(minetest.get_connected_players()) do
            bnb_coins.add_player_coins(player:get_player_name(), 1)
        end
    end
end)

minetest.register_on_chat_message(function(name, message)
    local newmsg = minetest.colorize("#b6d53c", "<"..name.."> "..message)
    minetest.chat_send_all(newmsg)
    return newmsg
end)