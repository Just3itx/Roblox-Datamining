-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local Localization = require(ProfilePlatformParent.Localization)

local Foundation = require(ProfilePlatformParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local useLocalization = Localization.Hooks.useLocalization
local FFlagProfileAboutDetailsUseSheet = require(ProfilePlatformParent.SharedFlags).FFlagProfileAboutDetailsUseSheet

local function AboutDescription(tbl1)
    local var1 = useLocalization({
        about = TextKeys.About,
        aboutHeading = {
            TextKeys.AboutDetailsHeading,
            name = tbl1.name
        },
        noBioYet = TextKeys.NoBioYet
    })

    local description = tbl1.description
    if description == nil or description == "" then
        description = var1.noBioYet
    end

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col size-full-0 auto-y gap-small align-x-left"
    }
    local tbl3 = {
        AboutTitle = if FFlagProfileAboutDetailsUseSheet then nil else React.createElement(FoundationText, {
            LayoutOrder = 1,
            tag = "size-full-0 auto-y text-heading-small text-align-x-left",
            Text = if tbl1.name then var1.aboutHeading else var1.about
        }),
        AboutDescription = React.createElement(
            FoundationText,
            {
                LayoutOrder = 2,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left",
                Text = description
            }
        )
    }
    return createElement(var2, tbl2, tbl3)
end

return AboutDescription
