--quartz
minetest.register_node(minetest.get_current_modname()..":quartz_block", {
    description = "Quartz Block",
    tiles = {"quartz_block.png"},
})

minetest.register_node(minetest.get_current_modname()..":quartz_slab", {
    description = "Quartz Slab",
    drawtype = "nodebox",
    tiles = {"quartz_block.png"},
    node_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
    },
})

minetest.register_node(minetest.get_current_modname()..":quartz_slab1", {
    description = "Quartz Slab",
    drawtype = "nodebox",
    tiles = {"quartz_block.png"},
    node_box = {
        type = "fixed",
        fixed = {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
    },
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
})

minetest.register_node(minetest.get_current_modname()..":quartz_welcome", {
    description = "Quartz Welcome",
    tiles = {"quartz_block.png^welcome_text.png"},
})

minetest.register_node(minetest.get_current_modname()..":quartz_play", {
    description = "Quartz Play",
    tiles = {"quartz_block.png^play_text.png"},
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        bnb_core.start(player)
    end
})

minetest.register_node(minetest.get_current_modname()..":quartz_shop", {
    description = "Quartz Shop",
    tiles = {"quartz_block.png^shop_text.png"},
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        bnb_core.tp_shop(player)
    end
})

minetest.register_node(minetest.get_current_modname()..":quartz_finished", {
    description = "Quartz Finished",
    tiles = {"quartz_block.png^finished_text.png"},
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        --local complete = bnb_core.finished()
        --bnb_core.complete(complete, player)
        bnb_core.finished(player)
    end
})

minetest.register_node(minetest.get_current_modname()..":quartz_build", {
    description = "Quartz Build",
    tiles = {"quartz_block.png^build_text.png"},
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        bnb_core.tp_build(player)
    end
})

--lantern
minetest.register_node(minetest.get_current_modname()..":light_block", {
    description = "Light Block",
    tiles = {"light.png"},
    light_source = 14,
})

--funcs
local register_ore = function(name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name.."_ore", {
        description = desc.." Ore",
        tiles = {"stone.png^"..name.."_ore.png"},
    })
end

local register_stone = function(name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name, {
        description = desc.." Stone",
        tiles = {name..".png"},
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
    })
end

local register_dirt = function(name, desc, texture)
    minetest.register_node(minetest.get_current_modname()..":"..name, {
        description = desc,
        tiles = texture,
    })
end

local register_sand = function(name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name, {
        description = desc,
        tiles = {name..".png"},
    })
end

local register_block = function(name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name.."_block", {
        description = desc,
        tiles = {name.."_block.png"},
    })
end

local register_wool = function(name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name .. "_wool", {
        description = desc.." Wool",
        tiles = {name .. "_wool.png"},
        light_source = 1,
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
    })
end

--logs
local register_log = function(name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name.."_log", {
        description = desc.." Log",
        tiles = {"log_"..name.."_top.png", "log_"..name.."_top.png", "log_"..name..".png"}
    })
end
local register_plank = function (name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name.."_plank", {
        description = desc.." Plank",
        tiles = {name.."_plank.png"}
    })
end

--signs

local register_sign = function(name, desc, tilez)
    minetest.register_node(minetest.get_current_modname()..":sign_"..name, {
        description = desc,
        tiles = tilez,
        light_source = 1,
    })
end

--wool signs
register_sign("magenta_w", "Magenta W Sign", {"magenta_wool.png", "magenta_wool.png", "magenta_wool.png^font_w.png"})
register_sign("orange_o", "Orange O Sign", {"orange_wool.png", "orange_wool.png", "orange_wool.png^font_o.png"})
register_sign("cyan_o", "Cyan O Sign", {"cyan_wool.png", "cyan_wool.png", "cyan_wool.png^font_o.png"})
register_sign("green_l", "Green L Sign", {"green_wool.png", "green_wool.png", "green_wool.png^font_l.png"})

--log signs
register_sign("pine_w", "Pine W Sign", {"log_pine_top.png", "log_pine_top.png", "log_pine.png^font_w.png"})
register_sign("oak_o", "Oak O Sign", {"log_oak_top.png", "log_oak_top.png", "log_oak.png^font_o.png"})
register_sign("beech_o", "Beech O Sign", {"log_beech_top.png", "log_beech_top.png", "log_beech.png^font_o.png"})
register_sign("teak_d", "Teak D Sign", {"log_teak_top.png", "log_teak_top.png", "log_teak.png^font_d.png"})

--signs for planks
register_sign("pine_plank_p", "Pine Plank P Sign", {"pine_plank.png", "pine_plank.png", "pine_plank.png^font_p.png"})
register_sign("oak_plank_l", "Oak Plank L Sign", {"oak_plank.png", "oak_plank.png", "oak_plank.png^font_l.png"})
register_sign("beech_plank_a", "Beech Plank A Sign", {"beech_plank.png", "beech_plank.png", "beech_plank.png^font_a.png"})
register_sign("teak_plank_n", "Teak Plank N Sign", {"teak_plank.png", "teak_plank.png", "teak_plank.png^font_n.png"})
register_sign("ash_plank_k", "Ash Plank K Sign", {"ash_plank.png", "ash_plank.png", "ash_plank.png^font_k.png"})
register_sign("pine_plank_s", "Pine Plank S Sign", {"pine_plank.png", "pine_plank.png", "pine_plank.png^font_s.png"})

--wool signs
register_sign("pink_g", "Pink G Sign", {"pink_wool.png", "pink_wool.png", "pink_wool.png^font_g.png"})
register_sign("brown_l", "Brown L Sign", {"brown_wool.png", "brown_wool.png", "brown_wool.png^font_l.png"})
register_sign("red_a", "Red A Sign", {"red_wool.png", "red_wool.png", "red_wool.png^font_a.png"})
register_sign("magenta_s", "Magenta S Sign", {"magenta_wool.png", "magenta_wool.png", "magenta_wool.png^font_s.png"})
register_sign("violet_s", "Violet S Sign", {"violet_wool.png", "violet_wool.png", "violet_wool.png^font_s.png"})

--ore signs
register_sign("coal_o", "Coal O Sign", {"stone.png^coal_ore.png", "stone.png^coal_ore.png", "stone.png^coal_ore.png^font_o.png"})
register_sign("copper_r", "Copper R Sign", {"stone.png^copper_ore.png", "stone.png^copper_ore.png", "stone.png^copper_ore.png^font_r.png"})
register_sign("mese_e", "Mese E Sign", {"stone.png^mese_ore.png", "stone.png^mese_ore.png", "stone.png^mese_ore.png^font_e.png"})
register_sign("diamond_s", "Diamond S Sign", {"stone.png^diamond_ore.png", "stone.png^diamond_ore.png", "stone.png^diamond_ore.png^font_s.png"})

--blocks signs
register_sign("coal_b", "Coal B Sign", {"coal_block.png", "coal_block.png", "coal_block.png^font_b.png"})
register_sign("copper_l", "Copper L Sign", {"copper_block.png", "copper_block.png", "copper_block.png^font_l.png"})
register_sign("mese_o", "Mese O Sign", {"mese_block.png", "mese_block.png", "mese_block.png^font_o.png"})
register_sign("diamond_c", "Diamond C Sign", {"diamond_block.png", "diamond_block.png", "diamond_block.png^font_c.png"})
register_sign("gold_k", "Gold K Sign", {"gold_block.png", "gold_block.png", "gold_block.png^font_k.png"})
register_sign("iron_s", "Iron S Sign", {"iron_block.png", "iron_block.png", "iron_block.png^font_s.png"})

--stones signs
register_sign("stone_s", "Stone S Sign", {"stone.png", "stone.png", "stone.png^font_s.png"})
register_sign("polished_stone_t", "Polished Stone T Sign", {"polished_stone.png", "polished_stone.png", "polished_stone.png^font_t.png"})
register_sign("brick_stone_o", "Brick Stone O Sign", {"brick_stone.png", "brick_stone.png", "brick_stone.png^font_o.png"})
register_sign("desert_stone_n", "Desert Stone N Sign", {"desert_stone.png", "desert_stone.png", "desert_stone.png^font_n.png"})
register_sign("polished_desert_stone_e", "Polished Desert Stone E Sign", {"polished_desert_stone.png", "polished_desert_stone.png", "polished_desert_stone.png^font_e.png"})
register_sign("desert_brick_stone_s", "Desert Brick Stone S Sign", {"desert_brick_stone.png", "desert_brick_stone.png", "desert_brick_stone.png^font_s.png"})

--liquids signs
register_sign("water_f", "Water F Sign", {"water.png", "water.png", "water.png^font_f.png"})
register_sign("lava_l", "Lava L Sign", {"lava.png", "lava.png", "lava.png^font_l.png"})
register_sign("river_water_u", "River Water U Sign", {"river_water.png", "river_water.png", "river_water.png^font_u.png"})
register_sign("lava_i", "Lava I Sign", {"lava.png", "lava.png", "lava.png^font_i.png"})
register_sign("water_d", "Water D Sign", {"water.png", "water.png", "water.png^font_d.png"})
register_sign("river_water_s", "River Water S Sign", {"river_water.png", "river_water.png", "river_water.png^font_s.png"})

--dirts signs
register_sign("dirt_d", "Dirt D Sign", {"dirt.png", "dirt.png", "dirt.png^font_d.png"})
register_sign("dirt_with_grass_i", "Dirt With Grass I Sign", {"grass.png", "dirt.png", "dirt.png^grass_side.png^font_i.png"})
register_sign("dirt_with_snow_r", "Dirt With Snow R Sign", {"snow.png", "dirt.png", "dirt.png^snow_side.png^font_r.png"})
register_sign("dry_dirt_with_dry_grass_t", "Dry Dirt With Dry Grass T Sign", {"dry_grass.png", "dry_dirt.png", "dry_dirt.png^dry_grass_side.png^font_t.png"})
register_sign("dry_dirt_s", "Dry Dirt S Sign", {"dry_dirt.png", "dry_dirt.png", "dry_dirt.png^font_s.png"})

--sand signs
register_sign("sand_s", "Sand S Sign", {"sand.png", "sand.png", "sand.png^font_s.png"})
register_sign("silver_sand_a", "Silver Sand A Sign", {"silver_sand.png", "silver_sand.png", "silver_sand.png^font_a.png"})
register_sign("sand_n", "Sand N Sign", {"sand.png", "sand.png", "sand.png^font_n.png"})
register_sign("silver_sand_d", "Silver Sand D Sign", {"silver_sand.png", "silver_sand.png", "silver_sand.png^font_d.png"})

--shops
local register_shop = function(item, desc, overlay, extra)
    if not extra then
        extra = ""
    end
    minetest.register_node(minetest.get_current_modname()..":shop_"..item, {
        description = desc,
        tiles = {"blue_wool.png", "blue_wool.png", "[combine:128x128:0,0=(blue_wool.png^shopping_cart.png\\^[resize\\:128x128):48,56="..overlay.."\\^[resize\\:32x32"..extra},
        light_source = 1,
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

--make it so when you look at a shop, it adds the name of the node it is selling to your hud
local name
minetest.register_globalstep(function(dtime)
    for _,player in ipairs(minetest.get_connected_players()) do

        local pos = player:get_pos()
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
                if node_name:find("bnb_nodes:shop_") then
                    name = node_name:gsub("bnb_nodes:shop_", ""):gsub("_", " ")
                    local n = player:hud_add({
                        hud_elem_type = "text",
                        position = {x = 0.1, y = 0.8},
                        offset = {x = 0, y = 0},
                        text = "Selling: "..name,
                        alignment = {x = 0, y = 0},
                        scale = {x = 1, y = 1},
                        number = 0xe6482e,
                    })
                    minetest.after(0.1, function()
                        player:hud_remove(n)
                    end)
                    return
                elseif node_pos.x >= bnb_core.building_min.x and node_pos.x <= bnb_core.building_max.x and node_pos.z >= bnb_core.building_min.z and node_pos.z <= bnb_core.building_max.z and node_pos.y >= bnb_core.building_min.y and node_pos.y <= bnb_core.building_max.y then
                    name = node_name:gsub("bnb_nodes:", ""):gsub("_", " ")
                    local n = player:hud_add({
                        hud_elem_type = "text",
                        position = {x = 0.1, y = 0.8},
                        offset = {x = 0, y = 0},
                        text = "Building: "..name,
                        alignment = {x = 0, y = 0},
                        scale = {x = 1, y = 1},
                        number = 0xe6482e,
                    })
                    minetest.after(0.1, function()
                        player:hud_remove(n)
                    end)
                    return
                elseif node_pos.x >= bnb_core.demo_min.x and node_pos.x <= bnb_core.demo_max.x and node_pos.z >= bnb_core.demo_min.z and node_pos.z <= bnb_core.demo_max.z and node_pos.y >= bnb_core.demo_min.y and node_pos.y <= bnb_core.demo_max.y then
                    name = node_name:gsub("bnb_nodes:", ""):gsub("_", " ")
                    local n = player:hud_add({
                        hud_elem_type = "text",
                        position = {x = 0.1, y = 0.8},
                        offset = {x = 0, y = 0},
                        text = "Demo: "..name,
                        alignment = {x = 0, y = 0},
                        scale = {x = 1, y = 1},
                        number = 0xe6482e,
                    })
                    minetest.after(0.1, function()
                        player:hud_remove(n)
                    end)
                    return
                end
            end
        end
    end
end)
