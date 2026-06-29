local settings    = require("scripts.SmoothScaling.core.settings")
local classSkills = require("scripts.SmoothScaling.core.utils.classSkills")


local M = {}

M.get = function(skillId)
    if classSkills.isSpecialized(skillId) then
        return settings.getSpecializationMultiplier() / 100
    end
    return settings.getNonSpecializationMultiplier() / 100
end

return M
