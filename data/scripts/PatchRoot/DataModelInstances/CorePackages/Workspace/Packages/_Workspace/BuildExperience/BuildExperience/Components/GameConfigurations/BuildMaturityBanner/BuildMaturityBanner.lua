-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize

local function BuildMaturityBanner(tbl1)
    local text = tbl1.text
    return React.createElement(View, {
        LayoutOrder = 2,
        tag = "col size-full-0 auto-y padding-medium radius-medium bg-shift-200",
        testId = "build-maturity-banner"
    }, {
        Content = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "row align-y-center gap-small size-full-0 auto-y padding-y-xxsmall"
            },
            {
                Icon = React.createElement(Icon, {
                    LayoutOrder = 1,
                    name = IconName.ShieldCheck,
                    size = IconSize.Small,
                    tag = "auto-xy content-emphasis",
                    testId = "build-maturity-banner-icon"
                }),
                Description = React.createElement(
                    FoundationText,
                    {
                        LayoutOrder = 2,
                        Text = text,
                        tag = "fill auto-y text-body-small text-wrap text-align-x-left content-emphasis"
                    }
                )
            }
        )
    })
end
return BuildMaturityBanner
