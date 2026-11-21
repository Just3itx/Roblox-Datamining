-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local _Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)

local SectionTitle = require(script.Parent.SectionTitle)
local SectionTitleWithAction = require(script.Parent.SectionTitleWithAction)

local function SectionHeader(tbl1)
    if tbl1.onBack then
        return React.createElement(
            SectionTitleWithAction,
            {
                title = tbl1.title,
                leadingIconName = tbl1.leadingIconName,
                variant = "back",
                onActivated = tbl1.onBack
            }
        )
    end
    return React.createElement(SectionTitle, { title = tbl1.title, leadingIconName = tbl1.leadingIconName })
end

return SectionHeader
