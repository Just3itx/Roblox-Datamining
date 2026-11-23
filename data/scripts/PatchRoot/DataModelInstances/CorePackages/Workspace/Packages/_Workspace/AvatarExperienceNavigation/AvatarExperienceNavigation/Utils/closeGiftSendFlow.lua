-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceNavigation = script:FindFirstAncestor("AvatarExperienceNavigation")

local AvatarScreen = require(AvatarExperienceNavigation.Enums.AvatarScreen)
local ClearScreens = require(AvatarExperienceNavigation.NavigationActions.ClearScreens)
local _NavigationType = require(AvatarExperienceNavigation.Types.NavigationType)

local function closeGiftSendFlow(arg1)
    arg1.dispatch(ClearScreens({ AvatarScreen.SendGiftRecipientPicker, AvatarScreen.SendGiftReview }))
end

return closeGiftSendFlow
