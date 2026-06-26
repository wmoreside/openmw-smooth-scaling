local message                  = require("scripts.SmoothScaling.core.utils.message")
local globalMultiplier         = require("scripts.SmoothScaling.core.multipliers.global")
local classMultiplier          = require("scripts.SmoothScaling.core.multipliers.class")
local specializationMultiplier = require("scripts.SmoothScaling.core.multipliers.specialization")
local individualMultiplier     = require("scripts.SmoothScaling.core.multipliers.individual")
local magickaMultiplier        = require("scripts.SmoothScaling.core.multipliers.magicka")
local damageMultiplier         = require("scripts.SmoothScaling.core.multipliers.damage")
local hitChanceMultiplier      = require("scripts.SmoothScaling.core.multipliers.hitChance")


local M = {}

M.apply = function(skillId, options)
    if options.skillGain == nil then return end

    local global = globalMultiplier.get(skillId)
    local class = classMultiplier.get(skillId)
    local specialization = specializationMultiplier.get(skillId)
    local individual = individualMultiplier.get(skillId)
    local magicka = magickaMultiplier.get(skillId, options)
    local damage = damageMultiplier.get(skillId)
    local hitChance = hitChanceMultiplier.get(skillId)

    local multiplier = global * class * specialization * individual * magicka * damage * hitChance

    options.skillGain = options.skillGain * multiplier

    message.show(skillId, {
        global = global,
        class = class,
        specialization = specialization,
        individual = individual,
        magicka = magicka,
        damage = damage,
        hitChance = hitChance,
        total = multiplier,
    })
end

return M
