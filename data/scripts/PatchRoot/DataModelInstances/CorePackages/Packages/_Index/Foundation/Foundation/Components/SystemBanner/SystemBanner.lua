-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:16Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactUtils = require(FoundationParent.ReactUtils)

local AlertActions = require(Foundation.Components.AlertActions)
local AlertConstants = require(Foundation.Components.AlertActions.AlertConstants)
local _AlertSeverity = require(Foundation.Enums.AlertSeverity)
local AlertVariant = require(Foundation.Enums.AlertVariant)
local Breakpoint = require(Foundation.Enums.Breakpoint)
local BuilderIcons = require(FoundationParent.BuilderIcons)
local _ButtonVariant = require(Foundation.Enums.ButtonVariant)
local CloseAffordance = require(Foundation.Components.CloseAffordance)
local CloseAffordanceVariant = require(Foundation.Enums.CloseAffordanceVariant)
local Icon = require(Foundation.Components.Icon)
local IconSize = require(Foundation.Enums.IconSize)
local IconVariant = BuilderIcons.IconVariant
local InputSize = require(Foundation.Enums.InputSize)
local PresentationContext = require(Foundation.Providers.Style.PresentationContext)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useBreakpoint = require(Foundation.Providers.Responsive.Hooks.useBreakpoint)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local useSystemBannerVariants = require(script.Parent.useSystemBannerVariants)

local SEVERITY_TO_ICON = AlertConstants.SEVERITY_TO_ICON

local tbl1 = {
    variant = AlertVariant.Standard,
    testId = "--foundation-system-banner"
}

local tbl2 = {
    [AlertVariant.System] = AlertVariant.Standard,
    [AlertVariant.Feedback] = AlertVariant.Standard
}

return React.memo(React.forwardRef(function(arg1, arg2) -- name: SystemBanner
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = tbl2[var1.variant] or var1.variant

    local var4 = useSystemBannerVariants(var2, var3, var1.severity)

    local var5, var6 = React.useState(nil)
    local ref = ReactUtils.useComposedRef(arg2, var6)

    local col = useBreakpoint(var5) == Breakpoint.XSmall

    local var8 = React.useMemo(function()
        return (React.createElement(AlertActions, {
            actions = var1.actions,
            testId = `{var1.testId}--actions`,
            LayoutOrder = 3,
            tag = {
                ["row gap-small auto-xy"] = true,
                ["align-x-left"] = col,
                ["align-x-right"] = not col
            },
            padding = col and {
                top = UDim.new(0, var2.Gap.Small)
            } or nil
        }))
    end, {
        var1.actions,
        var1.testId,
        col,
        var2.Gap.Small
    })
    local value = React.useMemo(function()
        return {
            colorNamespace = var4.container.colorNamespace
        }
    end, { var4.container.colorNamespace })

    local createElement = React.createElement
    local var10 = View
    local var11 = withCommonProps
    local tbl3 = {
        tag = {
            [var4.container.tag] = true,
            ["align-y-center"] = var1.title == "" or var1.description == nil,
            ["align-y-top"] = not (var1.title == "") and var1.description ~= nil
        },
        ref = ref
    }
    local var12 = var11(var1, tbl3)

    local createElement2 = React.createElement
    local provider = PresentationContext.Provider
    local tbl4 = { value = value }
    local tbl5 = {
        Icon = React.createElement(Icon, {
            LayoutOrder = 1,
            name = SEVERITY_TO_ICON[var1.severity],
            size = IconSize.Large,
            variant = IconVariant.Filled,
            style = var4.icon.style,
            testId = `{var1.testId}--icon`
        }),
        Content = 0,
        Actions = 0,
        Close = 0
    }
    local createElement3 = React.createElement
    local var13 = View
    local tbl6 = {
        LayoutOrder = 2,
        tag = {
            ["fill auto-xy"] = true,
            col = col,
            row = not col
        },
        testId = `{var1.testId}--content`
    }
    local tbl7 = {
        Text = React.createElement(View, { LayoutOrder = 2, tag = "col auto-xy" }, {
            Title = if var1.title == "" then nil else React.createElement(Text, {
                Text = var1.title,
                textStyle = var4.title.style,
                tag = var4.title.tag,
                LayoutOrder = 1,
                testId = `{var1.testId}--title`
            }),
            Description = if var1.description then React.createElement(Text, {
                Text = var1.description,
                textStyle = var4.description.style,
                tag = var4.description.tag,
                LayoutOrder = 2,
                testId = `{var1.testId}--description`
            }) else nil,
            Actions = if col then var8 else nil
        })
    }
    tbl5.Content = createElement3(var13, tbl6, tbl7)

    if col then
        var8 = nil
    end

    tbl5.Actions = var8
    tbl5.Close = if var1.onClose == nil then nil else React.createElement(CloseAffordance, {
        onActivated = var1.onClose,
        size = InputSize.Small,
        variant = CloseAffordanceVariant.Utility,
        LayoutOrder = 4,
        testId = `{var1.testId}--close`
    })
    return createElement(var10, var12, createElement2(provider, tbl4, tbl5))
end))
