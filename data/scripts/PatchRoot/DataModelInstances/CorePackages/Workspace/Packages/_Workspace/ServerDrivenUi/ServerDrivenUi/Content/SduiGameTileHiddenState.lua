-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local Foundation = require(ServerDrivenUiParent.Foundation)
local React = require(ServerDrivenUiParent.React)
local ReactFocusNavigation = require(ServerDrivenUiParent.ReactFocusNavigation)
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)

local View = Foundation.View
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper
local useFocusGuiObject = ReactFocusNavigation.useFocusGuiObject

return React.memo(function(tbl1) -- name: SduiGameTileHiddenState
    local buttonRef = React.useRef(nil)
    local var2 = useFocusGuiObject()

    local onActivated = React.useCallback(function()
        if not tbl1.onUndoActivated then
            return
        end

        local bool1 = GuiService.SelectedCoreObject == buttonRef.current

        tbl1.onUndoActivated()

        if not bool1 then
            return
        end

        task.defer(function()
            local current = if tbl1.parentRef then tbl1.parentRef.current else nil

            if current then
                var2(current)
            end
        end)
    end, { var2, tbl1.onUndoActivated, tbl1.parentRef })

    local undoButton = if tbl1.undoButtonComponent and tbl1.onUndoActivated then React.createElement(
        getSduiComponentWrapper(tbl1.undoButtonComponent),
        {
            componentConfig = tbl1.undoButtonComponent,
            debugName = "SduiGameTileHiddenState.UndoButton",
            extraLocalProps = {
                buttonRef = buttonRef,
                onActivated = onActivated,
                testId = "--sdui-game-tile-undo"
            },
            sduiContext = tbl1.sduiContext
        }
    ) else nil
    return React.createElement(View, {
        tag = tbl1.containerTag
            or "col align-x-center align-y-center gap-small size-full padding-medium radius-medium bg-surface-100"
    }, {
        Message = tbl1.messageComponent,
        UndoButton = undoButton
    })
end)
