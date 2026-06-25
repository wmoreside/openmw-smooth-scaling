local M = {}


local CURVE_EXPONENT = 2

M.interpolate = function(from, to, skillLevel)
    local t = math.max(0, math.min(1, skillLevel / 100))
    local eased = t ^ CURVE_EXPONENT
    return from + (to - from) * eased
end

return M
