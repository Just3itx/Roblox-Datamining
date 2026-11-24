-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)

local TransferFAEBlockSheet = require(CurrencyTransfers.Components.Generic.TransferFAEBlockSheet)
local VPCBlockContainer = require(CurrencyTransfers.Components.Generic.VPCBlockContainer)

local useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)

local _TransferDirection = require(CurrencyTransfers.Enums.TransferDirection)

local AmpWizardTransferConstants = require(CurrencyTransfers.Constants.AmpWizardTransferConstants)

local function ReceiveBlockSheet(_)
    local var1 = useTransferStore()
    local direction = var1.getDirection(false)
    local ampRecourseActions = var1.getAmpRecourseActions(false)
    local ampFeatureCheck = var1.getAmpFeatureCheck(false)

    local bool1 = false
    local bool2 = false
    if ampRecourseActions then
        for _, ampRecourseAction in ipairs(ampRecourseActions) do
            if ampRecourseAction == AmpWizardTransferConstants.RECOURSE_ID_VERIFICATION
                or ampRecourseAction == AmpWizardTransferConstants.RECOURSE_AGE_ESTIMATION
            then
                bool1 = true
            elseif ampRecourseAction == AmpWizardTransferConstants.RECOURSE_PARENT_LINK
                or ampRecourseAction == AmpWizardTransferConstants.RECOURSE_PARENT_CONSENT
            then
                bool2 = true
            end
        end
    end

    if bool1 and direction then
        return React.createElement(
            TransferFAEBlockSheet,
            {
                direction = direction,
                ampRecourseActions = ampRecourseActions,
                ampFeatureCheck = ampFeatureCheck
            }
        )
    elseif bool2 and direction then
        return React.createElement(
            VPCBlockContainer,
            {
                direction = direction,
                ampRecourseActions = ampRecourseActions,
                ampFeatureCheck = ampFeatureCheck
            }
        )
    end
    return React.createElement(React.Fragment)
end

return ReceiveBlockSheet
