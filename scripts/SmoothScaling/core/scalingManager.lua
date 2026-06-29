local message                  = require("scripts.SmoothScaling.core.utils.message")
local globalMultiplier         = require("scripts.SmoothScaling.core.multipliers.global")
local classMultiplier          = require("scripts.SmoothScaling.core.multipliers.class")
local specializationMultiplier = require("scripts.SmoothScaling.core.multipliers.specialization")
local individualMultiplier     = require("scripts.SmoothScaling.core.multipliers.individual")
local spellCostMultiplier      = require("scripts.SmoothScaling.core.multipliers.spellCost")
local castChanceMultiplier     = require("scripts.SmoothScaling.core.multipliers.castChance")
local damageMultiplier         = require("scripts.SmoothScaling.core.multipliers.damage")
local hitChanceMultiplier      = require("scripts.SmoothScaling.core.multipliers.hitChance")


local M = {}

M.apply = function(skillId, options)
    if options.skillGain == nil then return end

    local global = globalMultiplier.get(skillId)
    local class = classMultiplier.get(skillId)
    local specialization = specializationMultiplier.get(skillId)
    local individual = individualMultiplier.get(skillId)
    local spellCost = spellCostMultiplier.get(skillId, options)
    local castChance = castChanceMultiplier.get(skillId, options)
    local damage = damageMultiplier.get(skillId)
    local hitChance = hitChanceMultiplier.get(skillId)

    local multiplier = global * class * specialization * individual *
        spellCost * castChance * damage * hitChance

    options.skillGain = options.skillGain * multiplier

    message.show(skillId, {
        global = global,
        class = class,
        specialization = specialization,
        individual = individual,
        spellCost = spellCost,
        castChance = castChance,
        damage = damage,
        hitChance = hitChance,
        total = multiplier,
    })
end

return M
