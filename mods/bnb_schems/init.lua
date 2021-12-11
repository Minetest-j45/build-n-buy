bnb_schems = {}

bnb_schems.modname = minetest.get_current_modname()
bnb_schems.place = function(pos, schemname, rot, replace, force_place)
    minetest.place_schematic(pos, minetest.get_modpath(bnb_schems.modname).."/schems/"..schemname..".mts", rot, replace, force_place)
end