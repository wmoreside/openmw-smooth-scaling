local I = require("openmw.interfaces")
local damage = require("scripts.SmoothScaling.core.damage")
local scaling = require("scripts.SmoothScaling.core.scaling")


I.Combat.addOnHitHandler(damage.saveIncoming)
I.SkillProgression.addSkillUsedHandler(scaling.apply)
