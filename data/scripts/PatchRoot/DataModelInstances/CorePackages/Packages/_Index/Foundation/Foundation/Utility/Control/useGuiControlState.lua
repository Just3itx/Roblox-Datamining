-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:10:48Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local useForwardRef = require(FoundationParent.ReactUtils).useForwardRef
local ControlState = require(Foundation.Enums.ControlState)
local _ControlStateEvent = require(Foundation.Enums.ControlStateEvent)
local Flags = require(Foundation.Utility.Flags)
local _Types = require(Foundation.Components.Types)

local tbl1 = {
    [Enum.GuiState.Idle] = ControlState.Default,
    [Enum.GuiState.Hover] = ControlState.Hover,
    [Enum.GuiState.Press] = ControlState.Pressed,
    [Enum.GuiState.NonInteractable] = ControlState.Disabled
}

local function assignRef(arg1, current) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) == "function" then
        arg1(current)
    elseif arg1 ~= nil then
        arg1.current = current
    end
end

local function setControlState(current, arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    if current.isSelected then
        if arg1 == ControlState.Default or arg1 == ControlState.Hover then
            arg1 = ControlState.Selected
        elseif arg1 == ControlState.Pressed then
            arg1 = ControlState.SelectedPressed
        end
    end

    if current.controlState == arg1 then
        return
    end

    current.controlState = arg1

    if current.onStateChanged ~= nil then
        current.onStateChanged(arg1)
    end
end

return if Flags.FoundationLightweightGuiControlState then function(arg1, onStateChanged) -- name: useGuiControlState
    local var1 = React.useRef(nil)
    if var1.current == nil then
        var1.current = {
            isSelected = false,
            controlState = ControlState.Initialize,
            onStateChanged = onStateChanged,
            connections = nil
        }
    end

    var1.current.onStateChanged = onStateChanged

    return React.useCallback(function(current)
        local current2 = var1.current
        assignRef(arg1, current)

        local connections = current2.connections
        if connections ~= nil then
            for _, connection in connections do
                connection:Disconnect()
            end
            current2.connections = nil
        end

        if current == nil then
            return
        end

        setControlState(current2, tbl1[current.GuiState])

        current2.connections = {
            current:GetPropertyChangedSignal("GuiState"):Connect(function()
                setControlState(current2, tbl1[current.GuiState])
            end),
            current.SelectionGained:Connect(function()
                current2.isSelected = true
                setControlState(current2, current2.controlState)
            end),
            current.SelectionLost:Connect(function()
                current2.isSelected = false
                setControlState(current2, current2.controlState)
            end)
        }
    end, { arg1 })
end else function(arg1, callback) -- name: useGuiControlState_DEPRECATED
    local var1 = React.useRef(false)
    local var2 = React.useRef(ControlState.Initialize)

    local var3 = React.useCallback(function(arg2)
        local current = var2.current

        if var1.current then
            if arg2 == ControlState.Default or arg2 == ControlState.Hover then
                arg2 = ControlState.Selected
            elseif arg2 == ControlState.Pressed then
                arg2 = ControlState.SelectedPressed
            end
        end

        if current == arg2 then
            return
        end

        var2.current = arg2

        if callback ~= nil then
            callback(arg2)
        end
    end, { callback })

    local var4 = React.useCallback(function(arg2)
        local tbl2 = {}
        if arg2 then
            var3(tbl1[arg2.GuiState])

            local guiStateChanged = arg2:GetPropertyChangedSignal("GuiState")

            table.insert(tbl2, guiStateChanged:Connect(function()
                local var4 = tbl1[arg2.GuiState]
                var3(var4)
            end))

            local selectionGained = arg2.SelectionGained

            table.insert(tbl2, selectionGained:Connect(function()
                var1.current = true
                var3(var2.current)
            end))

            local selectionLost = arg2.SelectionLost

            table.insert(tbl2, selectionLost:Connect(function()
                var1.current = false
                var3(var2.current)
            end))
        end

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, { var3 })

    return useForwardRef(arg1, var4)
end
