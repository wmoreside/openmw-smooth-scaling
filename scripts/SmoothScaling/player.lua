local I = require("openmw.interfaces")
local multipliers = require("scripts.SmoothScaling.core.multipliers")


I.SkillProgression.addSkillUsedHandler(multipliers.apply)
