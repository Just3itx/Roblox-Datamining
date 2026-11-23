-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)

local FFlagAXPlusSubscribeBannerRestyle = require(script.Parent.FFlagAXPlusSubscribeBannerRestyle)

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens

return React.memo(function(tbl1) -- name: PlusSubscribeBanner
    local var1 = useTokens()
    local showPlusIcon = tbl1.showPlusIcon
    local testId = tbl1.testId or "PlusSubscribeBanner"

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        tag = {
            ["size-full-0 auto-y padding-medium radius-medium bg-action-standard"] = FFlagAXPlusSubscribeBannerRestyle,
            ["size-full-0 auto-y padding-medium stroke-standard stroke-position-inner stroke-default radius-medium"] = not FFlagAXPlusSubscribeBannerRestyle
        },
        LayoutOrder = tbl1.LayoutOrder,
        testId = testId
    }
    local tbl3 = { Content = 0 }
    local createElement2 = React.createElement
    local var3 = View
    local tbl4 = { tag = "row flex-between align-y-center gap-small size-full-0 auto-y" }

    local tbl5 = {
        Leading = React.createElement(View, {
            tag = "row align-y-center fill gap-small auto-xy",
            LayoutOrder = 1
        }, {
            PlusIcon = if showPlusIcon then React.createElement(Icon, {
                name = IconName.RobloxPlus,
                size = IconSize.Medium,
                style = var1.Color.Content.Emphasis,
                LayoutOrder = 1,
                testId = `{testId}PlusIcon`
            }) else nil,
            Message = React.createElement(
                FoundationText,
                {
                    tag = "fill text-body-small text-align-x-left content-emphasis",
                    Text = tbl1.message,
                    LayoutOrder = 2
                }
            )
        }),
        Subscribe = React.createElement(
            View,
            {
                tag = "auto-xy",
                LayoutOrder = 2,
                onActivated = tbl1.onActivated,
                testId = `{testId}Action`
            },
            {
                Label = React.createElement(
                    FoundationText,
                    {
                        tag = "auto-xy text-body-small content-default",
                        Text = `<u>{tbl1.actionText}</u>`,
                        RichText = true
                    }
                )
            }
        )
    }
    tbl3.Content = createElement2(var3, tbl4, tbl5)
    return createElement(var2, tbl2, tbl3)
end)
