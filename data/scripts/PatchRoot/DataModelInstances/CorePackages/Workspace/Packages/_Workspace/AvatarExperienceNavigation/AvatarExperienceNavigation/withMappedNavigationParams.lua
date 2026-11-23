-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceNavigationParent = script:FindFirstAncestor("AvatarExperienceNavigation").Parent

local Roact = require(AvatarExperienceNavigationParent.Roact)
local Cryo = require(AvatarExperienceNavigationParent.Cryo)
local ArgCheck = require(AvatarExperienceNavigationParent.ArgCheck)
local ReactIs = require(AvatarExperienceNavigationParent.ReactIs)

local function withMappedNavigationParams(arg1, arg2)
    ArgCheck.assert(
        ReactIs.isValidElementType(arg1),
        "withMappedNavigationParams must be called with a Roact component (stateful or functional)"
    )
    local var1 = arg2 or {}

    if var1.forwardRef == nil then
        var1.forwardRef = true
    end

    return function(arg3)
        local var2 = arg3.navigation.state.params or {}
        return Roact.createElement(
            arg1,
            Cryo.Dictionary.join(arg3, var2, { [Roact.Ref] = var1.forwardRef and arg3[Roact.Ref] or Cryo.None })
        )
    end
end

return withMappedNavigationParams
