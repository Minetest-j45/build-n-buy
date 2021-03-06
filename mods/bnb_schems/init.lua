bnb_schems = {}
bnb_schems.modname = minetest.get_current_modname()

bnb_schems.place = function(pos, schemname, rot, replace, force_place)
    minetest.place_schematic(pos, minetest.get_modpath(bnb_schems.modname).."/schems/"..schemname..".mts", rot, replace, force_place)
end

bnb_schems.demos = {
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
    "stash"
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
            minetest.chat_send_all(minetest.colorize("#71aa34", "You now have to build a "..demo.."!"))
        end
    end)
end