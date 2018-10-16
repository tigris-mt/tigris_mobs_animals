tigris.mobs.register(":tigris_mobs:cow", {
    description = "Cow",
    collision = {-0.4, -0.4, -0.4, 0.4, 0.4, 0.4},
    box = {
        {-0.4, 0, -0.5, 0.4, 0.7, 0.6},
        {-0.25, -0.5, -0.5, -0.1, 0, -0.35},
        {0.1, -0.5, -0.5, 0.25, 0, -0.35},
        {-0.25, -0.5, 0.35, -0.1, 0, 0.5},
        {0.1, -0.5, 0.45, 0.25, 0, 0.6},
        {-0.25, 0, -0.5, 0.25, 0.5, -0.75},
        {-0.1, 0.4, 0.5, 0.1, 0.5, 1},
    },
    textures = {
        "tigris_mobs_cow.png",
        "tigris_mobs_cow.png",
        "tigris_mobs_cow.png",
        "tigris_mobs_cow.png",
        "tigris_mobs_cow.png",
        "tigris_mobs_cow_face.png",
    },

    group = "peaceful",
    level = 1,

    drops = {
        {100, "mobs:meat_raw"},
        {75, "mobs:meat_raw"},
        {50, "mobs:meat_raw 2"},
        {100, "tigris_mobs:bone"},
        {50, "tigris_mobs:bone"},
        {35, "tigris_mobs:eye"},
        {25, "tigris_mobs:eye"},
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

    on_init = function(self, data)
        self.hp_max = 8
        data.jump = 5
        data.produce_milk_time = 60 * 7
    end,

    start = "wander",

    script = tigris.mobs.common.peaceful({
        eat = true,
        breed = true,
    }, function(s)
        s.global.interactions.get_milk = true
        s.flee.interactions.get_milk = false
        table.insert(s.wander.actions, "produce_milk")
        table.insert(s.standing.actions, "produce_milk")
    end),
})

tigris.mobs.register_spawn("tigris_mobs:cow", {
    ymax = tigris.world_limits.max.y,
    ymin = -24,

    light_min = 0,
    light_max = minetest.LIGHT_MAX,

    chance = 10000,

    nodes = {"group:soil"},
})
