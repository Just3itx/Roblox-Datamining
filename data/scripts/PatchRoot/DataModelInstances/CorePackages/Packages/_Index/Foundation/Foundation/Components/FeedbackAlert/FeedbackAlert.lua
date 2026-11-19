-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:51:19Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactUtils = require(FoundationParent.ReactUtils)

local AlertActions = require(Foundation.Components.AlertActions)
local AlertConstants = require(Foundation.Components.AlertActions.AlertConstants)
local _AlertSeverity = require(Foundation.Enums.AlertSeverity)
local BuilderIcons = require(FoundationParent.BuilderIcons)
local CloseAffordance = require(Foundation.Components.CloseAffordance)
local CloseAffordanceVariant = require(Foundation.Enums.CloseAffordanceVariant)
local ControlState = require(Foundation.Enums.ControlState)
local Icon = require(Foundation.Components.Icon)
local IconSize = require(Foundation.Enums.IconSize)
local InputSize = require(Foundation.Enums.InputSize)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local escapeRichText = require(Foundation.Utility.escapeRichText)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)
local IconVariant = BuilderIcons.IconVariant

local useFeedbackAlertVariants = require(script.Parent.useFeedbackAlertVariants)

local tbl1 = { testId = "--foundation-feedback-alert" }

return React.memo(React.forwardRef(function(arg1, arg2) -- name: FeedbackAlert
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()

    local var3 = useFeedbackAlertVariants(var2, var1.severity)

    local ref = ReactUtils.useComposedRef(arg2)
    local var5 = if var1.link then escapeRichText(var1.link.text) else nil
    local var6, var7 = React.useState(false)
    local onStateChanged = React.useCallback(function(hover)
        var7(hover == ControlState.Hover)
    end, {})

    local createElement = React.createElement
    local var9 = View
    local var10 = withCommonProps(
        var1,
        {
            tag = var3.container.tag,
            stroke = var3.stroke,
            backgroundStyle = var3.backgroundStyle,
            ref = ref
        }
    )
    local tbl2 = { HeaderRow = 0, Description = 0, Actions = 0 }
    local createElement2 = React.createElement
    local var11 = View
    local tbl3 = {
        LayoutOrder = 1,
        tag = var3.headerRow.tag,
        testId = `{var1.testId}--header`
    }
    local tbl4 = {
        Icon = React.createElement(Icon, {
            LayoutOrder = 1,
            name = AlertConstants.SEVERITY_TO_ICON[var1.severity],
            size = IconSize.Large,
            variant = IconVariant.Filled,
            style = var3.icon.style,
            testId = `{var1.testId}--icon`
        }),
        Content = 0,
        Close = 0
    }
    local createElement3 = React.createElement
    local var12 = View
    local tbl5 = {
        LayoutOrder = 2,
        tag = "row align-y-center fill gap-xsmall auto-y",
        testId = `{var1.testId}--content`
    }
    local tbl6 = {
        Title = React.createElement(
            Text,
            {
                Text = var1.title,
                tag = var3.title.tag,
                LayoutOrder = 1,
                testId = `{var1.testId}--title`
            }
        ),
        Subtitle = if var1.subtitle then React.createElement(
            Text,
            {
                Text = var1.subtitle,
                tag = var3.subtitle.tag,
                LayoutOrder = 2,
                testId = `{var1.testId}--subtitle`
            }
        ) else nil,
        Separator = if var1.link then React.createElement(Text, {
            Text = "·",
            tag = "auto-xy text-body-medium content-default",
            LayoutOrder = 3,
            testId = `{var1.testId}--separator`
        }) else nil,
        Link = 0
    }
    local var13

    if var1.link then
        local createElement4 = React.createElement
        local var14 = Text
        local tbl7 = {
            Text = 0,
            RichText = true,
            tag = 0,
            LayoutOrder = 4,
            stateLayer = 0,
            onStateChanged = 0,
            onActivated = 0,
            testId = 0
        }

        if var6 then
            var5 = `<u>{var5}</u>`
        end

        tbl7.Text = var5

        tbl7.tag = var3.link.tag

        tbl7.stateLayer = {
            affordance = StateLayerAffordance.None
        }
        tbl7.onStateChanged = onStateChanged
        tbl7.onActivated = var1.link.onActivated
        tbl7.testId = `{var1.testId}--link`
        var13 = createElement4(var14, tbl7)
    else
        var13 = nil
    end

    tbl6.Link = var13
    tbl4.Content = createElement3(var12, tbl5, tbl6)

    tbl4.Close = if var1.onClose == nil then nil else React.createElement(CloseAffordance, {
        onActivated = var1.onClose,
        size = InputSize.XSmall,
        variant = CloseAffordanceVariant.Utility,
        LayoutOrder = 3,
        testId = `{var1.testId}--close`
    })
    tbl2.HeaderRow = createElement2(var11, tbl3, tbl4)

    tbl2.Description = if var1.description then React.createElement(Text, {
        Text = var1.description,
        tag = var3.description.tag,
        LayoutOrder = 2,
        testId = `{var1.testId}--description`
    }) else nil

    tbl2.Actions = React.createElement(
        AlertActions,
        {
            actions = var1.actions,
            testId = `{var1.testId}--actions`,
            LayoutOrder = 3
        }
    )
    return createElement(var9, var10, tbl2)
end))
