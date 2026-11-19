-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T13:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagVirtualizedFeedFooterWrapperProp = require(script.Parent.FFlagVirtualizedFeedFooterWrapperProp)
local FFlagEditProfileImageR15UpgradePrompt = require(script.Parent.FFlagEditProfileImageR15UpgradePrompt)
local FFlagAppBloxConfirmationDialogFocusNav = require(script.Parent.FFlagAppBloxConfirmationDialogFocusNav)
local FFlagEditProfileImageV2ConsoleEnabled = require(script.Parent.FFlagEditProfileImageV2ConsoleEnabled)

local bool1 = game:DefineFastFlag("EditProfileImageV2Enabled7", false)

local engineFeature = game:GetEngineFeature("AvatarEditorServiceApplyProfileConfigurationEnabled")
    and game:GetEngineFeature("ThumbnailCustomizationsInProfileConfigurationEnabled")

return (bool1 or FFlagEditProfileImageV2ConsoleEnabled and FFlagAppBloxConfirmationDialogFocusNav)
    and engineFeature
    and FFlagVirtualizedFeedFooterWrapperProp
    and FFlagEditProfileImageR15UpgradePrompt
