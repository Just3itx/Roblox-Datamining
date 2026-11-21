-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local useLocalization = require(AvatarExperienceProfilePictureEditorParent.Localization).Hooks.useLocalization
local PlusSubscribeBanner = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceCommon.PlusSubscribeBanner)

local TextKeys = require(AvatarExperienceProfilePictureEditor.Common.TextKeys)

local function FramesPlusUpsellBar(tbl1)
    local var1 = useLocalization({ unlockBanner = TextKeys.ProfileFramesUnlockBanner, subscribe = TextKeys.Subscribe })

    return React.createElement(PlusSubscribeBanner, {
        message = var1.unlockBanner,
        actionText = tbl1.actionText or var1.subscribe,
        onActivated = tbl1.onSubscribeActivated,
        showPlusIcon = true,
        LayoutOrder = tbl1.layoutOrder,
        testId = "FramesPlusUpsellBar"
    })
end

return FramesPlusUpsellBar
