local storage = require("openmw.storage")


local M = {}

local globalSettings = storage.playerSection("SettingsPlayerSmoothScalingGlobal")
local classSkillSettings = storage.playerSection("SettingsPlayerSmoothScalingClassSkills")
local specializationSettings = storage.playerSection("SettingsPlayerSmoothScalingSpecialization")
local individualSettings = storage.playerSection("SettingsPlayerSmoothScalingIndividual")
local spellCastSettings = storage.playerSection("SettingsPlayerSmoothScalingSpellCost")
local armorScalingSettings = storage.playerSection("SettingsPlayerSmoothScalingArmorScaling")
local blockScalingSettings = storage.playerSection("SettingsPlayerSmoothScalingBlockScaling")
local weaponScalingSettings = storage.playerSection("SettingsPlayerSmoothScalingWeaponScaling")
local debugSettings = storage.playerSection("SettingsPlayerSmoothScalingDebug")

M.getGlobalFrom = function()
    return globalSettings:get("globalFrom") or 100
end

M.getGlobalTo = function()
    return globalSettings:get("globalTo") or 100
end

M.getMajorMultiplier = function()
    return classSkillSettings:get("majorMultiplier") or 100
end

M.getMinorMultiplier = function()
    return classSkillSettings:get("minorMultiplier") or 100
end

M.getMiscMultiplier = function()
    return classSkillSettings:get("miscMultiplier") or 100
end

M.getSpecializationMultiplier = function()
    return specializationSettings:get("specializationMultiplier") or 100
end

M.getIndividualMultiplier = function(skillId)
    return individualSettings:get(skillId) or 100
end

M.getSpellCostEnabled = function()
    return spellCastSettings:get("spellCostEnabled") or false
end

M.getXpPerMagicka = function()
    return spellCastSettings:get("xpPerMagicka") or 0.1
end

M.getArmorScalingEnabled = function()
    return armorScalingSettings:get("armorScalingEnabled") or false
end

M.getArmorScalingFrom = function()
    return armorScalingSettings:get("armorScalingFrom") or 100
end

M.getArmorScalingTo = function()
    return armorScalingSettings:get("armorScalingTo") or 100
end

M.getBlockScalingEnabled = function()
    return blockScalingSettings:get("blockScalingEnabled") or false
end

M.getBlockScalingFrom = function()
    return blockScalingSettings:get("blockScalingFrom") or 100
end

M.getBlockScalingTo = function()
    return blockScalingSettings:get("blockScalingTo") or 100
end

M.getWeaponScalingEnabled = function()
    return weaponScalingSettings:get("weaponScalingEnabled") or false
end

M.getWeaponScalingFrom = function()
    return weaponScalingSettings:get("weaponScalingFrom") or 100
end

M.getWeaponScalingTo = function()
    return weaponScalingSettings:get("weaponScalingTo") or 100
end

M.getEnableMessages = function()
    return debugSettings:get("enableMessages") or false
end

return M
