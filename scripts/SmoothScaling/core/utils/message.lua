local ui = require("openmw.ui")
local settings = require("scripts.SmoothScaling.core.settings")


local M = {}

local function round(n)
    return math.floor(n * 100 + 0.5) / 100
end

M.show = function(skillId, multipliers)
    if not multipliers then return end
    if not settings.getEnableMessages() then return end

    local order = {
        { label = "global",         value = multipliers.global },
        { label = "class",          value = multipliers.class },
        { label = "specialization", value = multipliers.specialization },
        { label = "individual",     value = multipliers.individual },
        { label = "magicka",        value = multipliers.magicka },
        { label = "damage",         value = multipliers.damage },
        { label = "total",          value = multipliers.total },
    }

    local msg = skillId
    for _, entry in ipairs(order) do
        local rounded = round(entry.value)
        if rounded ~= 1 or entry.label == "total" then
            msg = msg .. string.format("\n%s: %.2f", entry.label, rounded)
        end
    end

    ui.showMessage(msg)
end

return M
