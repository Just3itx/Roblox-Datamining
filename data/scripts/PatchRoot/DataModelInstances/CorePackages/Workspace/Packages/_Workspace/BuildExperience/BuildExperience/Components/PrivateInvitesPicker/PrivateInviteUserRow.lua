-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useUserProfileInfo = require(BuildExperience.Components.UserPicker.useUserProfileInfo)

local FoundationText = Foundation.Text

local function PrivateInviteUserRow(tbl1)
    local var1 = useUserProfileInfo(tbl1.userId)
    return React.createElement(FoundationText, {
        LayoutOrder = tbl1.layoutOrder,
        Text = if var1.displayName ~= "" then var1.displayName else tbl1.unknownText,
        tag = "size-full-0 auto-y text-body-medium text-align-x-left content-default"
    })
end

return PrivateInviteUserRow
