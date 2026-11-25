-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:10:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local Cryo = require(ProfilePlatformParent.Cryo)

local _Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Common.Types)
local getDeepValue = require(ProfilePlatform.Utils.getDeepValue)

local FFlagProfilePlatformEnableLazyLoadingComponents = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableLazyLoadingComponents)

return function(arg1, arg2, tbl1)
    local deepValue = getDeepValue(arg1, `{arg2.profileId}`) or {}
    local componentOrdering = if FFlagProfilePlatformEnableLazyLoadingComponents and arg2.onlyEssentialComponents then deepValue.componentOrdering or arg2.componentOrdering else arg2.componentOrdering or deepValue.componentOrdering
    local var1 = deepValue.components or {}
    local tbl2 = ({})
    for _, value in tbl1 or {} do
        tbl2[value] = Cryo.None
    end
    local components = Cryo.Dictionary.join(var1, arg2.components, tbl2)

    local tbl3 = {
        profileType = arg2.profileType,
        profileId = arg2.profileId,
        componentOrdering = componentOrdering,
        components = components
    }

    return Cryo.Dictionary.join(arg1, { [arg2.profileId] = tbl3 })
end
