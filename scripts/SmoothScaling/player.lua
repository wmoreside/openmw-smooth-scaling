local I = require("openmw.interfaces")
local scaling = require("scripts.SmoothScaling.core.scaling")


I.SkillProgression.addSkillUsedHandler(scaling.apply)
