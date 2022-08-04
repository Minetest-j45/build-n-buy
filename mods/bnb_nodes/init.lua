local node_sounds = {
   footstep = { name = "bnb_core_step", gain = 0.8 },
   place = { name = "bnb_core_place", gain = 1.0 },
   dig = { name = "bnb_core_dig", gain = 1.0 },
   dug = { name = "bnb_core_dig", gain = 1.0 },
}

--quartz
minetest.register_node(minetest.get_current_modname()..":quartz_block", {
    description = "Quartz Block",
    tiles = {"quartz_block.png"},
    sounds = node_sounds,
})

minetest.register_node(minetest.get_current_modname()..":quartz_slab", {
    description = "Quartz Slab",
    drawtype = "nodebox",
    tiles = {"quartz_block.png"},
    node_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
    },
    sounds = node_sounds,
})

minetest.register_node(minetest.get_current_modname()..":quartz_slab1", {
    description = "Quartz Slab",
    drawtype = "nodebox",
    tiles = {"quartz_block.png"},
    node_box = {
        type = "fixed",
        fixed = {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
    },
    sounds = node_sounds,
})

minetest.register_node(minetest.get_current_modname()..":quartz_pillar", {
    description = "Quartz Pillar",
    drawtype = "nodebox",
    tiles = {"quartz_block.png"},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
        },
    },
    sounds = node_sounds,
})

minetest.register_node(minetest.get_current_modname()..":quartz_wall1", {
    description = "Quartz Wall",
    drawtype = "nodebox",
    tiles = {"quartz_block.png"},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.25, 0.5, 0.5, 0.25},
        },
    },
    sounds = node_sounds,
})

minetest.register_node(minetest.get_current_modname()..":quartz_wall2", {
    description = "Quartz Wall",
    drawtype = "nodebox",
    tiles = {"quartz_block.png"},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.25, -0.5, -0.5, 0.25, 0.5, 0.5},
        },
    },
    sounds = node_sounds,
})

minetest.register_node(minetest.get_current_modname()..":quartz_wall3_1", {
    description = "Quartz Wall",
    drawtype = "nodebox",
    tiles = {"quartz_block.png"},
    node_box = {
        type = "fixed",
        fixed = {
            {0, -0.5, -0.5, 0.5, 0.5, 0.5},
        },
    },
    sounds = node_sounds,
})

minetest.register_node(minetest.get_current_modname()..":quartz_wall3_2", {
    description = "Quartz Wall",
    drawtype = "nodebox",
    tiles = {"quartz_block.png"},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0, 0.5, 0.5},
        },
    },
    sounds = node_sounds,
})

minetest.register_node(minetest.get_current_modname()..":quartz_wall4_1", {
    description = "Quartz Wall",
    drawtype = "nodebox",
    tiles = {"quartz_block.png"},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
        },
    },
    sounds = node_sounds,
})

minetest.register_node(minetest.get_current_modname()..":quartz_wall4_2", {
    description = "Quartz Wall",
    drawtype = "nodebox",
    tiles = {"quartz_block.png"},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0},
        },
    },
    sounds = node_sounds,
})

minetest.register_node(minetest.get_current_modname()..":quartz_welcome", {
    description = "Quartz Welcome",
    tiles = {"quartz_block.png","quartz_block.png","quartz_block.png^welcome_text.png"},
    sounds = node_sounds,
})

minetest.register_node(minetest.get_current_modname()..":quartz_play", {
    description = "Quartz Play",
    tiles = {"quartz_block.png","quartz_block.png","quartz_block.png^play_text.png"},
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        bnb_core.start(player)
    end,
    sounds = node_sounds,
})

minetest.register_node(minetest.get_current_modname()..":quartz_shop", {
    description = "Quartz Shop",
    tiles = {"quartz_block.png","quartz_block.png","quartz_block.png^shop_text.png"},
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        bnb_core.tp_shop(player)
    end,
    sounds = node_sounds,
})

minetest.register_node(minetest.get_current_modname()..":quartz_finished", {
    description = "Quartz Finished",
    tiles = {"quartz_block.png","quartz_block.png","quartz_block.png^finished_text.png"},
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        --local complete = bnb_core.finished()
        --bnb_core.complete(complete, player)
        bnb_core.finished(player)
    end,
    sounds = node_sounds,
})

minetest.register_node(minetest.get_current_modname()..":quartz_build", {
    description = "Quartz Build",
    tiles = {"quartz_block.png","quartz_block.png","quartz_block.png^build_text.png"},
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        bnb_core.tp_build(player)
    end,
    sounds = node_sounds,
})

--lantern
minetest.register_node(minetest.get_current_modname()..":light_block", {
    description = "Light Block",
    tiles = {"light.png"},
    light_source = 14,
    sounds = node_sounds,
})

--funcs
local register_ore = function(name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name.."_ore", {
        description = desc.." Ore",
        tiles = {"stone.png^"..name.."_ore.png"},
        sounds = node_sounds,
    })
end

local register_stone = function(name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name, {
        description = desc.." Stone",
        tiles = {name..".png"},
        sounds = node_sounds,
    })
end

local register_liquid = function(name, desc, animlength, light_level)
	local paramtype
    if light_level and light_level > 1 then
        paramtype = "light"
    end
    minetest.register_node(minetest.get_current_modname()..":"..name, {
        description = desc,
        tiles = {{
           name = name .. "_animated.png",
           animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = animlength },
        }},
	light_source = light_level,
	paramtype = paramtype,
        sounds = node_sounds,
    })
end

local register_dirt = function(name, desc, texture)
    minetest.register_node(minetest.get_current_modname()..":"..name, {
        description = desc,
        tiles = texture,
        sounds = node_sounds,
    })
end

local register_sand = function(name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name, {
        description = desc,
        tiles = {name..".png"},
        sounds = node_sounds,
    })
end

local register_block = function(name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name.."_block", {
        description = desc,
        tiles = {name.."_block.png"},
        sounds = node_sounds,
    })
end

local register_wool = function(name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name .. "_wool", {
        description = desc.." Wool",
        tiles = {name .. "_wool.png"},
        light_source = 1,
        sounds = node_sounds,
    })
end

local register_glass = function(name, desc, extra)
    minetest.register_node(minetest.get_current_modname()..":"..name .. "_stained_glass", {
        description = desc.. " Stained Glass",
        drawtype = "glasslike",
        use_texture_alpha = "blend",
        tiles = {name .. "_glass.png".. extra},
        light_source = 1,
        paramtype = "light",--suggested by wuzzy
        sounds = node_sounds,
    })
end

--logs
local register_log = function(name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name.."_log", {
        description = desc.." Log",
        tiles = {"log_"..name.."_top.png", "log_"..name.."_top.png", "log_"..name..".png"},
        sounds = node_sounds,
    })
end
local register_plank = function (name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name.."_plank", {
        description = desc.." Plank",
        tiles = {name.."_plank.png"},
        sounds = node_sounds,
    })
end

--signs
local register_sign = function(name, desc, tilez)
    minetest.register_node(minetest.get_current_modname()..":sign_"..name, {
        description = desc,
        tiles = tilez,
        drawtype = "nodebox",
        node_box = {
           type = "wallmounted",
           wall_side = { -0.5, -0.5, -0.5, -31/64, 0.5, 0.5, },
        },
        paramtype2 = "wallmounted",
        walkable = false,
        paramtype = "light",
        sunlight_propagates = true,
        sounds = node_sounds,
    })
end
for i=0, 25 do
   local letter = string.char(i + 0x61)
   local letter_capital = string.char(i + 0x41)

   register_sign(letter, letter_capital.." Sign", {"font_"..letter..".png"})
end

--shops
local register_shop = function(item, desc, overlay, extra)
    if not extra then
        extra = ""
    end
    minetest.register_node(minetest.get_current_modname()..":shop_"..item, {
        description = desc,
        tiles = {"blue_wool.png", "blue_wool.png", "[combine:128x128:0,0=(blue_wool.png^shopping_cart.png\\^[resize\\:128x128):48,56="..overlay.."\\^[resize\\:32x32"..extra},
        light_source = 1,
        groups = { shop = 1 },
        -- Store which item this shop is selling
        _bnb_selling = minetest.get_current_modname()..":"..item,
        sounds = node_sounds,
    })
end

local wools = {
    {"red", "Red"},
    {"blue", "Blue"},
    {"grey", "Grey", "^[colorize:#000F:70"},
    {"black", "Black"},
    {"brown", "Brown"},
    {"cyan", "Cyan"},
    {"dark_green", "Dark Green"},
    {"green", "Green"},
    {"light_grey", "Light Grey"},
    {"magenta", "Magenta"},
    {"orange", "Orange"},
    {"pink", "Pink"},
    {"violet", "Violet"},
    {"white", "White"},
    {"yellow", "Yellow"},
}

for _, wool in ipairs(wools) do
    --normal wools
    register_wool(wool[1], wool[2])
    register_shop(wool[1].."_wool", wool[2].."Wool Shop", wool[1].."_wool.png")

    --glasses
    if not wool[3] then
       wool[3] = ""
    end
    register_glass(wool[1], wool[2], wool[3])
    register_shop(wool[1].."_stained_glass", wool[2].." Stained Glass Shop", wool[1].."_glass.png")
end


local woods = {
    {"oak", "Oak"},
    {"pine", "Pine"},
    {"beech", "Beech"},
    {"ash", "Ash"},
    {"teak", "Teak"}
}
for _,wood in ipairs(woods) do
    register_log(wood[1], wood[2])
    register_shop(wood[1].."_log", wood[2].." Log Shop", "log_"..wood[1]..".png")

    register_plank(wood[1], wood[2])
    register_shop(wood[1].."_plank", wood[2].." Plank Shop", wood[1].."_plank.png")
end

local ores = {
    {"coal", "Coal"},
    {"copper", "Copper"},
    {"diamond", "Diamond"},
    {"gold", "Gold"},
    {"iron", "Iron"},
    {"mese", "Mese"},
    {"tin", "Tin"},

}

for _,ore in ipairs(ores) do
    register_ore(ore[1], ore[2])
    register_shop(ore[1].."_ore", ore[2].." Ore Shop", "(stone.png^"..ore[1].."_ore.png)")

    register_block(ore[1], ore[2])
    register_shop(ore[1].."_block", ore[2].." Block Shop", ore[1].."_block.png")
end

local stones = {
    {"stone", "Normal"},
    {"brick_stone", "Brick"},
    {"polished_stone", "Polished"},
    {"desert_stone", "Desert"},
    {"desert_brick_stone", "Desert Brick"},
    {"polished_desert_stone", "Desert Polished"},
}
for _,stone in ipairs(stones) do
    register_stone(stone[1], stone[2])
    register_shop(stone[1], stone[2].." Stone Shop", stone[1]..".png")
end

local liquids = {
    {"water", "Water", 2},
    {"river_water", "River Water", 2},
    {"lava", "Lava", 1, 14},
}

for _,liquid in ipairs(liquids) do
    register_liquid(liquid[1], liquid[2], liquid[3], liquid[4])
    register_shop(liquid[1], liquid[2].." Shop", liquid[1]..".png")
end


local dirts = {
    {"dirt", "Dirt", {"dirt.png"}},
    {"dirt_with_grass", "Dirt With Grass", {"grass.png", "dirt.png", "dirt.png^grass_side.png"}},
    {"dry_dirt", "Dry Dirt", {"dry_dirt.png"}},
    {"dry_dirt_with_dry_grass", "Dry Dirt With Dry Grass", {"dry_grass.png", "dry_dirt.png", "dry_dirt.png^dry_grass_side.png"}},
    {"dirt_with_snow", "Dirt With Snow", {"snow.png", "dirt.png", "dirt.png^snow_side.png"}},
}
for _,dirt in ipairs(dirts) do
    register_dirt(dirt[1], dirt[2], dirt[3])
    local sidetexture = dirt[3][3] or dirt[3][1]
    register_shop(dirt[1], dirt[2].." Shop", "("..sidetexture..")")
end

local sands = {
    {"sand", "Sand"},
    {"silver_sand", "Silver Sand"},
}
for _,sand in ipairs(sands) do
    register_sand(sand[1], sand[2])
    register_shop(sand[1], sand[2].." Shop", sand[1]..".png")
end

-- Initalize the HUD element for the text when
-- hovering a shop or demo/building block
local hover_hud_ids = {}
minetest.register_on_joinplayer(function(player)
   local name = player:get_player_name()
   local n = player:hud_add({
      hud_elem_type = "text",
      position = {x = 0.05, y = 0.8},
      offset = {x = 0, y = 0},
      text = "",
      alignment = {x = 1, y = 0},
      scale = {x = 1, y = 1},
      number = 0xffffffff,
   })
   hover_hud_ids[name] = n
end)
minetest.register_on_leaveplayer(function(player)
   local name = player:get_player_name()
   hover_hud_ids[name] = nil
end)

--make it so when you look at a shop, it adds the name of the node it is selling to your hud
minetest.register_globalstep(function(dtime)
    for _,player in ipairs(minetest.get_connected_players()) do

        local pos = player:get_pos()
	local pname = player:get_player_name()
        pos.y = pos.y + player:get_properties().eye_height
        local look_dir = player:get_look_dir()
        look_dir = vector.multiply(look_dir, 6)--make distance bigger cuz wuzzy comaplained
        local pos2 = vector.add(pos, look_dir)
        local ray = minetest.raycast(pos, pos2, false, false)
        if not ray then return end
        for pointed_thing in ray do
            if pointed_thing.type == "node" then
                local node = minetest.get_node(pointed_thing.under)
                local node_pos = pointed_thing.under
                local node_name = node.name
                -- Hovering a shop
                if minetest.get_item_group(node_name, "shop") == 1 then
                    local shopdef = minetest.registered_nodes[node_name]
                    local selling = shopdef._bnb_selling
                    local iname = bnb_core.item_readable(selling)
                    if hover_hud_ids[pname] then
                        player:hud_change(hover_hud_ids[pname], "text", "Selling: "..iname)
                        player:hud_change(hover_hud_ids[pname], "number", 0xffe44b)
                    end
                    return
                -- Hovering a block in the building zone
                elseif node_pos.x >= bnb_core.building_min.x and node_pos.x <= bnb_core.building_max.x and node_pos.z >= bnb_core.building_min.z and node_pos.z <= bnb_core.building_max.z and node_pos.y >= bnb_core.building_min.y and node_pos.y <= bnb_core.building_max.y then
                    local iname = bnb_core.item_readable(node_name)
                    if hover_hud_ids[pname] then
                        player:hud_change(hover_hud_ids[pname], "text", "Building: "..iname)
                        player:hud_change(hover_hud_ids[pname], "number", 0xe6482e)
                    end
                    return
                -- Hovering a block in the demo zone
                elseif node_pos.x >= bnb_core.demo_min.x and node_pos.x <= bnb_core.demo_max.x and node_pos.z >= bnb_core.demo_min.z and node_pos.z <= bnb_core.demo_max.z and node_pos.y >= bnb_core.demo_min.y and node_pos.y <= bnb_core.demo_max.y then
                    local iname = bnb_core.item_readable(node_name)
                    if hover_hud_ids[pname] then
                        player:hud_change(hover_hud_ids[pname], "text", "Demo: "..iname)
                        player:hud_change(hover_hud_ids[pname], "number", 0x4162e8)
                    end
                    return
                -- Hovering none of the above
	        else
                    -- Remove hover text
                    if hover_hud_ids[pname] then
                        player:hud_change(hover_hud_ids[pname], "text", "")
		    end
	        end
            end
        end
    end
end)
