-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)

local ReactFocusNavigation = require(ServerDrivenUiParent.ReactFocusNavigation)
local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)

return React.memo(function(tbl1) -- name: SduiFocusNavActions
    local keys = tbl1.focusNavActions.keys
    local events = tbl1.focusNavActions.events
    local var1 = React.useMemo(function()
        return if tbl1.guiObject then tbl1.guiObject else GuiService.SelectedCoreObject
    end, { tbl1.guiObject })

    local var2 = ReactFocusNavigation.useEventMap(keys)

    local var3 = ReactFocusNavigation.useEventHandlerMap(events, var2)

    React.useEffect(function()
        if var3 then
            var3(var1)
        end
        return function()
            var3(nil)
        end
    end, { var3, var1 })

    return nil
end)
