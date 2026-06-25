local omwself = require("openmw.self")
local types = require("openmw.types")
local combat = require("scripts.SmoothScaling.core.combat")
local settings = require("scripts.SmoothScaling.core.settings")


local M = {}

local armorSkills = {
    heavyarmor = true,
    mediumarmor = true,
    lightarmor = true,
    unarmored = true,
}

local function damageMultiplier(damage, from, to)
    local baseHealth = types.Actor.stats.dynamic.health(omwself).base
    if not baseHealth or baseHealth <= 0 then return 1 end
    local t = math.max(0, math.min(1, damage / baseHealth))
    return (from + (to - from) * t) / 100
end

M.get = function(skillId)
    local isArmor = armorSkills[skillId] == true
    local isBlock = skillId == "block"
    if not isArmor and not isBlock then return 1 end

    if isArmor and not settings.getArmorScalingEnabled() then return 1 end
    if isBlock and not settings.getBlockScalingEnabled() then return 1 end

    local damage = combat.getIncomingDamage()
    if not damage then return 1 end

    if isBlock then
        return damageMultiplier(
            damage,
            settings.getBlockScalingFrom(),
            settings.getBlockScalingTo())
    end

    return damageMultiplier(
        damage,
        settings.getArmorScalingFrom(),
        settings.getArmorScalingTo())
end

return M
