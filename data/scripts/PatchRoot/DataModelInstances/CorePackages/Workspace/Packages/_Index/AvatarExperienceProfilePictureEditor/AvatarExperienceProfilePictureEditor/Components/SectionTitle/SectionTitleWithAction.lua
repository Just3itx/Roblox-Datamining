-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)

local View = Foundation.View
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant

local _SectionTitle = require(script.Parent.SectionTitle)
local SectionTitleLabel = require(script.Parent.SectionTitleLabel)

local function SectionTitleWithAction(arg1)
    local bool1 = arg1.variant == "back"

    local createElement = React.createElement
    local var1 = View
    local tbl1 = {
        tag = "size-full-0 auto-y",
        LayoutOrder = arg1.layoutOrder
    }
    local tbl2 = { TitleRow = 0 }
    local createElement2 = React.createElement
    local var2 = View
    local tbl3 = {
        tag = "row align-y-center gap-xsmall auto-xy padding-y-xsmall",
        onActivated = arg1.onActivated
    }
    local tbl4 = {
        Label = React.createElement(
            SectionTitleLabel,
            {
                title = arg1.title,
                leadingIconName = arg1.leadingIconName,
                layoutOrder = if bool1 then 2 else 1
            }
        ),
        Chevron = React.createElement(Icon, {
            name = if bool1 then IconName.ChevronLargeLeft else IconName.ChevronLargeRight,
            size = IconSize.Medium,
            variant = IconVariant.Filled,
            LayoutOrder = if bool1 then 1 else 2
        })
    }
    tbl2.TitleRow = createElement2(var2, tbl3, tbl4)
    return createElement(var1, tbl1, tbl2)
end

return SectionTitleWithAction
