-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:10Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local FillBehavior = require(Foundation.Enums.FillBehavior)
local Icon = require(Foundation.Components.Icon)
local _InputSize = require(Foundation.Enums.InputSize)

local StepperStepState = require(Foundation.Enums.StepperStepState)

local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)

local useStepperVariants = require(script.Parent.useStepperVariants)

local Icon2 = BuilderIcons.Icon
local IconVariant = BuilderIcons.IconVariant

return React.memo(React.forwardRef(function(arg1, ref) -- name: StepItem
    local var1 = useTokens()
    local bool1 = arg1.fillBehavior == FillBehavior.Fill
    local var2 = useStepperVariants(var1, arg1.size, arg1.stepState, bool1)

    local createElement = React.createElement
    local var3 = View
    local tbl1 = {
        tag = var2.container.tag,
        testId = arg1.testId,
        LayoutOrder = arg1.LayoutOrder
    }
    local tbl2 = {
        Measure = React.createElement(View, { LayoutOrder = 1, tag = "size-full", ref = ref }),
        Content = 0
    }
    local createElement2 = React.createElement
    local var4 = View
    local tbl3 = {
        LayoutOrder = 2,
        tag = var2.content.tag,
        padding = var2.content.padding,
        testId = `{arg1.testId}--content`
    }
    local tbl4 = { IndicatorOuter = 0, TextColumn = 0 }
    local createElement3 = React.createElement
    local var5 = View
    local tbl5 = {
        LayoutOrder = 1,
        tag = var2.indicatorOuter.tag,
        testId = `{arg1.testId}--indicator-outer`
    }
    local tbl6 = { Indicator = 0 }
    local createElement4 = React.createElement
    local var6 = View
    local tbl7 = {
        tag = var2.indicatorInner.tag,
        testId = `{arg1.testId}--indicator`
    }
    local tbl8 = { StepIndex = 0 }
    local element

    if arg1.stepState == StepperStepState.Complete then
        element = React.createElement(Icon, {
            name = Icon2.Check,
            style = var1.Inverse.Content.Emphasis,
            size = var2.icon.size,
            variant = IconVariant.Filled,
            testId = `{arg1.testId}--check`
        })
    else
        element = React.createElement(
            Text,
            {
                Text = tostring(arg1.index),
                tag = var2.index.tag,
                testId = `{arg1.testId}--index`
            }
        )
    end

    tbl8.StepIndex = element
    tbl6.Indicator = createElement4(var6, tbl7, tbl8)
    tbl4.IndicatorOuter = createElement3(var5, tbl5, tbl6)

    tbl4.TextColumn = React.createElement(View, {
        LayoutOrder = 2,
        tag = var2.textColumn.tag,
        padding = var2.textColumn.padding,
        testId = `{arg1.testId}--text-column`
    }, {
        Label = React.createElement(
            Text,
            {
                LayoutOrder = 1,
                Text = arg1.step.label,
                tag = var2.label.tag,
                testId = `{arg1.testId}--label`
            }
        ),
        Description = if arg1.step.description then React.createElement(Text, {
            LayoutOrder = 2,
            Text = arg1.step.description,
            tag = var2.description.tag,
            testId = `{arg1.testId}--description`
        }) else nil
    })
    tbl2.Content = createElement2(var4, tbl3, tbl4)
    return createElement(var3, tbl1, tbl2)
end))
