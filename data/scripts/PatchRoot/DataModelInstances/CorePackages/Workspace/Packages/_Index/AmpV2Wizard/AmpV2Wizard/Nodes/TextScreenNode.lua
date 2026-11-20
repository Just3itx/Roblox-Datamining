-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local Foundation = require(AmpV2WizardParent.Foundation)
local Dialog = Foundation.Dialog
local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize
local EnumsOrientation = Foundation.Enums.Orientation
local useTokens = Foundation.Hooks.useTokens

local InlineRichText = require(AmpV2WizardParent.InlineRichText)
local Renderer = InlineRichText.Renderer
local LinkBehavior = InlineRichText.Enums.LinkBehavior
local prepareRichTextCopy = InlineRichText.prepareRichTextCopy

local _Types = require(AmpV2Wizard.Types)
local OdpAnalytics = require(AmpV2Wizard.OdpAnalytics)
local OdpAnalyticsConstants = require(AmpV2Wizard.OdpAnalyticsConstants)
local VpcEntryAnalytics = require(AmpV2Wizard.VpcEntryAnalytics)
local FFlagLuaAppOdpPrologueAnalytics = require(AmpV2WizardParent.SharedFlags).FFlagLuaAppOdpPrologueAnalytics

local FFlagLuaAppAmpWizardSendAnalyticsSessionId = require(AmpV2WizardParent.SharedFlags).FFlagLuaAppAmpWizardSendAnalyticsSessionId

local function TextScreenNode(arg1)
    local props = arg1.props
    local report = arg1.report
    local node = arg1.ctx.analytics.node

    local bool1 = node == OdpAnalyticsConstants.NEED_TO_REVERIFY_NODE
    local var1 = FFlagLuaAppOdpPrologueAnalytics and node == OdpAnalyticsConstants.PROLOGUE_NODE
    local var2 = FFlagLuaAppAmpWizardSendAnalyticsSessionId and node == OdpAnalyticsConstants.PROLOGUE_NODE
    local odpEventContext = arg1.ctx.odpEventContext
    local analyticsSessionId = arg1.ctx.analyticsSessionId
    local launchProps = arg1.ctx.launchProps
    local var3 = OdpAnalytics.useOdpAnalytics(arg1.ctx)
    local var4 = if FFlagLuaAppAmpWizardSendAnalyticsSessionId then VpcEntryAnalytics.useVpcEntryAnalytics(arg1.ctx) else nil
    local prologueType = nil
    if FFlagLuaAppAmpWizardSendAnalyticsSessionId then
        local var5 = props.buttons or {}
        prologueType = VpcEntryAnalytics.getPrologueType(#var5, if #var5 > 0 then var5[1].outcome else nil)
    end

    local var5 = React.useRef(nil)
    React.useEffect(function()
        if var5.current == node then
            return
        end
        var5.current = node
        if bool1 then
            var3.reverifyShown()
        elseif var1 and odpEventContext ~= nil then
            var3.prologueShown(odpEventContext, analyticsSessionId, launchProps)
        end
        if var2 and var4 and prologueType then
            var4.prologueShown(prologueType)
        end
    end, {
        node,
        bool1,
        var1,
        odpEventContext,
        analyticsSessionId,
        launchProps,
        var3,
        var2,
        var4,
        prologueType
    })

    local actions = React.useMemo(function()
        local result = {}

        for value, value2 in props.buttons or {} do
            local tbl1 = {
                text = value2.label,
                variant = if value == 1 then ButtonVariant.Emphasis else ButtonVariant.Standard,
                onActivated = 0
            }

            function tbl1.onActivated()
                if bool1 then
                    var3.reverifyButtonClick(value2.outcome)
                elseif var1 and odpEventContext ~= nil then
                    var3.prologueButtonClick(odpEventContext, analyticsSessionId, launchProps, value2.outcome)
                end
                if var2 and var4 and prologueType then
                    var4.prologueButtonClick(value2.outcome, prologueType)
                end
                report(value2.outcome)
            end

            table.insert(result, tbl1)
        end

        return result
    end, {
        props,
        report,
        bool1,
        var1,
        odpEventContext,
        analyticsSessionId,
        launchProps,
        var3,
        var2,
        var4,
        prologueType
    })

    local onClose = React.useCallback(function()
        if bool1 then
            var3.reverifyClose()
        elseif var1 and odpEventContext ~= nil then
            var3.prologueButtonClick(odpEventContext, analyticsSessionId, launchProps, "Cancel")
        end
        if var2 and var4 and prologueType then
            var4.prologueButtonClick("Cancel", prologueType)
        end
        report("Cancel")
    end, {
        report,
        bool1,
        var1,
        odpEventContext,
        analyticsSessionId,
        launchProps,
        var3,
        var2,
        var4,
        prologueType
    })

    local bool2 = not (props.imageUrl == nil) and props.imageUrl ~= ""
    local var8 = useTokens()

    local linkerOptions = React.useMemo(function()
        return {
            evaluateLinkBehavior = function()
                return LinkBehavior.Webview
            end
        }
    end, {})

    local footerText = props.footerText
    local bool3 = not (footerText == nil) and footerText ~= ""

    local text = React.useMemo(function()
        if bool3 then
            return (prepareRichTextCopy(footerText))
        end

        return nil
    end, { footerText, bool3 })

    return React.createElement(Dialog.Root, {
        size = DialogSize.Small,
        onClose = onClose
    }, {
        Illustration = if bool2 then React.createElement(Dialog.HeroMedia, { media = props.imageUrl }) else nil,
        Title = React.createElement(Dialog.Title, { text = props.title }),
        Content = React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                Description = React.createElement(Dialog.Text, { Text = props.description })
            }
        ),
        Actions = React.createElement(Dialog.Actions, { LayoutOrder = 3, orientation = EnumsOrientation.Vertical, actions = actions }),
        Footer = if bool3 then React.createElement(Renderer, {
            text = text,
            textStyle = var8.Color.Content.Default,
            fontStyle = var8.Typography.BodySmall,
            linkerOptions = linkerOptions,
            wrapperProps = { tag = "size-full-0 auto-y", LayoutOrder = 4 },
            nodeProps = {
                LINK = { showUnderline = true }
            }
        }) else nil
    })
end

return TextScreenNode
