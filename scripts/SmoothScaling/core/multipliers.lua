local omwself = require("openmw.self")
local types = require("openmw.types")
local I = require("openmw.interfaces")
local classSkills = require("scripts.SmoothScaling.core.classSkills")
local curve = require("scripts.SmoothScaling.core.curve")
local settings = require("scripts.SmoothScaling.core.settings")
local utils = require("scripts.SmoothScaling.core.utils")


local M = {}

local MAGICKA_SKILLS = {
    alteration = true,
    conjuration = true,
    destruction = true,
    illusion = true,
    mysticism = true,
    restoration = true,
}

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

local function getMagickaMultiplier(skillId, options)
    if not settings.getMagickaEnabled() then return 1 end
    if not MAGICKA_SKILLS[skillId] then return 1 end
    if options.useType ~= I.SkillProgression.SKILL_USE_TYPES.Spellcast_Success then return 1 end

    local spell = types.Actor.getSelectedSpell(omwself)
    if not spell or not spell.cost then return 1 end

    return settings.getXpPerMagicka() * spell.cost
end

M.apply = function(skillId, options)
    if options.skillGain == nil then return end

    local global = getGlobalMultiplier(skillId)
    local class = getClassMultiplier(skillId)
    local specialization = getSpecializationMultiplier(skillId)
    local individual = getIndividualMultiplier(skillId)
    local magicka = getMagickaMultiplier(skillId, options)

    local multiplier = global * class * specialization * individual * magicka

    options.skillGain = options.skillGain * multiplier

    utils.showDebugMessage(skillId, {
        global = global,
        class = class,
        specialization = specialization,
        individual = individual,
        magicka = magicka,
        total = multiplier,
    })
end

return M
