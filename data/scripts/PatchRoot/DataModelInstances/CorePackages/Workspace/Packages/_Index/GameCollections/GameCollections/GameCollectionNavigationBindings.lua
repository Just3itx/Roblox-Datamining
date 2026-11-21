-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent
local React = require(GameCollectionsParent.React)
local ReactFocusNavigation = require(GameCollectionsParent.ReactFocusNavigation)
local InputHandlers = require(GameCollectionsParent.InputHandlers)
local FocusNavigationEventNameEnum = require(GameCollectionsParent.FocusNavigationUtils).FocusNavigationEventNameEnum

local tbl1 = {
    [Enum.KeyCode.ButtonX] = FocusNavigationEventNameEnum.SeeAll,
    [Enum.KeyCode.ButtonA] = FocusNavigationEventNameEnum.HoldToPlay
}

local module = {}

local function useControllerBarFocusNavigationBindings<T>(func1: ((...any) -> (...any))?, handler: ((...any) -> (...any))?)
    local var1 = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.SeeAll] = func1 and {
                handler = InputHandlers.onRelease(func1)
            } or nil,
            [FocusNavigationEventNameEnum.HoldToPlay] = handler and { handler = handler } or nil
        }
    end, { func1, handler })

    local var2 = ReactFocusNavigation.useEventMap(tbl1)
    return ReactFocusNavigation.useEventHandlerMap(var1, var2)
end

module.useControllerBarFocusNavigationBindings = useControllerBarFocusNavigationBindings

function module.OnSeeAllControllerBarNavigateWrapper(tbl2)
    local ref = useControllerBarFocusNavigationBindings(tbl2.onSeeAll)

    return React.createElement(
        "Frame",
        {
            ref = ref,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1
        },
        tbl2.children
    )
end

return module
