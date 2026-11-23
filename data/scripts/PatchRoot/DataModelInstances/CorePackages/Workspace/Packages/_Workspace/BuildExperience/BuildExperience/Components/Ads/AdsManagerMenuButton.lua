-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local AdsManagerMenuButtonView = require(script.Parent.AdsManagerMenuButtonView)
local useAdsManagerMenuButtonViewModel = require(script.Parent.useAdsManagerMenuButtonViewModel)

local function AdsManagerMenuButton(arg1)
    local var1 = useAdsManagerMenuButtonViewModel(arg1)
    return React.createElement(AdsManagerMenuButtonView, var1)
end

return AdsManagerMenuButton
