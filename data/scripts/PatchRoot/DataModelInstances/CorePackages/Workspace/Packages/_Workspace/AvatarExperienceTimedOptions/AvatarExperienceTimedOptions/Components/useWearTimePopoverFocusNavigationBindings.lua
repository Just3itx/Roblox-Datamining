-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:11:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local AvatarExperienceTimedOptionsParent = script:FindFirstAncestor("AvatarExperienceTimedOptions").Parent

local React = require(AvatarExperienceTimedOptionsParent.React)
local ReactFocusNavigation = require(AvatarExperienceTimedOptionsParent.ReactFocusNavigation)
local FocusNavigationUtils = require(AvatarExperienceTimedOptionsParent.FocusNavigationUtils)
local InputHandlers = require(AvatarExperienceTimedOptionsParent.InputHandlers)
local AvatarExperienceFlags = require(AvatarExperienceTimedOptionsParent.AvatarExperienceFlags)

local PopoverFocusRestorationContext = require(script.Parent.PopoverFocusRestorationContext)

local FFlagAXTimedOptionsPopoverSkipFocusOnCursor = AvatarExperienceFlags.FFlagAXTimedOptionsPopoverSkipFocusOnCursor

local useFocusNavigableSurfaceRegistryConnection = FocusNavigationUtils.useFocusNavigableSurfaceRegistryConnection
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local getFirstFocusableDescendant = FocusNavigationUtils.getFirstFocusableDescendant
local useLastInputMode = FocusNavigationUtils.useLastInputMode

local tbl1 = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack
}

local function useWearTimePopoverFocusNavigationBindings(callback: (...any) -> (...any), bool1: boolean, tbl2)
    local var1 = React.useRef(nil)
    local current, var3 = React.useState(false)
    local var4 = React.useContext(PopoverFocusRestorationContext)

    React.useEffect(function()
        var3(bool1)
    end, { bool1 })

    useFocusNavigableSurfaceRegistryConnection(var1 and var1.current, FocusNavigableSurfaceIdentifierEnum.PopUp, current)
    local var5 = if FFlagAXTimedOptionsPopoverSkipFocusOnCursor then useLastInputMode() else nil
    local var6 = React.useRef(false)
    React.useEffect(function()
        local bool2 = not FFlagAXTimedOptionsPopoverSkipFocusOnCursor or var5 == "Focus"
        if current and not var6.current then
            if bool2 then
                local current = var1.current
                if current and current:IsDescendantOf(game) then
                    local selectedCoreObject = getFirstFocusableDescendant(current)
                    if selectedCoreObject then
                        GuiService.SelectedCoreObject = selectedCoreObject
                    end
                end
            end
        elseif not current and var6.current and var4 and bool2 then
            local current = tbl2 and tbl2.current
            if current and current:IsDescendantOf(game) then
                GuiService.SelectedCoreObject = current
            end
        end
        var6.current = current
    end, {
        current,
        var4,
        tbl2,
        var5
    })
    local var7 = ReactFocusNavigation.useEventMap(tbl1, var1)
    local var8 = React.useMemo(function()
        local result = {}
        result[FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(function(arg1)
                arg1.cancelled = true
                callback()
            end)
        }
        return result
    end, { callback })

    return ReactFocusNavigation.useEventHandlerMap(var8, var7)
end

return useWearTimePopoverFocusNavigationBindings
