-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent

local React = require(SduiSharedUtilitiesParent.React)
local ReactFocusNavigation = require(SduiSharedUtilitiesParent.ReactFocusNavigation)
local InputHandlers = require(SduiSharedUtilitiesParent.InputHandlers)
local FocusNavigationEventNameEnum = require(SduiSharedUtilitiesParent.FocusNavigationUtils).FocusNavigationEventNameEnum

local module = {}

local function useOnNavigateBack(callback: (...any) -> (...any), arg1)
    local var1 = React.useCallback(InputHandlers.onRelease(function(arg2)
        arg2:cancel()
        callback()
    end), { callback })

    return ReactFocusNavigation.useEventHandler(FocusNavigationEventNameEnum.NavigateBack, var1, nil, arg1)
end

module.useOnNavigateBack = useOnNavigateBack

function module.OnNavigateBackWrapper(tbl1)
    local ref = useOnNavigateBack(tbl1.onNavigateBack)

    return React.createElement(
        "Frame",
        {
            ref = ref,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1
        },
        tbl1.children
    )
end

return module
