-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local useDispatch = require(ProfilePlatformParent.RoactUtils).Hooks.RoactRodux.useDispatch

local useNavigation = require(ProfilePlatformParent.Navigation).useNavigation
local OpenGameDetails = require(ProfilePlatformParent.GameDetail).OpenGameDetails

local ExperienceTile = require(ProfilePlatform.BaseComponents.Tiles.ExperienceTile)

local _Types = require(ProfilePlatform.Common.Types)

local function useRenderExperienceTile(impressionsTag: string, str2: string?, callback: ((...any) -> (...any))?, showFooter: boolean?)
    local var1 = useDispatch()
    local var2 = useNavigation()

    local str3 = str2 or "ProfileExperienceTile_"
    local var3 = React.useCallback(function(arg1, arg2, arg3)
        return function()
            if callback then
                callback(arg1, arg2, arg3)
            end
            var1(OpenGameDetails(arg1.experienceId, var2, { mountAsFullView = false, showBackButton = true }))
        end
    end, { callback, var1, var2 })

    return (React.useCallback(function(arg1, index: number, _, num1: number?)
        return React.createElement(ExperienceTile, {
            item = arg1,
            index = index,
            onActivated = var3(arg1, index, num1),
            impressionsTag = impressionsTag,
            showFooter = showFooter
        }), `{str3}{arg1.experienceId}_`
    end, { impressionsTag, var3, str3 }))
end

return useRenderExperienceTile
