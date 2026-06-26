local I        = require("openmw.interfaces")
local omwself  = require("openmw.self")
local types    = require("openmw.types")
local settings = require("scripts.SmoothScaling.core.settings")


local M = {}

local MAGICKA_SKILLS = {
    alteration = true,
    conjuration = true,
    destruction = true,
    illusion = true,
    mysticism = true,
    restoration = true,
}

M.get = function(skillId, options)
    if not settings.getMagickaEnabled() then return 1 end
    if not MAGICKA_SKILLS[skillId] then return 1 end
    if options.useType ~= I.SkillProgression.SKILL_USE_TYPES.Spellcast_Success then return 1 end

    local spell = types.Actor.getSelectedSpell(omwself)
    if not spell or not spell.cost then return 1 end

    return settings.getXpPerMagicka() * spell.cost
end

return M
