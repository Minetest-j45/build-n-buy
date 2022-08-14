bnb_schems = {}
bnb_schems.modname = minetest.get_current_modname()

bnb_schems.place = function(pos, schemname, rot, replace, force_place)
    minetest.place_schematic(pos, minetest.get_modpath(bnb_schems.modname).."/schems/"..schemname..".mts", rot, replace, force_place)
end

bnb_schems.demos = {
    -- originals
    "tree",
    "camp",
    "lilly",
    "fire",
    "pokeball",
    "yinyang",
    "cave",
    "present",
    "bed",
    "cactus",
    "heart",
    "minion",
    "flower",
    "moon",
    "clash",
    "stash",
    -- by Wuzzy
    "castle",
    "cloud",
    "clearing",
    "containment",
    "furnace",
    "lava_crater",
    "mese_shrine",
    "orange",
    "portal",
    "ritual",
    "sign",
    "wasteland",
    "well",
    "ruin",
    "sewer",
    "lab_leak",
    "staircase",
    "beach",
    "bling_bling",
    "bling_floor",
    "coal_vein",
    "cursed_lava",
    "cursed_sand",
    "desert_statue",
    "dirt_hut",
    "wood_hut",
    "lava_flow",
    "mese_monument",
    "mese_vein",
    "M",
    "oasis",
    "snowland",
    "spring",
    "stone_circle",
    "traffic_lights",
    "water_pipe",
    "sheep",
    "snowmelt",
    "drizzle",
    "rain",
    "puddle",
    "mosaic_window",
    "collapsed_cave",
    "island",
    "crystal",
    "bridge",
    "dense_forest",
    "diamond",
    "I-beam",
    "mini_temple",
    "street",
    "turkey",
    "copper_shrine",
    "diamond_drill",
    "empty_pipe",
    "lava_lake",
    "sawmill",
    "tin_statue",
    "turtle",
}

bnb_schems.last_last_demo = ""
bnb_schems.last_demo = ""
bnb_schems.random_demo = function()
    local random = math.random(1, #bnb_schems.demos)
    local demo = bnb_schems.demos[random]
    if demo == bnb_schems.last_demo or demo == bnb_schems.last_last_demo then
        return bnb_schems.random_demo()
    else
        bnb_schems.last_last_demo = bnb_schems.last_demo
        bnb_schems.last_demo = demo
        return demo
    end
end

bnb_schems.place_demo = function(minpos, maxpos)
    local demo = bnb_schems.random_demo()
    minetest.emerge_area(minpos, maxpos, function(blockpos, action, remaining)
        if remaining == 0 then
            bnb_schems.place(minpos, "demo_"..demo, 0, nil, true)
            -- replace underscores with spaces for chat msg
            local print_name = string.gsub(demo, "_", " ")
            minetest.chat_send_all(minetest.colorize("#71aa34", "You now have to build a "..print_name.."!"))
        end
    end)
end
