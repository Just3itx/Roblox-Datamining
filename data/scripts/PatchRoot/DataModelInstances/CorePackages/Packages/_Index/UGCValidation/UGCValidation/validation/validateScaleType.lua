-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)
local _Types = require(scriptParentParent.util.Types)

local Analytics = require(scriptParentParent.Analytics)

local function validateScaleType(arg1, arg2)
    if not arg1 then
        return true
    end

    if Constants.AvatarPartScaleTypes[arg1.Value] then
        return true
    end

    Analytics.reportFailure(Analytics.ErrorType.validateScaleType_InvalidAvatarPartScaleType, nil, arg2)

    assert(arg1.Parent)
    return false, { string.format(
            "The AvatarPartScaleType value in '%s' is invalid. Please, verify the value you are using is either Classic, ProportionsSlender, or ProportionsNormal.",
            arg1.Parent.Name
        ) }
end

return validateScaleType
