-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local Foundation = require(AmpV2WizardParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Button = Foundation.Button
local InputLabel = Foundation.InputLabel
local ScrollView = Foundation.ScrollView
local OptionSelectorGroup = Foundation.OptionSelectorGroup
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local _Types = require(AmpV2Wizard.Types)
local OdpAnalytics = require(AmpV2Wizard.OdpAnalytics)
local FullPageChrome = require(AmpV2Wizard.FullPageChrome)

local tbl1 = {
    FAE = "square-person",
    IDV = "rectangle-person-with-three-horizontal-lines",
    CCV = "credit-card"
}

local function VerificationMethodSelectionNode(arg1)
    local props = arg1.props
    local report = arg1.report
    local var1 = props.methods or {}
    local var2 = OdpAnalytics.useOdpAnalytics(arg1.ctx)
    local id = if var1[1] == nil then nil else var1[1].id
    local value, var4 = React.useState(id)

    React.useEffect(function()
        var2.verificationMethodSelectorShown(id)
    end, {})

    local onActivated = React.useCallback(function()
        if value ~= nil then
            var2.verificationMethodContinue(value)
            report(value)
        end
    end, { value, report, var2 })

    local var6 = React.useCallback(function()
        var2.verificationMethodBack()
        report("Back")
    end, { report, var2 })

    local onValueChanged = React.useCallback(function(str1: string?)
        if str1 ~= nil then
            var2.verificationMethodSelected(str1)
            var4(str1)
        end
    end, { var4, var2 })

    local tbl2 = ({})
    for layoutOrder, value2 in var1 do
        local id2 = value2.id
        tbl2[id2] = React.createElement(OptionSelectorGroup.Item, {
            value = value2.id,
            label = value2.label,
            description = value2.description,
            icon = tbl1[value2.id],
            LayoutOrder = layoutOrder
        })
    end

    local body = React.createElement(View, { tag = "col gap-xlarge size-full-0 auto-y" }, {
        TitleAndBody = React.createElement(View, {
            tag = "col gap-xsmall size-full-0 auto-y",
            LayoutOrder = 1
        }, {
            Title = React.createElement(FoundationText, {
                Text = props.title,
                tag = "size-full-0 auto-y text-heading-medium text-wrap text-align-x-left text-align-y-top content-emphasis",
                LayoutOrder = 1
            }),
            Description = React.createElement(FoundationText, {
                Text = props.description,
                tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-left text-align-y-top content-default",
                LayoutOrder = 2
            })
        }),
        Options = React.createElement(View, {
            tag = "col gap-small size-full-0 auto-y padding-x-xsmall",
            LayoutOrder = 2
        }, {
            OptionsLabel = React.createElement(InputLabel, { Text = props.optionsLabel, LayoutOrder = 1 }),
            OptionList = React.createElement(
                OptionSelectorGroup.Root,
                { value = value, onValueChanged = onValueChanged, LayoutOrder = 2 },
                {
                    Items = React.createElement(View, { tag = "col gap-medium size-full-0 auto-y" }, tbl2)
                }
            )
        })
    })
    local bool1 = not (arg1.transitions == nil) and arg1.transitions.Back ~= nil
    local content = React.createElement(View, { tag = "col size-full" }, {
        Body = React.createElement(ScrollView, {
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
        }, {
            Content = React.createElement(
                View,
                { tag = "col gap-none size-full-0 auto-y padding-x-xlarge padding-y-xlarge" },
                { Body = body }
            )
        }),
        Footer = if value == nil then nil else React.createElement(
            View,
            {
                tag = "col gap-small size-full-0 auto-y padding-x-xlarge padding-bottom-large",
                LayoutOrder = 2
            },
            {
                Continue = React.createElement(Button, {
                    text = props.continueLabel,
                    onActivated = onActivated,
                    variant = ButtonVariant.Emphasis,
                    size = InputSize.Medium,
                    width = UDim.new(1, 0),
                    LayoutOrder = 1
                })
            }
        )
    })

    local createElement = React.createElement
    local var8 = FullPageChrome
    local tbl3 = {
        title = props.headerTitle,
        onBack = 0
    }

    if not bool1 then
        var6 = nil
    end

    tbl3.onBack = var6
    return createElement(var8, tbl3, { Content = content })
end

return VerificationMethodSelectionNode
