-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)

local function autoFocusNavigation(arg1, _: number?)
    return function(arg2)
        local ref = React.useRef(nil)
        local tbl1 = { nil }
        local var2 = FocusNavigationUtils.useAutoFocus(tbl1, 0.1)
        local var3 = React.useContext(ReactFocusNavigation.FocusNavigationContext)
        React.useEffect(function()
            tbl1[1] = ref.current
            local var4 = if var3 and var3.focusedGuiObject:getValue() ~= nil and var2 then var2() else nil

            return function()
                if var4 then
                    var4.cancel()
                end
            end
        end, { var2 })
        return React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Selectable = false,
                ref = ref
            },
            {
                content = React.createElement(arg1, arg2)
            }
        )
    end
end
return autoFocusNavigation
