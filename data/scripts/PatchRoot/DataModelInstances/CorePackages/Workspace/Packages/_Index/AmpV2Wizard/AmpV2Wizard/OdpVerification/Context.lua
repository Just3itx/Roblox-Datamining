-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)
local WebViewUtils = require(AmpV2WizardParent.WebViewUtils)

local ExternalBrowser = require(AmpV2Wizard.OdpVerification.ExternalBrowser)
local ApiProvider = require(AmpV2Wizard.OdpVerification.ApiProvider)
local PersonaInquiryService = require(AmpV2Wizard.OdpVerification.PersonaInquiryService)

return (React.createContext({
    api = ApiProvider,
    personaInquiryService = PersonaInquiryService,
    openWebView = WebViewUtils.openWebViewSession,
    externalBrowser = ExternalBrowser
}))
