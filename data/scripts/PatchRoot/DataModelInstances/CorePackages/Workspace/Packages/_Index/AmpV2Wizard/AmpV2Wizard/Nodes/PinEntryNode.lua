-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local Foundation = require(AmpV2WizardParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text

local _Types = require(AmpV2Wizard.Types)
local FullPageChrome = require(AmpV2Wizard.FullPageChrome)
local CodeInput = require(AmpV2Wizard.CodeInput)
local OdpAnalytics = require(AmpV2Wizard.OdpAnalytics)

local function PinEntryNode(arg1)
    local props = arg1.props
    local report = arg1.report
    local transitions = arg1.transitions
    local var1 = OdpAnalytics.useOdpAnalytics(arg1.ctx)

    local value, var3 = React.useState("")
    local var4, var5 = React.useState(false)

    local var6 = React.useRef(false)
    local controlRef = React.useRef(nil)

    local var8 = React.useRef(false)
    React.useEffect(function()
        if not var8.current then
            var8.current = true
            var1.pinEntryShown()
        end
    end, { var1 })

    local var9 = React.useRef(0)

    React.useEffect(function()
        var3("")
        var5(false)
        var6.current = false
        var9.current = 0
    end, { props })

    local var10 = React.useRef(nil)
    React.useEffect(function()
        if var10.current == props then
            return
        end
        var10.current = props
        if props.error ~= nil and props.error ~= "" then
            var1.pinEntryIncorrect()
        end
    end, { props, var1 })

    local onChanged = React.useCallback(function(str1: string)
        if #str1 ~= var9.current then
            var9.current = #str1
            var1.pinEntryDigitsChanged(#str1)
        end
        var3(str1)
    end, { var1 })

    local onComplete = React.useCallback(function(pin: string)
        report("Success", { pin = pin })
    end, { report })

    local onActivated = React.useCallback(function()
        local current = controlRef.current
        if current ~= nil then
            current.releaseFocus()
        end
        var1.pinEntryForgotPin()
        report("ForgotPin")
    end, { report, var1 })

    local var14 = React.useCallback(function()
        local current = controlRef.current
        if current ~= nil then
            current.releaseFocus()
        end
        report("Back")
    end, { report })

    local var15 = React.useCallback(function()
        local current = controlRef.current
        if current ~= nil then
            current.releaseFocus()
        end
        report("Cancel")
    end, { report })

    local var2 = React.useCallback(function()
        local current = not var6.current
        var6.current = current
        var1.pinEntryRevealToggled(current)
        var5(current)
    end, { var1 })

    local createElement = React.createElement
    local var17 = View
    local tbl1 = { tag = "col gap-xlarge size-full-0 auto-y padding-y-xlarge" }

    local tbl2 = {
        Copy = React.createElement(View, {
            tag = "col gap-none size-full-0 auto-y padding-x-xlarge",
            LayoutOrder = 1
        }, {
            Title = React.createElement(FoundationText, {
                Text = props.title,
                tag = "size-full-0 auto-y text-heading-medium text-wrap text-align-x-left content-emphasis",
                LayoutOrder = 1
            }),
            Description = React.createElement(FoundationText, {
                Text = props.description,
                tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-left content-default",
                LayoutOrder = 2
            }),
            ForgotPin = React.createElement(FoundationText, {
                Text = `<u>{props.forgotPinLabel}</u>`,
                RichText = true,
                onActivated = onActivated,
                tag = "auto-xy text-body-large text-align-x-left content-default",
                LayoutOrder = 3
            })
        }),
        Field = 0
    }

    local createElement2 = React.createElement
    local var18 = View
    local tbl3 = { tag = "col gap-none size-full-0 auto-y padding-x-xlarge", LayoutOrder = 2 }

    local tbl4 = { Label = 0, Input = 0, Error = 0 }
    local createElement3 = React.createElement
    local var19 = View
    local tbl5 = {
        tag = "row flex-between align-y-center gap-xsmall size-full-0 auto-y padding-bottom-small",
        LayoutOrder = 1
    }

    local tbl6 = {
        InputLabel = React.createElement(
            FoundationText,
            {
                Text = props.inputLabel,
                tag = "auto-xy text-title-medium text-align-x-left content-emphasis",
                LayoutOrder = 1
            }
        ),
        RevealToggle = React.createElement(FoundationText, {
            Text = if var4 then props.hidePinLabel else props.showPinLabel,
            onActivated = var2,
            tag = "auto-xy text-title-medium content-default",
            LayoutOrder = 2
        })
    }
    tbl4.Label = createElement3(var19, tbl5, tbl6)

    tbl4.Input = React.createElement(CodeInput, {
        value = value,
        onChanged = onChanged,
        length = 6,
        onComplete = onComplete,
        isMasked = not var4,
        controlRef = controlRef,
        LayoutOrder = 2
    })

    tbl4.Error = if props.error == nil or props.error == "" then nil else React.createElement(FoundationText, {
        Text = props.error,
        tag = "size-full-0 auto-y padding-top-small text-body-small text-wrap text-align-x-left content-system-alert",
        LayoutOrder = 3
    })
    tbl2.Field = createElement2(var18, tbl3, tbl4)
    local content = createElement(var17, tbl1, tbl2)

    local createElement4 = React.createElement
    local var20 = FullPageChrome
    local tbl7 = {
        title = props.headerTitle,
        onBack = 0,
        onClose = 0
    }

    if transitions == nil or transitions.Back == nil then
        var14 = nil
    end

    tbl7.onBack = var14
    if transitions == nil or transitions.Back ~= nil or transitions.Cancel == nil then
        var15 = nil
    end

    tbl7.onClose = var15
    return createElement4(var20, tbl7, { Content = content })
end

return PinEntryNode
