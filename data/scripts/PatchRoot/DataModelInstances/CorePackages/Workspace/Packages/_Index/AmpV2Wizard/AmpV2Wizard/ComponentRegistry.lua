-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")

local _Types = require(AmpV2Wizard.Types)
local FFlagAmpV2WizardRetryAmp = require(AmpV2Wizard.Flags.FFlagAmpV2WizardRetryAmp)
local TextScreenNode = require(AmpV2Wizard.Nodes.TextScreenNode)
local OdpHandoffNode = require(AmpV2Wizard.Nodes.OdpHandoffNode)
local CreateOdpSessionNode = require(AmpV2Wizard.Nodes.CreateOdpSessionNode)
local PinEntryNode = require(AmpV2Wizard.Nodes.PinEntryNode)
local UserAgreementNode = require(AmpV2Wizard.Nodes.UserAgreementNode)
local AgreementConsentsNode = require(AmpV2Wizard.Nodes.AgreementConsentsNode)
local VerificationMethodSelectionNode = require(AmpV2Wizard.Nodes.VerificationMethodSelectionNode)
local SessionPollingNode = require(AmpV2Wizard.Nodes.SessionPollingNode)
local RedirectNode = require(AmpV2Wizard.Nodes.RedirectNode)
local RemoteParentRequestNode = require(AmpV2Wizard.Nodes.RemoteParentRequestNode)
local default = {
    TextScreen = { component = TextScreenNode },
    OdpHandoff = { component = OdpHandoffNode, fillsViewport = true },
    CreateOdpSession = { component = CreateOdpSessionNode, ownsLoadingState = true },
    PinEntry = { component = PinEntryNode, fillsViewport = true },
    UserAgreement = { component = UserAgreementNode, fillsViewport = true },
    AgreementConsents = { component = AgreementConsentsNode, fillsViewport = true },
    VerificationMethodSelection = {
        component = VerificationMethodSelectionNode,
        fillsViewport = true
    },
    SessionPolling = { component = SessionPollingNode, ownsLoadingState = true },
    Redirect = { component = RedirectNode, ownsLoadingState = true },
    RemoteParentRequest = { component = RemoteParentRequestNode, ownsLoadingState = true },
    OdpAgeEstimation = {
        component = require(AmpV2Wizard.Nodes.OdpAgeEstimationNode),
        ownsLoadingState = true
    },
    OdpGovernmentId = {
        component = require(AmpV2Wizard.Nodes.OdpGovernmentIdNode),
        ownsLoadingState = true
    }
}

local module = { default = default }

function module.get(arg1, str1: string)
    local var1 = arg1[str1]
    return if var1 then var1.component else nil
end

function module.ownsLoadingState(arg1, str1: string): boolean
    local var1 = arg1[str1]
    return not (var1 == nil) and var1.ownsLoadingState == true
end

function module.fillsViewport(arg1, str1: string): boolean
    local var1 = arg1[str1]
    return not (var1 == nil) and var1.fillsViewport == true
end

function module.capabilities(arg1)
    local var1 = arg1 or default
    local result = {}
    for value in var1 do
        table.insert(result, value)
    end
    if FFlagAmpV2WizardRetryAmp and module.get(var1, "RemoteParentRequest") == RemoteParentRequestNode then
        table.insert(result, "RemoteParentRequestRetryAmp")
    end
    table.sort(result)
    return result
end

return module
