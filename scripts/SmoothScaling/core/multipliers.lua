local omwself = require("openmw.self")
local types = require("openmw.types")
local classSkills = require("scripts.SmoothScaling.core.classSkills")
local curve = require("scripts.SmoothScaling.core.curve")
local settings = require("scripts.SmoothScaling.core.settings")
local utils = require("scripts.SmoothScaling.core.utils")


local M = {}

local function getGlobalMultiplier(skillId)
    local skillLevel = types.NPC.stats.skills[skillId](omwself).base
    local from = settings.getGlobalFrom()
    local to = settings.getGlobalTo()
    return curve.interpolate(from, to, skillLevel) / 100
end

local function getClassMultiplier(skillId)
    local category = classSkills.getCategory(skillId)
    if category == "major" then return settings.getMajorMultiplier() / 100 end
    if category == "minor" then return settings.getMinorMultiplier() / 100 end
    return settings.getMiscMultiplier() / 100
end

local function getSpecializationMultiplier(skillId)
    if not classSkills.isSpecialized(skillId) then return 1 end
    return settings.getSpecializationMultiplier() / 100
end

local function getIndividualMultiplier(skillId)
    return settings.getIndividualMultiplier(skillId) / 100
end

M.apply = function(skillId, options)
    if options.skillGain == nil then return end

    local global = getGlobalMultiplier(skillId)
    local class = getClassMultiplier(skillId)
    local specialization = getSpecializationMultiplier(skillId)
    local individual = getIndividualMultiplier(skillId)

    local multiplier = global * class * specialization * individual

    options.skillGain = options.skillGain * multiplier

    utils.showDebugMessage(skillId, {
        global = global,
        class = class,
        specialization = specialization,
        individual = individual,
        total = multiplier,
    })
end

return M
