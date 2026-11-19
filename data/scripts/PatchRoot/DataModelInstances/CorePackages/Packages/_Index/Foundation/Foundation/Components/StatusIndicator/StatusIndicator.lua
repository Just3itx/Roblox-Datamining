-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:06Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local Flags = require(Foundation.Utility.Flags)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local devAssert = require(Foundation.Utility.devAssert)
local useStatusIndicatorVariants = require(script.Parent.useStatusIndicatorVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local StatusIndicatorSize = require(Foundation.Enums.StatusIndicatorSize)

local StatusIndicatorVariant = require(Foundation.Enums.StatusIndicatorVariant)

local StatusIndicatorShape = require(Foundation.Enums.StatusIndicatorShape)

local ValidNumericVariants = require(script.Parent.ValidNumericVariants)

local tbl1 = {
    variant = StatusIndicatorVariant.Standard,
    shape = StatusIndicatorShape.Circle,
    size = StatusIndicatorSize.Small,
    max = math.huge,
    testId = "--foundation-status-indicator"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: StatusIndicator
    local var1 = withDefaults(arg1, tbl1)
    local var2 = if var1.value then StatusIndicatorShape.Circle else var1.shape

    if var1.value ~= nil then
        devAssert(
            ValidNumericVariants[var1.variant],
            `{var1.variant} is not a supported numeric variant. The following are valid numeric variants: {table.concat(Dash.filter(Dash.keys(ValidNumericVariants), function(arg2, _): boolean
                return ValidNumericVariants[arg2] == true
            end), ",")}`
        )
    end

    local var3 = useTokens()
    local bool1 = var1.value ~= nil

    local var4 = useStatusIndicatorVariants(var3, var1.variant, bool1, var2, var1.size, var1.mask)

    local var5 = React.useCallback(function(max: number): string
        if var1.max and var1.max < max then
            return `{var1.max}+`
        end
        return tostring(max)
    end, { var1.max })

    local createElement = React.createElement
    local var6 = View
    local var7 = withCommonProps
    local tbl2 = {
        tag = var4.container.tag,
        backgroundStyle = if var4.container.backgroundStyle then var4.container.backgroundStyle else nil,
        stroke = if var1.mask then var4.stroke else nil,
        ref = ref,
        Size = var4.container.size
    }
    local var8 = var7(var1, tbl2)

    local tbl3 = { Text = 0, InnerRing = 0 }
    local element

    if bool1 and var4.content.style then
        element = React.createElement(Text, {
            Text = if ReactIs.isBinding(var1.value) then var1.value:map(var5) else var5(var1.value),
            textStyle = var4.content.style,
            fontStyle = Flags.FoundationStatusIndicatorDesignUpdate
                and {
                    Font = var4.content.font,
                    FontSize = var4.content.typography.FontSize,
                    LineHeight = var4.content.typography.LineHeight
                }
                or {
                    Font = var4.content.font,
                    FontSize = var3.Typography.LabelSmall.FontSize,
                    LineHeight = var3.Typography.LabelSmall.LineHeight
                },
            tag = var4.content.tag,
            testId = `{var1.testId}--text`
        })
    else
        element = nil
    end

    tbl3.Text = element

    tbl3.InnerRing = if var2 == StatusIndicatorShape.Ring and var4.ring then React.createElement(View, { tag = var4.ring.tag, Size = var4.ring.size, testId = `{var1.testId}--ring` }) else nil
    return createElement(var6, var8, tbl3)
end))
