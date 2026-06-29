local I        = require("openmw.interfaces")
local core     = require("openmw.core")
local omwself  = require("openmw.self")
local types    = require("openmw.types")
local settings = require("scripts.SmoothScaling.core.settings")
local curve    = require("scripts.SmoothScaling.core.utils.curve")


local M = {}

local fFatigueBase = core.getGMST("fFatigueBase")
local fFatigueMult = core.getGMST("fFatigueMult")

local magickaSkills = {
    alteration = true,
    conjuration = true,
    destruction = true,
    illusion = true,
    mysticism = true,
    restoration = true,
}

local function fatiguePart(actor)
    local fatigue = types.Actor.stats.dynamic.fatigue(actor)
    local max = fatigue.base + (fatigue.modifier or 0)
    local normalised = 1

    if max > 0 then
        normalised = math.max(0, fatigue.current / max)
    end

    return fFatigueBase - fFatigueMult * (1 - normalised)
end

local function castChance(skillId, spell)
    local skill = types.NPC.stats.skills[skillId](omwself).modified
    local willpower = types.Actor.stats.attributes.willpower(omwself).modified
    local luck = types.Actor.stats.attributes.luck(omwself).modified

    local chance = (2 * skill - spell.cost + 0.2 * willpower + 0.1 * luck) * fatiguePart(omwself)
    return math.max(0, math.min(100, chance))
end

local function castChanceMultiplier(chance, from, to)
    local difficulty = math.max(0, math.min(100, 100 - chance))
    return curve.interpolate(from, to, difficulty) / 100
end

M.get = function(skillId, options)
    if not settings.getCastChanceEnabled() then return 1 end
    if not magickaSkills[skillId] then return 1 end
    if options.useType ~= I.SkillProgression.SKILL_USE_TYPES.Spellcast_Success then return 1 end

    local spell = types.Actor.getSelectedSpell(omwself)
    if not spell or not spell.cost then return 1 end

    return castChanceMultiplier(
        castChance(skillId, spell),
        settings.getCastChanceFrom(),
        settings.getCastChanceTo())
end

return M
