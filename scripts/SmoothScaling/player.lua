local I = require("openmw.interfaces")
local combat = require("scripts.SmoothScaling.core.combat")
local scaling = require("scripts.SmoothScaling.core.scaling")


I.Combat.addOnHitHandler(combat.saveIncomingDamage)
I.SkillProgression.addSkillUsedHandler(scaling.apply)
