-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local _Types = require(AmpV2Wizard.Types)
local OdpAnalytics = require(AmpV2Wizard.OdpAnalytics)
local WizardSpinner = require(AmpV2Wizard.WizardSpinner)
local Types = require(AmpV2Wizard.OdpVerification.Types)
local useOdpVerification = require(AmpV2Wizard.OdpVerification.useOdpVerification)
local FFlagAmpV2WizardVerificationDiagnostics = require(AmpV2Wizard.FFlagAmpV2WizardVerificationDiagnostics)

local VendorOutcome = Types.VendorOutcome

local function createOdpVerificationNode(method)
    local function OdpVerificationNode(arg1)
        local props = arg1.props
        local report = arg1.report
        local var1 = OdpAnalytics.useOdpAnalytics(arg1.ctx)

        local var2 = useOdpVerification
        local tbl1 = {
            sessionId = props.sessionId or "",
            method = method,
            flowId = if FFlagAmpV2WizardVerificationDiagnostics and arg1.ctx.analytics then arg1.ctx.analytics.flowId else nil,
            analyticsSessionId = if FFlagAmpV2WizardVerificationDiagnostics then arg1.ctx.analyticsSessionId else nil,
            onSettled = 0
        }

        function tbl1.onSettled(arg2)
            if arg2.outcome == VendorOutcome.Submitted then
                report("Submitted")
                return
            end

            if arg2.outcome == VendorOutcome.Cancelled then
                report("Cancel")
                return
            end
            var1.verificationFailed(method, arg2.failure)
            if FFlagAmpV2WizardVerificationDiagnostics then
                report("Failure", { reason = arg2.failure, diagnostic = arg2.diagnostic })
                return
            end
            report("Failure", { reason = arg2.failure })
        end

        var2(tbl1)

        return React.createElement(WizardSpinner)
    end

    return OdpVerificationNode
end

return createOdpVerificationNode
