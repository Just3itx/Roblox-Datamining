-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:31:20Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)

local Button = require(Foundation.Components.Button)
local ButtonGroup = require(Foundation.Components.ButtonGroup)
local CloseAffordance = require(Foundation.Components.CloseAffordance)
local CloseAffordanceVariant = require(Foundation.Enums.CloseAffordanceVariant)
local ColorNamespace = require(Foundation.Enums.ColorNamespace)
local FillBehavior = require(Foundation.Enums.FillBehavior)
local Flags = require(Foundation.Utility.Flags)
local InputSize = require(Foundation.Enums.InputSize)
local Logger = require(Foundation.Utility.Logger)
local Orientation = require(Foundation.Enums.Orientation)
local Popover = require(Foundation.Components.Popover)
local PopoverAlign = require(Foundation.Enums.PopoverAlign)
local PopoverSide = require(Foundation.Enums.PopoverSide)
local PresentationContext = require(Foundation.Providers.Style.PresentationContext)
local Radius = require(Foundation.Enums.Radius)
local Text = require(Foundation.Components.Text)
local Translator = require(Foundation.Utility.Localization.Translator)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local useScaledValue = require(Foundation.Utility.useScaledValue)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    isOpen = false,
    align = PopoverAlign.Start,
    side = PopoverSide.Right,
    hasArrow = true,
    actionsFillBehavior = if Flags.FoundationEducationalTooltipRefresh then FillBehavior.Fill else nil,
    testId = "--foundation-coachmark"
}

local value = {
    colorNamespace = ColorNamespace.Inverse
}
local function stepsText(current: number, total: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return Translator:FormatByKey("CommonUI.Controls.Label.PageCount", { current = current, total = total })
end

return React.memo(React.forwardRef(function(arg1, ref) -- name: Coachmark
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local x = useScaledValue(if Flags.FoundationEducationalTooltipRefresh then Constants.TOOLTIP_MAX_WIDTH else 320)

    local x2 = useScaledValue(240)
    if Flags.FoundationEducationalTooltipMinMediaWidth and not var1.media then
        x2 = var2.Size.Size_3000
    end

    local var3 = if Flags.FoundationEducationalTooltipMinMediaWidth then nil else var1.onClose and {
        MaxSize = Vector2.new(x - var2.Size.Size_1200, math.huge)
    } or nil

    local buttons = React.useMemo(function()
        local result = ({})

        if not var1.actions then
            return result
        end

        for layoutOrder, action in var1.actions do
            if not Flags.FoundationEducationalTooltipRefresh and layoutOrder > 2 then
                Logger:warning(`Coachmark only supports up to {2} actions`)
                return result
            end

            if Flags.FoundationEducationalTooltipRefresh then
                result[layoutOrder] = action
            else
                local tbl3 = {
                    LayoutOrder = layoutOrder,
                    size = InputSize.Medium,
                    fillBehavior = FillBehavior.Fill,
                    testId = `{var1.testId}--action-{layoutOrder}`
                }
                local var4 = Dash.union(action, tbl3)
                result["CoachmarkButton" .. layoutOrder] = React.createElement(Button, var4)
            end
        end
        return result
    end, { var1.actions, var1.testId })

    local var5 = if Flags.FoundationEducationalTooltipMinMediaWidth then var1.onClose and not var1.media else nil
    local bool1 = if Flags.FoundationEducationalTooltipBodyOnlyContentLayout
        and var1.title == ""
        and var1.text ~= nil
        and var1.text ~= ""
        and var1.media == nil
        and var1.steps == nil then var1.actions == nil or #var1.actions == 0 else false
    local createElement = React.createElement
    local root = Popover.Root
    local tbl3 = {
        isOpen = var1.isOpen,
        testId = var1.testId
    }
    local tbl4 = {
        Anchor = React.createElement(Popover.Anchor, withCommonProps(var1, { anchorRef = var1.anchorRef }), var1.children),
        Content = 0
    }
    local createElement2 = React.createElement
    local content = Popover.Content
    local tbl5 = {
        hasArrow = var1.hasArrow,
        align = var1.align,
        DO_NOT_USE_hasContentInputSink = true,
        onPressedOutside = var1.onPressedOutside,
        side = {
            position = var1.side,
            offset = var2.Size.Size_200
        },
        radius = Radius.Medium,
        backgroundStyle = var2.Inverse.Surface.Surface_0,
        selection = var1.selection,
        selectionGroup = var1.selectionGroup,
        ref = ref
    }
    local createElement3 = React.createElement
    local provider = PresentationContext.Provider
    local tbl6 = { value = value }

    local createElement4 = React.createElement
    local var6 = View
    local tbl7 = {
        testId = var1.testId,
        tag = if Flags.FoundationEducationalTooltipRefresh then "col auto-xy" else "col gap-medium auto-xy padding-bottom-medium",
        sizeConstraint = {
            MaxSize = Vector2.new(x, math.huge),
            MinSize = if Flags.FoundationEducationalTooltipRefresh then Vector2.new(x2, 0) else nil
        }
    }

    local tbl8 = { CloseAffordanceContainer = 0, Media = 0, ContentSection = 0, Actions = 0 }
    local element

    if var1.onClose then
        element = React.createElement("Folder", {}, {
            CloseAffordance = React.createElement(CloseAffordance, {
                onActivated = var1.onClose,
                size = InputSize.Small,
                variant = CloseAffordanceVariant.Utility,
                Position = UDim2.new(1, -var2.Padding.Small, 0, var2.Padding.Small),
                AnchorPoint = Vector2.new(1, 0),
                ZIndex = 2,
                testId = `{var1.testId}--close-affordance`
            })
        })
    else
        element = nil
    end

    tbl8.CloseAffordanceContainer = element

    tbl8.Media = if var1.media then React.createElement(View, { LayoutOrder = 1, tag = "size-full-0 auto-y" }, var1.media) else nil

    local createElement5 = React.createElement
    local var7 = View
    local tbl9 = { LayoutOrder = 2, tag = 0, padding = 0, sizeConstraint = 0 }
    local tbl10

    if Flags.FoundationEducationalTooltipMinMediaWidth then
        tbl10 = {
            [if Flags.FoundationEducationalTooltipRefresh then "col auto-xy" else "col gap-xsmall auto-xy"] = not (Flags.FoundationEducationalTooltipBodyOnlyContentLayout and bool1),
            ["col align-y-center auto-xy"] = if Flags.FoundationEducationalTooltipBodyOnlyContentLayout then bool1 else false,
            [if Flags.FoundationEducationalTooltipRefresh then "padding-medium" else "padding-x-medium padding-bottom-xsmall padding-top-medium"] = not (var5 or bool1)
        }
    else
        tbl10 = if Flags.FoundationEducationalTooltipRefresh then "col auto-xy padding-medium" else "col gap-xsmall auto-xy padding-x-medium padding-bottom-xsmall padding-top-medium"
    end

    tbl9.tag = tbl10
    local tbl11

    if bool1 then
        tbl11 = {
            top = UDim.new(0, var2.Padding.Small),
            bottom = UDim.new(0, var2.Padding.Small),
            left = UDim.new(0, var2.Padding.Medium),
            right = 0
        }
        local new = UDim.new
        local num1 = 0
        local var8 = if var5 then var2.Size.Size_1200 else var2.Padding.Medium
        tbl11.right = new(num1, var8)
    elseif Flags.FoundationEducationalTooltipMinMediaWidth and var5 then
        tbl11 = {
            top = UDim.new(0, var2.Padding.Medium),
            bottom = 0,
            left = 0,
            right = 0
        }
        local new = UDim.new
        local num1 = 0
        local var8 = if Flags.FoundationEducationalTooltipRefresh then var2.Padding.Medium else var2.Padding.XSmall
        tbl11.bottom = new(num1, var8)

        tbl11.left = UDim.new(0, var2.Padding.Medium)
        tbl11.right = UDim.new(0, var2.Size.Size_1200)
    else
        tbl11 = nil
    end

    tbl9.padding = tbl11

    tbl9.sizeConstraint = bool1 and {
        MinSize = Vector2.new(0, var2.Size.Size_800)
    } or nil

    local tbl12 = { StepIndicator = 0, Header = 0, Text = 0 }
    local element2

    if var1.steps then
        element2 = React.createElement(Text, {
            LayoutOrder = 1,
            Text = stepsText(var1.steps.current, var1.steps.total),
            tag = if Flags.FoundationEducationalTooltipRefresh then "auto-xy text-caption-medium text-align-x-left text-truncate-end content-inverse-default" else "auto-xy text-label-small text-align-x-left text-truncate-end content-inverse-default",
            sizeConstraint = if Flags.FoundationEducationalTooltipMinMediaWidth then nil else var3,
            testId = `{var1.testId}--step-indicator`
        })
    else
        element2 = nil
    end

    tbl12.StepIndicator = element2
    local var8

    if var1.title == "" then
        var8 = nil
    else
        local createElement6 = React.createElement
        local var9 = Text
        local tbl13 = {
            LayoutOrder = 2,
            Text = var1.title,
            tag = "auto-xy text-title-large text-align-x-left text-truncate-split content-inverse-emphasis",
            sizeConstraint = 0,
            testId = 0
        }
        if Flags.FoundationEducationalTooltipMinMediaWidth then
            var3 = nil
        end

        tbl13.sizeConstraint = var3

        tbl13.testId = `{var1.testId}--header`
        var8 = createElement6(var9, tbl13)
    end

    tbl12.Header = var8
    local element3

    if var1.text and var1.text ~= "" then
        element3 = React.createElement(Text, {
            LayoutOrder = 3,
            Text = var1.text,
            tag = if Flags.FoundationEducationalTooltipMinMediaWidth then "auto-xy text-body-medium text-wrap text-align-x-left content-inverse-default" else "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-inverse-default",
            padding = if Flags.FoundationEducationalTooltipRefresh then not Flags.FoundationEducationalTooltipMinMediaWidth and {
                top = UDim.new(0, var2.Size.Size_100)
            }
                or var1.title ~= "" and {
                    top = UDim.new(0, var2.Size.Size_100)
                }
                or nil else nil,
            testId = `{var1.testId}--text`
        })
    else
        element3 = nil
    end

    tbl12.Text = element3
    tbl8.ContentSection = createElement5(var7, tbl9, tbl12)
    local element4

    if var1.actions and #var1.actions > 0 then
        element4 = React.createElement(
            View,
            {
                LayoutOrder = 3,
                tag = if Flags.FoundationEducationalTooltipRefresh then "row align-x-right size-full-0 auto-y padding-x-medium padding-bottom-medium" else "row gap-small size-full-0 auto-y padding-x-medium"
            },
            Flags.FoundationEducationalTooltipRefresh
                and {
                    ButtonGroup = React.createElement(ButtonGroup, {
                        buttons = buttons,
                        fillBehavior = var1.actionsFillBehavior,
                        maxButtonCount = 2,
                        orientation = Orientation.Horizontal,
                        size = InputSize.Small,
                        testId = `{var1.testId}--actions`
                    })
                }
                or buttons
        )
    else
        element4 = nil
    end

    tbl8.Actions = element4
    tbl4.Content = createElement2(content, tbl5, createElement3(provider, tbl6, createElement4(var6, tbl7, tbl8)))
    return createElement(root, tbl3, tbl4)
end))
