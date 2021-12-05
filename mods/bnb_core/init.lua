bnb_core = {}
bnb_core.play_pos = {x = 0, y = 101, z = 0}
bnb_core.shop_pos = {x = 0, y = 301, z = 0}
bnb_core.building_min = {x = -11, y = 102, z = -3}
bnb_core.building_max = {x = -5, y = 105, z = 3}
bnb_core.demo_min = {x = 5, y = 102, z = -3}
bnb_core.demo_max = { x = 11, y = 105, z = 3}

bnb_core.start = function(player)
    player:set_pos(bnb_core.play_pos)
end

bnb_core.tp_shop = function(player)
    player:set_pos(bnb_core.shop_pos)
end

bnb_core.finished = function()
    for x = bnb_core.building_min.x, bnb_core.building_max.x do
        for y = bnb_core.building_min.y, bnb_core.building_max.y do
            for z = bnb_core.building_min.z, bnb_core.building_max.z do
                local pos = {x = x, y = y, z = z}
                local node = minetest.get_node(pos)
                local pos_demo = {x = x+16, y = y, z = z}
                local node_demo = minetest.get_node(pos_demo)
                if node.name ~= node_demo.name then
                    return false
                end
            end
        end
    end
    return true
end

minetest.register_chatcommand("check", {
    description = "Check if the areas are the same",
    func = function(name)
        minetest.chat_send_all(dump(bnb_core.finished()))
    end,
})

local punching = false
local punchtimer = 0
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
    if node_pos.x >= bnb_core.building_min.x and node_pos.x <= bnb_core.building_max.x and node_pos.z >= bnb_core.building_min.z and node_pos.z <= bnb_core.building_max.z then
        if node_pos.y >= bnb_core.building_min.y and node_pos.y <= bnb_core.building_max.y then
            --give puncher the node
            local nodename = node.name
            puncher:get_inventory():add_item("main", nodename)
            minetest.set_node(node_pos, {name = "air"})
        end
    elseif node_pos.x >= bnb_core.demo_min.x and node_pos.x <= bnb_core.demo_max.x and node_pos.z >= bnb_core.demo_min.z and node_pos.z <= bnb_core.demo_max.z then
        if node_pos.y >= bnb_core.demo_min.y and node_pos.y <= bnb_core.demo_max.y then
            minetest.chat_send_player(puncher:get_player_name(), "This is the demo you need to replicate!")
        end
    else
        return false
    end
end)