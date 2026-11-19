-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:00:59Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local IconVariant = BuilderIcons.IconVariant
local CloseAffordance = require(Foundation.Components.CloseAffordance)
local CloseAffordanceVariant = require(Foundation.Enums.CloseAffordanceVariant)
local ColorNamespace = require(Foundation.Enums.ColorNamespace)
local Icon = require(Foundation.Components.Icon)
local InputSize = require(Foundation.Enums.InputSize)
local PresentationContext = require(Foundation.Providers.Style.PresentationContext)
local StateLayerMode = require(Foundation.Enums.StateLayerMode)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useScaledValue = require(Foundation.Utility.useScaledValue)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = { testId = "--foundation-snackbar" }

local value = {
    colorNamespace = ColorNamespace.Inverse
}
return React.memo(React.forwardRef(function(arg1, ref) -- name: Snackbar
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()

    local var3 = var1.icon and var1.icon ~= ""
    local bool1 = not (var1.action == nil) and var1.action.text ~= ""
    local bool2 = bool1 or var1.onClose ~= nil
    local var4 = var3 or bool2

    local xOffset = useScaledValue(371)
    local x = useScaledValue(if var3 then 304 else 272)
    local var5 = typeof(var1.icon) == "string" and {
        name = var1.icon,
        variant = IconVariant.Regular
    } or var1.icon
    local y = var2.Typography.CaptionLarge.FontSize * var2.Typography.CaptionLarge.LineHeight * 2
    local action = var1.action

    local createElement = React.createElement
    local var6 = View
    local var7 = withCommonProps(var1, {
        Size = if bool2 then UDim2.fromOffset(xOffset, 0) else UDim2.fromOffset(0, 0),
        sizeConstraint = not bool2 and {
            MinSize = Vector2.new(0, 0),
            MaxSize = Vector2.new(x, math.huge)
        } or nil,
        tag = {
            ["row align-y-center gap-large padding-y-xsmall radius-medium bg-system-contrast"] = true,
            ["padding-left-large"] = not var4,
            ["padding-left-medium"] = var4,
            ["auto-xy padding-right-large"] = not bool2,
            ["auto-y padding-right-small"] = bool2
        },
        ref = ref
    })
    local createElement2 = React.createElement
    local provider = PresentationContext.Provider
    local tbl3 = { value = value }
    local tbl4 = {
        Content = React.createElement(View, {
            LayoutOrder = 1,
            tag = "row align-y-center fill gap-small auto-xy padding-y-small",
            testId = `{var1.testId}--content`
        }, {
            Icon = if var3 then React.createElement(
                Icon,
                Dash.join(var5, { style = var2.Inverse.Content.Emphasis, LayoutOrder = 1, testId = `{var1.testId}--icon` })
            ) else nil,
            Title = React.createElement(Text, {
                LayoutOrder = 2,
                Text = var1.title,
                sizeConstraint = {
                    MinSize = Vector2.new(0, 0),
                    MaxSize = Vector2.new(math.huge, y)
                },
                tag = "fill auto-xy text-caption-large text-wrap text-align-x-left text-truncate-split content-inverse-emphasis",
                testId = `{var1.testId}--title`
            })
        }),
        Buttons = 0
    }
    local element

    if bool2 then
        element = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "row align-y-center gap-xsmall auto-xy",
                testId = `{var1.testId}--buttons`
            },
            {
                Action = if bool1 then React.createElement(Text, {
                    LayoutOrder = 1,
                    onActivated = action.onActivated,
                    stateLayer = {
                        mode = StateLayerMode.Inverse
                    },
                    Text = action.text,
                    tag = "auto-xy padding-small text-label-medium radius-medium content-inverse-link",
                    testId = `{var1.testId}--action`
                }) else nil,
                CloseAffordance = if var1.onClose == nil then nil else React.createElement(CloseAffordance, {
                    LayoutOrder = 2,
                    onActivated = var1.onClose,
                    size = InputSize.Small,
                    variant = CloseAffordanceVariant.Utility,
                    testId = `{var1.testId}--close-affordance`
                })
            }
        )
    else
        element = nil
    end

    tbl4.Buttons = element
    return createElement(var6, var7, createElement2(provider, tbl3, tbl4))
end))
