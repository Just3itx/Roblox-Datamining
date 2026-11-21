-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local FoundationText = require(AvatarExperienceUIKitParent.Foundation).Text

local function DescriptionTextBlock(tbl1)
    return React.createElement(FoundationText, {
        Text = tbl1.text,
        tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-left content-default",
        LayoutOrder = tbl1.LayoutOrder
    })
end

return DescriptionTextBlock
