-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize

local function SectionTitleLabel(tbl1)
    local tbl2 = {
        Title = React.createElement(FoundationText, {
            tag = "auto-xy text-heading-small content-emphasis",
            Text = tbl1.title,
            LayoutOrder = if tbl1.leadingIconName then 2 else 1
        })
    }

    if tbl1.leadingIconName then
        tbl2.LeadingIcon = React.createElement(Icon, { name = tbl1.leadingIconName, size = IconSize.Medium, LayoutOrder = 1 })
    end

    return React.createElement(View, {
        tag = if tbl1.leadingIconName then "row align-y-center gap-xsmall auto-xy" else "auto-xy",
        LayoutOrder = tbl1.layoutOrder
    }, tbl2)
end

return SectionTitleLabel
