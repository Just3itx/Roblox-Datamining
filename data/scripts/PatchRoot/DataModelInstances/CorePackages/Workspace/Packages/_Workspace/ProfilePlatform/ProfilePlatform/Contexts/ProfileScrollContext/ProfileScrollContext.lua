-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent
local React = require(ProfilePlatformParent.React)
local FFlagProfileInspectAvatarSlideIn = require(ProfilePlatformParent.SharedFlags).FFlagProfileInspectAvatarSlideIn
local FFlagProfileInspectAvatarShopChip = require(ProfilePlatformParent.SharedFlags).FFlagProfileInspectAvatarShopChip

return (React.createContext({
    scrollY = 0,
    setAbsoluteYPosition = function() end,
    peekViewOpenPercent = 0,
    setPeekViewOpenPercent = function() end,
    isPeekViewFullyOpen = if FFlagProfileInspectAvatarSlideIn then true elseif FFlagProfileInspectAvatarShopChip then true else nil,
    setIsPeekViewFullyOpen = (FFlagProfileInspectAvatarSlideIn or FFlagProfileInspectAvatarShopChip) and function() end or nil
}))
