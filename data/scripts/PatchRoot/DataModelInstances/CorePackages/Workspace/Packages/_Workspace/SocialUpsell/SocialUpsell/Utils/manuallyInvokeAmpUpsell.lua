-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local SocialUpsellParent = SocialUpsell.Parent

local AmpUpsell = require(SocialUpsellParent.AmpUpsell)
local Constants = require(SocialUpsell.Constants)
local InExpAmpWizardController = AmpUpsell.InExpAmpWizardController
local AccessResponseEnum = AmpUpsell.AmpEnums.AccessResponseEnum

local DEFAULT_FAE_ENTRY_POINT_EVENT_CTX = Constants.DEFAULT_FAE_ENTRY_POINT_EVENT_CTX

local FStringCommsFAEFeatureName = require(SocialUpsell.Flag.FStringCommsFAEFeatureName)
local FStringCommsFAENamespace = require(SocialUpsell.Flag.FStringCommsFAENamespace)

return function(str1: string?, callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?)
    return InExpAmpWizardController.OpenAmpWizardContainerInExp(FStringCommsFAEFeatureName, function(granted, _)
        if granted == AccessResponseEnum.Granted then
            if callback then
                callback()
            end
        elseif callback2 then
            callback2()
        end
    end, nil, str1 or DEFAULT_FAE_ENTRY_POINT_EVENT_CTX, nil, FStringCommsFAENamespace)
end
