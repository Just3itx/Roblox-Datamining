-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local React = require(scriptParentParentParentParentParent.React)
local useForwardRef = require(scriptParentParentParentParentParent.ReactUtils).useForwardRef
local ControlState = require(scriptParentParentParentParent.Core.Control.Enum.ControlState)
local ControlStateEvent = require(scriptParentParentParentParent.Core.Control.Enum.ControlStateEvent)

local createGuiControlStateTable = require(scriptParentParentParentParent.Core.Control.createGuiControlStateTable)

local function useGuiControlState(arg1, callback, current: boolean)
    local var1 = React.useRef(ControlState.Initialize)
    local var2 = React.useRef(current)

    local var3 = React.useRef(false)

    local var4 = React.useCallback(function(arg2, current2)
        var1.current = current2
        callback(arg2, current2)
    end, { callback })

    local var5 = React.useMemo(function()
        return createGuiControlStateTable(var4)
    end, {})

    React.useEffect(function()
        var5:onStateChange(var4)
    end, { var4 })

    local var6 = React.useCallback(function(arg2)
        local tbl1 = {}
        if arg2 then
            local inputBegan = arg2.InputBegan

            table.insert(tbl1, inputBegan:Connect(function(input: InputObject)
                if not var2.current then
                    return nil
                end

                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch
                    or input.KeyCode == Enum.KeyCode.ButtonA
                    or input.KeyCode == Enum.KeyCode.Return
                then
                    var5.events[ControlStateEvent.PrimaryPressed]()
                end
            end))

            local inputEnded = arg2.InputEnded

            table.insert(tbl1, inputEnded:Connect(function(input: InputObject)
                if not var2.current then
                    return nil
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    var5.events[ControlStateEvent.PrimaryReleasedHover]()
                elseif input.UserInputType == Enum.UserInputType.Touch
                    or input.KeyCode == Enum.KeyCode.ButtonA
                    or input.KeyCode == Enum.KeyCode.Return
                then
                    var5.events[ControlStateEvent.PrimaryReleased]()
                end
            end))

            local selectionGained = arg2.SelectionGained

            table.insert(tbl1, selectionGained:Connect(function()
                if not var2.current then
                    return nil
                end
                var5.events[ControlStateEvent.SelectionGained]()
            end))

            local selectionLost = arg2.SelectionLost

            table.insert(tbl1, selectionLost:Connect(function()
                if not var2.current then
                    return nil
                end
                var5.events[ControlStateEvent.SelectionLost]()
            end))

            local mouseEnter = arg2.MouseEnter

            table.insert(tbl1, mouseEnter:Connect(function()
                if not var2.current then
                    return nil
                end
                var3.current = true
                var5.events[ControlStateEvent.PointerHover]()
            end))

            local mouseLeave = arg2.MouseLeave

            table.insert(tbl1, mouseLeave:Connect(function()
                if not var2.current then
                    return nil
                end
                var3.current = false
                var5.events[ControlStateEvent.PointerHoverEnd]()
            end))
        end

        return function()
            for _, value in ipairs(tbl1) do
                value:Disconnect()
            end
        end
    end, { var5, var3 })

    React.useEffect(function()
        var2.current = current
    end, { current })

    return useForwardRef(arg1, var6), var5
end

return useGuiControlState
