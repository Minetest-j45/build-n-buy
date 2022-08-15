minetest.after(1, function()
bnb_schems.analyze = function(demoname)
    local schem = minetest.read_schematic(minetest.get_modpath(bnb_schems.modname).."/schems/demo_"..demoname..".mts", {})
    if schem then
       minetest.chat_send_all(demoname..": "..minetest.pos_to_string(schem.size))
       local nodes = 0
       for d=1, #schem.data do
	       local dat = schem.data[d]
	       if dat.name ~= "air" and dat.prob > 1 then
		       nodes = nodes + 1
	       end
       end
       minetest.chat_send_all(demoname..": "..nodes.." node(s)")
    else
       minetest.chat_send_all(demoname..": ERROR")
    end
end

       minetest.chat_send_all(#bnb_schems.demos)
for d=1, #bnb_schems.demos do
   local demoname = bnb_schems.demos[d]
   bnb_schems.analyze(demoname)
end
end)
