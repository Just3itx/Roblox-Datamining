-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceGiftingParent = script:FindFirstAncestor("AvatarExperienceGifting").Parent

local React = require(AvatarExperienceGiftingParent.React)
local RecipientPickerView = require(AvatarExperienceGiftingParent.Gifting).Components.RecipientPickerView

local function AvatarItemGiftRecipientPickerView(tbl1)
    if not tbl1.isVisible then
        return nil
    end

    return React.createElement(RecipientPickerView, tbl1.pickerProps)
end

return AvatarItemGiftRecipientPickerView
