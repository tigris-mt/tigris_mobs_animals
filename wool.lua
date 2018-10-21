-- Expects mod node <name>_shorn.
-- Expects produce_wool_time in data as seconds.
-- Place grow_wool as idle action.
-- Enable shear_wool as interaction.

tigris.mobs.register_action("grow_wool", {
    func = function(self, context)
        if not self._data.shorn then
            return
        end
        local leat = self._data.eaten or 0
        local lshear = self._data.last_shorn or 0
        if leat < lshear then
            return
        end
        if minetest.get_gametime() - lshear >= self._data.produce_wool_time then
            self.textures = {self.def.name}
            self._data.shorn = false
        end
    end,
})

tigris.mobs.register_interaction("shear_wool", {
    func = function(self, context)
        local stack = context.other:get_wielded_item()
        if not self._data.tame or stack:get_name() ~= "mobs:shears" or self._data.shorn or tigris.mobs.is_protected(self.object, context.other:get_player_name()) then
            return
        end

        self._data.shorn = true
        self._data.last_shorn = minetest.get_gametime()
        self.textures = {self.def.name .. "_shorn"}

        local obj = minetest.add_item(self.object:getpos(), ItemStack("wool:" .. self.def.color .. " " .. math.random(1, self._data.wool_max or 3)))
        if obj then
            obj:setvelocity(vector.new(math.random() * 2 - 1, math.random() * 4 - 2, math.random() * 2 - 1))
        end

        stack:add_wear(655)
        context.other:set_wielded_item(stack)

        return true
    end,
})

-- MIT TenPlus1 mobs_redo - Shears
minetest.register_tool(":mobs:shears", {
    description = "Steel Shears",
    inventory_image = "mobs_shears.png",
})

minetest.register_craft{
    output = "mobs:shears",
    recipe = {
        {"default:steel_ingot", ""},
        {"group:stick", "default:steel_ingot"},
    },
}
