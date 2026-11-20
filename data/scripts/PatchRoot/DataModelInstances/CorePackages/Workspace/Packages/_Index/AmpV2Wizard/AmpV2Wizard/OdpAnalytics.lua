-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local Players = game:GetService("Players")

local AuthAnalytics = require(AmpV2WizardParent.AuthAnalytics)
local authButtonClick = AuthAnalytics.Events.authButtonClick
local authFormInteraction = AuthAnalytics.Events.authFormInteraction
local authModalShown = AuthAnalytics.Events.authModalShown
local authMsgShown = AuthAnalytics.Events.authMsgShown
local authPageload = AuthAnalytics.Events.authPageload

local _Types = require(AmpV2Wizard.Types)
local OdpAnalyticsConstants = require(AmpV2Wizard.OdpAnalyticsConstants)

local function joinTokens(tbl1): string
    local tbl2 = {}
    for _, value in tbl1 do
        if value ~= nil and value ~= "" then
            table.insert(tbl2, tostring(value))
        end
    end
    return table.concat(tbl2, " ")
end

local function buildState(str1: string?, str2: string?, str3: string?): string -- Luacid: Inlined by compiler; 19 call sites recovered
    return joinTokens({ str1, str2, tostring(Players.LocalPlayer and Players.LocalPlayer.UserId or 0), str3 })
end

local function requestDetails(tbl1): {[any]: any}? -- Luacid: Inlined by compiler; 1 call site recovered
    local requestDetails2 = if tbl1 == nil then nil else tbl1.requestDetails
    return if type(requestDetails2) == "table" then requestDetails2 else nil
end

local function settingNameFromRequestDetails(tbl1)
    if tbl1 == nil then
        return nil
    end
    local var1 = nil
    for value in tbl1 do
        if type(value) ~= "string" or value == "" or var1 ~= nil then
            return nil
        end

        var1 = value
    end

    return var1
end

local function buildParentalState(str1: string, str2: string?, str3: string?, tbl1, str4: string?, str5: string?)
    if str2 == nil or str2 == "" then
        return nil
    end

    local var1 = requestDetails(tbl1)

    if str1 == OdpAnalyticsConstants.Contexts.GameJoin then
        local universeId = if tbl1 == nil then nil else tbl1.universeId

        if universeId == nil or tostring(universeId) == "" then
            if var1 == nil then
                universeId = nil
            else
                universeId = var1.universeId
            end
        end

        if universeId == nil or tostring(universeId) == "" then
            return nil
        end
        return buildState(str2, str3, joinTokens({ universeId, "odp", str4 }))
    elseif str1 == OdpAnalyticsConstants.Contexts.Settings then
        local var2 = settingNameFromRequestDetails(var1)
        if var2 == nil then
            return nil
        end
        return `unlockSetting {var2} odp {buildState(str2, str3, (joinTokens({ str5, str4 })))}`
    else
        return nil
    end
end

local function createOdpAnalytics(arg1, str1: string?)
    local var1 = if arg1 == nil then nil else arg1[OdpAnalyticsConstants.AGE_GROUP_KEY]
    local var2 = if arg1 == nil then nil else arg1[OdpAnalyticsConstants.ASK_COPY_VARIANT_KEY]
    local var3 = if arg1 == nil then nil else arg1[OdpAnalyticsConstants.PARENT_SUPERVISION_STATE_KEY]
    local var4 = if arg1 == nil then nil else arg1[OdpAnalyticsConstants.INTRO_COPY_VARIANT_KEY]

    local function agreementState(str2: string?): string -- Luacid: Inlined by compiler; 5 call sites recovered
        return buildState(str1, var1, str2 or var4 or OdpAnalyticsConstants.DEFAULT_INTRO_COPY_VARIANT)
    end

    local var5 = if arg1 == nil then nil else arg1[OdpAnalyticsConstants.PIN_PURPOSE_KEY]
    local var6 = if arg1 == nil then nil else arg1[OdpAnalyticsConstants.REVERIFY_REASON_KEY]
    local reverifyVariant = if var6 == nil then nil else OdpAnalyticsConstants.ReverifyVariants[var6]

    local function pinEntryState(str2: string?): string -- Luacid: unused: defined but never referenced
        if var5 ~= nil and var5 ~= "" then
            if str2 == nil then
                str2 = var5
            else
                str2 = `{var5} {str2}`
            end
        end

        return buildState(str1, var1, str2)
    end

    return {
        handoffShown = function()
            authPageload(OdpAnalyticsConstants.Contexts.Handoff, buildState(str1, var1))
        end,
        handoffContinue = function()
            authButtonClick(
                OdpAnalyticsConstants.Contexts.Handoff,
                OdpAnalyticsConstants.Buttons.ContinueAsParent,
                buildState(str1, var1)
            )
        end,
        handoffBack = function()
            authButtonClick(OdpAnalyticsConstants.Contexts.Handoff, OdpAnalyticsConstants.Buttons.Back, buildState(str1, var1))
        end,
        agreementShown = function(str2: string?)
            authPageload(
                OdpAnalyticsConstants.Contexts.Intro,
                agreementState(str2),
                nil,
                nil,
                nil,
                OdpAnalyticsConstants.AssociatedText.AgreementScreen
            )
        end,
        agreementContinue = function(str2: string?)
            authButtonClick(
                OdpAnalyticsConstants.Contexts.Intro,
                OdpAnalyticsConstants.Buttons.Continue,
                agreementState(str2),
                nil,
                nil,
                nil,
                nil,
                OdpAnalyticsConstants.AssociatedText.AgreementContinue
            )
        end,
        agreementBack = function(str2: string?)
            authButtonClick(
                OdpAnalyticsConstants.Contexts.Intro,
                OdpAnalyticsConstants.Buttons.Back,
                agreementState(str2),
                nil,
                nil,
                nil,
                nil,
                OdpAnalyticsConstants.AssociatedText.AgreementBack
            )
        end,
        agreementTerms = function(str2: string?)
            authButtonClick(
                OdpAnalyticsConstants.Contexts.Intro,
                OdpAnalyticsConstants.Buttons.Terms,
                agreementState(str2),
                nil,
                nil,
                nil,
                nil,
                OdpAnalyticsConstants.AssociatedText.AgreementTerms
            )
        end,
        agreementPrivacy = function(str2: string?)
            authButtonClick(
                OdpAnalyticsConstants.Contexts.Intro,
                OdpAnalyticsConstants.Buttons.Privacy,
                agreementState(str2),
                nil,
                nil,
                nil,
                nil,
                OdpAnalyticsConstants.AssociatedText.AgreementPrivacy
            )
        end,
        verificationMethodSelectorShown = function(str2: string?)
            authPageload(
                OdpAnalyticsConstants.Contexts.VerifyMethod,
                buildState(str1, var1, nil),
                nil,
                nil,
                str2,
                OdpAnalyticsConstants.AssociatedText.VerificationMethodSelector
            )
        end,
        verificationMethodSelected = function(str2: string)
            authFormInteraction(
                OdpAnalyticsConstants.Contexts.VerifyMethod,
                OdpAnalyticsConstants.Fields.VerifyMethod,
                buildState(str1, var1, str2),
                nil,
                nil,
                OdpAnalyticsConstants.AssociatedText.VerificationMethodOptions
            )
        end,
        verificationMethodContinue = function(str2: string)
            authButtonClick(
                OdpAnalyticsConstants.Contexts.VerifyMethod,
                OdpAnalyticsConstants.Buttons.Continue,
                buildState(str1, var1, str2),
                nil,
                nil,
                nil,
                nil,
                OdpAnalyticsConstants.AssociatedText.VerificationMethodContinue
            )
        end,
        verificationMethodBack = function()
            authButtonClick(
                OdpAnalyticsConstants.Contexts.VerifyMethod,
                OdpAnalyticsConstants.Buttons.Back,
                buildState(str1, var1, nil),
                nil,
                nil,
                nil,
                nil,
                OdpAnalyticsConstants.AssociatedText.VerificationMethodBack
            )
        end,
        verificationFailed = function(str2: string, str3: string?)
            authModalShown(
                OdpAnalyticsConstants.Contexts.VerifyMethod,
                buildState(str1, var1, str2),
                OdpAnalyticsConstants.Fields.VerificationFailed,
                nil,
                OdpAnalyticsConstants.AssociatedText.VerificationFailed,
                str3
            )
        end,
        prologueShown = function(gameJoin: string, str2: string?, tbl1)
            if gameJoin ~= OdpAnalyticsConstants.Contexts.GameJoin then
                return
            end
            local parentalState = buildParentalState(gameJoin, str2, var1, tbl1, var2, nil)
            if parentalState ~= nil then
                authModalShown(
                    gameJoin,
                    parentalState,
                    OdpAnalyticsConstants.Fields.AskParent,
                    nil,
                    OdpAnalyticsConstants.AssociatedText.AskParent
                )
            end
        end,
        prologueButtonClick = function(settings: string, str2: string?, tbl1, str3: string)
            local bool1 = settings == OdpAnalyticsConstants.Contexts.Settings
            local var7

            if str3 == "ODP" then
                var7 = OdpAnalyticsConstants.Buttons.AskInPerson
            elseif str3 == "Remote" then
                if bool1 then
                    var7 = OdpAnalyticsConstants.Buttons.EmailParent
                else
                    var7 = OdpAnalyticsConstants.Buttons.AskParent
                end
            elseif str3 ~= "Cancel" then
                var7 = nil
            elseif bool1 then
                var7 = OdpAnalyticsConstants.Buttons.Cancel
            else
                var7 = OdpAnalyticsConstants.Buttons.CancelAskParent
            end
            if var7 == nil then
                return
            end

            local var8 = if str3 == "ODP" then OdpAnalyticsConstants.AssociatedText.AskInPerson elseif str3 == "Remote" then OdpAnalyticsConstants.AssociatedText.EmailParent else OdpAnalyticsConstants.AssociatedText.Cancel
            local parentalState = buildParentalState(
                settings,
                str2,
                var1,
                tbl1,
                if bool1 or str3 == "Cancel" then nil else var2,
                if bool1 and str3 == "ODP" then var3 else nil
            )

            if parentalState ~= nil then
                authButtonClick(settings, var7, parentalState, nil, nil, nil, nil, var8)
            end
        end,
        remoteRequestSent = function(str2: string?, str3: string?, tbl1)
            if str2 == nil then
                return
            end
            local parentalState = buildParentalState(str2, str3, var1, tbl1, nil, nil)
            if parentalState ~= nil then
                authMsgShown(
                    str2,
                    parentalState,
                    OdpAnalyticsConstants.Fields.RequestSentToast,
                    nil,
                    OdpAnalyticsConstants.AssociatedText.RequestSent
                )
            end
        end,
        pinEntryShown = function()
            local var7 = authPageload
            local pinEntry = OdpAnalyticsConstants.Contexts.PinEntry
            local var8 = if var5 == nil or var5 == "" then nil else var5
            var7(
                pinEntry,
                buildState(str1, var1, var8),
                nil,
                nil,
                nil,
                if var5 == nil or var5 == "" then nil else OdpAnalyticsConstants.AssociatedText.PinEntryShown
            )
        end,
        pinEntryDigitsChanged = function(num1: number)
            local var7 = authFormInteraction
            local pinEntry = OdpAnalyticsConstants.Contexts.PinEntry
            local pinEntry2 = OdpAnalyticsConstants.Fields.PinEntry
            local str2 = tostring(num1)

            if var5 ~= nil and var5 ~= "" then
                if str2 == nil then
                    str2 = var5
                else
                    str2 = `{var5} {str2}`
                end
            end

            var7(pinEntry, pinEntry2, buildState(str1, var1, str2), nil, nil, OdpAnalyticsConstants.AssociatedText.PinEntry)
        end,
        pinEntryRevealToggled = function(bool1: boolean)
            local var7 = authFormInteraction
            local pinEntry = OdpAnalyticsConstants.Contexts.PinEntry
            local pinShowToggle = OdpAnalyticsConstants.Fields.PinShowToggle
            local var8 = if bool1 then OdpAnalyticsConstants.PinRevealStates.Shown else OdpAnalyticsConstants.PinRevealStates.Hidden

            if var5 ~= nil and var5 ~= "" then
                if var8 == nil then
                    var8 = var5
                else
                    var8 = `{var5} {var8}`
                end
            end

            var7(
                pinEntry,
                pinShowToggle,
                buildState(str1, var1, var8),
                nil,
                nil,
                if bool1 then OdpAnalyticsConstants.AssociatedText.PinShowToggle else OdpAnalyticsConstants.AssociatedText.PinHideToggle
            )
        end,
        pinEntryForgotPin = function()
            local var7 = authButtonClick
            local pinEntry = OdpAnalyticsConstants.Contexts.PinEntry
            local forgotPin = OdpAnalyticsConstants.Buttons.ForgotPin
            local var8 = if var5 == nil or var5 == "" then nil else var5
            var7(
                pinEntry,
                forgotPin,
                buildState(str1, var1, var8),
                nil,
                nil,
                nil,
                nil,
                OdpAnalyticsConstants.AssociatedText.ForgotPin
            )
        end,
        pinEntryIncorrect = function()
            local var7 = authMsgShown
            local pinEntry = OdpAnalyticsConstants.Contexts.PinEntry
            local var8 = if var5 == nil or var5 == "" then nil else var5
            var7(pinEntry, buildState(str1, var1, var8), OdpAnalyticsConstants.Fields.PinIncorrect)
        end,
        reverifyShown = function()
            if reverifyVariant == nil then
                return
            end
            authModalShown(
                OdpAnalyticsConstants.Contexts.PinRecovery,
                buildState(str1, var1, nil),
                reverifyVariant.field,
                nil,
                reverifyVariant.associatedText
            )
        end,
        reverifyButtonClick = function(str2: string)
            local button = if reverifyVariant == nil then nil else reverifyVariant.buttons[str2]

            if button == nil then
                return
            end
            authButtonClick(
                OdpAnalyticsConstants.Contexts.PinRecovery,
                button.btn,
                buildState(str1, var1, nil),
                nil,
                nil,
                nil,
                nil,
                button.associatedText
            )
        end,
        reverifyClose = function()
            if reverifyVariant == nil then
                return
            end
            authButtonClick(
                OdpAnalyticsConstants.Contexts.PinRecovery,
                OdpAnalyticsConstants.Buttons.Close,
                buildState(str1, var1, nil),
                nil,
                nil,
                nil,
                nil,
                OdpAnalyticsConstants.AssociatedText.PinRecoveryClose
            )
        end
    }
end

return {
    childUserId = function(): string
        return tostring(Players.LocalPlayer and Players.LocalPlayer.UserId or 0)
    end,
    joinTokens = joinTokens,
    createOdpAnalytics = createOdpAnalytics,
    useOdpAnalytics = function(arg1)
        return React.useMemo(function()
            return (createOdpAnalytics(arg1.analyticsStrings, arg1.analyticsSessionId))
        end, { arg1.analyticsStrings, arg1.analyticsSessionId })
    end
}
