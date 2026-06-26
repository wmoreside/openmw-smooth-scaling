local I        = require("openmw.interfaces")
local core     = require("openmw.core")
local omwself  = require("openmw.self")
local types    = require("openmw.types")
local settings = require("scripts.SmoothScaling.core.settings")


local M = {}

local lastHitChance = nil

local fFatigueBase = core.getGMST("fFatigueBase")
local fFatigueMult = core.getGMST("fFatigueMult")

local weaponTypeSkills = {
    [types.Weapon.TYPE.ShortBladeOneHand] = "shortblade",
    [types.Weapon.TYPE.LongBladeOneHand] = "longblade",
    [types.Weapon.TYPE.LongBladeTwoHand] = "longblade",
    [types.Weapon.TYPE.BluntOneHand] = "bluntweapon",
    [types.Weapon.TYPE.BluntTwoClose] = "bluntweapon",
    [types.Weapon.TYPE.BluntTwoWide] = "bluntweapon",
    [types.Weapon.TYPE.SpearTwoWide] = "spear",
    [types.Weapon.TYPE.AxeOneHand] = "axe",
    [types.Weapon.TYPE.AxeTwoHand] = "axe",
    [types.Weapon.TYPE.MarksmanBow] = "marksman",
    [types.Weapon.TYPE.MarksmanCrossbow] = "marksman",
    [types.Weapon.TYPE.MarksmanThrown] = "marksman",
}

local function attackSkill(attack)
    local weapon = attack.weapon
    if weapon and types.Weapon.objectIsInstance(weapon) then
        return weaponTypeSkills[types.Weapon.record(weapon).type]
    end

    return "handtohand"
end

local function fatiguePart(actor)
    local fatigue = types.Actor.stats.dynamic.fatigue(actor)
    local max = fatigue.base + (fatigue.modifier or 0)
    local normalised = 1

    if max > 0 then
        normalised = math.max(0, fatigue.current / max)
    end

    return fFatigueBase - fFatigueMult * (1 - normalised)
end

local function hitRatePart(attacker, skillId)
    local skill = types.NPC.stats.skills[skillId](attacker).modified
    local agility = types.Actor.stats.attributes.agility(attacker).modified
    local luck = types.Actor.stats.attributes.luck(attacker).modified
    return (skill + 0.2 * agility + 0.1 * luck) * fatiguePart(attacker)
end

local function evasionPart(defender)
    local agility = types.Actor.stats.attributes.agility(defender).modified
    local luck = types.Actor.stats.attributes.luck(defender).modified
    return (0.2 * agility + 0.1 * luck) * fatiguePart(defender)
end

M.getLastHit = function()
    local hitChance = lastHitChance
    lastHitChance = nil
    return hitChance
end

M.saveLastHit = function(attack, target)
    lastHitChance = nil

    if not settings.getWeaponScalingEnabled() then return end
    if not attack or not attack.successful then return end
    if not target then return end
    if attack.sourceType == I.Combat.ATTACK_SOURCE_TYPES.Magic then return end

    local skillId = attackSkill(attack)
    if not skillId then return end

    lastHitChance = hitRatePart(omwself, skillId) - evasionPart(target)
end

return M
