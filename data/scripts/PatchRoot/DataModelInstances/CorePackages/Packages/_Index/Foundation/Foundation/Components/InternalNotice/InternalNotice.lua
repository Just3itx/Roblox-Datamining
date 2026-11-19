-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:11:04Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local CloseAffordance = require(Foundation.Components.CloseAffordance)
local CloseAffordanceVariant = require(Foundation.Enums.CloseAffordanceVariant)
local Flags = require(Foundation.Utility.Flags)
local Icon = require(Foundation.Components.Icon)
local InputSize = require(Foundation.Enums.InputSize)
local Link = require(Foundation.Components.Link)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local Text = require(Foundation.Components.Text)
local TextOverflow = require(Foundation.Enums.TextOverflow)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local escapeRichText = require(Foundation.Utility.escapeRichText)
local useInternalNoticeLayout = require(script.Parent.useInternalNoticeLayout)
local useInternalNoticeVariantsProps = require(script.Parent.useInternalNoticeVariantsProps)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)

return React.memo(React.forwardRef(function(arg1, ref) -- name: InternalNotice
    local testId = arg1.testId or "--foundation-internal-notice"
    local size600 = useTokens().Size.Size_600
    local uDim2 = UDim2.fromOffset(0, size600)
    local sizeConstraint = React.useMemo(function()
        return {
            MinSize = Vector2.new(0, size600)
        }
    end, { size600 })

    local var2 = useInternalNoticeLayout(arg1.onAbsoluteSizeChanged)
    local isStacked = var2.isStacked
    local var3 = useInternalNoticeVariantsProps(arg1.variantProps, isStacked, arg1.truncation == true)

    local var4 = typeof(arg1.icon) == "string" and {
        name = arg1.icon,
        variant = nil
    } or arg1.icon
    local icon = if var4 then React.createElement(Icon, {
        name = var4.name,
        variant = var4.variant,
        size = var3.icon.size,
        style = var3.icon.style,
        LayoutOrder = 1,
        testId = `{testId}--icon`
    }) else nil
    local element = if icon then React.createElement(View, { tag = "col align-y-center auto-x", Size = uDim2, LayoutOrder = 1 }, { Icon = icon }) else nil
    local message = React.createElement(Text, {
        Text = arg1.text,
        tag = var3.message.tag,
        padding = var3.message.padding,
        LayoutOrder = 2,
        testId = `{testId}--message`
    })

    local linkContainer = var3.linkContainer
    local element4

    if arg1.link and Flags.FoundationInternalNoticeUseLink then
        local createElement = React.createElement
        local var5 = View
        local tbl1 = {
            tag = if linkContainer then linkContainer.tag else nil,
            padding = var3.link.padding,
            LayoutOrder = if isStacked then 3 else 2,
            onAbsoluteSizeChanged = var2.measureInlineLink
        }
        local tbl2 = {
            Link = React.createElement(Link, {
                text = arg1.link.text,
                onActivated = arg1.link.onActivated,
                size = var3.link.size,
                hasUnderline = true,
                textOverflow = if isStacked then if arg1.truncation then TextOverflow.Truncate else TextOverflow.Wrap else TextOverflow.None,
                testId = `{testId}--link`
            })
        }
        element4 = createElement(var5, tbl1, tbl2)
    elseif arg1.link then
        element4 = React.createElement(Text, {
            Text = `<u>{escapeRichText(arg1.link.text)}</u>`,
            RichText = true,
            tag = var3.link.tag,
            padding = var3.link.padding,
            sizeConstraint = var2.stackedLinkConstraint,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onActivated = arg1.link.onActivated,
            LayoutOrder = if isStacked then 3 else 2,
            testId = `{testId}--link`,
            onAbsoluteSizeChanged = var2.measureInlineLink
        })
    else
        element4 = nil
    end

    local close = if arg1.onClose then React.createElement(
        View,
        { tag = "col align-y-center auto-x", Size = uDim2, LayoutOrder = 3 },
        {
            Close = React.createElement(CloseAffordance, {
                onActivated = arg1.onClose,
                size = InputSize.Small,
                variant = CloseAffordanceVariant.Utility,
                hasPadding = false,
                LayoutOrder = 1,
                testId = `{testId}--close`
            })
        }
    ) else nil
    local container = var3.container
    local var5 = withCommonProps(arg1, {
        tag = if container then container.tag else nil,
        backgroundStyle = if container then container.backgroundStyle else nil,
        ref = ref
    })
    var5.onAbsoluteSizeChanged = var2.onNoticeAbsoluteSizeChanged

    local main = React.createElement(
        View,
        {
            tag = var3.content.tag,
            padding = var3.content.padding,
            LayoutOrder = if var3.border then 2 else 1
        },
        isStacked
            and {
                Icon = element,
                Stack = React.createElement(View, {
                    LayoutOrder = 2,
                    tag = var3.stack.tag,
                    sizeConstraint = sizeConstraint,
                    onAbsoluteSizeChanged = var2.onStackedColumnAbsoluteSizeChanged,
                    testId = `{testId}--stack`
                }, { Message = message, Link = element4 }),
                Close = close
            }
            or {
                Leading = React.createElement(
                    View,
                    {
                        tag = var3.leading.tag,
                        sizeConstraint = sizeConstraint,
                        LayoutOrder = 1,
                        testId = `{testId}--leading`
                    },
                    { Icon = element, Message = message }
                ),
                Link = element4,
                Close = close
            }
    )

    return React.createElement(
        View,
        var5,
        var3.border
            and {
                TopBorder = React.createElement(View, {
                    Size = var3.border.Size,
                    backgroundStyle = var3.border.backgroundStyle,
                    LayoutOrder = 1,
                    testId = `{testId}--top-border`
                }),
                Main = main,
                BottomBorder = React.createElement(View, {
                    Size = var3.border.Size,
                    backgroundStyle = var3.border.backgroundStyle,
                    LayoutOrder = 3,
                    testId = `{testId}--bottom-border`
                })
            }
            or { Main = main }
    )
end))
