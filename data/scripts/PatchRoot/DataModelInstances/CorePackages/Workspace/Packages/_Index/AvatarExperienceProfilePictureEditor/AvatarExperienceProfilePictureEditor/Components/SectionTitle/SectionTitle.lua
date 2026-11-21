-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local View = require(AvatarExperienceProfilePictureEditorParent.Foundation).View

local SectionTitleLabel = require(script.Parent.SectionTitleLabel)

local function SectionTitle(tbl1)
    return React.createElement(View, {
        tag = "auto-xy",
        LayoutOrder = tbl1.layoutOrder
    }, {
        TitleRow = React.createElement(
            View,
            { tag = "auto-xy padding-y-xsmall" },
            {
                Label = React.createElement(SectionTitleLabel, { title = tbl1.title, leadingIconName = tbl1.leadingIconName })
            }
        )
    })
end

return SectionTitle
