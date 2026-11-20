-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local _React = require(AmpV2WizardParent.React)
local AppPage = require(AmpV2WizardParent.RobloxAppEnums).AppPage

local _Types = require(AmpV2Wizard.Types)
local createUpsellNode = require(AmpV2Wizard.Nodes.createUpsellNode)
local OdpAnalytics = require(AmpV2Wizard.OdpAnalytics)
local VpcEntryAnalytics = require(AmpV2Wizard.VpcEntryAnalytics)
local FFlagLuaAppOdpRequestSentToast = require(AmpV2WizardParent.SharedFlags).FFlagLuaAppOdpRequestSentToast

local FFlagLuaAppAmpWizardSendAnalyticsSessionId = require(AmpV2WizardParent.SharedFlags).FFlagLuaAppAmpWizardSendAnalyticsSessionId

local function createVpcNode(recourseAction: string)
    return createUpsellNode(function(arg1, arg2, arg3, callback)
        local odpAnalytics = OdpAnalytics.createOdpAnalytics(arg3.analyticsStrings)

        local function popThenReport(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
            arg1.navigation.pop()
            callback(str1)
        end
        local push = arg1.navigation.push
        local vpcUpsellContainer = AppPage.VPCUpsellContainer
        local tbl1 = { extraProps = 0 }
        local extraProps = {
            recourseAction = recourseAction,
            parentConsentTypes = arg2.requestType and { arg2.requestType } or nil,
            recourseData = arg2.requestDetails,
            isInExperienceEntry = arg2.isInExperienceEntry,
            entryPointEventCtx = arg3.analytics.flowId,
            analyticsSessionId = if FFlagLuaAppAmpWizardSendAnalyticsSessionId then arg3.analyticsSessionId else nil,
            vpcEntryAnalytics = if FFlagLuaAppAmpWizardSendAnalyticsSessionId then VpcEntryAnalytics.createVpcEntryAnalytics(
                arg3.analyticsStrings,
                arg3.analyticsSessionId,
                arg3.analytics.surface,
                arg2.requestType
            ) else nil,
            onRequestSent = FFlagLuaAppOdpRequestSentToast and function(_: string?)
                odpAnalytics.remoteRequestSent(arg3.odpEventContext, arg3.analyticsSessionId, arg3.launchProps)
            end or nil,
            onSuccess = 0,
            onCancel = 0,
            onRetryAmp = 0
        }

        function extraProps.onSuccess()
            popThenReport("Success")
        end

        function extraProps.onCancel()
            popThenReport("Cancel")
        end

        function extraProps.onRetryAmp()
            popThenReport("RetryAmp")
        end

        tbl1.extraProps = extraProps
        push(vpcUpsellContainer, tbl1)
    end)
end

return createVpcNode
