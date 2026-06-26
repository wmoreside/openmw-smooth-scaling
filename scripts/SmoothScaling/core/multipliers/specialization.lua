local settings    = require("scripts.SmoothScaling.core.settings")
local classSkills = require("scripts.SmoothScaling.core.utils.classSkills")


local M = {}

M.get = function(skillId)
    if not classSkills.isSpecialized(skillId) then return 1 end
    return settings.getSpecializationMultiplier() / 100
end

return M
