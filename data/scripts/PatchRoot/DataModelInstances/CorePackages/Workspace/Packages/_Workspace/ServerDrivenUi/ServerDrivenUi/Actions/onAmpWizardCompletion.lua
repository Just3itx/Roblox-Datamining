-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local AmpUpsell = require(ServerDrivenUiParent.AmpUpsell)
local AccessResponseEnum = AmpUpsell.AmpEnums.AccessResponseEnum
local ActionStatusEnum = AmpUpsell.AmpEnums.ActionStatusEnum
local ActionTypeEnum = AmpUpsell.AmpEnums.ActionTypeEnum

local AgeCheckUpsellDismissedData = require(ServerDrivenUiParent.GameDetail).AgeCheckUpsellDismissedData

local function onAmpWizardCompletion(granted, arg1)
    if granted == AccessResponseEnum.Granted and arg1 and arg1[ActionTypeEnum.AgeEstimation] == ActionStatusEnum.Success then
        AgeCheckUpsellDismissedData.setAgeCheckUpsellDismissed()
    end
end

return onAmpWizardCompletion
