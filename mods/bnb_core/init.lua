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
bnb_core.shopmax = {x = 21, y = 325, z = 20}

local REWARD = 50 -- reward for completing a building
local PASSIVE_INCOME_TIMER = 10 -- give 1 free coin after this number of seconds
local BLOCK_COST = 1 -- cost of 1 block

local mod_storage = minetest.get_mod_storage()--must be called at load time
local modpath = minetest.get_modpath(minetest.get_current_modname())
dofile(modpath.."/time.lua")

bnb_core.item_readable = function(itemstring)
   if minetest.registered_items[itemstring] then
      local stack = ItemStack(itemstring)
      return stack:get_short_description()
   else
      return itemstring
   end
end

bnb_core.tp_build = function(player)
    player:set_pos(bnb_core.play_pos)
    minetest.sound_play({name="bnb_core_teleport"}, {pos=player:get_pos()}, true)
    bnb_core.not_afk(player)
end

bnb_core.tp_shop = function(player)
    player:set_pos(bnb_core.shop_pos)
    minetest.sound_play({name="bnb_core_teleport"}, {pos=player:get_pos()}, true)
    bnb_core.not_afk(player)
end

bnb_core.start = function(player)
    bnb_core.tp_build(player)
    bnb_coins.add_player_coins(player:get_player_name(), REWARD)
    --place schem
    bnb_schems.place_demo(bnb_core.demo_min, bnb_core.demo_max)
    bnb_core.reset_time(player)
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

local function wrong_node_message(pos, is_node, should_node, prefix)
    local msg
    if is_node.name == "air" then
        msg = "There's no block at " .. minetest.pos_to_string(pos) .. " but it should be " .. bnb_core.item_readable(should_node.name).."."
    elseif should_node.name == "air" then
        msg = "The block at " .. minetest.pos_to_string(pos) .. " is " .. bnb_core.item_readable(is_node.name) .. " but should be removed."
    else
        msg = "The block at " .. minetest.pos_to_string(pos) .. " is " .. bnb_core.item_readable(is_node.name) .. " but should be " .. bnb_core.item_readable(should_node.name).."."
    end
    msg = prefix .. msg
    return msg
end

bnb_core.finished = function(player)
    local same = true
    local all_air = true
    local unloaded = false
    local fail_msg_clone, fail_msg_mirror
    for x = bnb_core.building_min.x, bnb_core.building_max.x do
    for y = bnb_core.building_min.y, bnb_core.building_max.y do
    for z = bnb_core.building_min.z, bnb_core.building_max.z do
        local pos = {x = x, y = y, z = z}
        local node = minetest.get_node(pos)
        local pos_demo = {x = x+16, y = y, z = z}
        local node_demo = minetest.get_node(pos_demo)
        if node_demo.name ~= "air" then
            all_air = false
        end
        if node_demo.name == "ignore" then
            unloaded = true
            break
        end
        if node.name ~= node_demo.name then
            if same then--only send one msg for each type at a time
                fail_msg_clone = wrong_node_message(pos, node, node_demo, "If you are building an exact clone: ")
            end
            same = false
        end
    end
    end
    end

    local finished
    if all_air or unloaded then
        finished = false
        minetest.chat_send_all(minetest.colorize("#71aa34", "Please wait for the demo to load, thanks for your patience!"))
        minetest.load_area(bnb_core.demo_min, bnb_core.demo_max)
        minetest.load_area(bnb_core.building_min, bnb_core.building_max)
    elseif same and all_air == false and unloaded == false then
        finished = true
    elseif same == false and all_air == false and unloaded == false then
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
                    fail_msg_mirror = wrong_node_message(pos, node, node_demo, "If you are building a mirror: ")
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
        local time = bnb_core.get_time(player)
        bnb_core.reset_time(player)

        local reward = REWARD --implement calculation with time
        bnb_coins.add_player_coins(player:get_player_name(), reward)
        minetest.chat_send_all(minetest.colorize("#71aa34", "You have completed the building in "..time.." seconds! Well done, for doing this, you receive " .. reward .. " coins!"))
        minetest.sound_play({name="bnb_core_submit_win"}, {to_player=player:get_player_name()}, true)

        --place demo schem
        bnb_schems.place_demo(bnb_core.demo_min, bnb_core.demo_max)
    else
        minetest.sound_play({name="bnb_core_submit_fail"}, {to_player=player:get_player_name()}, true)
        if fail_msg_clone then
           minetest.chat_send_all(minetest.colorize("#71aa34", fail_msg_clone))
        end
        if fail_msg_mirror then
           minetest.chat_send_all(minetest.colorize("#71aa34", fail_msg_mirror))
        end
    end
end

local punching = false
minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
    bnb_core.not_afk(puncher)
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
            minetest.sound_play({name="bnb_core_dig"}, {pos=node_pos}, true)
    elseif node_pos.x >= bnb_core.demo_min.x and node_pos.x <= bnb_core.demo_max.x and node_pos.z >= bnb_core.demo_min.z and node_pos.z <= bnb_core.demo_max.z and node_pos.y >= bnb_core.demo_min.y and node_pos.y <= bnb_core.demo_max.y then
            minetest.chat_send_player(puncher:get_player_name(), minetest.colorize("#71aa34", "This is the demo you need to replicate!"))
    elseif minetest.get_item_group(node.name, "shop") == 1 then
        local shopdef = minetest.registered_nodes[node.name]
        local selling = shopdef._bnb_selling
        local coins = bnb_coins.get_player_coins(puncher:get_player_name())
        if coins >= BLOCK_COST then
            local inv = puncher:get_inventory()
            if inv:room_for_item("main", selling) then
               bnb_coins.remove_player_coins(puncher:get_player_name(), BLOCK_COST)
               inv:add_item("main", selling)
               minetest.sound_play({name="bnb_core_buy"}, {pos=puncher:get_pos()}, true)
            else
               minetest.chat_send_player(puncher:get_player_name(), minetest.colorize("#71aa34", "Your inventory is full!"))
               minetest.sound_play({name="bnb_core_buy_fail"}, {to_player=puncher:get_player_name()}, true)
            end
        else
            minetest.chat_send_player(puncher:get_player_name(), minetest.colorize("#71aa34", "You don't have enough coins!"))
            minetest.sound_play({name="bnb_core_buy_fail"}, {to_player=puncher:get_player_name()}, true)
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
    minetest.load_area(bnb_core.demo_min, bnb_core.demo_max)
    minetest.load_area(bnb_core.building_min, bnb_core.building_max)

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
    minetest.sound_play("bnb_core_bg_music", {to_player = player:get_player_name(), gain = 0.6, loop = true}, true)
    --incase ppl have modified minetest.confs
    minetest.set_player_privs(player:get_player_name(), {fly = true, shout = true, interact = true})
    player:set_physics_override({
        speed = 1.5,
    })
    player:set_armor_groups({immortal = 1})--make player immortal cuz apparently enable_damage = false sometimes doesnt work
    player:set_inventory_formspec("size[8,4.25]list[current_player;main;0,0;8,1;]list[current_player;main;0,1.5;8,4.25;8]")
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
    local player = minetest.get_player_by_name(name)
    bnb_core.not_afk(player)
    return newmsg
end)

--remove crafting and placing in a area that isnt the building area
minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
	itemstack:set_count(0)
	return itemstack
end)

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
    bnb_core.not_afk(placer)
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

bnb_core.not_afk = function(player)
    local pname = player:get_player_name()
    afk[pname] = false
    cachepos[pname] = player:get_pos()
end
minetest.register_on_chatcommand(function(pname)
    local player = minetest.get_player_by_name(pname)
    bnb_core.not_afk(player)
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
    if timer >= PASSIVE_INCOME_TIMER then
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

--chat commands to tp to shop/arena/submit a build

minetest.register_chatcommand("shop", {
    description = "Teleport to the shop",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        bnb_core.tp_shop(player)
    end
})
minetest.register_chatcommand("s", {
    description = "Teleport to the shop",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        bnb_core.tp_shop(player)
    end
})

minetest.register_chatcommand("arena", {
    description = "Teleport to the arena",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        bnb_core.tp_build(player)
    end
})
minetest.register_chatcommand("a", {
    description = "Teleport to the arena",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        bnb_core.tp_build(player)
    end
})

minetest.register_chatcommand("submit", {
    description = "Submit your build",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        bnb_core.finished(player)
    end
})

minetest.register_chatcommand("s", {
    description = "Submit your build",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        bnb_core.finished(player)
    end
})
