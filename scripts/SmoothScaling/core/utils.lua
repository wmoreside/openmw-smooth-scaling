local ui = require("openmw.ui")
local settings = require("scripts.SmoothScaling.core.settings")


local M = {}

local function round(n)
    return math.floor(n * 100 + 0.5) / 100
end

M.showDebugMessage = function(skillId, multipliers)
    if not multipliers then return end
    if not settings.getEnableMessages() then return end

    local fmt = "%s" ..
        "\nglobal: %.2f" ..
        "\nclass: %.2f" ..
        "\nspecialization: %.2f" ..
        "\nindividual: %.2f" ..
        "\ntotal: %.2f"

    local msg = string.format(
        fmt,
        skillId,
        round(multipliers.global),
        round(multipliers.class),
        round(multipliers.specialization),
        round(multipliers.individual),
        round(multipliers.total)
    )

    ui.showMessage(msg)
end

return M
