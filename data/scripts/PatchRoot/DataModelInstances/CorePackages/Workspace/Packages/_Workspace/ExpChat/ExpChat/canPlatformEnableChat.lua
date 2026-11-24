-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local UserInputService = game:GetService("UserInputService")
local AvatarChatService = game:GetService("AvatarChatService")

local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local SocialExperiments = require(ExpChatParent.SocialExperiments)
local FFlagTestDeviceForFAEUpsell = SocialExperiments.FFlagTestDeviceForFAEUpsell
local deviceMeetsRequirementsForFAE = SocialExperiments.deviceMeetsRequirementsForFAE

local FFlagAEGIS2UseGuacToShowFAEUpsell = require(ExpChatParent.SharedFlags).FFlagAEGIS2UseGuacToShowFAEUpsell

local UniversalAppPolicy = if FFlagAEGIS2UseGuacToShowFAEUpsell then require(ExpChatParent.UniversalAppPolicy) else nil

return function()
    if FFlagAEGIS2UseGuacToShowFAEUpsell then
        local var1 = UniversalAppPolicy.getAppFeaturePolicies().getShowInExpFAEUpsell()
            and AvatarChatService:deviceMeetsRequirementsForFeature(Enum.DeviceFeatureType.InExperienceFAE)

        if var1 then
            if FFlagTestDeviceForFAEUpsell then
                return (deviceMeetsRequirementsForFAE())
            end

            var1 = true
        end

        return var1
    end

    local platform = UserInputService:GetPlatform()
    local var1

    if platform == Enum.Platform.IOS
        or platform == Enum.Platform.Android
        or platform == Enum.Platform.Windows
        or platform == Enum.Platform.OSX
    then
        var1 = AvatarChatService:deviceMeetsRequirementsForFeature(Enum.DeviceFeatureType.InExperienceFAE)

        if var1 then
            if FFlagTestDeviceForFAEUpsell then
                return (deviceMeetsRequirementsForFAE())
            end

            var1 = true
        end
    else
        var1 = false
    end

    return var1
end
