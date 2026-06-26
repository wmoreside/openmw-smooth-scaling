local hitChance = require("scripts.SmoothScaling.core.hitChance")
local settings = require("scripts.SmoothScaling.core.settings")
local curve = require("scripts.SmoothScaling.core.utils.curve")


local M = {}

local weaponSkills = {
    axe = true,
    bluntweapon = true,
    longblade = true,
    marksman = true,
    shortblade = true,
    spear = true,
    handtohand = true,
}

local function hitChanceMultiplier(chance, from, to)
    local difficulty = math.max(0, math.min(100, 100 - chance))
    return curve.interpolate(from, to, difficulty) / 100
end

M.get = function(skillId)
    if not weaponSkills[skillId] then return 1 end
    if not settings.getWeaponScalingEnabled() then return 1 end

    local incomingHitChance = hitChance.getIncoming()
    if not incomingHitChance then return 1 end

    return hitChanceMultiplier(
        incomingHitChance,
        settings.getWeaponScalingFrom(),
        settings.getWeaponScalingTo())
end

return M
