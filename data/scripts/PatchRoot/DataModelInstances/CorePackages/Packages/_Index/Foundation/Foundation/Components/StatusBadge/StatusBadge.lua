-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:01Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local StatusBadgeShape = require(Foundation.Enums.StatusBadgeShape)

local StatusBadgeSize = require(Foundation.Enums.StatusBadgeSize)

local StatusBadgeVariant = require(Foundation.Enums.StatusBadgeVariant)

local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useScaledValue = require(Foundation.Utility.useScaledValue)
local useStatusBadgeVariants = require(script.Parent.useStatusBadgeVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    variant = StatusBadgeVariant.Standard,
    shape = StatusBadgeShape.Utility,
    size = StatusBadgeSize.Small,
    testId = "--foundation-status-badge"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: StatusBadge
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = useStatusBadgeVariants(var2, var1.variant, var1.shape, var1.size)
    local x = useScaledValue(200)

    return React.createElement(View, withCommonProps(var1, { tag = var3.container.tag, ref = ref }), {
        Content = React.createElement(View, {
            tag = var3.content.tag,
            layout = var3.content.gap and {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, var3.content.gap)
            } or nil,
            LayoutOrder = 1,
            testId = `{var1.testId}--content`
        }, {
            StatusLight = React.createElement(
                View,
                {
                    tag = var3.statusLight.tag,
                    LayoutOrder = 1,
                    testId = `{var1.testId}--status-light`
                },
                {
                    Dot = React.createElement(View, { tag = var3.dot.tag, LayoutOrder = 1, testId = `{var1.testId}--dot` })
                }
            ),
            Text = React.createElement(Text, {
                Text = var1.text,
                tag = var3.text.tag,
                textStyle = var3.text.style,
                LayoutOrder = 2,
                sizeConstraint = {
                    MaxSize = Vector2.new(x, math.huge)
                },
                testId = `{var1.testId}--text`
            })
        })
    })
end))
