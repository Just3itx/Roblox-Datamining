-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local AppNavBar = require(BuildExperienceParent.AppNavBar)
local useTokens = require(BuildExperienceParent.Foundation).Hooks.useTokens
local useSelector = require(BuildExperienceParent.RoactUtils).Hooks.RoactRodux.useSelector
local useNavBarPlacement = AppNavBar.useNavBarPlacement

local function useBuildPageLayout()
    local tokens = useTokens()
    local var2 = useNavBarPlacement()
    local var3 = useSelector(function(arg1)
        return arg1.TabBarVisible
    end)

    return {
        tokens = tokens,
        topBarHeight = 56 * tokens.Config.UI.Scale,
        shouldIncludeBottomBar = var2 == AppNavBar.Placement.Bottom and var3 ~= false
    }
end

return useBuildPageLayout
