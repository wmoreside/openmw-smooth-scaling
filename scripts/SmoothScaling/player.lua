local I = require("openmw.interfaces")
local damageManager = require("scripts.SmoothScaling.core.damageManager")
local hitChanceManager = require("scripts.SmoothScaling.core.hitChanceManager")
local scalingManager = require("scripts.SmoothScaling.core.scalingManager")


I.Combat.addOnHitHandler(damageManager.saveIncoming)
I.SkillProgression.addSkillUsedHandler(scalingManager.apply)

return {
    eventHandlers = {
        SmoothScalingPlayerHitActor = function(data)
            hitChanceManager.saveIncoming(data.attack, data.target)
        end
    }
}
