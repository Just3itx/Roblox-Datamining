-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local React = require(AvatarExperienceCommonParent.React)
local Navigation = require(AvatarExperienceCommonParent.Navigation)
local SafeAppStorageService = require(AvatarExperienceCommon.Lib.SafeAppStorageService)
local AvatarExperienceNavigation = require(AvatarExperienceCommonParent.AvatarExperienceNavigation)
local AvatarScreen = AvatarExperienceNavigation.Enums.AvatarScreen
local useAvatarRoute = AvatarExperienceNavigation.AvatarRoute.Hooks.useAvatarRoute
local useNavigation = Navigation.useNavigation
local useSelector = require(AvatarExperienceCommonParent.RoactUtils).Hooks.RoactRodux.useSelector

local useIsSpatial = require(AvatarExperienceCommonParent.Responsive).useIsSpatial

local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local FFlagAXEnhancedAvatarHeadsFtuxUseMemStorage = AvatarExperienceFlags.FFlagAXEnhancedAvatarHeadsFtuxUseMemStorage
local FIntAXEnhancedAvatarHeadsFtuxDelay = AvatarExperienceFlags.FIntAXEnhancedAvatarHeadsFtuxDelay

local function func1(arg1)
    return arg1.ScreenSize
end

local function useEnhancedAvatarHeadsFtux()
    local var1 = useNavigation()
    local var2 = useAvatarRoute()
    local screenSize = useSelector(func1)

    local var4 = React.useMemo(function()
        return var2 and var2.opaque and var2.opaque.name
    end, { var2 })

    local var5 = React.useCallback(function()
        return SafeAppStorageService.getItem("AXEnhancedAvatarHeadsFtux", FFlagAXEnhancedAvatarHeadsFtuxUseMemStorage)
    end, {})

    local var6 = React.useCallback(function()
        SafeAppStorageService.setItem("AXEnhancedAvatarHeadsFtux", "true", FFlagAXEnhancedAvatarHeadsFtuxUseMemStorage)
        SafeAppStorageService.flush()
    end, {})

    local var7 = useIsSpatial()

    React.useEffect(function()
        if var7 or var5() == "true" or var4 ~= AvatarScreen.AvatarEditor then
            return
        end

        local var8 = task.delay(FIntAXEnhancedAvatarHeadsFtuxDelay / 1000, function()
            var1.navigate(AvatarScreen.EnhancedAvatarHeadsFtuxPrompt, {
                screenSize = screenSize,
                onConfirm = function()
                    var6()
                end
            })
        end)

        return function()
            if var8 then
                task.cancel(var8)
            end
        end
    end, {
        var5,
        var6,
        var4,
        screenSize,
        var1,
        var7
    })
end

return useEnhancedAvatarHeadsFtux
