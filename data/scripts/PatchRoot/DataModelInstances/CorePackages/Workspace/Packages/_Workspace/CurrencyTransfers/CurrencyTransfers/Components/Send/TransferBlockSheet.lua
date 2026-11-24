-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)

local TransferFAEBlockSheet = require(CurrencyTransfers.Components.Generic.TransferFAEBlockSheet)
local SubscriptionUpsellContainer = require(CurrencyTransfers.Components.Generic.SubscriptionUpsellContainer)
local VPCBlockContainer = require(CurrencyTransfers.Components.Generic.VPCBlockContainer)

local useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)

local _TransferDirection = require(CurrencyTransfers.Enums.TransferDirection)

local AmpWizardTransferConstants = require(CurrencyTransfers.Constants.AmpWizardTransferConstants)

local function TransferBlockSheet(_)
    local var1 = useTransferStore()
    local direction = var1.getDirection(false)
    local ampRecourseActions = var1.getAmpRecourseActions(false)
    local ampFeatureCheck = var1.getAmpFeatureCheck(false)

    local bool1 = false
    local bool2 = false
    local bool3 = false
    if ampRecourseActions then
        for _, ampRecourseAction in ipairs(ampRecourseActions) do
            if ampRecourseAction == AmpWizardTransferConstants.RECOURSE_PLUS_SUBSCRIPTION then
                bool1 = true
            elseif ampRecourseAction == AmpWizardTransferConstants.RECOURSE_ID_VERIFICATION
                or ampRecourseAction == AmpWizardTransferConstants.RECOURSE_AGE_ESTIMATION
            then
                bool2 = true
            elseif ampRecourseAction == AmpWizardTransferConstants.RECOURSE_PARENT_LINK
                or ampRecourseAction == AmpWizardTransferConstants.RECOURSE_PARENT_CONSENT
            then
                bool3 = true
            end
        end
    end

    local tbl1 = {
        direction = direction,
        ampRecourseActions = ampRecourseActions,
        ampFeatureCheck = ampFeatureCheck
    }

    if bool1 and direction then
        return React.createElement(
            SubscriptionUpsellContainer,
            {
                direction = tbl1.direction,
                ampRecourseActions = tbl1.ampRecourseActions,
                ampFeatureCheck = tbl1.ampFeatureCheck
            }
        )
    elseif bool2 and direction then
        return React.createElement(
            TransferFAEBlockSheet,
            {
                direction = tbl1.direction,
                ampRecourseActions = tbl1.ampRecourseActions,
                ampFeatureCheck = tbl1.ampFeatureCheck
            }
        )
    elseif bool3 and direction then
        return React.createElement(
            VPCBlockContainer,
            {
                direction = tbl1.direction,
                ampRecourseActions = tbl1.ampRecourseActions,
                ampFeatureCheck = tbl1.ampFeatureCheck
            }
        )
    end
    return React.createElement(React.Fragment)
end

return TransferBlockSheet
