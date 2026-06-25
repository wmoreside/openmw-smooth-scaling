local storage = require("openmw.storage")


local M = {}

local globalSettings = storage.playerSection("SettingsPlayerSmoothScalingGlobal")
local classSkillSettings = storage.playerSection("SettingsPlayerSmoothScalingClassSkills")
local specializationSettings = storage.playerSection("SettingsPlayerSmoothScalingSpecialization")
local individualSettings = storage.playerSection("SettingsPlayerSmoothScalingIndividual")
local magickaSettings = storage.playerSection("SettingsPlayerSmoothScalingMagicka")
local armorScalingSettings = storage.playerSection("SettingsPlayerSmoothScalingArmorScaling")
local blockScalingSettings = storage.playerSection("SettingsPlayerSmoothScalingBlockScaling")
local debugSettings = storage.playerSection("SettingsPlayerSmoothScalingDebug")

M.getGlobalFrom = function()
    return globalSettings:get("globalFrom")
end

M.getGlobalTo = function()
    return globalSettings:get("globalTo")
end

M.getMajorMultiplier = function()
    return classSkillSettings:get("majorMultiplier")
end

M.getMinorMultiplier = function()
    return classSkillSettings:get("minorMultiplier")
end

M.getMiscMultiplier = function()
    return classSkillSettings:get("miscMultiplier")
end

M.getSpecializationMultiplier = function()
    return specializationSettings:get("specializationMultiplier")
end

M.getIndividualMultiplier = function(skillId)
    return individualSettings:get(skillId) or 100
end

M.getMagickaEnabled = function()
    return magickaSettings:get("magickaEnabled")
end

M.getXpPerMagicka = function()
    return magickaSettings:get("xpPerMagicka")
end

M.getArmorScalingEnabled = function()
    return armorScalingSettings:get("armorScalingEnabled")
end

M.getArmorScalingFrom = function()
    return armorScalingSettings:get("armorScalingFrom")
end

M.getArmorScalingTo = function()
    return armorScalingSettings:get("armorScalingTo")
end

M.getBlockScalingEnabled = function()
    return blockScalingSettings:get("blockScalingEnabled")
end

M.getBlockScalingFrom = function()
    return blockScalingSettings:get("blockScalingFrom")
end

M.getBlockScalingTo = function()
    return blockScalingSettings:get("blockScalingTo")
end

M.getEnableMessages = function()
    return debugSettings:get("enableMessages")
end

return M
