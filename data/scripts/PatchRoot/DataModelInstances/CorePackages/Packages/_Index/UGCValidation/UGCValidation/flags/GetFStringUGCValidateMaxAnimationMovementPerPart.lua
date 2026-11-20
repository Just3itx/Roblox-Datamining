-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local GetFStringUGCValidateMaxAnimationMovement = require(scriptParentParent.flags.GetFStringUGCValidateMaxAnimationMovement)

local function getFallbackValue()
    return GetFStringUGCValidateMaxAnimationMovement.asString()
end

game:DefineFastString("UGCValidateMaxAnimationMovementHead", "")
game:DefineFastString("UGCValidateMaxAnimationMovementUpperTorso", "")
game:DefineFastString("UGCValidateMaxAnimationMovementLeftUpperLeg", "")
game:DefineFastString("UGCValidateMaxAnimationMovementLeftLowerLeg", "")
game:DefineFastString("UGCValidateMaxAnimationMovementLeftHand", "")
game:DefineFastString("UGCValidateMaxAnimationMovementRightUpperArm", "")
game:DefineFastString("UGCValidateMaxAnimationMovementRightLowerArm", "")
game:DefineFastString("UGCValidateMaxAnimationMovementRightHand", "")
game:DefineFastString("UGCValidateMaxAnimationMovementLeftUpperArm", "")
game:DefineFastString("UGCValidateMaxAnimationMovementLeftLowerArm", "")
game:DefineFastString("UGCValidateMaxAnimationMovementLeftFoot", "")
game:DefineFastString("UGCValidateMaxAnimationMovementRightUpperLeg", "")
game:DefineFastString("UGCValidateMaxAnimationMovementRightLowerLeg", "")
game:DefineFastString("UGCValidateMaxAnimationMovementRightFoot", "")

local module = {}

local tbl1 = {
    Head = function(): string
        return game:GetFastString("UGCValidateMaxAnimationMovementHead")
    end,
    UpperTorso = function(): string
        return game:GetFastString("UGCValidateMaxAnimationMovementUpperTorso")
    end,
    LeftUpperLeg = function(): string
        return game:GetFastString("UGCValidateMaxAnimationMovementLeftUpperLeg")
    end,
    LeftLowerLeg = function(): string
        return game:GetFastString("UGCValidateMaxAnimationMovementLeftLowerLeg")
    end,
    LeftHand = function(): string
        return game:GetFastString("UGCValidateMaxAnimationMovementLeftHand")
    end,
    RightUpperArm = function(): string
        return game:GetFastString("UGCValidateMaxAnimationMovementRightUpperArm")
    end,
    RightLowerArm = function(): string
        return game:GetFastString("UGCValidateMaxAnimationMovementRightLowerArm")
    end,
    RightHand = function(): string
        return game:GetFastString("UGCValidateMaxAnimationMovementRightHand")
    end,
    LeftUpperArm = function(): string
        return game:GetFastString("UGCValidateMaxAnimationMovementLeftUpperArm")
    end,
    LeftLowerArm = function(): string
        return game:GetFastString("UGCValidateMaxAnimationMovementLeftLowerArm")
    end,
    LeftFoot = function(): string
        return game:GetFastString("UGCValidateMaxAnimationMovementLeftFoot")
    end,
    RightUpperLeg = function(): string
        return game:GetFastString("UGCValidateMaxAnimationMovementRightUpperLeg")
    end,
    RightLowerLeg = function(): string
        return game:GetFastString("UGCValidateMaxAnimationMovementRightLowerLeg")
    end,
    RightFoot = function(): string
        return game:GetFastString("UGCValidateMaxAnimationMovementRightFoot")
    end
}

function module.asString(str1: string)
    local var1 = tbl1[str1]
    if not var1 then
        return getFallbackValue()
    end
    local var2 = var1()
    if #var2 == 0 then
        return getFallbackValue()
    end
    return var2
end

function module.asNumber(str1: string): number?
    return tonumber(module.asString(str1))
end

return module
