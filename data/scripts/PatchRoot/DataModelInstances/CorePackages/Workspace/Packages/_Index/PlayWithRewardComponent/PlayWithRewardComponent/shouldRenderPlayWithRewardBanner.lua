-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local PlayWithRewardComponentParent = script:FindFirstAncestor("PlayWithRewardComponent").Parent
local _PlayWithRewardState = require(PlayWithRewardComponentParent.PlayWithRewardState)

local function shouldRenderPlayWithRewardBanner(str1: string, str2: string, str3: string?, arg1): boolean
    local localPlayer = Players.LocalPlayer
    local num1 = tonumber(arg1 and arg1.productId or 0) or 0

    if localPlayer == nil
        or str2 == ""
        or str3 == nil
        or str3 ~= str1
        or arg1 == nil
        or arg1.adAvailabilityResult ~= Enum.AdAvailabilityResult.IsAvailable
        or arg1.experimentVariantData == nil
        or arg1.experimentVariantData.titleText == "" and arg1.experimentVariantData.subtitleText == ""
    then
        return false
    end

    return num1 ~= 0
end

return shouldRenderPlayWithRewardBanner
