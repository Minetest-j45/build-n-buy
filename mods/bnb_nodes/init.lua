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
        description = desc,
        tiles = {name .. "_wool.png"},
        light_source = 1,
    })
end

local wools = {
    {"red", "Red Wool"},
    {"blue", "Blue Wool"},
    {"grey", "Grey Wool"},
    {"black", "Black Wool"},
    {"brown", "Brown Wool"},
    {"cyan", "Cyan Wool"},
    {"dark_green", "Dark Green Wool"},
    {"green", "Green Wool"},
    {"light_grey", "Light Grey Wool"},
    {"magenta", "Magenta Wool"},
    {"orange", "Orange Wool"},
    {"pink", "Pink Wool"},
    {"violet", "Violet Wool"},
    {"white", "White Wool"},
    {"yellow", "Yellow Wool"},
}

for _, conc in ipairs(wools) do
    register_wool(conc[1], conc[2])
end

minetest.register_node(minetest.get_current_modname()..":grey_stained_glass", {
    description = "Grey Stained Glass",
    drawtype = "glasslike",
    use_texture_alpha = true,
    tiles = {"grey_glass.png^[colorize:#000F:100"},
    light_source = 1,
})

minetest.register_node(minetest.get_current_modname()..":grey_stained_glass_slab", {
    description = "Grey Stained Glass",
    drawtype = "nodebox",
    use_texture_alpha = true,
    tiles = {"grey_glass.png^[colorize:#000F:100"},
    node_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
    },
    light_source = 1,
})

--signs

local register_sign = function(name, desc, tile)
    minetest.register_node(minetest.get_current_modname()..":sign_"..name, {
        description = desc,
        tiles = {tile},
        light_source = 1,
    })
end

register_sign("magenta_w", "Magenta W Sign", "magenta_wool.png^font_w.png")
register_sign("orange_o", "Orange O Sign", "orange_wool.png^font_o.png")
register_sign("cyan_o", "Cyan O Sign", "cyan_wool.png^font_o.png")
register_sign("green_l", "Green L Sign", "green_wool.png^font_l.png")