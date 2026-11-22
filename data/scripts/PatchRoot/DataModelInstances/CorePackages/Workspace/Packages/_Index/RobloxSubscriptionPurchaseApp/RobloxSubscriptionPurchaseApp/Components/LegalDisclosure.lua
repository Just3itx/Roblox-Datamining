-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local Foundation = require(RobloxSubscriptionPurchaseAppParent.Foundation)
local React = require(RobloxSubscriptionPurchaseAppParent.React)
local InlineRichText = require(RobloxSubscriptionPurchaseAppParent.InlineRichText)
local Renderer = InlineRichText.Renderer
local LinkBehavior = InlineRichText.Enums.LinkBehavior
local useLocalization = require(RobloxSubscriptionPurchaseAppParent.Localization).Hooks.useLocalization
local getPeriodTypeDisplayLabel = require(RobloxSubscriptionPurchaseApp.Utils.getPeriodTypeDisplayLabel)
local isSupportedTrialPeriodType = require(RobloxSubscriptionPurchaseApp.Utils.isSupportedTrialPeriodType)
local FFlagSupportFreeTrial = require(RobloxSubscriptionPurchaseApp.Flags.FFlagSupportFreeTrial)
local FFlagRobloxPlusDynamicFreeTrialLength = require(RobloxSubscriptionPurchaseApp.Flags.FFlagRobloxPlusDynamicFreeTrialLength)
local FFlagEnablePlusReferralLegalDisclosure = require(RobloxSubscriptionPurchaseApp.Flags.FFlagEnablePlusReferralLegalDisclosure)

local FFlagSubscriptionSheetCampaignLocalizations = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagSubscriptionSheetCampaignLocalizations

local termsUrl = game:DefineFastString("RobloxSubscriptionTermsOfUseLink", "https://en.help.roblox.com/hc/articles/46804865425300")

local referralTermsUrl = game:DefineFastString("PlusReferralProgramTermsURL2", "https://en.help.roblox.com/hc/en-us/articles/52737229124628")

local function decodeLuauUnicodeEscapes(str3: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    return (str3:gsub("\\u{(%x+)}", function(str4: string): string
        local var1 = tonumber(str4, 16)
        if var1 == nil or var1 < 0 or var1 > 1114111 then
            return ""
        end
        return utf8.char(var1)
    end))
end

local function decodeInlineRichTextEntities(str3: string)
    return str3:gsub("&amp;lt;", "<"):gsub("&amp;gt;", ">"):gsub("&amp;quot;", "\""):gsub("&amp;apos;", "'"):gsub("&amp;amp;", "&"):gsub(
        "&lt;",
        "<"
    ):gsub(
        "&gt;",
        ">"
    ):gsub(
        "&quot;",
        "\""
    ):gsub(
        "&apos;",
        "'"
    ):gsub(
        "&amp;",
        "&"
    )
end

local function replaceQuotesOutsideTags(str3: string): string
    local tbl1 = {}
    local bool1 = false
    local bool2 = true
    for i = 1, #str3 do
        local str4 = str3:sub(i, i)
        if str4 == "<" then
            table.insert(tbl1, str4)
            bool1 = true
        elseif str4 == ">" then
            table.insert(tbl1, str4)
            bool1 = false
        elseif str4 == "\"" and not bool1 then
            table.insert(tbl1, if bool2 then utf8.char(8220) else utf8.char(8221))
            bool2 = not bool2
        else
            table.insert(tbl1, str4)
        end
    end
    return table.concat(tbl1)
end

local function prepareTermsAgreementRichText(str3: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if FFlagSupportFreeTrial then
        return replaceQuotesOutsideTags(decodeInlineRichTextEntities((decodeLuauUnicodeEscapes(str3))))
    end

    return decodeInlineRichTextEntities((decodeLuauUnicodeEscapes(str3)))
end

local function fillDisclosureTemplate(textTemplate: string, ctaText: string)
    local tbl1 = {
        linkStart = "<a href=\"" .. termsUrl .. "\">",
        linkEnd = "</a>",
        ctaText = ctaText
    }

    return (textTemplate:gsub("{(%w+)}", function(str3: string)
        return tbl1[str3] or "{" .. str3 .. "}"
    end))
end

local function LegalDisclosure(tbl1)
    local var1 = Foundation.Hooks.useTokens()

    local trialDuration = tbl1.trialDuration or 1

    local var2 = FFlagSupportFreeTrial and FFlagRobloxPlusDynamicFreeTrialLength

    if var2 then
        if tbl1.isFreeTrial == true and tbl1.trialDuration ~= nil then
            var2 = isSupportedTrialPeriodType(tbl1.trialPeriodType)
        else
            var2 = false
        end
    end
    local tbl2 = { subscribe = "Feature.RobloxSubscription.Action.Subscribe" }

    if var2 then
        tbl2.trialPeriodLabel = getPeriodTypeDisplayLabel(tbl1.trialPeriodType or "", trialDuration > 1)
        tbl2.billingPeriodLabel = getPeriodTypeDisplayLabel(tbl1.billingPeriodType or "", false)
    end
    local var3 = useLocalization(tbl2)
    local var4 = useLocalization
    local tbl3 = {
        termsAgreement = {
            "Feature.RobloxSubscription.Disclosure.BlackbirdTermsAgreement",
            termsUrl = termsUrl,
            ctaText = if tbl1.ctaText and tbl1.ctaText ~= "" then tbl1.ctaText else var3.subscribe
        },
        freeTrialTermsAgreement = FFlagSupportFreeTrial
            and {
                "Feature.RobloxSubscription.Label.FreeTrialDisclosureV2",
                linkStart = "<a href=\"" .. termsUrl .. "\">",
                linkEnd = "</a>"
            }
            or nil,
        freeTrialTermsAgreementV3 = var2
            and {
                "Feature.RobloxSubscription.Label.FreeTrialDisclosureV3",
                linkStart = "<a href=\"" .. termsUrl .. "\">",
                linkEnd = "</a>",
                trialDuration = trialDuration,
                trialPeriodLabel = var3.trialPeriodLabel,
                billingPeriodLabel = var3.billingPeriodLabel
            }
            or nil,
        shortFreeTrialTermsAgreement = {
            "Feature.RobloxSubscription.Label.FreeTrialDisclosureShort",
            linkStart = "<a href=\"" .. termsUrl .. "\">",
            linkEnd = "</a>"
        },
        referralTermsAgreement = if FFlagEnablePlusReferralLegalDisclosure then {
            "Feature.RobloxSubscription.Description.ReferralRecipientLegalDisclosurePurchase",
            referralTermsUrl = referralTermsUrl,
            termsUrl = termsUrl,
            ctaText = if tbl1.ctaText and tbl1.ctaText ~= "" then tbl1.ctaText else var3.subscribe
        } else nil
    }
    local var5 = var4(tbl3)

    local linkerOptions = React.useMemo(function()
        return {
            evaluateLinkBehavior = function(_: string, _)
                return LinkBehavior.Webview
            end
        }
    end, {})

    local var7

    if FFlagSubscriptionSheetCampaignLocalizations and tbl1.textTemplate then
        var7 = fillDisclosureTemplate(tbl1.textTemplate, if tbl1.ctaText and tbl1.ctaText ~= "" then tbl1.ctaText else var3.subscribe)
    elseif FFlagEnablePlusReferralLegalDisclosure and tbl1.isReferral then
        var7 = var5.referralTermsAgreement
    elseif tbl1.shortenFreeTrialTerms then
        var7 = var5.shortFreeTrialTermsAgreement
    elseif var2 then
        var7 = var5.freeTrialTermsAgreementV3
    elseif FFlagSupportFreeTrial and tbl1.isFreeTrial then
        var7 = var5.freeTrialTermsAgreement
    else
        var7 = var5.termsAgreement
    end
    return React.createElement(Renderer, {
        text = prepareTermsAgreementRichText(var7),
        textStyle = var1.Color.Content.Default,
        fontStyle = var1.Typography.BodySmall,
        linkerOptions = linkerOptions,
        wrapperProps = {
            tag = "size-full-0 auto-y",
            LayoutOrder = tbl1.layoutOrder
        },
        nodeProps = {
            LINK = { showUnderline = true }
        }
    })
end

return LegalDisclosure
