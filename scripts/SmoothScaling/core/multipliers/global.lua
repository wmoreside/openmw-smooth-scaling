local omwself  = require("openmw.self")
local types    = require("openmw.types")
local settings = require("scripts.SmoothScaling.core.settings")
local curve    = require("scripts.SmoothScaling.core.utils.curve")


local M = {}

M.get = function(skillId)
    local skillLevel = types.NPC.stats.skills[skillId](omwself).base
    local from = settings.getGlobalFrom()
    local to = settings.getGlobalTo()
    return curve.interpolate(from, to, skillLevel) / 100
end

return M
