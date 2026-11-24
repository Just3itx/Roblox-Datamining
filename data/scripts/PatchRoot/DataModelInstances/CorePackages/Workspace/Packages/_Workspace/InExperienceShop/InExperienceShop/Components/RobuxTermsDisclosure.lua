-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization
local useOpenWebView = require(InExperienceShopParent.WebViewUtils).useOpenWebView
local UrlBuilder = require(InExperienceShopParent.UrlBuilder).UrlBuilder

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local InlineLayout = require(InExperienceShopParent.InlineLayout)
local InlineLayout2 = InlineLayout.Components.InlineLayout
local LinkElement = InlineLayout.Components.InlineLayoutElements.LinkElement
local TextElement = InlineLayout.Components.InlineLayoutElements.TextElement

local tbl1 = {
    disclosure = {
        "Feature.InExperienceShop.Description.RobuxPurchaseLegalDisclosure",
        termsLinkStart = "<a>",
        termsLinkEnd = "</a>"
    }
}

return React.memo(function(tbl2) -- name: RobuxTermsDisclosure
    local var1 = useTokens()
    local var2 = useOpenWebView()
    local disclosure = useLocalization(tbl1).disclosure

    local onActivated = React.useCallback(function()
        var2(UrlBuilder.static.about.terms(), "")
    end, { var2 })

    local bool1 = tbl2.isMobile == true
    local fontStyle = if bool1 then var1.Typography.CaptionSmall else var1.Typography.BodySmall
    local var3 = if bool1 then var1.Typography.CaptionSmall else var1.Typography.CaptionMedium
    local textStyle = if bool1 then var1.Color.System.Neutral else var1.Color.Content.Default
    local var4 = if bool1 then var1.Color.Content.Emphasis else textStyle

    local elements = React.useMemo(function()
        local var8, var9, var10 = string.match(disclosure, "^(.*)<a>(.*)</a>(.*)$")

        if var9 == nil then
            return { TextElement.new({ Text = disclosure, fontStyle = fontStyle, textStyle = textStyle }) }
        end

        return { TextElement.new(
                {
                    Text = var8,
                    fontStyle = fontStyle,
                    textStyle = textStyle,
                    testId = "RobuxTermsDisclosure-LeadingText"
                }
            ), LinkElement.new(
                { TextElement.new({ Text = var9, fontStyle = var3, textStyle = var4, testId = "RobuxTermsDisclosure-TermsLinkText" }) },
                { key = "RobuxTermsDisclosure-TermsLink", onActivated = onActivated }
            ), TextElement.new({ Text = var10, fontStyle = fontStyle, textStyle = textStyle }) }
    end, {
        disclosure,
        fontStyle,
        var3,
        textStyle,
        var4,
        onActivated
    })
    return React.createElement(
        View,
        {
            tag = "size-full-0 auto-y",
            testId = "RobuxTermsDisclosure",
            LayoutOrder = tbl2.LayoutOrder
        },
        {
            Layout = React.createElement(InlineLayout2, { Elements = elements })
        }
    )
end)
