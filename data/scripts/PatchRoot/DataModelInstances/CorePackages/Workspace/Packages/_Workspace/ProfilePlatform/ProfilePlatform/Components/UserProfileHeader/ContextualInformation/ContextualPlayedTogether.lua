-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization

local TextKeys = require(ProfilePlatform.Common.TextKeys)

local PlayerContext = require(ProfilePlatformParent.UIBlox).App.Indicator.PlayerContext

local function ContextualPlayedTogether(tbl1)
    local experienceName = tbl1.experienceName

    local var1 = useLocalization({
        playedTogetherText = experienceName ~= "" and {
            TextKeys.PlayedTogetherInGameDescription,
            experience_name = experienceName
        }
            or TextKeys.PlayedTogether
    })

    return React.createElement(PlayerContext, { text = var1.playedTogetherText })
end

return ContextualPlayedTogether
