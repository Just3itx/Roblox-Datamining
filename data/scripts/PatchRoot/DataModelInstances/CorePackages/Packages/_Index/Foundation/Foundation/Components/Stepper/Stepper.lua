-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:12Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local FillBehavior = require(Foundation.Enums.FillBehavior)
local InputSize = require(Foundation.Enums.InputSize)
local OverflowScrollContainer = require(Foundation.Components.OverflowScrollContainer)
local StepperStepState = require(Foundation.Enums.StepperStepState)

local StepItem = require(script.Parent.StepItem)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useAnimatedHighlight = require(Foundation.Utility.useAnimatedHighlight)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    fillBehavior = FillBehavior.Fill,
    size = InputSize.Medium,
    testId = "--foundation-stepper",
    ZIndex = 1
}

local function getStepState(num1: number, num2: number, bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    if bool1 then
        return StepperStepState.Current
    end

    if num1 < num2 then
        return StepperStepState.Complete
    end

    return StepperStepState.Incomplete
end

return React.memo(React.forwardRef(function(arg1, ref) -- name: Stepper
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()

    local var3 = var1.activeStepId or Dash.get(var1, { "steps", 1, "id" })
    local index = Dash.findIndex(var1.steps, function(arg2): boolean
        return arg2.id == var3
    end) or 1

    local bool1 = var1.fillBehavior == FillBehavior.Fill

    local var4 = React.useRef(nil)

    local var5 = React.useRef({})
    local var6 = React.useMemo(function()
        local current = var5.current
        for _, step in var1.steps do
            if not current[step.id] then
                current[step.id] = React.createRef()
            end
        end
        return current
    end, { var1.steps })

    local var7 = useAnimatedHighlight(var3, ref or var4, var6, var1.size, var1.fillBehavior)

    local var8, var9 = React.useBinding(0)
    local onAbsoluteSizeChanged = React.useCallback(function(arg2)
        var9(arg2.AbsoluteSize.X)
    end, {})

    local standard = var2.Stroke.Standard

    local tbl2 = ({})
    for i, step in ipairs(var1.steps) do
        local stepState = if var3 == step.id then getStepState(nil, nil, true) else getStepState(i, index, false)
        local str1 = `Step{step.id}`
        tbl2[str1] = React.createElement(StepItem, {
            step = step,
            index = i,
            stepState = stepState,
            size = var1.size,
            fillBehavior = var1.fillBehavior,
            LayoutOrder = i,
            testId = `{var1.testId}--step-{step.id}`,
            ref = var6[step.id]
        })
    end

    return React.createElement(
        View,
        withCommonProps(var1, {
            tag = "size-full-0 auto-y no-clip",
            sizeConstraint = not bool1 and {
                MaxSize = var8:map(function(x: number): Vector2
                    return Vector2.new(x, math.huge)
                end)
            } or nil
        }),
        {
            Stepper = React.createElement(View, {
                ref = ref or var4,
                tag = "col size-full-0 auto-y",
                ZIndex = var1.ZIndex,
                testId = `{var1.testId}--container`
            }, {
                ScrollContainer = React.createElement(OverflowScrollContainer, {
                    LayoutOrder = 1,
                    size = var1.size,
                    scrimBottomInset = standard,
                    testId = `{var1.testId}--scroll-container`
                }, {
                    StepList = React.createElement(View, {
                        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
                        tag = { ["row flex-y-fill auto-xy"] = true, ["size-full-0"] = bool1 },
                        testId = `{var1.testId}--list`
                    }, tbl2)
                }),
                Border = React.createElement(View, {
                    LayoutOrder = 2,
                    tag = "position-bottom-left anchor-bottom-left",
                    Size = UDim2.new(1, 0, 0, var2.Stroke.Standard),
                    backgroundStyle = var2.Color.Stroke.Default,
                    testId = `{var1.testId}--border`
                })
            }),
            AnimatedBorder = React.createElement(View, {
                LayoutOrder = 0,
                ZIndex = var1.ZIndex + 1,
                tag = "anchor-bottom-left bg-system-contrast",
                Size = var7.highlightWidth:map(function(xOffset: number): UDim2
                    return UDim2.fromOffset(xOffset, standard)
                end),
                Position = React.joinBindings({ var7.highlightPosition, var7.activeItemHeight }):map(function(tbl3: {number}): UDim2
                    local xOffset = tbl3[1]
                    local yOffset = tbl3[2]
                    return UDim2.fromOffset(xOffset, yOffset)
                end),
                testId = `{var1.testId}--animated-border`
            })
        }
    )
end))
