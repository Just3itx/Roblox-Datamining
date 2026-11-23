-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local AdaptiveScrollingContext = require(script.Parent.AdaptiveScrollingContext)

local function useAdaptiveScrolling()
    return React.useContext(AdaptiveScrollingContext)
end

return useAdaptiveScrolling
