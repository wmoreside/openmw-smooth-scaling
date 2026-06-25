local core = require("openmw.core")
local omwself = require("openmw.self")
local types = require("openmw.types")


local M = {}

local cache = nil

local function getCache()
    if cache then return cache end

    local player = types.NPC.record(omwself)
    local class = types.NPC.classes.record(player.class)
    local major = {}
    local minor = {}

    for _, skillId in ipairs(class.majorSkills) do
        major[skillId] = true
    end

    for _, skillId in ipairs(class.minorSkills) do
        minor[skillId] = true
    end

    cache = {
        major = major,
        minor = minor,
        specialization = class.specialization,
    }

    return cache
end

M.getCategory = function(skillId)
    local c = getCache()
    if c.major[skillId] then return "major" end
    if c.minor[skillId] then return "minor" end
    return "misc"
end

M.isSpecialized = function(skillId)
    local specialization = core.stats.Skill.record(skillId).specialization
    return specialization == getCache().specialization
end

return M
