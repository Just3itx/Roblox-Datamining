-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent
local Roact = require(AuthCommonParent.Roact)

local Cryo = require(AuthCommonParent.Cryo)
local withStyle = require(AuthCommonParent.UIBlox).Style.withStyle

local ScrollingPickerDirection = require(AuthCommon.Enums.ScrollingPickerDirection)

local Otter = require(AuthCommonParent.Otter)

local FitChildren = require(AuthCommon.Components.FitChildren)

local tbl1 = {
    [ScrollingPickerDirection.Horizontal] = "X",
    [ScrollingPickerDirection.Vertical] = "Y"
}

local tbl2 = {
    [ScrollingPickerDirection.Horizontal] = "Y",
    [ScrollingPickerDirection.Vertical] = "X"
}

local num1 = game:DefineFastInt("ScrollingPickerSlowScrollStepWaitMs", 100)

local num2 = game:DefineFastInt("ScrollingPickerMaximumPickerChangePerInput", 1)
local num3 = game:DefineFastInt("ScrollingPickerSmallInputDecayFactor", 3)

local var1 = Roact.PureComponent:extend("ScrollingPicker")

var1.MOUSE_WHEEL_STEP_THRESHOLD = 0.1

var1.defaultProps = {
    layoutOrder = 0,
    parentSpecifiedTarget = 1,
    entries = {},
    entrySizeOnScrollingAxis = 10,
    scrollDirection = ScrollingPickerDirection.Vertical,
    clipsDescendants = true,
    shouldExpandTapTarget = false,
    tapTargetExpansionSize = 0,
    minTargetIndex = 1
}

local var2 = setmetatable({
    [Enum.UserInputType.MouseButton1] = true,
    [Enum.UserInputType.Touch] = true
}, {
    __index = function(_, _): boolean
        return false
    end
})

function var1.init(arg1)
    local parentSpecifiedTarget = arg1.props.parentSpecifiedTarget
    local scrollDirection = arg1.props.scrollDirection
    local shouldExpandTapTarget = arg1.props.shouldExpandTapTarget

    arg1.state = {
        scrollDirection = scrollDirection,
        scrollingAxis = tbl1[scrollDirection],
        subAxis = tbl2[scrollDirection]
    }

    arg1.isMounted = false

    arg1.currentIndex = 1
    arg1.targetEntryRef = Roact.createRef()
    arg1.targetIndex = parentSpecifiedTarget
    arg1.isEntrySelected = false

    arg1.isTargetIndexSetByUserInput = false
    arg1.timeInputBegan = tick()

    arg1.recognizedInputBegan = false
    arg1.inputChanged = false
    arg1.inputPositionAtInputBegan = 0
    arg1.inputPreviousPositionScrollingAxis = 0
    arg1.scrollRef = Roact.createRef()
    arg1.shouldExpandTapTarget = shouldExpandTapTarget
    arg1.tapTargetExpansionSize = arg1.props.tapTargetExpansionSize

    arg1.scrollDeltaAccumulator = 0

    function arg1.getCenterIndexByPosition(arg2): number
        local entrySizeOnScrollingAxis = arg1.props.entrySizeOnScrollingAxis

        return math.floor(-arg2 / entrySizeOnScrollingAxis) + 1
    end

    function arg1.getCenterIndexByScrollPosition(arg2)
        arg2 -= arg1.props.entrySizeOnScrollingAxis / 2
        return arg1.getCenterIndexByPosition(arg2)
    end

    function arg1.updateParent()
        local onCurrentIndexChanged = arg1.props.onCurrentIndexChanged
        local onSelectedIndexChanged = arg1.props.onSelectedIndexChanged

        if onCurrentIndexChanged then
            onCurrentIndexChanged(arg1.currentIndex)
        end

        if onSelectedIndexChanged and arg1.currentIndex == arg1.targetIndex then
            onSelectedIndexChanged(arg1.currentIndex, arg1.isTargetIndexSetByUserInput)
        end
    end

    function arg1.onScrollPositionChanged()
        if not arg1.scrollRef.current then
            return
        end

        local scrollingAxis = arg1.state.scrollingAxis
        local offset = arg1.scrollRef.current.Position[scrollingAxis].Offset
        local currentIndex = arg1.getCenterIndexByScrollPosition(offset)
        if currentIndex ~= arg1.currentIndex then
            arg1.currentIndex = currentIndex
            arg1.updateParent()
        end
    end

    function arg1.updateTargetIndex(tbl3)
        local newTargetIndex = tbl3.newTargetIndex
        local isSetByUserInput = tbl3.isSetByUserInput
        local otterAnimationType = tbl3.otterAnimationType

        local var3 = if otterAnimationType == nil then "spring" else otterAnimationType

        local entries = arg1.props.entries
        local entrySizeOnScrollingAxis = arg1.props.entrySizeOnScrollingAxis
        local var4 = if #entries < 1 then 0 else math.clamp(newTargetIndex, math.max(1, arg1.props.minTargetIndex or 1), #entries)
        arg1.targetIndex = var4
        arg1.isTargetIndexSetByUserInput = isSetByUserInput

        arg1.motor:setGoal(Otter[var3](-(entrySizeOnScrollingAxis * (arg1.targetIndex - 1)), { frequency = 2 }))

        if arg1.currentIndex == arg1.targetIndex then
            arg1.updateParent()
        end
    end

    function arg1.updateIndexByInputPosition(arg2)
        if not arg1.scrollRef.current then
            return
        end

        local scrollingAxis = arg1.state.scrollingAxis

        local absolutePosition = arg1.scrollRef.current.AbsolutePosition
        local absoluteSize = arg1.scrollRef.current.AbsoluteSize
        local entrySizeOnScrollingAxis = arg1.props.entrySizeOnScrollingAxis
        local var3

        if arg2.X > absolutePosition.X
            and arg2.X < absolutePosition.X + absoluteSize.X
            and arg2.Y > absolutePosition.Y
            and arg2.Y < absolutePosition.Y + absoluteSize.Y
        then
            var3 = absolutePosition[scrollingAxis] - arg2[scrollingAxis]
        else
            var3 = -(arg1.targetIndex - 1) * entrySizeOnScrollingAxis
        end

        local newTargetIndex = arg1.getCenterIndexByPosition(var3)

        arg1.updateTargetIndex({ newTargetIndex = newTargetIndex, isSetByUserInput = true })
    end

    function arg1.updateIndexByScrollPositionAndOffset(arg2)
        arg2 = arg2 or 0

        if not arg1.scrollRef.current then
            return
        end

        local scrollingAxis = arg1.state.scrollingAxis
        local var3 = arg1.scrollRef.current.Position[scrollingAxis].Offset + arg2
        local newTargetIndex = arg1.getCenterIndexByScrollPosition(var3)

        arg1.updateTargetIndex({ newTargetIndex = newTargetIndex, isSetByUserInput = true })
    end

    function arg1.onInputBegan(_, arg2)
        local entries = arg1.props.entries
        local scrollingAxis = arg1.state.scrollingAxis

        if not arg1.isMounted
            or not var2[arg2.UserInputType]
            or not (#entries > 0)
            or arg2.UserInputState ~= Enum.UserInputState.Begin
        then
            return
        end
        arg1.recognizedInputBegan = true
        arg1.timeInputBegan = tick()
        arg1.inputPositionAtInputBegan = arg2.Position[scrollingAxis]
        arg1.inputPreviousPositionScrollingAxis = arg2.Position[scrollingAxis]

        arg1.motor:stop()
    end

    function var1.restrictInputChangeDelta(_, num4: number)
        local num5 = if num4 > 0 then 1 else -1
        local num6 = math.min(math.abs(num4), num2 * var1.MOUSE_WHEEL_STEP_THRESHOLD)

        if not (num6 < var1.MOUSE_WHEEL_STEP_THRESHOLD) then
            return num6 * num5
        end

        return math.pow(num6 / var1.MOUSE_WHEEL_STEP_THRESHOLD, num3) * var1.MOUSE_WHEEL_STEP_THRESHOLD
    end

    function arg1.onInputChanged(_, arg2)
        local entries = arg1.props.entries
        local entrySizeOnScrollingAxis = arg1.props.entrySizeOnScrollingAxis
        local scrollingAxis = arg1.state.scrollingAxis

        if arg2.UserInputType ~= Enum.UserInputType.MouseWheel then
            if arg1.recognizedInputBegan then
                local var3 = arg2.Position[scrollingAxis] - arg1.inputPreviousPositionScrollingAxis
                if arg1.scrollRef.current then
                    local var4 = arg1.scrollRef.current.Position[scrollingAxis].Offset + var3
                    local num4 = math.max(
                        math.min(-(entrySizeOnScrollingAxis * (math.max(1, arg1.props.minTargetIndex or 1) - 1)), var4),
                        -(entrySizeOnScrollingAxis * (#entries - 1))
                    )
                    arg1.motor:setGoal(Otter.instant(num4))
                end

                arg1.inputChanged = true
                arg1.inputPreviousPositionScrollingAxis = arg2.Position[scrollingAxis]
            end
            return
        end

        local z = arg2.Position.Z
        local var3 = var1:restrictInputChangeDelta(z)

        if z < 0 ~= (arg1.scrollDeltaAccumulator < 0) then
            arg1.scrollDeltaAccumulator = 0
        end

        arg1.scrollDeltaAccumulator += var3

        local bool1 = math.abs(arg1.scrollDeltaAccumulator) <= 4 * var1.MOUSE_WHEEL_STEP_THRESHOLD

        while math.abs(arg1.scrollDeltaAccumulator) >= var1.MOUSE_WHEEL_STEP_THRESHOLD do
            local num4 = if arg1.scrollDeltaAccumulator > 0 then 1 else -1
            arg1.updateTargetIndex(
                {
                    newTargetIndex = arg1.targetIndex - num4,
                    isSetByUserInput = true,
                    OtterAnimationType = "spring"
                }
            )

            arg1.scrollDeltaAccumulator -= var1.MOUSE_WHEEL_STEP_THRESHOLD * num4
            if bool1 then
                task.wait(num1)
            end
        end
    end

    function arg1.onInputEnded(_, arg2)
        local scrollingAxis = arg1.state.scrollingAxis

        if arg1.recognizedInputBegan then
            local var3 = arg2.Position[scrollingAxis] - arg1.inputPositionAtInputBegan

            if arg1.inputChanged and math.abs(var3) > 1.5 then
                local var4 = tick() - arg1.timeInputBegan
                if var4 < 0.3 then
                    local var5 = arg2.Delta[scrollingAxis] / var4
                    arg1.updateIndexByScrollPositionAndOffset(var5)
                else
                    arg1.updateIndexByScrollPositionAndOffset(0)
                end
            else
                arg1.updateIndexByInputPosition(arg2.Position)
            end
        end

        arg1.recognizedInputBegan = false
        arg1.inputChanged = false
    end

    function arg1.onSelectionGained(newTargetIndex: number)
        arg1.isEntrySelected = true
        arg1.updateTargetIndex({ newTargetIndex = newTargetIndex, isSetByUserInput = true, otterAnimationType = "instant" })
    end

    function arg1.onSelectionLost()
        arg1.isEntrySelected = false
    end
end

function var1.didMount(arg1)
    arg1.updateParent()

    arg1.motor = Otter.createSingleMotor(0)
    arg1.motor:onStep(function(offset: number?)
        if not arg1.scrollRef.current then
            return
        end

        local scrollingAxis = arg1.state.scrollingAxis
        local subAxis = arg1.state.subAxis

        local scrollDirection = arg1.state.scrollDirection
        local currentPosition = arg1.scrollRef.current.Position
        local uDim2 = if scrollDirection == ScrollingPickerDirection.Horizontal then UDim2.new(UDim.new(currentPosition[scrollingAxis].Scale, offset), currentPosition[subAxis]) else UDim2.new(currentPosition[subAxis], UDim.new(currentPosition[scrollingAxis].Scale, offset))
        arg1.scrollRef.current.Position = uDim2
    end)

    arg1.motor:onComplete(function()
        if arg1.props.onAnimationComplete then
            arg1.props.onAnimationComplete()
        end
    end)

    arg1.updateTargetIndex({ newTargetIndex = arg1.targetIndex, isSetByUserInput = false, otterAnimationType = "instant" })

    arg1.isMounted = true
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
    arg1.motor:destroy()
end

function var1.didUpdate(arg1, arg2)
    local parentSpecifiedTarget = arg1.props.parentSpecifiedTarget

    if arg1.props.entrySizeOnScrollingAxis == arg2.entrySizeOnScrollingAxis
        and (parentSpecifiedTarget == arg1.targetIndex or parentSpecifiedTarget == arg2.parentSpecifiedTarget)
    then
        return
    end
    local newTargetIndex = parentSpecifiedTarget or arg1.targetIndex

    arg1.updateTargetIndex({ newTargetIndex = newTargetIndex, isSetByUserInput = false })
end

function var1.render(arg1)
    return withStyle(function(_)
        local layoutOrder = arg1.props.layoutOrder
        local size = arg1.props.size
        local entries = arg1.props.entries
        local entrySizeOnScrollingAxis = arg1.props.entrySizeOnScrollingAxis
        local clipsDescendants = arg1.props.clipsDescendants
        local scrollDirection = arg1.state.scrollDirection
        local getEntryWrapperProps = arg1.props.getEntryWrapperProps
        local var3, var4, var5, var6, var7

        if scrollDirection == ScrollingPickerDirection.Horizontal then
            var3 = FitChildren.FitAxis.Width
            var4 = Enum.FillDirection.Horizontal
            var5 = UDim2.new(0, entrySizeOnScrollingAxis, 1, 0)
            var6 = UDim2.new(0, 0, 1, 0)
            var7 = UDim2.new(0.5, -entrySizeOnScrollingAxis / 2, 0, 0)
        else
            var3 = FitChildren.FitAxis.Height
            var4 = Enum.FillDirection.Vertical
            var5 = UDim2.new(1, 0, 0, entrySizeOnScrollingAxis)
            var6 = UDim2.new(1, 0, 0, 0)
            var7 = UDim2.new(0, 0, 0.5, -entrySizeOnScrollingAxis / 2)
        end

        local tbl3 = {}

        for i, value in ipairs(entries) do
            local tbl4 = {
                Interactable = i == arg1.targetIndex and arg1.isEntrySelected,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Text = ""
            }
            local var8 = arg1.targetIndex - i
            tbl4.Selectable = math.abs(var8) < 2
            local ref = Roact.Ref
            local targetEntryRef = if i == arg1.targetIndex then arg1.targetEntryRef else nil
            tbl4[ref] = targetEntryRef
            tbl4[Roact.Event.SelectionGained] = function()
                arg1.onSelectionGained(i)
            end
            tbl4[Roact.Event.SelectionLost] = arg1.onSelectionLost
            tbl4[Roact.Event.Activated] = arg1.props.onEntryActivated

            if getEntryWrapperProps then
                tbl4 = Cryo.Dictionary.join(tbl4, getEntryWrapperProps(value))
            end

            local var9 = Cryo.Dictionary.join(tbl4, { Size = var5, LayoutOrder = i })

            table.insert(tbl3, Roact.createElement("TextButton", var9, { arg1.props.renderEntry(value) }))
        end

        table.insert(
            tbl3,
            Roact.createElement("UIListLayout", {
                FillDirection = var4,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        )

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl4 = {
            LayoutOrder = layoutOrder,
            Size = if arg1.shouldExpandTapTarget then size + UDim2.new(0, 0, 0, arg1.tapTargetExpansionSize) else size,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ClipsDescendants = clipsDescendants,
            SelectionGroup = true,
            SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
            SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
            [Roact.Event.InputBegan] = arg1.onInputBegan,
            [Roact.Event.InputChanged] = arg1.onInputChanged,
            [Roact.Event.InputEnded] = arg1.onInputEnded
        }
        local tbl5 = { CenterPosition = 0 }
        local var8

        if arg1.shouldExpandTapTarget then
            local createElement2 = Roact.createElement
            local tbl6 = {
                Size = size,
                AutomaticSize = Enum.AutomaticSize.X,
                ClipsDescendants = true,
                BorderSizePixel = 0,
                BackgroundTransparency = 1
            }

            local tbl7 = { CenterPosition = 0 }
            local createElement3 = Roact.createElement

            local tbl8 = {
                AnimatedSlidingList = Roact.createElement(FitChildren.FitFrame, {
                    Size = var6,
                    fitAxis = var3,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    [Roact.Ref] = arg1.scrollRef,
                    [Roact.Change.AbsolutePosition] = arg1.onScrollPositionChanged
                }, tbl3)
            }
            tbl7.CenterPosition = createElement3("Frame", { Size = var6, Position = var7, BorderSizePixel = 0, BackgroundTransparency = 1 }, tbl8)
            var8 = createElement2("Frame", tbl6, tbl7)
        else
            local createElement2 = Roact.createElement

            local tbl6 = {
                AnimatedSlidingList = Roact.createElement(FitChildren.FitFrame, {
                    Size = var6,
                    fitAxis = var3,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    [Roact.Ref] = arg1.scrollRef,
                    [Roact.Change.AbsolutePosition] = arg1.onScrollPositionChanged
                }, tbl3)
            }
            var8 = createElement2("Frame", { Size = var6, Position = var7, BorderSizePixel = 0, BackgroundTransparency = 1 }, tbl6)
        end

        tbl5.CenterPosition = var8
        return createElement(str1, tbl4, tbl5)
    end)
end

return var1
