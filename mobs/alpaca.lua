local function textures(color, shorn)
    local s = shorn and "^tigris_mobs_shorn.png" or ""
    return {
        "wool_" .. color .. ".png" .. s,
        "wool_" .. color .. ".png" .. s,
        "wool_" .. color .. ".png" .. s,
        "wool_" .. color .. ".png" .. s,
        "wool_" .. color .. ".png" .. s,
        "wool_" .. color .. ".png^tigris_mobs_alpaca_face.png",
    }
end

local colors = {"red", "blue", "yellow", "green", "orange", "violet", "pink", "cyan", "magenta", "dark_green"}
local alpacas = {}
for _,color in ipairs(colors) do
    local name = "tigris_mobs:alpaca_" .. color
    table.insert(alpacas, name)
    tigris.mobs.register(":" .. name, {
        description = "Alpaca",
        collision = {-0.4, -0.4, -0.4, 0.4, 0.4, 0.4},
        box = {
            {-0.25, 0, -0.5, 0.25, 0.6, 0.5},
            {-0.25, -0.5, -0.5, -0.1, 0, -0.35},
            {0.1, -0.5, -0.5, 0.25, 0, -0.35},
            {-0.25, -0.5, 0.35, -0.1, 0, 0.5},
            {0.1, -0.5, 0.35, 0.25, 0, 0.5},
            {-0.25, 0, -0.5, 0.25, 0.5, -1},
            {-0.1, 0.4, 0.5, 0.1, 0.5, 0.75},
        },
        textures = textures(color, false),

        group = "peaceful",
        level = 1,

        drops = {
            {100, "mobs:meat_raw"},
            {50, "mobs:meat_raw"},
            {25, "mobs:meat_raw"},
            {100, "tigris_mobs:bone"},
            {25, "tigris_mobs:eye"},
            {15, "tigris_mobs:eye"},
            {75, "wool:" .. color},
        },

        food_nodes = {
            "group:grass",
            "group:flora",
        },

        food_items = {
            "farming:wheat",
            "farming:seed_wheat",
        },

        habitat_nodes = {"group:soil"},
        breedable = alpacas,

        color = color,

        on_init = function(self, data)
            self.hp_max = 4
            data.jump = 5
            data.wool_max = 5
            data.produce_wool_time = 60 * 8
            data.produce_milk_time = 60 * 35
        end,

        start = "wander",

        script = tigris.mobs.common.peaceful({
            eat = true,
            breed = true,
        }, function(s)
            s.global.interactions.shear_wool = true
            s.flee.interactions.shear_wool = false
            table.insert(s.wander.actions, "grow_wool")
            table.insert(s.standing.actions, "grow_wool")

            s.global.interactions.get_milk = true
            s.flee.interactions.get_milk = false
            table.insert(s.wander.actions, "produce_milk")
            table.insert(s.standing.actions, "produce_milk")
        end),
    })

    tigris.mobs.register_mob_node(":" .. name .. "_shorn", name, {
        tiles = textures(color, true),
    })

    tigris.mobs.register_spawn(name, {
        ymax = tigris.world_limits.max.y,
        ymin = 40,

        light_min = 0,
        light_max = minetest.LIGHT_MAX,

        chance = 7000 * #colors,

        nodes = {"group:soil"},
    })
end
