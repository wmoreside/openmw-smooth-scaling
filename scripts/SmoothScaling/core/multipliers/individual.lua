local settings = require("scripts.SmoothScaling.core.settings")


local M = {}

M.get = function(skillId)
    return settings.getIndividualMultiplier(skillId) / 100
end

return M
