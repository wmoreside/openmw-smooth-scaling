local I        = require("openmw.interfaces")
local core     = require("openmw.core")
local omwself  = require("openmw.self")
local types    = require("openmw.types")
local settings = require("scripts.SmoothScaling.core.settings")


local M = {}

local incomingDamage = nil

local fDamageStrengthBase = core.getGMST("fDamageStrengthBase")
local fDamageStrengthMult = core.getGMST("fDamageStrengthMult")

local creatureDamageRanges = {
    [I.Combat.ATTACK_TYPES.Chop] = { min = 1, max = 2 },
    [I.Combat.ATTACK_TYPES.Slash] = { min = 3, max = 4 },
    [I.Combat.ATTACK_TYPES.Thrust] = { min = 5, max = 6 },
}

local weaponDamageRanges = {
    [I.Combat.ATTACK_TYPES.Chop] = { min = "chopMinDamage", max = "chopMaxDamage" },
    [I.Combat.ATTACK_TYPES.Slash] = { min = "slashMinDamage", max = "slashMaxDamage" },
    [I.Combat.ATTACK_TYPES.Thrust] = { min = "thrustMinDamage", max = "thrustMaxDamage" },
}

local function isHoldingShield()
    local item = types.Actor.getEquipment(omwself, types.Actor.EQUIPMENT_SLOT.CarriedLeft)
    if not item or not types.Armor.objectIsInstance(item) then return false end
    return types.Armor.record(item).type == types.Armor.TYPE.Shield
end

--- Consider any successful melee hit that deals 0 damage a block.
--- Also check that the player is holding a shield to be safe.
local function isBlock(attack)
    if attack.sourceType ~= I.Combat.ATTACK_SOURCE_TYPES.Melee then return false end
    local healthDamage = attack.damage and attack.damage.health or 0
    if healthDamage > 0 then return false end
    return isHoldingShield()
end

local function calculateWeaponDamage(attacker, attack)
    local weapon = attack.weapon
    local record = types.Weapon.record(weapon)

    -- Weapon damage
    local range = weaponDamageRanges[attack.type]
    local min = record[range.min]
    local max = record[range.max]
    local damage = min + (max - min) * attack.strength

    -- Strength modifier
    local str = types.Actor.stats.attributes.strength(attacker).modified
    damage = damage * (fDamageStrengthBase + str * fDamageStrengthMult * 0.1)

    -- Condition modifier
    local itemData = types.Item.itemData(weapon)
    damage = damage * (itemData.condition / record.health)

    return damage
end

local function calculateCreatureDamage(attacker, attack)
    local record = types.Creature.record(attacker)

    local range = creatureDamageRanges[attack.type]
    local min = record.attack[range.min]
    local max = record.attack[range.max]

    return min + (max - min) * attack.strength
end

local function calculateBlockedDamage(attack)
    local attacker = attack.attacker
    if not attacker then return 0 end

    if attack.weapon and types.Weapon.objectIsInstance(attack.weapon) then
        return calculateWeaponDamage(attacker, attack)
    end

    if types.Creature.objectIsInstance(attacker) then
        return calculateCreatureDamage(attacker, attack)
    end

    -- Hand to hand damage falls through here, but doesn't grant XP in vanilla anyways.
    return 0
end

--- Do the difficulty adjustment on a copy, to prevent the engine from applying it twice.
local function applyDifficulty(damage, attacker)
    if damage <= 0 then return damage end

    local copy = {
        attacker = attacker,
        damage = { health = damage },
    }

    I.Combat.adjustDamageForDifficulty(copy, omwself)
    if copy.damage and copy.damage.health then
        return copy.damage.health
    end

    return damage
end

M.getIncoming = function()
    local damage = incomingDamage
    incomingDamage = nil
    return damage
end

M.saveIncoming = function(attack)
    incomingDamage = nil

    if not attack or not attack.successful then return end

    local rawDamage = 0
    if settings.getBlockScalingEnabled() and isBlock(attack) then
        rawDamage = calculateBlockedDamage(attack)
    elseif settings.getArmorScalingEnabled() then
        rawDamage = attack.damage and attack.damage.health or 0
    end

    incomingDamage = applyDifficulty(rawDamage, attack.attacker)
end

return M
