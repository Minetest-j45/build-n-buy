--stick that sets pointed_thing to air, for development purposes
minetest.register_craftitem("bnb_nodes:stick", {
    description = "Stick",
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type == "node" then
            minetest.set_node(pointed_thing.under, {name="air"})
        end
    end
})

--quartz
minetest.register_node(minetest.get_current_modname()..":quartz_block", {
    description = "Quartz Block",
    tiles = {"quartz_block.png"},
    groups = {choppy = 2, oddly_breakable_by_hand = 2,},
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
        local complete = bnb_core.finished()
        bnb_core.complete(complete, player)
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

minetest.register_node(minetest.get_current_modname()..":stone_block", {
    description = "Stone Block",
    tiles = {"stone.png"},
})

--funcs
local register_ore = function (name, desc)
    minetest.register_node(minetest.get_current_modname()..":"..name.."_ore", {
        description = desc.." Ore",
        tiles = {"stone.png^"..name.."_ore.png"},
    })
end--coal copper dia gold iron mese tin

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
        tiles = {name .. "_wool.png^[opacity:210".. extra},
        light_source = 1,
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

--shops
local register_shop = function(item, desc, overlay, extra)
    if not extra then
        extra = ""
    end
    minetest.register_node(minetest.get_current_modname()..":shop_"..item, {
        description = desc,
        --tiles = {"[combine:32x32:0,0=(blue_wool.png^shopping_cart.png):11,13=red_wool.png\\^[resize\\:10x10"},
        tiles = {"blue_wool.png", "blue_wool.png", "[combine:128x128:0,0=(blue_wool.png^shopping_cart.png\\^[resize\\:128x128):48,56="..overlay.."\\^[resize\\:32x32"..extra},
        groups = {shop = 1},
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
    register_shop(wool[1].."_stained_glass", wool[2].." Stained Glass Shop", wool[1].."_wool.png", "\\^[opacity\\:210")
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
end
--make it so when you look at a shop, it adds the name of the node it is selling to your hud
minetest.register_globalstep(function(dtime)
    for _,player in ipairs(minetest.get_connected_players()) do

        local pos = player:get_pos()
        pos.y = pos.y + player:get_properties().eye_height
        local look_dir = player:get_look_dir()
        look_dir = vector.multiply(look_dir, 4)
        local pos2 = vector.add(pos, look_dir)
        local ray = minetest.raycast(pos, pos2, false, false)
        if not ray then return end
        for pointed_thing in ray do
            if pointed_thing.type == "node" then
                local node = minetest.get_node(pointed_thing.under)
                if node.name:find("bnb_nodes:shop_") then
                    local name = node.name:gsub("bnb_nodes:shop_", ""):gsub("_", " ")
                    local n = player:hud_add({
                        hud_elem_type = "text",
                        position = {x = 0.1, y = 0.8},
                        offset = {x = 0, y = 0},
                        text = "Selling: "..name,
                        alignment = {x = 0, y = 0},
                        scale = {x = 1, y = 1},
                        number = 0xe6482e,
                    })
                    --remove hud after 1 second
                    minetest.after(0.1, function()
                        player:hud_remove(n)
                    end)
                end
            end
        end
    end
end)