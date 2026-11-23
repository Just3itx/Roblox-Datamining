-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshopParent = script:FindFirstAncestor("AvatarWorkshop").Parent

local React = require(AvatarWorkshopParent.React)
local Foundation = require(AvatarWorkshopParent.Foundation)

local function AvatarPreview()
    return React.createElement(
        Foundation.View,
        {
            tag = "size-full-full radius-medium bg-shift-200",
            testId = "avatar-workshop-avatar-preview"
        }
    )
end

return AvatarPreview
