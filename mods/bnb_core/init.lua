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
    bnb_coins.add_player_coins(player:get_player_name(), 50)
    --place schem
    bnb_schems.place_demo(bnb_core.demo_min, bnb_core.demo_max)
end

bnb_core.tp_shop = function(player)
    player:set_pos(bnb_core.shop_pos)
end

bnb_core.set_areas_air = function ()
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
end

bnb_core.finished = function(player)
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
            if same then--only send one msg for each type at a time
                minetest.chat_send_all(minetest.colorize("#71aa34", "If you are building an exact clone: the node at " .. minetest.pos_to_string(pos) .. " is " .. node.name .. " but should be " .. node_demo.name))
            end
            same = false
        end
        if node_demo.name ~= "air" then
            all_air = false
        end
    end
    end
    end

    local finished
    if all_air then
        finished = false
        minetest.chat_send_all(minetest.colorize("#71aa34", "Please wait for the demo to load, thanks for your patience!"))
    elseif same and all_air == false then
        finished = true
    elseif same == false and all_air == false then
        --check for mirrors
        local mirror_same = true
        for x = bnb_core.building_min.x, bnb_core.building_max.x do
        for y = bnb_core.building_min.y, bnb_core.building_max.y do
        for z = bnb_core.building_min.z, bnb_core.building_max.z do
            local pos = {x = x, y = y, z = z}
            local node = minetest.get_node(pos)
            local pos_demo = {x = math.abs(x), y = y, z = z}
            local node_demo = minetest.get_node(pos_demo)
            if node.name ~= node_demo.name then
                if mirror_same then
                    minetest.chat_send_all(minetest.colorize("#71aa34", "If you are building a mirror: the node at " .. minetest.pos_to_string(pos) .. " is " .. node.name .. " but should be " .. node_demo.name))
                end
                mirror_same = false
            end
        end
        end
        end
        if mirror_same then
            finished = true
        else
            finished = false
        end
    end

    if finished then
        --set both areas to air
        bnb_core.set_areas_air()

        --give player coins and send chat message
        local reward = 50--implement calculation with time
        bnb_coins.add_player_coins(player:get_player_name(), reward)
        minetest.chat_send_all(minetest.colorize("#71aa34", "You have completed the building! Well done, for doing this, you receive " .. reward .. " coins!"))


        --place demo schem
        bnb_schems.place_demo(bnb_core.demo_min, bnb_core.demo_max)
    else
        --minetest.chat_send_all(minetest.colorize("#71aa34", fail_msg))
    end
end

--[[bnb_core.complete = function(complete, player)
    local pname = player:get_player_name()
    if complete then
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
        minetest.chat_send_all(minetest.colorize("#71aa34", "You have completed the building!"))
        bnb_coins.add_player_coins(pname, 50)
        --place schem for new demo
        bnb_schems.place_demo(bnb_core.demo_min, bnb_core.demo_max)
    else
        minetest.chat_send_all(minetest.colorize("#71aa34", "Either the build is not the same as the demo or the demo isnt ready yet. Please try building again or wait for the demo to be ready."))
    end
end]]--move all to bnb_core.finished()

local punching = false
minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
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
    --incase ppl have modified minetest.confs
    minetest.set_player_privs(player:get_player_name(), {fly = true, shout = true, interact = true})
    player:set_physics_override({
        speed = 1.5,
    })
end)


--new hand texture
minetest.register_item(":", {
    type = "none",
    wield_image = "wieldhand.png",
    wield_scale = {x=1,y=1,z=2.5},
})

minetest.register_on_chat_message(function(name, message)
    local newmsg = minetest.colorize("#b6d53c", "<"..name.."> "..message)
    minetest.chat_send_all(newmsg)
    return newmsg
end)

--remove crafting and placing in a area that isnt the building area
minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
	itemstack:set_count(0)
	return itemstack
end)

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
    if pos.x >= bnb_core.building_min.x and pos.x <= bnb_core.building_max.x and pos.z >= bnb_core.building_min.z and pos.z <= bnb_core.building_max.z and pos.y >= bnb_core.building_min.y and pos.y <= bnb_core.building_max.y then
        --its fine
    else
        minetest.set_node(pos, oldnode)
        return itemstack
    end
end)

minetest.register_on_newplayer(function(player)
    player:set_pos({x = 0, y = 0, z = 0})
end)

local round = function(int)
    return math.floor(int*10)/10--1 dp
end

local round_pos = function(table)
    table.x = round(table.x)
    table.y = round(table.y)
    table.z = round(table.z)
    return table
end

local afkdectector = 0
local cachepos = {}
local afk = {}
minetest.register_globalstep(function(dtime)
    afkdectector = afkdectector + dtime
    if afkdectector >= 130 then
        afkdectector = 0
        for _,player in ipairs(minetest.get_connected_players()) do
            local ppos = round_pos(player:get_pos())
            local pname = player:get_player_name()
            if cachepos[pname] and ppos.x == cachepos[pname].x and ppos.y == cachepos[pname].y and ppos.z == cachepos[pname].z then
                minetest.chat_send_all(minetest.colorize("#b6d53c", pname.." is AFK"))
                afk[pname] = true
            else
                afk[pname] = false
            end
            cachepos[pname] = ppos
        end
    end
end)

minetest.register_on_leaveplayer(function(player)
    local pname = player:get_player_name()
    cachepos[pname] = nil
    if afk[pname] then
        afk[pname] = nil
    end
end)
minetest.register_on_joinplayer(function(player)
    local pname = player:get_player_name()
    cachepos[pname] = round_pos(player:get_pos())
end)

--passive income
local timer = 0
minetest.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer >= 10 then
        timer = 0
        for _, player in ipairs(minetest.get_connected_players()) do
            local pname = player:get_player_name()
            if afk[pname] then
                minetest.chat_send_player(player:get_player_name(), minetest.colorize("#71aa34", "You are AFK, you will not receive coins from passive income!"))
            else
                bnb_coins.add_player_coins(player:get_player_name(), 1)
            end
        end
    end
end)