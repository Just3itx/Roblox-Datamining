-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)
local useAppPolicy = require(AmpV2WizardParent.UniversalAppPolicy).useAppPolicy

local Context = require(AmpV2Wizard.OdpVerification.Context)
local Types = require(AmpV2Wizard.OdpVerification.Types)
local resolveVerificationPresentation = require(AmpV2Wizard.OdpVerification.resolveVerificationPresentation)
local VerificationDiagnostics = require(AmpV2Wizard.OdpVerification.VerificationDiagnostics)
local FFlagAmpV2WizardVerificationDiagnostics = require(AmpV2Wizard.FFlagAmpV2WizardVerificationDiagnostics)

local VerificationPresentation = resolveVerificationPresentation.VerificationPresentation

local VendorFailure = Types.VendorFailure
local VendorOutcome = Types.VendorOutcome

local function useOdpVerification(tbl1)
    local var1 = React.useContext(Context)

    local var2 = useAppPolicy(function(arg1)
        return arg1.getHasWebViewSupportForFAE()
    end)

    local var3 = React.useRef(tbl1.onSettled)
    var3.current = tbl1.onSettled

    React.useEffect(function()
        local api = var1.api
        local personaInquiryService = var1.personaInquiryService
        local openWebView = var1.openWebView
        local externalBrowser = var1.externalBrowser

        local var4 = resolveVerificationPresentation.resolveVerificationPresentation(personaInquiryService.isAvailable(), var2 == true)

        local bool1 = false
        local bool2 = false
        local var5 = nil
        local var6 = nil
        local str1 = "start_request"
        local var7 = nil
        local var8 = nil
        local var9 = nil
        local var10 = nil

        if FFlagAmpV2WizardVerificationDiagnostics then
            local success, result = pcall(VerificationDiagnostics.beginAttempt, tbl1.sessionId, tbl1.method, var4, tbl1.flowId, tbl1.analyticsSessionId)

            if success then
                var6 = result
            end
        end

        local function settle(outcome, failure)
            if bool2 or bool1 then
                return
            end
            bool2 = true
            local tbl2 = { outcome = outcome, failure = failure }
            if FFlagAmpV2WizardVerificationDiagnostics and outcome == VendorOutcome.Failed and var6 then
                local success, result = pcall(VerificationDiagnostics.completeFailure, var6, str1, var7, var8, var9, var10)

                if success then
                    tbl2.diagnostic = result
                end
            end
            var3.current(tbl2)
        end

        local function startNative(sessionIdentifier: string)
            if FFlagAmpV2WizardVerificationDiagnostics then
                var7 = sessionIdentifier
                var8 = os.clock()
                str1 = "inquiry_invocation"
            end
            personaInquiryService.startInquiry(sessionIdentifier):andThen(function(arg1)
                local resultType

                if FFlagAmpV2WizardVerificationDiagnostics then
                    if typeof(arg1) == "table" then
                        resultType = arg1.resultType
                        var10 = arg1.debugMessage
                    else
                        resultType = arg1
                    end
                    var9 = resultType
                    str1 = "native_result"
                else
                    resultType = arg1
                end
                if resultType == Enum.FacialAgeEstimationResultType.Complete then
                    settle(VendorOutcome.Submitted)
                elseif resultType == Enum.FacialAgeEstimationResultType.Cancel then
                    settle(VendorOutcome.Cancelled)
                else
                    settle(VendorOutcome.Failed, VendorFailure.VendorError)
                end
            end):catch(function(arg1)
                if FFlagAmpV2WizardVerificationDiagnostics then
                    str1 = "inquiry_rejection"
                    var10 = arg1
                end
                settle(VendorOutcome.Failed, VendorFailure.VendorError)
            end)
        end

        api.startOdpVerification({ sessionId = tbl1.sessionId, verificationType = tbl1.method }):andThen(function(arg1)
            if bool1 then
                return
            end
            if FFlagAmpV2WizardVerificationDiagnostics then
                str1 = "start_response"
                var7 = arg1.sessionIdentifier
            end

            if var4 == VerificationPresentation.Native then
                if arg1.sessionIdentifier == nil then
                    if FFlagAmpV2WizardVerificationDiagnostics then
                        str1 = "missing_inquiry_id"
                    end
                    settle(VendorOutcome.Failed, VendorFailure.StartFailed)
                    return
                end
                startNative(arg1.sessionIdentifier)
                return
            end

            if arg1.verificationLink == nil then
                if FFlagAmpV2WizardVerificationDiagnostics then
                    str1 = "missing_verification_link"
                end
                settle(VendorOutcome.Failed, VendorFailure.StartFailed)
                return
            end

            if var4 == VerificationPresentation.InAppWebView then
                if FFlagAmpV2WizardVerificationDiagnostics then
                    str1 = "webview_presentation"
                end
                var5 = openWebView(arg1.verificationLink, "", function()
                    settle(VendorOutcome.Submitted)
                end)
            else
                if FFlagAmpV2WizardVerificationDiagnostics then
                    str1 = "external_presentation"
                end
                externalBrowser.open(arg1.verificationLink)
                settle(VendorOutcome.Submitted)
            end
        end):catch(function(arg1)
            if FFlagAmpV2WizardVerificationDiagnostics then
                var10 = arg1
            end
            settle(VendorOutcome.Failed, VendorFailure.StartFailed)
        end)

        return function()
            bool1 = true
            if var5 then
                var5()
            end
        end
    end, { tbl1.sessionId, tbl1.method, var2 })
end

return useOdpVerification
