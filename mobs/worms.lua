local function register(name, def)
    tigris.mobs.register(":" .. name, {
        description = def.desc,
        box = {{-0.2, -0.2, -0.5, 0.2, 0.2, 0.5}},
        textures = {def.texture},

        group = "peaceful",
        level = 1,

        drops = def.drops,
        armor = def.armor,

        habitat_nodes = def.nodes,

        on_init = function(self, data)
            self.hp_max = 3 * def.strength
            data.jump = 5
            data.speed = 0.5
            data.fast_speed = 1
            data.regen = 3
        end,

        start = "wander",
        script = tigris.mobs.common.peaceful(),
    })

    tigris.mobs.register_spawn(name, {
        ymax = tigris.world_limits.max.y,
        ymin = tigris.world_limits.min.y,

        light_min = 0,
        light_max = def.light,

        chance = def.chance,

        nodes = def.nodes,
    })
end

register("tigris_mobs:clay_worm", {
    desc = "Clay Worm",
    texture = "default_clay.png",
    drops = {
        {100, "default:clay_lump"},
        {50, "default:clay_lump"},
        {25, "default:clay_lump"},
    },
    nodes = {"group:soil", "group:sand", "default:stone"},
    chance = 12000,
    light = minetest.LIGHT_MAX / 2,
    strength = 1.5,
})

register("tigris_mobs:sand_worm", {
    desc = "Sand Worm",
    texture = "default_sand.png",
    drops = {
        {100, "default:sand"},
        {25, "default:sand"},
    },
    nodes = {"group:sand"},
    chance = 12000,
    light = minetest.LIGHT_MAX,
    strength = 1,
})
