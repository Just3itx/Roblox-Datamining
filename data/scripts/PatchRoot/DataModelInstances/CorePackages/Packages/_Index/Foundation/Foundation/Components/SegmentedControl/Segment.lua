-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:41:18Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _BuilderIcons = require(FoundationParent.BuilderIcons)

local Icon = require(Foundation.Components.Icon)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local _FillBehavior = require(Foundation.Enums.FillBehavior)
local Flags = require(Foundation.Utility.Flags)
local _IconSize = require(Foundation.Enums.IconSize)
local _InputSize = require(Foundation.Enums.InputSize)
local _SegmentedControlVariant = require(Foundation.Enums.SegmentedControlVariant)

local devAssert = require(Foundation.Utility.devAssert)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)

local useSegmentedControlVariants = require(script.Parent.useSegmentedControlVariants)

return React.memo(React.forwardRef(function(arg1, ref) -- name: Segment
    local variant = if Flags.FoundationSegmentedControlBeta then arg1.variant else nil
    local fillBehavior = if Flags.FoundationSegmentedControlBeta then arg1.fillBehavior else nil
    local var1 = useTokens()
    local var2 = useSegmentedControlVariants

    local size = arg1.size
    if not Flags.FoundationSegmentedControlBeta then
        variant = nil
    end

    if not Flags.FoundationSegmentedControlBeta then
        fillBehavior = nil
    end

    local var3 = var2(
        var1,
        size,
        variant,
        fillBehavior,
        arg1.isCircular,
        if Flags.FoundationSegmentedControlBeta then arg1.isActive else nil
    )

    devAssert(
        arg1.text == nil or arg1.icon == nil,
        "Segment: `text` and `icon` are mutually exclusive. Only one can be provided."
    )

    local bool1 = arg1.icon ~= nil

    local variant2 = nil
    local var4, icon

    if bool1 then
        if typeof(arg1.icon) == "table" then
            local icon2 = arg1.icon

            var4 = icon2.name
            variant2 = icon2.variant
        else
            var4 = arg1.icon
        end
        icon = var3.icon
    else
        var4 = nil
        icon = nil
    end

    local createElement = React.createElement
    local var5 = View
    local var6 = withCommonProps(arg1, {
        tag = var3.segment.tag,
        onActivated = function()
            arg1.onActivated(arg1.id)
        end,
        ref = ref
    })
    local tbl1 = { Text = 0 }
    local element

    if bool1 then
        element = React.createElement(Icon, {
            name = var4,
            variant = variant2,
            size = icon.size,
            style = icon.style,
            testId = if Flags.FoundationSegmentedControlBeta then `{arg1.testId}--icon` else nil
        })
    else
        element = React.createElement(Text, {
            tag = var3.text.tag,
            Text = arg1.text,
            textStyle = if Flags.FoundationSegmentedControlBeta then var3.text.style else nil,
            testId = if Flags.FoundationSegmentedControlBeta then `{arg1.testId}--text` else nil
        })
    end

    tbl1.Text = element
    return createElement(var5, var6, tbl1)
end))
