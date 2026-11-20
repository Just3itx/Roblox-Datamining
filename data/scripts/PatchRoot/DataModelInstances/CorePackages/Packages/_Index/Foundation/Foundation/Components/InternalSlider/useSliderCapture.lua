-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Services = require(Foundation.Utility.Wrappers.Services)
local GuiService = Services.GuiService
local RunService = Services.RunService

local ControlState = require(Foundation.Enums.ControlState)

local InputMode = require(Foundation.Utility.Input.InputMode)

local getSelectionEntryDirection = require(Foundation.Components.Slider.getSelectionEntryDirection)
local useSliderCaptureKeys = require(Foundation.Components.Slider.useSliderCaptureKeys)

local useSliderDirectionalInput = require(script.Parent.useSliderDirectionalInput)
local _useSliderThumbs = require(script.Parent.useSliderThumbs)

local function useSliderCapture(tbl1)
    local thumbsLen = #tbl1.thumbs

    local controlState, var2 = React.useState(ControlState.Initialize)
    local var3, var4 = React.useState(false)
    local var5, setActiveIndex = React.useState(1)
    local activeThumbIndex = math.min(var5, thumbsLen)

    local focusTargetRef = React.useRef(nil)
    local captureTargetRef = React.useRef(nil)
    local var9 = React.useRef(false)
    local var10 = React.useRef(false)
    local var11 = React.useRef(tbl1.lastInputMode)

    local isSelected = var3 or controlState == ControlState.Selected or controlState == ControlState.SelectedPressed

    local var13 = React.useCallback(function()
        if not var3 then
            var4(true)
        elseif thumbsLen > 1 then
            setActiveIndex(activeThumbIndex % thumbsLen + 1)
        end
    end, { var3, thumbsLen, activeThumbIndex })
    useSliderCaptureKeys(isSelected and not tbl1.isDisabled, var13)

    local onExit = React.useCallback(function()
        var4(false)
        GuiService.SelectedObject = focusTargetRef.current
    end, {})

    React.useEffect(function()
        if tbl1.isDisabled then
            var4(false)
        end
    end, { tbl1.isDisabled })

    React.useEffect(function()
        local bool1 = tbl1.lastInputMode ~= var11.current
        var11.current = tbl1.lastInputMode

        if var3 and bool1 and tbl1.lastInputMode ~= nil and tbl1.lastInputMode ~= InputMode.Directional then
            var4(false)
        end
    end, { var3, tbl1.lastInputMode })

    React.useEffect(function()
        if var3 == var10.current then
            return
        end
        var10.current = var3
        if var3 then
            if tbl1.onCaptureStarted then
                tbl1.onCaptureStarted()
            end
        elseif tbl1.onCaptureEnded then
            tbl1.onCaptureEnded()
        end
    end, { var3, tbl1.onCaptureStarted, tbl1.onCaptureEnded })

    local var15 = React.useRef(tbl1.onCaptureEnded)
    var15.current = tbl1.onCaptureEnded
    React.useEffect(function()
        return function()
            if var10.current and var15.current then
                var15.current()
            end
        end
    end, {})

    React.useEffect(function()
        local function redirectDragSelection() -- Luacid: Inlined by compiler; 1 call site recovered
            local selectedObject = GuiService.SelectedObject
            local isDescendantOf

            if selectedObject == tbl1.rootRef.current then
                isDescendantOf = true
            elseif selectedObject == nil or tbl1.rootRef.current == nil then
                isDescendantOf = false
            else
                isDescendantOf = selectedObject:IsDescendantOf(tbl1.rootRef.current)

                if isDescendantOf then
                    if selectedObject == focusTargetRef.current then
                        isDescendantOf = false
                    else
                        isDescendantOf = selectedObject ~= captureTargetRef.current
                    end
                end
            end

            if isDescendantOf then
                GuiService.SelectedObject = focusTargetRef.current
            end
        end

        redirectDragSelection()
        local connection = GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(redirectDragSelection)
        return function()
            connection:Disconnect()
        end
    end, { tbl1.rootRef })

    React.useEffect(function()
        if not var3 then
            return
        end

        local current = captureTargetRef.current
        GuiService.SelectedObject = current

        local connection = nil
        if GuiService.SelectedObject ~= current then
            local num2 = 0
            connection = RunService.Heartbeat:Connect(function()
                num2 += 1
                GuiService.SelectedObject = current
                if (GuiService.SelectedObject == current or num2 >= 10) and connection then
                    connection:Disconnect()
                    connection = nil
                end
            end)
        end

        local connection2 = GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(function()
            if GuiService.SelectedObject ~= captureTargetRef.current and connection == nil then
                var4(false)
            end
        end)
        return function()
            connection2:Disconnect()
            if connection then
                connection:Disconnect()
            end

            if current ~= nil and GuiService.SelectedObject == current then
                GuiService.SelectedObject = focusTargetRef.current
            end
        end
    end, { var3 })

    local var16 = React.useMemo(function()
        return {
            getValue = function()
                return tbl1.thumbs[activeThumbIndex].value:getValue()
            end,
            onStep = function(num2: number)
                tbl1.updateThumbValue(activeThumbIndex, tbl1.clampToNeighbors(activeThumbIndex, num2))
            end,
            onExit = onExit
        }
    end, {
        tbl1.thumbs,
        activeThumbIndex,
        tbl1.updateThumbValue,
        tbl1.clampToNeighbors,
        onExit
    })
    useSliderDirectionalInput(var3 and not tbl1.isDisabled, tbl1.step, tbl1.range, tbl1.isVertical, var16)

    return {
        controlState = controlState,
        isCaptured = var3,
        isSelected = isSelected,
        activeThumbIndex = activeThumbIndex,
        setActiveIndex = setActiveIndex,
        onStateChanged = React.useCallback(function(arg1)
            var2(arg1)

            local current = arg1 == ControlState.Selected or arg1 == ControlState.SelectedPressed
            if thumbsLen > 1 and current and not var9.current then
                setActiveIndex(if getSelectionEntryDirection(tbl1.isVertical) < 0 then thumbsLen else 1)
            end
            var9.current = current
        end, { thumbsLen, tbl1.isVertical }),
        focusTargetRef = focusTargetRef,
        captureTargetRef = captureTargetRef
    }
end

return useSliderCapture
