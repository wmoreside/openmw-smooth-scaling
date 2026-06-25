local I = require("openmw.interfaces")


I.Settings.registerPage {
    key = "SmoothScaling",
    l10n = "SmoothScaling",
    name = "page_name",
    description = "page_description",
}

I.Settings.registerGroup {
    key = "SettingsPlayerSmoothScalingGlobal",
    page = "SmoothScaling",
    l10n = "SmoothScaling",
    name = "global_group_name",
    description = "global_group_description",
    permanentStorage = true,
    order = 0,
    settings = {
        {
            key = "globalFrom",
            renderer = "number",
            name = "globalFrom_name",
            default = 100,
            argument = {
                integer = false,
                min = 0,
            },
        },
        {
            key = "globalTo",
            renderer = "number",
            name = "globalTo_name",
            default = 100,
            argument = {
                integer = false,
                min = 0,
            },
        },
    },
}

I.Settings.registerGroup {
    key = "SettingsPlayerSmoothScalingClassSkills",
    page = "SmoothScaling",
    l10n = "SmoothScaling",
    name = "classSkills_group_name",
    description = "classSkills_group_description",
    permanentStorage = true,
    order = 1,
    settings = {
        {
            key = "majorMultiplier",
            renderer = "number",
            name = "majorMultiplier_name",
            default = 100,
            argument = {
                integer = false,
                min = 0,
            },
        },
        {
            key = "minorMultiplier",
            renderer = "number",
            name = "minorMultiplier_name",
            default = 100,
            argument = {
                integer = false,
                min = 0,
            },
        },
        {
            key = "miscMultiplier",
            renderer = "number",
            name = "miscMultiplier_name",
            default = 100,
            argument = {
                integer = false,
                min = 0,
            },
        },
    },
}

I.Settings.registerGroup {
    key = "SettingsPlayerSmoothScalingSpecialization",
    page = "SmoothScaling",
    l10n = "SmoothScaling",
    name = "specialization_group_name",
    description = "specialization_group_description",
    permanentStorage = true,
    order = 2,
    settings = {
        {
            key = "specializationMultiplier",
            renderer = "number",
            name = "specializationMultiplier_name",
            default = 100,
            argument = {
                integer = false,
                min = 0,
            },
        },
    },
}

local function individualSetting(skillId)
    return {
        key = skillId,
        renderer = "number",
        name = skillId .. "_name",
        default = 100,
        argument = {
            integer = false,
            min = 0,
        },
    }
end

I.Settings.registerGroup {
    key = "SettingsPlayerSmoothScalingIndividual",
    page = "SmoothScaling",
    l10n = "SmoothScaling",
    name = "individual_group_name",
    description = "individual_group_description",
    permanentStorage = true,
    order = 3,
    settings = {
        -- Combat
        individualSetting("armorer"),
        individualSetting("athletics"),
        individualSetting("axe"),
        individualSetting("block"),
        individualSetting("bluntweapon"),
        individualSetting("heavyarmor"),
        individualSetting("longblade"),
        individualSetting("mediumarmor"),
        individualSetting("spear"),
        -- Magic
        individualSetting("alchemy"),
        individualSetting("alteration"),
        individualSetting("conjuration"),
        individualSetting("destruction"),
        individualSetting("enchant"),
        individualSetting("illusion"),
        individualSetting("mysticism"),
        individualSetting("restoration"),
        individualSetting("unarmored"),
        -- Stealth
        individualSetting("acrobatics"),
        individualSetting("handtohand"),
        individualSetting("lightarmor"),
        individualSetting("marksman"),
        individualSetting("mercantile"),
        individualSetting("security"),
        individualSetting("shortblade"),
        individualSetting("sneak"),
        individualSetting("speechcraft"),
    },
}
