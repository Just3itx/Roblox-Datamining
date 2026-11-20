-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local AlertConstants = require(Foundation.Components.AlertActions.AlertConstants)
local AlertSeverity = require(Foundation.Enums.AlertSeverity)
local AlertVariant = require(Foundation.Enums.AlertVariant)
local Breakpoint = require(Foundation.Enums.Breakpoint)
local BreakpointConfig = require(Foundation.Utility.Responsive.BreakpointConfig)
local ButtonGroup = require(Foundation.Components.ButtonGroup)
local ButtonVariant = require(Foundation.Enums.ButtonVariant)
local CloseAffordance = require(Foundation.Components.CloseAffordance)
local CloseAffordanceVariant = require(Foundation.Enums.CloseAffordanceVariant)
local Flags = require(Foundation.Utility.Flags)
local Icon = require(Foundation.Components.Icon)
local IconSize = require(Foundation.Enums.IconSize)
local InputSize = require(Foundation.Enums.InputSize)
local Link = require(Foundation.Components.Link)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local Text = require(Foundation.Components.Text)
local TextOverflow = require(Foundation.Enums.TextOverflow)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local escapeRichText = require(Foundation.Utility.escapeRichText)
local isBuilderIcon = require(Foundation.Utility.isBuilderIcon)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local useAlertVariants = require(script.Parent.useAlertVariants)

local IconVariant = BuilderIcons.IconVariant

local tbl1 = {
    variant = AlertVariant.Feedback,
    severity = AlertSeverity.Info,
    testId = "--foundation-alert"
}

local tbl2 = {
    [AlertVariant.Standard] = AlertVariant.Feedback,
    [AlertVariant.Emphasis] = AlertVariant.Feedback
}

local width = BreakpointConfig.widths[Breakpoint.XSmall]

local function getTrailingLabels(link, actions) -- Luacid: Inlined by compiler; 1 call site recovered
    if link then
        return link.text
    elseif actions then
        return `{actions.primary.text}|{if actions.secondary then actions.secondary.text else ""}`
    end

    return ""
end

local function WrappingRichText(tbl3)
    local x, var1 = React.useState(0)
    local alertWidth = tbl3.alertWidth
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        local absoluteSizeX = arg1.AbsoluteSize.X
        if alertWidth <= 0 or absoluteSizeX <= alertWidth then
            var1(absoluteSizeX)
        end
    end, { alertWidth })

    local tbl4 = {
        [`Label-{math.floor(x)}`] = React.createElement(Text, {
            Text = tbl3.text,
            RichText = true,
            tag = {
                ["size-full-0"] = true,
                [tbl3.slot.tag] = true
            },
            padding = tbl3.slot.padding,
            sizeConstraint = x > 0 and {
                MaxSize = Vector2.new(x, math.huge)
            } or nil,
            stateLayer = tbl3.stateLayer,
            onActivated = tbl3.onActivated,
            testId = tbl3.testId
        })
    }

    return React.createElement(
        View,
        {
            tag = tbl3.slot.tag,
            LayoutOrder = tbl3.LayoutOrder,
            onAbsoluteSizeChanged = onAbsoluteSizeChanged
        },
        tbl4
    )
end

return React.memo(React.forwardRef(function(arg1, ref) -- name: Alert
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = tbl2[var1.variant] or var1.variant

    local var4, var5 = React.useState(Vector2.zero)
    local onAbsoluteSizeChanged = React.useCallback(function(arg2)
        var5(arg2.AbsoluteSize)
        if var1.onAbsoluteSizeChanged then
            var1.onAbsoluteSizeChanged(arg2)
        end
    end, { var1.onAbsoluteSizeChanged })

    local var7, var8 = React.useState(0)
    local var9 = React.useCallback(function(arg2)
        var8(arg2.AbsoluteSize.X)
    end, {})
    local trailingLabels = getTrailingLabels(var1.link, var1.actions)

    local var10 = React.useRef(false)
    React.useEffect(function()
        if var10.current then
            var8(0)
        end
        var10.current = true
    end, { trailingLabels })

    local bool1 = var4.X > 0 and var4.X <= width
    local x = var4.X * (if Flags.FoundationAlertStackTrailingOnOverflow then 0.3 else 0.4)

    if Flags.FoundationAlertStackTrailingOnOverflow then
        if not bool1 then
            if x > 0 then
                bool1 = x < var7
            else
                bool1 = false
            end
        end
    elseif not bool1 then
        if var1.actions == nil or not (x > 0) then
            bool1 = false
        else
            bool1 = x < var7
        end
    end

    local var11 = useAlertVariants(var2, var1.severity, var3, bool1)

    local buttons = React.useMemo(function()
        if not var1.actions then
            return nil
        end

        local tbl3 = {{
            text = var1.actions.primary.text,
            onActivated = var1.actions.primary.onActivated,
            variant = ButtonVariant.Standard
        }}

        if var1.actions.secondary then
            table.insert(tbl3, {
                text = var1.actions.secondary.text,
                onActivated = var1.actions.secondary.onActivated,
                variant = ButtonVariant.Utility
            })
        end

        return tbl3
    end, { var1.actions })

    local var13 = AlertConstants.SEVERITY_TO_ICON[var1.severity]
    local filled = IconVariant.Filled
    local iconBackplate = var11.iconBackplate
    local icon = var1.icon
    if icon ~= nil and var1.severity == AlertSeverity.Info then
        local var14 = if typeof(icon) == "string" then icon else icon.name

        if isBuilderIcon(var14) then
            if typeof(icon) == "table" and icon.variant then
                filled = icon.variant
            else
                filled = IconVariant.Filled
            end

            var13 = var14
            iconBackplate = nil
        end
    end

    local element = React.createElement(Icon, {
        name = var13,
        size = IconSize.Medium,
        variant = filled,
        style = var11.icon.style,
        LayoutOrder = 2,
        ZIndex = 2,
        testId = `{var1.testId}--icon`
    })
    local createElement = React.createElement
    local var14 = View
    local tbl3 = { tag = "align-y-center size-0-800 auto-x", LayoutOrder = 1 }

    local tbl4 = { Content = 0 }
    if iconBackplate then
        element = React.createElement(View, {
            Size = var11.iconFrame.Size,
            LayoutOrder = 1
        }, {
            Backplate = React.createElement(View, {
                Size = iconBackplate.Size,
                Position = iconBackplate.Position,
                tag = iconBackplate.tag,
                backgroundStyle = iconBackplate.backgroundStyle,
                LayoutOrder = 1,
                ZIndex = 1,
                testId = `{var1.testId}--icon-backplate`
            }),
            Icon = element
        })
    end

    tbl4.Content = element
    local element2 = createElement(var14, tbl3, tbl4)
    local element3

    if var1.richText then
        element3 = React.createElement(WrappingRichText, {
            slot = var11.message,
            text = var1.text,
            LayoutOrder = 2,
            testId = `{var1.testId}--message`,
            alertWidth = var4.X
        })
    else
        element3 = React.createElement(Text, {
            Text = var1.text,
            tag = var11.message.tag,
            padding = var11.message.padding,
            LayoutOrder = 2,
            testId = `{var1.testId}--message`
        })
    end

    if bool1 then
        var9 = nil
    end

    local element4

    if var1.link and Flags.FoundationAlertUseLink then
        local createElement2 = React.createElement
        local var15 = View
        local tbl5 = {
            tag = var11.linkContainer.tag,
            padding = var11.link.padding,
            LayoutOrder = 3,
            onAbsoluteSizeChanged = var9
        }
        local tbl6 = {
            Link = React.createElement(Link, {
                text = var1.link.text,
                onActivated = var1.link.onActivated,
                hasUnderline = true,
                textOverflow = if bool1 then TextOverflow.Wrap else TextOverflow.None,
                testId = `{var1.testId}--link`
            })
        }
        element4 = createElement2(var15, tbl5, tbl6)
    elseif var1.link then
        if bool1 and Flags.FoundationAlertLinkWrap then
            element4 = React.createElement(WrappingRichText, {
                slot = var11.link,
                text = `<u>{escapeRichText(var1.link.text)}</u>`,
                LayoutOrder = 3,
                testId = `{var1.testId}--link`,
                alertWidth = var4.X,
                onActivated = var1.link.onActivated,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                }
            })
        else
            element4 = React.createElement(Text, {
                Text = `<u>{escapeRichText(var1.link.text)}</u>`,
                RichText = true,
                tag = var11.link.tag,
                padding = var11.link.padding,
                sizeConstraint = if Flags.FoundationAlertStackTrailingOnOverflow or bool1 then nil else x > 0 and {
                    MaxSize = Vector2.new(x, math.huge)
                } or nil,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                },
                onActivated = var1.link.onActivated,
                LayoutOrder = 3,
                testId = `{var1.testId}--link`,
                onAbsoluteSizeChanged = var9
            })
        end
    elseif buttons then
        element4 = React.createElement(ButtonGroup, {
            buttons = buttons,
            size = InputSize.Small,
            LayoutOrder = 3,
            testId = `{var1.testId}--actions`,
            onAbsoluteSizeChanged = var9
        })
    else
        element4 = nil
    end

    local close = if var1.onClose then React.createElement(CloseAffordance, {
        onActivated = var1.onClose,
        size = InputSize.Small,
        variant = CloseAffordanceVariant.Utility,
        LayoutOrder = 4,
        testId = `{var1.testId}--close`
    }) else nil
    local var15 = bool1
        and {
            Icon = element2,
            Stack = React.createElement(
                View,
                {
                    LayoutOrder = 2,
                    tag = var11.stack.tag,
                    testId = `{var1.testId}--stack`
                },
                { Message = element3, Trailing = element4 }
            ),
            Close = close
        }
        or { Icon = element2, Message = element3, Trailing = element4, Close = close }

    local var16 = withCommonProps(var1, { tag = var11.container.tag, backgroundStyle = var11.container.backgroundStyle, ref = ref })

    var16.onAbsoluteSizeChanged = onAbsoluteSizeChanged

    local var17 = var3 == AlertVariant.System
        and {
            TopBorder = React.createElement(View, {
                Size = var11.border.Size,
                backgroundStyle = var11.border.backgroundStyle,
                LayoutOrder = 1,
                testId = `{var1.testId}--top-border`
            }),
            Main = React.createElement(View, { tag = var11.main.tag, LayoutOrder = 2 }, var15),
            BottomBorder = React.createElement(View, {
                Size = var11.border.Size,
                backgroundStyle = var11.border.backgroundStyle,
                LayoutOrder = 3,
                testId = `{var1.testId}--bottom-border`
            })
        }
        or var15

    return React.createElement(View, var16, var17)
end))
