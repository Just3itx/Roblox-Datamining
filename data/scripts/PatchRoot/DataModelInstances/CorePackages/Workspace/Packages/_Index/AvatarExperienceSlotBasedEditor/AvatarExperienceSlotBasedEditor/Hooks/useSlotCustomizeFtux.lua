-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditor = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor")
local AvatarExperienceSlotBasedEditorParent = AvatarExperienceSlotBasedEditor.Parent
local React = require(AvatarExperienceSlotBasedEditorParent.React)
local useSelector = require(AvatarExperienceSlotBasedEditorParent.RoactUtils).Hooks.RoactRodux.useSelector
local useSlotBasedEditorContext = require(AvatarExperienceSlotBasedEditor.Context.useSlotBasedEditorContext)
local ScreenLayout = require(AvatarExperienceSlotBasedEditor.Enums.ScreenLayout)
local Navigation = require(AvatarExperienceSlotBasedEditorParent.Navigation)
local AXCommon = require(AvatarExperienceSlotBasedEditorParent.AXCommon)
local SlotBasedEditorAnalytics = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceAnalytics).Surfaces.SlotBasedEditorAnalytics
local SafeAppStorageService = AXCommon.Lib.SafeAppStorageService
local AvatarExperienceNavigation = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceNavigation)
local AvatarScreen = AvatarExperienceNavigation.Enums.AvatarScreen
local useAvatarRoute = AvatarExperienceNavigation.AvatarRoute.Hooks.useAvatarRoute
local useNavigation = Navigation.useNavigation
local selectIsFullView = AXCommon.State.Selectors.selectIsFullView
local useIsSpatial = require(AvatarExperienceSlotBasedEditorParent.Responsive).useIsSpatial
local MenuItemEnum = require(AvatarExperienceSlotBasedEditorParent.AXControlBar).Enums.MenuItemEnum

local bool1 = game:DefineFastFlag("AXSlotBasedEditorCustomizeFtuxUseMemStorage2", false)
local num1 = game:DefineFastInt("AXSlotBasedEditorCustomizeFtuxDelay2", 3000) / 1000
local num2 = game:DefineFastInt("AXSlotBasedEditorAvatarSwitcherFtuxDelay2", 1000) / 1000

local function func1(arg1)
    return arg1.ScreenSize
end

local function useSlotCustomizeFtux(func2: (...any) -> (...any))
    local var1 = useNavigation()
    local var2 = useAvatarRoute()
    local var3 = useSlotBasedEditorContext()
    local screenLayout = var3 and var3.screenLayout
    local screenSize = useSelector(func1)
    local bool2 = not useIsSpatial()

    local var5 = React.useMemo(function()
        return var2 and var2.opaque and var2.opaque.name
    end, { var2 })

    local var6 = React.useCallback(function(arg1)
        return selectIsFullView(arg1, var5)
    end, { var5 })

    local var7 = useSelector(var6)

    local var8 = React.useMemo(function()
        return func2(var7)
    end, { var7 })

    local var9 = React.useCallback(function()
        return (SafeAppStorageService.getItem("AXSlotBasedEditorCustomizeFtux", bool1))
    end, {})

    local var10 = React.useCallback(function(arg1)
        SafeAppStorageService.setItem("AXSlotBasedEditorCustomizeFtux", arg1, bool1)
        SafeAppStorageService.flush()
    end, {})

    React.useEffect(function()
        local var11 = var9()

        local var12 = nil

        if var11 == ""
            and var5 == AvatarScreen.AvatarEditor
            and bool2
            and var8
            and (screenLayout == ScreenLayout.LandscapeSplit or screenLayout == ScreenLayout.PortraitSlots)
        then
            var12 = task.delay(num1, function()
                var1.navigate(AvatarScreen.SlotsCustomizeFtuxPrompt, {
                    screenSize = screenSize,
                    onConfirm = function()
                        var10("AVATAR_FOCUS_ICON")
                        SlotBasedEditorAnalytics.trackSlotsCustomizeFtuxPrompt()
                    end
                })
            end)
        elseif var11 == "AVATAR_FOCUS_ICON" and var5 == AvatarScreen.AvatarSwitcher and bool2 and var8 then
            var12 = task.delay(num2, function()
                var10("PROFILE_REDIRECT")
                var1.navigate(AvatarScreen.SlotsAvatarSwitcherFtuxPrompt, {
                    screenSize = screenSize,
                    onConfirm = function()
                        var10("FINISHED")
                        SlotBasedEditorAnalytics.trackSlotsAvatarSwitcherFtuxPrompt()
                    end
                })
            end)
        end

        return function()
            if var12 then
                task.cancel(var12)
            end
        end
    end, {
        var9,
        var10,
        var5,
        var8,
        screenLayout
    })
    return {
        enabled = var9() == "AVATAR_FOCUS_ICON" and var5 == AvatarScreen.AvatarEditor,
        menuItemId = MenuItemEnum.Main.AvatarSwitcher
    }
end

return useSlotCustomizeFtux
