-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local Foundation = require(AvatarExperienceCommonParent.Foundation)

local _BackgroundHighlight = require(script.Parent.BackgroundHighlight)

local useTokens = Foundation.Hooks.useTokens

return function(tbl1)
    local surface100 = useTokens().Color.Surface.Surface_100

    return {
        ZIndex = tbl1.ZIndex or 0,
        highlightColor = surface100
    }
end
