local I = require("openmw.interfaces")
local damage = require("scripts.SmoothScaling.core.damage")
local hitChance = require("scripts.SmoothScaling.core.hitChance")
local scaling = require("scripts.SmoothScaling.core.scaling")


I.Combat.addOnHitHandler(damage.saveIncoming)
I.SkillProgression.addSkillUsedHandler(scaling.apply)

return {
    eventHandlers = {
        SmoothScalingPlayerHitActor = function(data)
            hitChance.saveIncoming(data.attack, data.target)
        end
    }
}
