-- Expects produce_milk_time in data as seconds.
-- Place produce_milk as idle action.
-- Enable get_milk as interaction.

tigris.mobs.register_action("produce_milk", {
    func = function(self, context)
        if not self._data.milk_dry then
            return
        end
        local leat = self._data.eaten or 0
        local lmilk = self._data.last_milk or 0
        if leat < lmilk then
            return
        end
        if minetest.get_gametime() - lshear >= self._data.produce_milk_time then
            self._data.milk_dry = false
        end
    end,
})

tigris.mobs.register_interaction("get_milk", {
    func = function(self, context)
        local stack = context.other:get_wielded_item()
        if not self._data.tame or stack:get_name() ~= "bucket:bucket_empty" or self._data.dry or tigris.mobs.is_protected(self.object, context.other:get_player_name()) then
            return
        end

        self._data.dry = true
        self._data.last_milk = minetest.get_gametime()

        stack:take_item()
        context.other:set_wielded_item(stack)

        minetest.add_item(self.object:getpos(), context.other:get_inventory():add_item("main", ItemStack("mobs:bucket_milk")))
    end,
})

-- Milk and products taken from MIT-licensed mobs_animal/mobs_redo by TenPlus1.
minetest.register_craftitem(":mobs:bucket_milk", {
    description = "Bucket of Milk",
    inventory_image = "mobs_bucket_milk.png",
    stack_max = 1,
    on_use = minetest.item_eat(8, "bucket:bucket_empty"),
    groups = {food_milk = 1, flammable = 3},
})

minetest.register_craftitem(":mobs:butter", {
    description = "Butter",
    inventory_image = "mobs_butter.png",
    on_use = minetest.item_eat(1),
    groups = {food_butter = 1, flammable = 2},
})

if minetest.get_modpath("farming") and farming and farming.mod then
    minetest.register_craft({
        type = "shapeless",
        output = "mobs:butter",
        recipe = {"mobs:bucket_milk", "farming:salt"},
        replacements = {{"mobs:bucket_milk", "bucket:bucket_empty"}}
    })
else
    minetest.register_craft({
        type = "shapeless",
        output = "mobs:butter",
        recipe = {"mobs:bucket_milk", "group:sapling"},
        replacements = {{"mobs:bucket_milk", "bucket:bucket_empty"}}
    })
end

minetest.register_craftitem(":mobs:cheese", {
    description = "Cheese",
    inventory_image = "mobs_cheese.png",
    on_use = minetest.item_eat(4),
    groups = {food_cheese = 1, flammable = 2},
})

minetest.register_craft({
    type = "cooking",
    output = "mobs:cheese",
    recipe = "mobs:bucket_milk",
    cooktime = 5,
    replacements = {{ "mobs:bucket_milk", "bucket:bucket_empty"}}
})

minetest.register_node(":mobs:cheeseblock", {
    description = "Cheese Block",
    tiles = {"mobs_cheeseblock.png"},
    is_ground_content = false,
    groups = {crumbly = 3},
    sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
    output = "mobs:cheeseblock",
    recipe = {
        {"mobs:cheese", "mobs:cheese", "mobs:cheese"},
        {"mobs:cheese", "mobs:cheese", "mobs:cheese"},
        {"mobs:cheese", "mobs:cheese", "mobs:cheese"},
    }
})

minetest.register_craft({
    output = "mobs:cheese 9",
    recipe = {
        {"mobs:cheeseblock"},
    }
})
