-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local Localization = require(ProfilePlatformParent.Localization)
local BuilderIcons = require(ProfilePlatformParent.BuilderIcons)
local TextKeys = require(ProfilePlatform.Common.TextKeys)

local FoundationText = Foundation.Text
local View = Foundation.View
local Icon = Foundation.Icon
local InputSize = Foundation.Enums.InputSize
local IconVariant = Foundation.Enums.IconVariant
local CircleI = BuilderIcons.Icon.CircleI

local useLocalization = Localization.Hooks.useLocalization

local function JoinYear(tbl1)
    if not tbl1.joinDateTime or tbl1.joinDateTime == "" then
        return nil
    end

    local year = string.match(tbl1.joinDateTime, "^(%d%d%d%d)")
    if not year then
        return nil
    end

    local var2 = useLocalization({ statistics = TextKeys.Statistics, joinedInYear = { TextKeys.JoinedInYear, year = year } })

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
                    Text = var2.statistics
                }
            ),
            Content = React.createElement(
                View,
                {
                    LayoutOrder = tbl1.layoutOrder,
                    tag = "auto-xy size-0 row align-y-center gap-xsmall"
                },
                {
                    Icon = React.createElement(Icon, { LayoutOrder = 1, name = CircleI, size = InputSize.XSmall, variant = IconVariant.Filled }),
                    Text = React.createElement(
                        FoundationText,
                        {
                            LayoutOrder = 2,
                            tag = "auto-xy size-0 text-align-x-left text-body-medium",
                            Text = var2.joinedInYear
                        }
                    )
                }
            )
        }
    )
end

return JoinYear
