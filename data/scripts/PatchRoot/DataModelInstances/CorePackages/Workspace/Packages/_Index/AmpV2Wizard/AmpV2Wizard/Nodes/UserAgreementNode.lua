-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local Foundation = require(AmpV2WizardParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local Icon = Foundation.Icon
local Button = Foundation.Button
local ScrollView = Foundation.ScrollView
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local IconSize = Foundation.Enums.IconSize
local IconName = Foundation.Enums.IconName
local useTokens = Foundation.Hooks.useTokens

local InlineRichText = require(AmpV2WizardParent.InlineRichText)
local Renderer = InlineRichText.Renderer
local LinkBehavior = InlineRichText.Enums.LinkBehavior

local _Types = require(AmpV2Wizard.Types)
local FullPageChrome = require(AmpV2Wizard.FullPageChrome)
local OdpAnalytics = require(AmpV2Wizard.OdpAnalytics)
local prepareRichTextCopy = InlineRichText.prepareRichTextCopy

local function canonicalLegalUrl(url: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = string.gsub(url, "[?#].*$", "")
    return string.lower((string.gsub(var1, "^https?://[^/]+", "")))
end

local function renderGlyph(image: string)
    local name = IconName[image]
    if name ~= nil then
        return React.createElement(Icon, { name = name, size = IconSize.Large, tag = "content-emphasis" })
    end

    return React.createElement(
        Image,
        {
            Image = image,
            Size = UDim2.fromOffset(24, 24),
            ScaleType = Enum.ScaleType.Fit,
            tag = "content-emphasis"
        }
    )
end

local function renderBulletLeading(tbl1)
    local icon = tbl1.icon
    if icon == nil or icon == "" then
        return nil
    end

    return React.createElement(View, {
        tag = "col align-x-center align-y-center",
        Size = UDim2.fromOffset(40, 40),
        LayoutOrder = 1,
        testId = "amp-v2-wizard-bullet-glyph"
    }, {
        Glyph = renderGlyph(icon)
    })
end

local function renderBullet(tbl1, layoutOrder: number)
    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        tag = "row align-y-center gap-medium size-full-0 auto-y padding-y-small",
        LayoutOrder = layoutOrder
    }
    local tbl3 = {
        Leading = renderBulletLeading(tbl1),
        Copy = React.createElement(View, { tag = "col fill gap-xsmall auto-y", LayoutOrder = 2 }, {
            Title = React.createElement(FoundationText, {
                Text = tbl1.title,
                tag = "size-full-0 auto-y text-title-large text-wrap text-align-x-left content-emphasis",
                LayoutOrder = 1
            }),
            Description = if tbl1.description == nil or tbl1.description == "" then nil else React.createElement(FoundationText, {
                Text = tbl1.description,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default",
                LayoutOrder = 2
            })
        })
    }
    return createElement(var1, tbl2, tbl3)
end

local function UserAgreementNode(arg1)
    local props = arg1.props
    local report = arg1.report
    local var1 = useTokens()
    local copyVariant = props.copyVariant
    local termsUrl = props.termsUrl or "https://www.roblox.com/info/terms"
    local privacyUrl = props.privacyUrl or "https://www.roblox.com/info/privacy"
    local var2 = OdpAnalytics.useOdpAnalytics(arg1.ctx)

    React.useEffect(function()
        var2.agreementShown(copyVariant)
    end, {})

    local onActivated = React.useCallback(function()
        var2.agreementContinue(copyVariant)
        report("Continue")
    end, { report, copyVariant, var2 })

    local onBack = React.useCallback(function()
        var2.agreementBack(copyVariant)
        report("Back")
    end, { report, copyVariant, var2 })

    local onActivatedSubscriber = React.useCallback(function(arg2)
        local str1 = canonicalLegalUrl(arg2.url)
        local var5 = string.gsub(termsUrl, "[?#].*$", "")

        if str1 == string.lower((string.gsub(var5, "^https?://[^/]+", ""))) then
            var2.agreementTerms(copyVariant)
            return
        end

        local var6 = string.gsub(privacyUrl, "[?#].*$", "")

        if str1 == string.lower((string.gsub(var6, "^https?://[^/]+", ""))) then
            var2.agreementPrivacy(copyVariant)
        end
    end, {
        termsUrl,
        privacyUrl,
        copyVariant,
        var2
    })
    local linkerOptions = React.useMemo(function()
        return {
            evaluateLinkBehavior = function()
                return LinkBehavior.Webview
            end,
            onActivatedSubscriber = onActivatedSubscriber
        }
    end, { onActivatedSubscriber })

    local tbl1 = {}

    for value, value2 in props.bullets or {} do
        tbl1[`Bullet_{value}`] = renderBullet(value2, value)
    end

    local legalText = props.legalText
    local bool1 = not (legalText == nil) and legalText ~= ""

    local text = React.useMemo(function()
        if bool1 then
            return (prepareRichTextCopy(legalText))
        end

        return nil
    end, { legalText, bool1 })

    local createElement = React.createElement
    local var8 = View
    local tbl2 = { tag = "col size-full" }
    local tbl3 = { Body = 0, Footer = 0 }
    local createElement2 = React.createElement
    local var9 = ScrollView
    local tbl4 = {
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
    local tbl5 = { Content = 0 }
    local createElement3 = React.createElement
    local var10 = View
    local tbl6 = { tag = "col gap-none size-full-0 auto-y" }

    local tbl7 = { Copy = 0 }
    local createElement4 = React.createElement
    local var11 = View
    local tbl8 = {
        tag = "col gap-xlarge size-full-0 auto-y padding-x-xlarge padding-y-xlarge",
        LayoutOrder = 1
    }

    local tbl9 = {
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
        }),
        Bullets = if next(tbl1) == nil then nil else React.createElement(View, { tag = "col gap-xxlarge size-full-0 auto-y", LayoutOrder = 2 }, tbl1)
    }
    tbl7.Copy = createElement4(var11, tbl8, tbl9)
    tbl5.Content = createElement3(var10, tbl6, tbl7)
    tbl3.Body = createElement2(var9, tbl4, tbl5)

    tbl3.Footer = React.createElement(
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
            }),
            Legal = if bool1 then React.createElement(Renderer, {
                text = text,
                textStyle = var1.Color.Content.Default,
                fontStyle = var1.Typography.CaptionLarge,
                linkerOptions = linkerOptions,
                wrapperProps = { tag = "size-full-0 auto-y", LayoutOrder = 2 },
                nodeProps = {
                    LINK = { showUnderline = true }
                }
            }) else nil
        }
    )
    local content = createElement(var8, tbl2, tbl3)

    return React.createElement(FullPageChrome, { title = props.headerTitle, onBack = onBack }, { Content = content })
end

return UserAgreementNode
