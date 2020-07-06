local inspect = require("inspect")
local modpath = minetest.get_modpath("graphviz")

dofile(modpath .. "/graphviz.lua")

local graph = GraphVizNew()



minetest.register_on_joinplayer(function(player)
  local player_inventory = player:get_inventory()  
  player_inventory:add_item("main", "graphviz:node" .. " 1")
end)

function parse_input(input_data) 
  if input_data == nil then
    return
  end
  local args = {}
  
  for w in string.gmatch(input_data, "[^%s]+") do
    table.insert(args, w)
  end


  if (#args >= 1) then
    from_pos = graph:register_node(args[1]) 
  end
  if (#args >= 2) then
    to_pos = graph:register_node(args[2]) 
  end
  if (#args >= 3) then
    node = minetest.get_node(from_pos) 
    local obj = minetest.add_entity(from_pos, "graphviz:item")
    obj:set_properties({
      infotext = args[2]
    })
    obj:set_acceleration(vector.direction(from_pos, to_pos))
  end

end

minetest.register_chatcommand("input", {
  params = "<text>",
  description = "Send text to chat",
  func = function( _ , text)
    parse_input(text) 
    return true, nil
  end,
})



minetest.register_node("graphviz:node", {
  tiles = { "graphviz_node.png" },
  on_punch = function(pos, node, player, pointed_thing) 
    local nodeMetaRef = minetest.get_meta(pos) 

    minetest.log("action", inspect(nodeMetaRef:to_table()))

    if (nodeMetaRef["fields"] ~= nil) then
      return true
    end

    minetest.chat_send_player(player:get_player_name(), "initialized")

    local r = nodeMetaRef:from_table({
      fields = {
        aaa = "aaa",
      } 
    })

    if (r ~= true) then
      minetest.log("error", "graphiz:node:on_punch nodeMetaRef:from_table({}) fail")
    end

    return r
  end,
}) 

minetest.register_entity("graphviz:item", {
    hp_max = 1,
    drawtype = "front",
    physical = false,
    weight = 5,
    --collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
    visual = "cube",
    visual_size = {x=1, y=1},
    textures = { "graphviz_packet.png",  "graphviz_packet.png", "graphviz_packet.png", "graphviz_packet.png", "graphviz_packet.png", "graphviz_packet.png"}, -- number of required textures depends on visual
    on_step = function (self, dtime)
      local node = minetest.get_node(self.object:get_pos())
      local properties = self.object:get_properties() 
      if (node ~= nil) then
        local nodeMetaDataRef = minetest.get_meta(self.object:get_pos()):to_table()    
        if (nodeMetaDataRef and nodeMetaDataRef["fields"] and nodeMetaDataRef["fields"]["name"] == properties["infotext"] ) then
          self.object:remove()
          minetest.log("remove obj")
        end 
        --minetest.log(inspect(nodeMetaDataRef:to_table()))
      
      end
    end,
    spritediv = {x=1, y=1},
    initial_sprite_basepos = {x=0, y=0},
    is_visible = true,
    makes_footstep_sound = false,
    automatic_rotate = false,
})

minetest.register_node("graphviz:graph", {
  tiles = { "graphviz_node.png" },
})

input_data = io.open("/tmp/minetest_input") 
if (input_data == nil) then
  print("io.open fails")
end

minetest.register_globalstep(function()
    local data = input_data:read()
    if (data ~= nil) then
      print("input data " .. data)
      parse_input(data)
    end
  end)


