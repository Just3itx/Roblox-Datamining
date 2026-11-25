-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local useSelectionActivateAction = require(script.Parent.FocusNavigation.useSelectionActivateAction)

local function useChatWindowEntryHandoff(tbl1)
    local var1 = tbl1.guiService or GuiService
    local enabled = tbl1.enabled
    local windowInstance = tbl1.windowInstance
    local focusTargetRef = tbl1.focusTargetRef

    local var2 = React.useRef(tbl1.setSelection)
    var2.current = tbl1.setSelection

    React.useEffect(function()
        if not enabled or windowInstance == nil then
            return
        end

        local selectable = windowInstance.Selectable
        windowInstance.Selectable = true
        return function()
            windowInstance.Selectable = selectable
            if focusTargetRef.current == nil or var1.SelectedCoreObject ~= focusTargetRef.current then
                return
            end

            var1.SelectedCoreObject = nil
            if windowInstance:IsDescendantOf(game) then
                var1.SelectedObject = windowInstance
            end
        end
    end, {
        enabled,
        windowInstance,
        focusTargetRef,
        var1
    })
    local onAction = React.useCallback(function(userInputState): Enum.ContextActionResult
        if userInputState == Enum.UserInputState.Begin then
            local current = focusTargetRef.current
            if current ~= nil then
                local current2 = var2.current
                if current2 then
                    current2(current)
                else
                    var1.SelectedCoreObject = current
                end
            end
            var1.SelectedObject = nil
        end

        return Enum.ContextActionResult.Sink
    end, { var1, focusTargetRef })

    local shouldBind = React.useCallback(function(): boolean
        return var1.SelectedObject == windowInstance
    end, { var1, windowInstance })

    local rebindSignal = React.useMemo(function()
        if windowInstance ~= nil then
            return (var1:GetPropertyChangedSignal("SelectedObject"))
        end

        return nil
    end, { var1, windowInstance })

    useSelectionActivateAction({
        enabled = enabled,
        active = windowInstance ~= nil,
        actionNamePrefix = "EnterTextChannelWindow",
        onAction = onAction,
        shouldBind = shouldBind,
        rebindSignal = rebindSignal,
        contextActionService = tbl1.contextActionService
    })
end

return useChatWindowEntryHandoff
