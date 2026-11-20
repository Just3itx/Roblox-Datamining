-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParent.t)
local RoactGamepad = require(scriptParentParentParentParent.RoactGamepad)
local ImageSetComponent = require(scriptParentParent.ImageSet.ImageSetComponent)

local useCursorByType = require(scriptParentParentParent.App.SelectionCursor.useCursorByType)
local CursorType = require(scriptParentParentParent.App.SelectionCursor.CursorType)
local lerp = require(scriptParentParentParent.Utility.lerp)
local withSelectionCursorProvider = require(scriptParentParentParent.App.SelectionImage.withSelectionCursorProvider)

local var1 = Roact.PureComponent:extend("GenericSlider")

var1.validateProps = t.strictInterface({
    lowerValue = t.number,
    upperValue = t.optional(t.number),
    min = t.number,
    max = t.number,
    stepInterval = t.numberPositive,
    isDisabled = t.optional(t.boolean),
    onValueChanged = t.callback,
    onDragStartLower = t.optional(t.callback),
    onDragStartUpper = t.optional(t.callback),
    onDragEnd = t.optional(t.callback),
    trackImage = t.union(t.string, t.table),
    trackColor = t.union(t.Color3, t.table),
    trackTransparency = t.union(t.number, t.table),
    trackSliceCenter = t.optional(t.Rect),
    trackFillImage = t.union(t.string, t.table),
    trackFillColor = t.union(t.Color3, t.table),
    trackFillTransparency = t.union(t.number, t.table),
    trackFillSliceCenter = t.optional(t.Rect),
    knobImage = t.union(t.string, t.table),
    knobColorLower = t.union(t.Color3, t.table),
    knobColorUpper = t.optional(t.union(t.Color3, t.table)),
    knobTransparency = t.union(t.number, t.table),
    knobImagePadding = t.optional(t.numberMin(0)),
    knobShadowImage = t.union(t.string, t.table),
    knobShadowTransparencyLower = t.union(t.number, t.table),
    knobShadowTransparencyUpper = t.optional(t.union(t.number, t.table)),
    width = t.optional(t.UDim),
    position = t.optional(t.UDim2),
    anchorPoint = t.optional(t.Vector2),
    layoutOrder = t.optional(t.integer),
    imageButtonRef = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    focusController = t.optional(t.table),
    containerRef = t.optional(t.table),
    customTrack = t.optional(t.table),
    customKnobHeight = t.optional(t.number),
    customKnobBorderColor = t.optional(t.Color3),
    customKnobBorderSize = t.optional(t.number),
    selectedCursor = t.table,
    unselectedCursor = t.table
})

var1.defaultProps = {
    width = UDim.new(1, 0),
    knobImagePadding = 0,
    customKnobBorderColor = Color3.new(0, 0, 0)
}

function var1.init(arg1)
    arg1.rootRef = arg1.props.imageButtonRef or Roact.createRef()
    arg1.lowerKnobRef = Roact.createRef()
    arg1.upperKnobRef = Roact.createRef()
    arg1.moveDirection = 0

    arg1.lowerKnobDrag = false
    arg1.upperKnobDrag = false
    arg1.totalMoveTime = 0
    arg1.isFirstMove = true
    arg1.unhandledTime = 0

    arg1.state = { lowerKnobIsSelected = false, upperKnobIsSelected = false }
end

function var1.getKnobVisibleHeight(arg1)
    if arg1.props.customKnobHeight then
        return (44 - arg1.props.knobImagePadding * 2) / 44 * arg1.props.customKnobHeight
    end

    return 44 - arg1.props.knobImagePadding * 2
end

function var1.getKnobHeight(arg1)
    if arg1.props.customKnobHeight then
        return 44 / (44 - arg1.props.knobImagePadding * 2) * arg1.props.customKnobHeight
    end

    return 44
end

function var1.onMoveStep(arg1, arg2, arg3)
    if not (arg1.state.lowerKnobIsSelected or arg1.state.upperKnobIsSelected) then
        return
    end

    local position = arg2[Enum.KeyCode.Thumbstick1].Position
    local bool1 = position.Magnitude > 0.2
    local num1 = 0

    arg1.totalMoveTime += arg3
    local var2, num2, num3

    if bool1 then
        var2 = if position.x > 0 then 1 else -1
        num2 = 0.2
        num3 = 12
    else
        var2 = (if arg2[Enum.KeyCode.DPadLeft].UserInputState == Enum.UserInputState.Begin then -1 else 0) + (if arg2[Enum.KeyCode.DPadRight].UserInputState == Enum.UserInputState.Begin then 1 else 0)
        num2 = 0.5
        num3 = 8
    end

    if var2 == 0 then
        arg1.totalMoveTime = 0
        arg1.isFirstMove = true
    elseif arg1.isFirstMove then
        arg1.isFirstMove = false
        arg1.totalMoveTime = 0
        arg1.unhandledTime = 0
        num1 = 1
    elseif num2 < arg1.totalMoveTime then
        local var3 = arg3 - math.max(num2 - arg1.totalMoveTime - arg3, 0) + arg1.unhandledTime
        num1 = math.floor(num3 * var3)

        arg1.unhandledTime = var3 - num1 / num3
    else
        arg1.unhandledTime = 0
        num1 = 0
    end

    if num1 > 0 then
        arg1:processGamepadInput(var2, num1)
    end
end

function var1.processGamepadInput(arg1, arg2, arg3)
    if arg1:hasTwoKnobs() then
        arg1:processTwoKnobGamepadInput(arg2, arg3)
        return
    end
    arg1:processOneKnobGamepadInput(arg2, arg3)
end

function var1.processTwoKnobGamepadInput(arg1, arg2, arg3)
    local var2 = arg1.props.stepInterval * arg2
    local lowerValue = arg1.props.lowerValue
    local upperValue = arg1.props.upperValue

    if lowerValue == upperValue and not arg1.state.processingGamepad then
        if arg1.state.lowerKnobIsSelected and arg2 == 1 and lowerValue ~= arg1.props.max then
            arg1:setState({ lowerKnobIsSelected = false, upperKnobIsSelected = true, processingGamepad = true })

            arg1.props.focusController.moveFocusTo(arg1.upperKnobRef)
        elseif arg1.state.upperKnobIsSelected and arg2 == -1 and upperValue ~= arg1.props.min then
            arg1:setState({ lowerKnobIsSelected = true, upperKnobIsSelected = false, processingGamepad = true })

            arg1.props.focusController.moveFocusTo(arg1.lowerKnobRef)
        end
    elseif not arg1.state.processingGamepad then
        arg1:setState({ processingGamepad = true })
    end

    if arg1.state.lowerKnobIsSelected then
        lowerValue = math.max(math.min(lowerValue + var2 * arg3, arg1.props.max), arg1.props.min)
        if not (lowerValue <= upperValue) then
            lowerValue = upperValue
        end
    elseif arg1.state.upperKnobIsSelected then
        upperValue = math.max(math.min(upperValue + var2 * arg3, arg1.props.max), arg1.props.min)
        if not (lowerValue <= upperValue) then
            upperValue = lowerValue
        end
    end

    if upperValue ~= arg1.props.upperValue or lowerValue ~= arg1.props.lowerValue then
        arg1.props.onValueChanged(lowerValue, upperValue)
    end
end

function var1.processOneKnobGamepadInput(arg1, arg2, arg3)
    local var2 = arg1.props.stepInterval * arg2
    local lowerValue = arg1.props.lowerValue

    if arg1.state.lowerKnobIsSelected then
        lowerValue = math.max(math.min(lowerValue + var2 * arg3, arg1.props.max), arg1.props.min)
    end

    if lowerValue ~= arg1.props.lowerValue then
        arg1.props.onValueChanged(lowerValue)
    end
end

function var1.renderTrack(arg1, size, arg2, xScale: number?)
    if arg1.props.customTrack then
        return arg1.props.customTrack
    end
    return Roact.createElement(ImageSetComponent.Label, {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        ImageColor3 = arg1.props.trackColor,
        ImageTransparency = arg1.props.trackTransparency,
        Image = arg1.props.trackImage,
        Size = UDim2.new(1, 0, 0, 4),
        Position = UDim2.fromScale(0.5, 0.5),
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = arg1.props.trackSliceCenter
    }, {
        TrackFill = Roact.createElement(ImageSetComponent.Label, {
            BackgroundTransparency = 1,
            ImageColor3 = arg1.props.trackFillColor,
            ImageTransparency = arg1.props.trackFillTransparency,
            Image = arg1.props.trackFillImage,
            Size = size,
            Position = arg2 and UDim2.new(xScale, 0, 0, 0) or UDim2.new(0, 0, 0, 0),
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = arg1.props.trackFillSliceCenter
        })
    })
end

function var1.wrapKnobWithBorder(arg1, knobContent, position)
    local var2 = if arg1.props.customKnobHeight then arg1.props.customKnobHeight else arg1:getKnobVisibleHeight()
    return Roact.createElement(
        "Frame",
        {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.fromOffset(var2, var2),
            Position = position,
            BackgroundColor3 = arg1.props.customKnobBorderColor,
            ZIndex = 3
        },
        {
            UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
            KnobContent = knobContent
        }
    )
end

function var1.renderUpperKnob(arg1, arg2, arg3, arg4, _)
    if not arg4 then
        return nil
    end

    local knobHeight = arg1:getKnobHeight()
    local scale

    if arg1.props.customKnobBorderSize and arg1.props.customKnobBorderSize > 0 then
        knobHeight -= 2 * (arg1.props.customKnobBorderSize + 2)
        scale = UDim2.fromScale(0.5, 0.5)
    else
        scale = arg2
    end

    local createElement = Roact.createElement
    local var2 = RoactGamepad.Focusable[ImageSetComponent.Button]
    local tbl1 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        ImageColor3 = arg1.props.knobColorUpper,
        ImageTransparency = arg1.props.knobTransparency,
        Image = arg1.props.knobImage,
        Size = UDim2.fromOffset(knobHeight, knobHeight),
        Position = scale,
        ZIndex = 3,
        NextSelectionLeft = if arg3 or arg1.props.upperValue == arg1.props.lowerValue then nil else arg1.lowerKnobRef or nil,
        NextSelectionRight = if arg3 then arg1.upperKnobRef or nil else nil,
        NextSelectionUp = if arg3 then arg1.upperKnobRef or nil else nil,
        NextSelectionDown = if arg3 then arg1.upperKnobRef or nil else nil,
        SelectionImageObject = arg3 and arg1.props.selectedCursor or arg1.props.unselectedCursor,
        [Roact.Ref] = arg1.upperKnobRef
    }

    tbl1[Roact.Event.InputBegan] = function(_, arg5)
        if arg1.props.isDisabled then
            return
        end

        arg1:onInputBegan(arg5, true)
    end
    tbl1.inputBindings = {
        OnMoveStep = RoactGamepad.Input.onMoveStep(function(arg5, arg6)
            arg1:onMoveStep(arg5, arg6)
        end),
        SelectUpperKnob = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonA, function()
            arg1:setState(function(arg5)
                return {
                    upperKnobIsSelected = not arg5.upperKnobIsSelected,
                    processingGamepad = false
                }
            end)
        end),
        UnselectUpperKnob = if arg3 then RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonB, function()
            arg1:setState({ upperKnobIsSelected = false, processingGamepad = false })
        end) or nil else nil
    }

    local element = createElement(var2, tbl1)

    if arg1.props.customKnobBorderSize and arg1.props.customKnobBorderSize > 0 then
        return arg1:wrapKnobWithBorder(element, arg2)
    end
    return element
end

function var1.renderLowerKnob(arg1, arg2, arg3, arg4, _)
    local knobHeight = arg1:getKnobHeight()
    local scale

    if arg1.props.customKnobBorderSize and arg1.props.customKnobBorderSize > 0 then
        knobHeight -= 2 * (arg1.props.customKnobBorderSize + 2)
        scale = UDim2.fromScale(0.5, 0.5)
    else
        scale = arg2
    end

    local createElement = Roact.createElement
    local var2 = RoactGamepad.Focusable[ImageSetComponent.Button]

    local tbl1 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        ImageColor3 = arg1.props.knobColorLower,
        ImageTransparency = arg1.props.knobTransparency,
        Image = arg1.props.knobImage,
        Size = UDim2.fromOffset(knobHeight, knobHeight),
        Position = scale,
        ZIndex = 3,
        inputBindings = {
            OnMoveStep = RoactGamepad.Input.onMoveStep(function(arg5, arg6)
                arg1:onMoveStep(arg5, arg6)
            end),
            SelectLowerKnob = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonA, function()
                arg1:setState(function(arg5)
                    return {
                        lowerKnobIsSelected = not arg5.lowerKnobIsSelected,
                        processingGamepad = false
                    }
                end)
            end),
            UnselectLowerKnob = if arg3 then RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonB, function()
                arg1:setState({ lowerKnobIsSelected = false, processingGamepad = false })
            end) or nil else nil
        },
        NextSelectionLeft = if arg3 then arg1.lowerKnobRef or nil else nil,
        NextSelectionRight = if arg4 and not arg3 and arg1.props.upperValue ~= arg1.props.lowerValue then arg1.upperKnobRef or nil else nil,
        NextSelectionUp = if arg3 then arg1.lowerKnobRef or nil else nil,
        NextSelectionDown = if arg3 then arg1.lowerKnobRef or nil else nil,
        SelectionImageObject = arg3 and arg1.props.selectedCursor or arg1.props.unselectedCursor,
        [Roact.Ref] = arg1.lowerKnobRef
    }

    tbl1[Roact.Event.InputBegan] = function(_, arg5)
        if arg1.props.isDisabled then
            return
        end

        arg1:onInputBegan(arg5, true)
    end

    local element = createElement(var2, tbl1)

    if arg1.props.customKnobBorderSize and arg1.props.customKnobBorderSize > 0 then
        return arg1:wrapKnobWithBorder(element, arg2)
    end
    return element
end

function var1.renderKnobShadow(arg1, imageTransparency, position)
    return Roact.createElement(ImageSetComponent.Label, {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        ImageTransparency = imageTransparency,
        Image = arg1.props.knobShadowImage,
        Size = UDim2.fromOffset(arg1:getKnobHeight(), arg1:getKnobHeight()),
        Position = position,
        ZIndex = 2
    })
end

function var1.render(arg1)
    local var2 = arg1.state.lowerKnobIsSelected or arg1.state.upperKnobIsSelected
    local var3 = arg1:hasTwoKnobs()
    local xScale = (arg1.props.lowerValue - arg1.props.min) / (arg1.props.max - arg1.props.min)
    local xScale2 = if var3 then (arg1.props.upperValue - arg1.props.min) / (arg1.props.max - arg1.props.min) or nil else nil
    local knobVisibleHeight = arg1:getKnobVisibleHeight()
    local xOffset = lerp(knobVisibleHeight / 2, -knobVisibleHeight / 2, xScale)
    local xOffset2 = if var3 then lerp(knobVisibleHeight / 2, -knobVisibleHeight / 2, xScale2) or nil else nil
    local uDim2 = UDim2.new(xScale, xOffset, 0.5, 0)
    local var4 = if var3 then UDim2.new(xScale2, xOffset2, 0.5, 0) or nil else nil
    local uDim2_2 = var3 and UDim2.fromScale(xScale2 - xScale, 1) or UDim2.fromScale(xScale, 1)
    local var5 = arg1.state.lowerKnobIsSelected or arg1.state.upperKnobIsSelected

    return withSelectionCursorProvider(function(arg2)
        local createElement = Roact.createElement
        local var6 = RoactGamepad.Focusable[ImageSetComponent.Button]
        local tbl1 = {
            BackgroundTransparency = 1,
            AnchorPoint = arg1.props.anchorPoint,
            Size = UDim2.new(arg1.props.width.Scale, arg1.props.width.Offset, 0, 36),
            LayoutOrder = arg1.props.layoutOrder,
            Position = arg1.props.position
        }

        tbl1[Roact.Event.InputBegan] = function(_, arg3)
            if arg1.props.isDisabled then
                return
            end

            arg1:onInputBegan(arg3, false)
        end
        tbl1[Roact.Ref] = arg1.rootRef

        tbl1.NextSelectionLeft = var5 and arg1.rootRef or nil
        tbl1.NextSelectionRight = var5 and arg1.rootRef or nil

        tbl1.NextSelectionUp = not var5 and arg1.props.NextSelectionUp or arg1.rootRef
        tbl1.NextSelectionDown = not var5 and arg1.props.NextSelectionDown or arg1.rootRef
        tbl1.defaultChild = arg1.props.upperValue ~= arg1.props.min and arg1.lowerKnobRef or arg1.upperKnobRef or nil
        function tbl1.onFocusLost()
            if arg1.state.lowerKnobIsSelected or arg1.state.upperKnobIsSelected then
                arg1:setState({ lowerKnobIsSelected = false, upperKnobIsSelected = false })
            end
        end

        return createElement(var6, tbl1, {
            Track = arg1:renderTrack(uDim2_2, var3, xScale),
            LowerKnob = arg1:renderLowerKnob(uDim2, var2, var3, arg2),
            LowerKnobShadow = arg1:renderKnobShadow(arg1.props.knobShadowTransparencyLower, uDim2),
            UpperKnob = arg1:renderUpperKnob(var4, var2, var3, arg2),
            UpperKnobShadow = var3 and arg1:renderKnobShadow(arg1.props.knobShadowTransparencyUpper, var4) or nil
        })
    end)
end

function var1.didMount(arg1)
    local current = arg1.rootRef.current

    local connection = nil
    local function checkAncestry() -- Luacid: Inlined by compiler; 1 call site recovered
        if not current:IsDescendantOf(game) then
            return
        end

        connection:Disconnect()

        arg1.canUseUserInputService = current:FindFirstAncestorWhichIsA("PluginGui") == nil
    end
    connection = current.AncestryChanged:Connect(checkAncestry)
    checkAncestry()
end

function var1.didUpdate(arg1, _, arg2)
    if arg1.props.disabled then
        arg1:stopListeningForDrag()
    end
    local var2 = arg2.lowerKnobIsSelected and not arg1.state.lowerKnobIsSelected
    local var3 = arg2.upperKnobIsSelected and not arg1.state.upperKnobIsSelected
    if arg1.props.onDragEnd ~= nil and (var2 or var3) then
        arg1.props.onDragEnd()
    elseif arg1.props.onDragStartLower ~= nil and not arg2.lowerKnobIsSelected and arg1.state.lowerKnobIsSelected then
        arg1.props.onDragStartLower()
    elseif arg1.props.onDragStartUpper ~= nil and not arg2.upperKnobIsSelected and arg1.state.upperKnobIsSelected then
        arg1.props.onDragStartUpper()
    end
end

function var1.willUnmount(arg1)
    arg1:stopListeningForDrag()
end

function var1.onInputBegan(arg1, arg2, arg3)
    if arg1.props.disabled or arg2.UserInputState ~= Enum.UserInputState.Begin then
        return
    end

    local userInputType = arg2.UserInputType

    if (userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch)
        and (userInputType ~= Enum.UserInputType.Touch or arg3)
    then
        arg1:processDrag(arg2.Position.X)
        arg1:startListeningForDrag()
    end
end

function var1.startListeningForDrag(arg1)
    local current = arg1.rootRef.current

    if current == nil or arg1.dragging then
        return
    end

    if arg1.canUseUserInputService then
        local function func1(arg2)
            if not arg1.dragging then
                return
            end

            local userInputType = arg2.UserInputType

            if (userInputType == Enum.UserInputType.MouseMovement or userInputType == Enum.UserInputType.Touch)
                and arg2.UserInputState == Enum.UserInputState.Change
            then
                arg1:processDrag(arg2.Position.X)
            end
        end
        if arg1.props.containerRef then
            arg1.moveConnection = arg1.props.containerRef.current.InputChanged:Connect(func1)
        else
            arg1.moveConnection = UserInputService.InputChanged:Connect(func1)
        end

        arg1.releaseConnection = UserInputService.InputEnded:Connect(function(input: InputObject)
            local userInputType = input.UserInputType
            if userInputType ~= Enum.UserInputType.MouseButton1 and userInputType ~= Enum.UserInputType.Touch then
                return
            end

            arg1:stopListeningForDrag()

            if not arg1.props.containerRef then
                arg1:processOneKnobDrag(input.Position.X)
            end
        end)

        arg1.focusLostConnection = UserInputService.WindowFocusReleased:Connect(function()
            arg1:stopListeningForDrag()
        end)
    else
        local pluginGui = current:FindFirstAncestorWhichIsA("PluginGui")

        local sliderPluginGuiInputCapturer = Instance.new("ImageButton")
        sliderPluginGuiInputCapturer.BackgroundTransparency = 1
        sliderPluginGuiInputCapturer.Image = ""
        sliderPluginGuiInputCapturer.Name = "SliderPluginGuiInputCapturer"
        sliderPluginGuiInputCapturer.Size = UDim2.new(1, 0, 1, 0)
        sliderPluginGuiInputCapturer.ZIndex = 100000
        arg1.moveConnection = sliderPluginGuiInputCapturer.MouseMoved:Connect(function(x: number)
            arg1:processDrag(x)
        end)

        arg1.releaseConnection = sliderPluginGuiInputCapturer.MouseButton1Up:Connect(function(x: number)
            arg1:stopListeningForDrag()
            arg1:processOneKnobDrag(x)
        end)

        arg1.focusLostConnection = sliderPluginGuiInputCapturer.MouseLeave:Connect(function(x: number)
            arg1:stopListeningForDrag()
            arg1:processOneKnobDrag(x)
        end)

        sliderPluginGuiInputCapturer.Parent = pluginGui
        arg1.inputCapturerButton = sliderPluginGuiInputCapturer
    end

    arg1.dragging = true

    if arg1.lowerKnobDrag and arg1.props.onDragStartLower ~= nil then
        arg1.props.onDragStartLower()
    end

    if arg1.upperKnobDrag and arg1.props.onDragStartUpper ~= nil then
        arg1.props.onDragStartUpper()
    end
end

function var1.getSteppedValue(arg1, arg2)
    local current = arg1.rootRef.current
    if current == nil then
        return 0
    end

    local min = arg1.props.min
    local max = arg1.props.max
    local stepInterval = arg1.props.stepInterval

    local absoluteSizeX = current.AbsoluteSize.X
    return math.floor(
        (math.clamp(arg2 - current.AbsolutePosition.X, 0, absoluteSizeX) / absoluteSizeX * (max - min) + min) / stepInterval + 0.5
    ) * stepInterval
end

function var1.processDrag(arg1, arg2)
    if arg1:hasTwoKnobs() then
        arg1:processTwoKnobDrag(arg2)
        return
    end
    arg1:processOneKnobDrag(arg2)
end

function var1.processOneKnobDrag(arg1, arg2)
    if arg1:hasTwoKnobs() then
        return
    end

    local steppedValue = arg1:getSteppedValue(arg2)
    arg1.lowerKnobDrag = true

    if steppedValue ~= arg1.props.lowerValue then
        arg1.props.onValueChanged(steppedValue)
    end
end

function var1.processTwoKnobDrag(arg1, arg2)
    local steppedValue = arg1:getSteppedValue(arg2)
    local lowerValue = arg1.props.lowerValue
    local upperValue = arg1.props.upperValue

    if not (arg1.lowerKnobDrag or arg1.upperKnobDrag) then
        if steppedValue == lowerValue then
            arg1.lowerKnobDrag = true
        end
        if steppedValue == upperValue then
            arg1.upperKnobDrag = true
        end
    elseif arg1.lowerKnobDrag and arg1.upperKnobDrag then
        if upperValue <= steppedValue - arg1.props.stepInterval then
            arg1.upperKnobDrag = true
            arg1.lowerKnobDrag = false
            upperValue = steppedValue
        elseif steppedValue + arg1.props.stepInterval <= lowerValue then
            arg1.upperKnobDrag = false
            arg1.lowerKnobDrag = true
            lowerValue = steppedValue
        end
    elseif arg1.lowerKnobDrag then
        if steppedValue <= upperValue then
            lowerValue = steppedValue
        end
    elseif arg1.upperKnobDrag and lowerValue <= steppedValue then
        upperValue = steppedValue
    end

    if upperValue ~= arg1.props.upperValue or lowerValue ~= arg1.props.lowerValue then
        arg1.props.onValueChanged(lowerValue, upperValue)
    end
end

function var1.stopListeningForDrag(arg1)
    if arg1.moveConnection ~= nil then
        arg1.moveConnection:Disconnect()
        arg1.moveConnection = nil
    end

    if arg1.releaseConnection ~= nil then
        arg1.releaseConnection:Disconnect()
        arg1.releaseConnection = nil
    end

    if arg1.focusLostConnection ~= nil then
        arg1.focusLostConnection:Disconnect()
        arg1.focusLostConnection = nil
    end

    if arg1.inputCapturerButton ~= nil then
        arg1.inputCapturerButton:Destroy()
        arg1.inputCapturerButton = nil
    end

    arg1.dragging = false
    arg1.lowerKnobDrag = false
    arg1.upperKnobDrag = false

    if arg1.props.onDragEnd ~= nil then
        arg1.props.onDragEnd()
    end
end

function var1.hasTwoKnobs(arg1): boolean
    return arg1.props.upperValue ~= nil
end

return Roact.forwardRef(function(arg1, imageButtonRef)
    local selectedCursor = useCursorByType(CursorType.SelectedKnob)
    local unselectedCursor = useCursorByType(CursorType.UnselectedKnob)
    arg1 = Cryo.Dictionary.join(arg1, { selectedCursor = selectedCursor, unselectedCursor = unselectedCursor })

    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { imageButtonRef = imageButtonRef }))
end)
