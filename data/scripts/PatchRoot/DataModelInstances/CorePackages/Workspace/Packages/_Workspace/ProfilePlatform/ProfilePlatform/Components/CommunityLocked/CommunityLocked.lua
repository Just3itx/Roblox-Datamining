-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local TextKeys = require(ProfilePlatform.Common.TextKeys)

local FoundationText = require(ProfilePlatformParent.Foundation).Text
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization

local function CommunityLocked(_)
    local var1 = useLocalization({ groupLocked = TextKeys.GroupLocked })

    return React.createElement(FoundationText, { Text = var1.groupLocked, tag = "padding-top-xlarge" })
end

return CommunityLocked
