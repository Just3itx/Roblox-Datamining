-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local React = require(AuthCommonParent.React)
local useLocalization = require(AuthCommonParent.Localization).Hooks.useLocalization
local UrlBuilder = require(AuthCommonParent.UrlBuilder).UrlBuilder

local LegalTextWithLinks = require(script.Parent.LegalTextWithLinks)
local useOpenDisclaimerLinks = require(AuthCommon.Hooks.useOpenDisclaimerLinks)
local RegisterAuditContent = require(AuthCommon.Components.RegisterAuditContent)
local RegisterAdditionalAuditContent = require(AuthCommon.Components.RegisterAdditionalAuditContent)

local parameters = {
    startTermsTag = "<a href=\"terms\">",
    endTermsTag = "</a>",
    startPrivacyTag = "<a href=\"privacy\">",
    endPrivacyTag = "</a>"
}

local function DisclaimerTextWithLinks(tbl2)
    local bool1 = tbl2.enableAuditContentCapture == true

    local text = table.clone(parameters)
    text[1] = tbl2.textKey
    local var2 = useLocalization({ text = text, template = if bool1 then tbl2.textKey else nil })

    local var3 = useOpenDisclaimerLinks({ ctx = tbl2.ctx, state = tbl2.state, origin = tbl2.origin })

    local onLinkActivated = React.useCallback(function(str1: string)
        if str1 == "terms" then
            var3.openTerms()
        elseif str1 == "privacy" then
            var3.openPrivacy()
        end
    end, { var3 })

    return React.createElement(React.Fragment, nil, {
        Text = React.createElement(
            LegalTextWithLinks,
            {
                text = var2.text,
                onLinkActivated = onLinkActivated,
                LayoutOrder = tbl2.LayoutOrder
            }
        ),
        TextAuditContent = if bool1 then React.createElement(
            RegisterAuditContent,
            {
                translationKey = tbl2.textKey,
                translatedSourceString = var2.template,
                parameters = parameters
            }
        ) else nil,
        TermsLinkAuditContent = if bool1 then React.createElement(
            RegisterAdditionalAuditContent,
            {
                contentKey = "termsLink",
                value = UrlBuilder.static.about.terms()
            }
        ) else nil,
        PrivacyLinkAuditContent = if bool1 then React.createElement(
            RegisterAdditionalAuditContent,
            {
                contentKey = "privacyLink",
                value = UrlBuilder.static.about.privacy()
            }
        ) else nil
    })
end

return DisclaimerTextWithLinks
