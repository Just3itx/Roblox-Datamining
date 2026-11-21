-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local React = require(GameDetailParent.React)
local InputHandlers = require(GameDetailParent.InputHandlers)
local FocusNavigationUtils = require(GameDetailParent.FocusNavigationUtils)
local ReactFocusNavigation = require(GameDetailParent.ReactFocusNavigation)
local SduiSharedUtilities = require(GameDetailParent.SduiSharedUtilities)
local SduiFocusTags = SduiSharedUtilities.SduiFocusTags
local useInitialFocusOnTag = SduiSharedUtilities.useInitialFocusOnTag
local useSelectionOrderTracking = SduiSharedUtilities.useSelectionOrderTracking
local usePageButtonBindings = SduiSharedUtilities.usePageButtonBindings
local useOnNavigateBack = SduiSharedUtilities.useOnNavigateBack
local getSduiFocusActivationStore = SduiSharedUtilities.getSduiFocusActivationStore
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local FFlagLuaAppMediaGalleryGamepadSupport = require(GameDetailParent.SharedFlags).FFlagLuaAppMediaGalleryGamepadSupport

local CollectionService = game:GetService("CollectionService")

local tbl1 = {
    [Enum.KeyCode.ButtonX] = FocusNavigationEventNameEnum.Play,
    [Enum.KeyCode.ButtonY] = if FFlagLuaAppMediaGalleryGamepadSupport then nil else FocusNavigationEventNameEnum.DisplayStatsAndInfo,
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function findTaggedDescendant(statsSection: string, tbl2)
    local current = tbl2.current
    if not current then
        return nil
    end
    for _, value in CollectionService:GetTagged(statsSection) do
        if value:IsDescendantOf(current) then
            return value
        end
    end
    return nil
end

local function useExperienceDetailsFocusNavigation(func1: (...any) -> (...any))
    local var1 = React.useRef(nil)
    useInitialFocusOnTag(SduiFocusTags.PrimaryAction, var1)
    useSelectionOrderTracking(var1)

    local var2 = ReactFocusNavigation.useFocusGuiObject()

    local var3 = React.useCallback(function()
        getSduiFocusActivationStore().activate(SduiFocusTags.PrimaryAction)
    end, {})

    local var4 = React.useCallback(function()
        local taggedDescendant = findTaggedDescendant(SduiFocusTags.StatsSection, var1)
        if taggedDescendant then
            var2(taggedDescendant)
        end
    end, { var2, var1 })

    local var5 = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.Play] = {
                handler = InputHandlers.onRelease(var3)
            },
            [FocusNavigationEventNameEnum.DisplayStatsAndInfo] = not FFlagLuaAppMediaGalleryGamepadSupport and {
                handler = InputHandlers.onRelease(var4)
            } or nil
        }
    end, { var3, var4 })

    local var6 = usePageButtonBindings(var1, tbl1, var5)
    local var7 = useOnNavigateBack(func1, var6)

    return (React.useCallback(function(current)
        var1.current = current
        if type(var7) == "function" then
            var7(current)
        elseif var7 ~= nil then
            var7.current = current
        end
    end, { var7 }))
end

return useExperienceDetailsFocusNavigation
