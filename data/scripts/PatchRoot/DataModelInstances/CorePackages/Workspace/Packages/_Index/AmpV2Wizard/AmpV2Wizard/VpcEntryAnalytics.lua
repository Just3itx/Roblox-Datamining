-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local AuthAnalytics = require(AmpV2WizardParent.AuthAnalytics)
local authButtonClick = AuthAnalytics.Events.authButtonClick
local authFormInteraction = AuthAnalytics.Events.authFormInteraction
local authModalShown = AuthAnalytics.Events.authModalShown
local authMsgShown = AuthAnalytics.Events.authMsgShown
local authPageload = AuthAnalytics.Events.authPageload

local _Types = require(AmpV2Wizard.Types)
local OdpAnalytics = require(AmpV2Wizard.OdpAnalytics)
local OdpAnalyticsConstants = require(AmpV2Wizard.OdpAnalyticsConstants)

local tbl1 = {
    WizardLaunch = "ampWizard",
    Prologue = "odpPrologue",
    RemoteParentRequest = "remoteParentEmailRequest"
}

local tbl2 = {
    btn = OdpAnalyticsConstants.Buttons.AskParent,
    associatedText = "Ask my parent"
}
local Cancel = {
    btn = OdpAnalyticsConstants.Buttons.Close,
    associatedText = "X icon"
}
local tbl4 = {
    odpAndRemote = {
        ODP = {
            btn = OdpAnalyticsConstants.Buttons.AskInPerson,
            associatedText = "Ask in person"
        },
        Remote = {
            btn = OdpAnalyticsConstants.Buttons.EmailParent,
            associatedText = "Send an email"
        },
        Cancel = Cancel
    },
    remoteOnly = { Remote = tbl2, Cancel = Cancel },
    odpOnly = { ODP = tbl2, Cancel = Cancel }
}

local function buildState(str1: string?, str2: string?, str3: string?, str4: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    return OdpAnalytics.joinTokens({ str1, str2, OdpAnalytics.childUserId(), str3, str4 })
end

local function createVpcEntryAnalytics(arg1, str1: string?, str2: string?, str3: string?)
    local var1 = if arg1 == nil then nil else arg1[OdpAnalyticsConstants.AGE_GROUP_KEY]

    local function prologueState(str4: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local joinTokens = OdpAnalytics.joinTokens
        local var2 = str2
        return joinTokens({ OdpAnalytics.joinTokens({ str1, var1, OdpAnalytics.childUserId(), var2, nil }), str4 })
    end

    local state = buildState(str1, var1, str2, str3)

    local function remoteButtonClick(str4: string, str5: string) -- Luacid: unused: defined but never referenced
        authButtonClick("remoteParentEmailRequest", str4, state, nil, nil, nil, nil, str5)
    end

    return {
        prologueShown = function(str4: string)
            authModalShown(
                "odpPrologue",
                prologueState(str4),
                "askParent",
                nil,
                "Ask your parent - You need parent approval to {takeChildAction}."
            )
        end,
        prologueButtonClick = function(str4: string, str5: string)
            local var2 = tbl4[str5]
            local var3 = if var2 == nil then nil else var2[str4]

            if var3 == nil then
                return
            end
            authButtonClick("odpPrologue", var3.btn, prologueState(str5), nil, nil, nil, nil, var3.associatedText)
        end,
        remoteEmailShown = function()
            authModalShown(
                "remoteParentEmailRequest",
                state,
                "emailModal",
                nil,
                "Enter parent's email - Ask your parents to help you with this step. We'll send an email to your parent to verify their age and link them to your account. Parents, after linking, you'll get access to parental controls and insights on your child's screen time, spending, and more."
            )
        end,
        remoteEmailEntered = function()
            authFormInteraction("remoteParentEmailRequest", "email", state, nil, nil, "Parent's email")
        end,
        remoteEmailSubmit = function()
            authButtonClick(tbl1.RemoteParentRequest, "submit", state, nil, nil, nil, nil, "Send Email")
        end,
        remoteRequestSent = function()
            authMsgShown("remoteParentEmailRequest", state, "requestSent", nil, "Email sent")
        end,
        remoteRequestOk = function()
            authButtonClick(tbl1.RemoteParentRequest, "ok", state, nil, nil, nil, nil, "Email sent > OK")
        end,
        remoteRequestError = function(str4: string?)
            authMsgShown("remoteParentEmailRequest", state, "errorMessage", str4 or "unknown")
        end,
        remoteRequestRetry = function()
            authButtonClick(tbl1.RemoteParentRequest, "retry", state, nil, nil, nil, nil, "Something went wrong > Retry")
        end,
        remoteRequestCancel = function()
            local cancel = OdpAnalyticsConstants.Buttons.Cancel
            authButtonClick(tbl1.RemoteParentRequest, cancel, state, nil, nil, nil, nil, "Something went wrong > Cancel")
        end,
        remoteRequestClose = function()
            local close = OdpAnalyticsConstants.Buttons.Close
            authButtonClick(tbl1.RemoteParentRequest, close, state, nil, nil, nil, nil, "X icon")
        end
    }
end

return {
    getPrologueType = function(num1: number, str1: string?): string
        return if num1 == 1 then if str1 == "ODP" then "odpOnly" else "remoteOnly" else "odpAndRemote"
    end,
    sendWizardLaunch = function(arg1, str1: string?, str2: string?, str3: string?, str4: string?, str5: string?)
        local var1 = if arg1 == nil then nil else arg1[OdpAnalyticsConstants.AGE_GROUP_KEY]
        local var2 = OdpAnalytics.joinTokens({ str1, var1, OdpAnalytics.childUserId(), str2, str3, str4, str5 })

        authPageload("ampWizard", var2, nil, nil, nil, "AMP wizard launch")
    end,
    createVpcEntryAnalytics = createVpcEntryAnalytics,
    useVpcEntryAnalytics = function(arg1, str1: string?)
        local surface = arg1.analytics.surface
        return React.useMemo(function()
            return (createVpcEntryAnalytics(arg1.analyticsStrings, arg1.analyticsSessionId, surface, str1))
        end, {
            arg1.analyticsStrings,
            arg1.analyticsSessionId,
            surface,
            str1
        })
    end
}
