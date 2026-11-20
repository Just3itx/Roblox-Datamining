-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GetFStringUGCValidateMaxJointRotation = require(script.Parent.GetFStringUGCValidateMaxJointRotation)

local function getFallbackValue()
    return GetFStringUGCValidateMaxJointRotation.asString()
end

game:DefineFastString("UGCValidateMaxJointRotationHead", "")
game:DefineFastString("UGCValidateMaxJointRotationUpperTorso", "")
game:DefineFastString("UGCValidateMaxJointRotationLeftUpperLeg", "")
game:DefineFastString("UGCValidateMaxJointRotationLeftLowerLeg", "")
game:DefineFastString("UGCValidateMaxJointRotationLeftHand", "")
game:DefineFastString("UGCValidateMaxJointRotationRightUpperArm", "")
game:DefineFastString("UGCValidateMaxJointRotationRightLowerArm", "")
game:DefineFastString("UGCValidateMaxJointRotationRightHand", "")
game:DefineFastString("UGCValidateMaxJointRotationLeftUpperArm", "")
game:DefineFastString("UGCValidateMaxJointRotationLeftLowerArm", "")
game:DefineFastString("UGCValidateMaxJointRotationLeftFoot", "")
game:DefineFastString("UGCValidateMaxJointRotationRightUpperLeg", "")
game:DefineFastString("UGCValidateMaxJointRotationRightLowerLeg", "")
game:DefineFastString("UGCValidateMaxJointRotationRightFoot", "")

local module = {}

local tbl1 = {
    Head = function(): string
        return game:GetFastString("UGCValidateMaxJointRotationHead")
    end,
    UpperTorso = function(): string
        return game:GetFastString("UGCValidateMaxJointRotationUpperTorso")
    end,
    LeftUpperLeg = function(): string
        return game:GetFastString("UGCValidateMaxJointRotationLeftUpperLeg")
    end,
    LeftLowerLeg = function(): string
        return game:GetFastString("UGCValidateMaxJointRotationLeftLowerLeg")
    end,
    LeftHand = function(): string
        return game:GetFastString("UGCValidateMaxJointRotationLeftHand")
    end,
    RightUpperArm = function(): string
        return game:GetFastString("UGCValidateMaxJointRotationRightUpperArm")
    end,
    RightLowerArm = function(): string
        return game:GetFastString("UGCValidateMaxJointRotationRightLowerArm")
    end,
    RightHand = function(): string
        return game:GetFastString("UGCValidateMaxJointRotationRightHand")
    end,
    LeftUpperArm = function(): string
        return game:GetFastString("UGCValidateMaxJointRotationLeftUpperArm")
    end,
    LeftLowerArm = function(): string
        return game:GetFastString("UGCValidateMaxJointRotationLeftLowerArm")
    end,
    LeftFoot = function(): string
        return game:GetFastString("UGCValidateMaxJointRotationLeftFoot")
    end,
    RightUpperLeg = function(): string
        return game:GetFastString("UGCValidateMaxJointRotationRightUpperLeg")
    end,
    RightLowerLeg = function(): string
        return game:GetFastString("UGCValidateMaxJointRotationRightLowerLeg")
    end,
    RightFoot = function(): string
        return game:GetFastString("UGCValidateMaxJointRotationRightFoot")
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
