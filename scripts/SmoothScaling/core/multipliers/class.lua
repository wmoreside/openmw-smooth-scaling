local settings = require("scripts.SmoothScaling.core.settings")
local classSkills = require("scripts.SmoothScaling.core.utils.classSkills")


local M = {}

M.get = function(skillId)
    local category = classSkills.getCategory(skillId)
    if category == "major" then return settings.getMajorMultiplier() / 100 end
    if category == "minor" then return settings.getMinorMultiplier() / 100 end
    return settings.getMiscMultiplier() / 100
end

return M
