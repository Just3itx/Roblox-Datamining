-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local BuilderIcons = require(MomentsParent.BuilderIcons)
local FocusNavigationUtils = require(MomentsParent.FocusNavigationUtils)
local _Foundation = require(MomentsParent.Foundation)
local InputHandlers = require(MomentsParent.InputHandlers)
local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)
local ReactFocusNavigation = require(MomentsParent.ReactFocusNavigation)

local Image = BuilderIcons.Icon.Image
local FrameVideoCamera = BuilderIcons.Icon.FrameVideoCamera

local useLocalization = Localization.Hooks.useLocalization
local useToggleState = MomentsCommon.Hooks.useToggleState
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusOnMount = FocusNavigationUtils.useFocusOnMount
local useFocusRoot = FocusNavigationUtils.useFocusRoot

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local tbl2 = {
    gallery = "Feature.Captures.Title.Gallery",
    myAvatars = "Feature.Avatar.Label.Title.MyAvatars"
}

local function useCreationMenuViewModel(tbl3)
    local var1 = useLocalization(tbl2)
    local var2 = useToggleState()
    local disable = var2.disable

    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    disable()
                    arg1:cancel()
                end)
            }
        }
    end, { disable })
    local var4 = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ContextualMenu,
        isFocusable = var2.enabled,
        isAutoFocusRoot = true,
        shouldRestoreFocus = false,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })
    local var5, menuRef = ReactFocusNavigation.useDefaultFocusBehavior(var4)
    local ref = useFocusOnMount(var5)

    local onToggle = React.useCallback(function()
        if tbl3.onTriggerActivated ~= nil then
            tbl3.onTriggerActivated()
        end
        if var2.enabled then
            var2.disable()
            return
        end
        var2.enable()
    end, {
        tbl3.onTriggerActivated,
        var2.enabled,
        var2.enable,
        var2.disable
    })

    local onActivated = React.useCallback(function()
        var2.disable()
        tbl3.onCreateFromCaptures()
    end, { var2.disable, tbl3.onCreateFromCaptures })

    local var3 = React.useCallback(function()
        var2.disable()
        tbl3.onCreateFromAvatar()
    end, { var2.disable, tbl3.onCreateFromAvatar })

    local items = React.useMemo(function()
        return {
            {
                id = "gallery",
                icon = Image,
                ref = ref,
                text = var1.gallery,
                onActivated = onActivated
            },
            {
                id = "myAvatars",
                icon = FrameVideoCamera,
                text = var1.myAvatars,
                onActivated = var3
            }
        }
    end, {
        var1,
        onActivated,
        var3,
        ref
    })
    return {
        isOpen = var2.enabled,
        items = items,
        menuRef = menuRef,
        onToggle = onToggle,
        onPressedOutside = disable
    }
end

return useCreationMenuViewModel
