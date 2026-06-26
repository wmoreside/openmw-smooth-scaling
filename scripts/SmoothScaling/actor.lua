local I = require("openmw.interfaces")
local omwself = require("openmw.self")
local types = require("openmw.types")


I.Combat.addOnHitHandler(function(attack)
    if not attack.successful then return end
    if not types.Player.objectIsInstance(attack.attacker) then return end

    attack.attacker:sendEvent("SmoothScalingPlayerHitActor", {
        attack = attack,
        target = omwself.object
    })
end)

return {}
