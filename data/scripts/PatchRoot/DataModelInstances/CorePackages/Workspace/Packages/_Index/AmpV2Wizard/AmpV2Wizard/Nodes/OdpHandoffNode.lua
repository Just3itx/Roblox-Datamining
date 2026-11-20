-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local Foundation = require(AmpV2WizardParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Button = Foundation.Button
local ScrollView = Foundation.ScrollView
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local _Types = require(AmpV2Wizard.Types)
local FullPageChrome = require(AmpV2Wizard.FullPageChrome)
local ODPTiltedCardsArt = require(AmpV2Wizard.ODPTiltedCardsArt)
local OdpAnalytics = require(AmpV2Wizard.OdpAnalytics)

local function OdpHandoffNode(arg1)
    local props = arg1.props
    local report = arg1.report
    local transitions = arg1.transitions
    local var1 = OdpAnalytics.useOdpAnalytics(arg1.ctx)
    local var2 = React.useRef(false)
    React.useEffect(function()
        if not var2.current then
            var2.current = true
            var1.handoffShown()
        end
    end, { var1 })

    local onActivated = React.useCallback(function()
        var1.handoffContinue()
        report("Continue")
    end, { report, var1 })

    local var4 = React.useCallback(function()
        var1.handoffBack()
        report("Back")
    end, { report, var1 })

    local bool1 = not (transitions == nil) and transitions.Back ~= nil

    local var5 = React.useCallback(function()
        report("Cancel")
    end, { report })

    local bool2 = not (transitions == nil) and transitions.Cancel ~= nil
    local createElement = React.createElement
    local var6 = View
    local tbl1 = { tag = "col size-full" }
    local tbl2 = { Body = 0, Footer = 0 }
    local createElement2 = React.createElement
    local var7 = ScrollView
    local tbl3 = {
        LayoutOrder = 1,
        flexItem = {
            FlexMode = Enum.UIFlexMode.Fill
        },
        Size = UDim2.fromScale(1, 0),
        scroll = {
            ScrollingDirection = Enum.ScrollingDirection.Y,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.fromScale(0, 1)
        }
    }
    local tbl4 = { Content = 0 }
    local createElement3 = React.createElement
    local var8 = View
    local tbl5 = { tag = "col gap-none size-full-0 auto-y" }

    local tbl6 = {
        Hero = React.createElement(ODPTiltedCardsArt, { LayoutOrder = 1 }),
        Copy = 0
    }
    local createElement4 = React.createElement
    local var9 = View
    local tbl7 = {
        tag = "col gap-xlarge size-full-0 auto-y padding-x-xlarge padding-y-xlarge",
        LayoutOrder = 2
    }

    local tbl8 = {
        Intro = React.createElement(View, {
            tag = "col gap-none size-full-0 auto-y",
            LayoutOrder = 1
        }, {
            Title = React.createElement(FoundationText, {
                Text = props.title,
                tag = "size-full-0 auto-y text-heading-medium text-wrap text-align-x-left content-emphasis",
                LayoutOrder = 1
            }),
            Description = if props.description == nil or props.description == "" then nil else React.createElement(
                FoundationText,
                {
                    Text = props.description,
                    tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-left content-default",
                    LayoutOrder = 2
                }
            )
        })
    }
    tbl6.Copy = createElement4(var9, tbl7, tbl8)
    tbl4.Content = createElement3(var8, tbl5, tbl6)
    tbl2.Body = createElement2(var7, tbl3, tbl4)

    tbl2.Footer = React.createElement(
        View,
        {
            tag = "col gap-small size-full-0 auto-y padding-x-xlarge padding-bottom-large",
            LayoutOrder = 2
        },
        {
            Continue = React.createElement(Button, {
                text = props.continueLabel or "",
                onActivated = onActivated,
                variant = ButtonVariant.Emphasis,
                size = InputSize.Medium,
                width = UDim.new(1, 0),
                LayoutOrder = 1
            })
        }
    )
    local content = createElement(var6, tbl1, tbl2)

    local createElement5 = React.createElement
    local var10 = FullPageChrome
    local tbl9 = {
        title = props.headerTitle,
        onBack = 0,
        onClose = 0
    }

    if not bool1 then
        var4 = nil
    end

    tbl9.onBack = var4
    if bool1 or not bool2 then
        var5 = nil
    end

    tbl9.onClose = var5
    return createElement5(var10, tbl9, { Content = content })
end

return OdpHandoffNode
