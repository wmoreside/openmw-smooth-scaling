local M = {}


local exponent = 2

--- Interpolates a value between 0 and 100 on a curve from "from" to "to".
--- Starts gradual before becoming steeper the higher the value gets.
M.interpolate = function(from, to, value)
    local t = math.max(0, math.min(1, value / 100))
    local eased = t ^ exponent
    return from + (to - from) * eased
end

return M
