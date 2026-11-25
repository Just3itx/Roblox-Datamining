-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local Foundation = require(ProfilePlatformParent.Foundation)
local Localization = require(ProfilePlatformParent.Localization)
local TextKeys = require(ProfilePlatform.Common.TextKeys)

local FoundationText = Foundation.Text
local View = Foundation.View
local useLocalization = Localization.Hooks.useLocalization

local function NameHistory(tbl1)
    local var1 = useLocalization({ previousNames = TextKeys.PreviousNames, noPreviousName = TextKeys.NoPreviousName })
    local var2 = if not tbl1.nameHistory or #tbl1.nameHistory == 0 then var1.noPreviousName else table.concat(tbl1.nameHistory, ", ")
    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "col size-full-0 auto-y gap-small align-x-left"
        },
        {
            Title = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 1,
                    tag = "auto-y size-full-0 text-align-x-left text-heading-small",
                    Text = var1.previousNames
                }
            ),
            Content = React.createElement(FoundationText, {
                LayoutOrder = 2,
                tag = "auto-y size-full-0 text-align-x-left text-body-medium text-wrap",
                Text = var2,
                RichText = true
            })
        }
    )
end

return NameHistory
