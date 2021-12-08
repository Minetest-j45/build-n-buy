--stick that sets pointed_thing to air, for development purposes
minetest.register_craftitem("bnb_nodes:stick", {
    description = "Stick",
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type == "node" then
            minetest.set_node(pointed_thing.under, {name="air"})
        end
    end
})

--logs
minetest.register_node(minetest.get_current_modname()..":oak_log", {
    description = "Oak Log",
    tiles = {"log_oak_top.png", "log_oak_top.png", "log_oak.png"},
})
minetest.register_node(minetest.get_current_modname()..":pine_log", {
    description = "Pine Log",
    tiles = {"log_pine_top.png", "log_pine_top.png", "log_pine.png"},
})
minetest.register_node(minetest.get_current_modname()..":beech_log", {
    description = "Beech Log",
    tiles = {"log_beech_top.png", "log_beech_top.png", "log_beech.png"},
})
minetest.register_node(minetest.get_current_modname()..":ash_log", {
    description = "Ash Log",
    tiles = {"log_ash_top.png", "log_ash_top.png", "log_ash.png"},
})
minetest.register_node(minetest.get_current_modname()..":teak_log", {
    description = "Teak Log",
    tiles = {"log_teak_top.png", "log_teak_top.png", "log_teak.png"},
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
        bnb_core.finished()
    end
})

--lantern
minetest.register_node(minetest.get_current_modname()..":light_block", {
    description = "Light Block",
    tiles = {"light.png"},
    --emmits light
    light_source = 14,
})


local function register_wool(name, desc)
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
        use_texture_alpha = true,
        tiles = {name .. "_wool.png^[opacity:210".. extra},
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

--[[minetest.register_node(minetest.get_current_modname()..":grey_stained_glass", {
    description = "Grey Stained Glass",
    drawtype = "glasslike",
    use_texture_alpha = true,
    --tiles = {"grey_glass.png^[colorize:#000F:100"},
    tiles = {"grey_wool.png^[opacity:210"},
    light_source = 1,
})]]


--[[minetest.register_node(minetest.get_current_modname()..":grey_stained_glass_slab", {
    description = "Grey Stained Glass",
    drawtype = "nodebox",
    use_texture_alpha = true,
    tiles = {"grey_glass.png^[colorize:#000F:100"},
    node_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
    },
    light_source = 1,
})]]

--signs

local register_sign = function(name, desc, tilez)
    minetest.register_node(minetest.get_current_modname()..":sign_"..name, {
        description = desc,
        tiles = tilez,
        light_source = 1,
    })
end

register_sign("magenta_w", "Magenta W Sign", {"magenta_wool.png", "magenta_wool.png", "magenta_wool.png^font_w.png"})
register_sign("orange_o", "Orange O Sign", {"orange_wool.png", "orange_wool.png", "orange_wool.png^font_o.png"})
register_sign("cyan_o", "Cyan O Sign", {"cyan_wool.png", "cyan_wool.png", "cyan_wool.png^font_o.png"})
register_sign("green_l", "Green L Sign", {"green_wool.png", "green_wool.png", "green_wool.png^font_l.png"})

register_sign("pine_w", "Pine W Sign", {"log_pine_top.png", "log_pine_top.png", "log_pine.png^font_w.png"})
register_sign("oak_o", "Oak O Sign", {"log_oak_top.png", "log_oak_top.png", "log_oak.png^font_o.png"})
register_sign("beech_o", "Beech O Sign", {"log_beech_top.png", "log_beech_top.png", "log_beech.png^font_o.png"})
register_sign("teak_d", "Teak D Sign", {"log_teak_top.png", "log_teak_top.png", "log_teak.png^font_d.png"})

register_sign("pink_g", "Pink G Sign", {"pink_wool.png", "pink_wool.png", "pink_wool.png^font_g.png"})
register_sign("brown_l", "Brown L Sign", {"brown_wool.png", "brown_wool.png", "brown_wool.png^font_l.png"})
register_sign("red_a", "Red A Sign", {"red_wool.png", "red_wool.png", "red_wool.png^font_a.png"})
register_sign("magenta_s", "Magenta S Sign", {"magenta_wool.png", "magenta_wool.png", "magenta_wool.png^font_s.png"})
register_sign("violet_s", "Violet S Sign", {"violet_wool.png", "violet_wool.png", "violet_wool.png^font_s.png"})

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
        --on point, show name of block hud
    })
end

--[[register_shop("red_wool", "Red Wool Shop", "red_wool.png")
register_shop("blue_wool", "Blue Wool Shop", "blue_wool.png")
register_shop("grey_wool", "Grey Wool Shop", "grey_wool.png")
register_shop("black_wool", "Black Wool Shop", "black_wool.png")
register_shop("brown_wool", "Brown Wool Shop", "brown_wool.png")
register_shop("cyan_wool", "Cyan Wool Shop", "cyan_wool.png")
register_shop("dark_green_wool", "Dark Green Wool Shop", "dark_green_wool.png")
register_shop("green_wool", "Green Wool Shop", "green_wool.png")
register_shop("light_grey_wool", "Light Grey Wool Shop", "light_grey_wool.png")
register_shop("magenta_wool", "Magenta Wool Shop", "magenta_wool.png")
register_shop("orange_wool", "Orange Wool Shop", "orange_wool.png")
register_shop("pink_wool", "Pink Wool Shop", "pink_wool.png")
register_shop("violet_wool", "Violet Wool Shop", "violet_wool.png")
register_shop("white_wool", "White Wool Shop", "white_wool.png")
register_shop("yellow_wool", "Yellow Wool Shop", "yellow_wool.png")]]

for _, wool in ipairs(wools) do
    --normal wools
    register_wool(wool[1], wool[2])
    --glasses
    if not wool[3] then
       wool[3] = ""
    end
    register_glass(wool[1], wool[2], wool[3])
    --normal shops
    register_shop(wool[1].."_wool", wool[2].."Wool Shop", wool[1].."_wool.png")
    --glass shops
    register_shop(wool[1].."_stained_glass", wool[2].." Stained Glass Shop", wool[1].."_wool.png", "\\^[opacity\\:210")
end

register_shop("oak_log", "Oak Log Shop", "log_oak.png")
register_shop("pine_log", "Pine Log Shop", "log_pine.png")
register_shop("beech_log", "Beech Log Shop", "log_beech.png")
register_shop("ash_log", "Ash Log Shop", "log_ash.png")
register_shop("teak_log", "Teak Log Shop", "log_teak.png")

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
                        number = 0xFF0000,
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