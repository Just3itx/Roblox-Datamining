-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContactsParent = script:FindFirstAncestor("TrustedContacts").Parent

local React = require(TrustedContactsParent.React)

local Foundation = require(TrustedContactsParent.Foundation)
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize

local IconVariant = require(TrustedContactsParent.BuilderIcons).IconVariant

local useDesignTokens = require(TrustedContactsParent.Style).useDesignTokens

local useProfileInsightsToIconsAndTexts = require(script.Parent.useProfileInsightsToIconsAndTexts)

local function SocialMetadataIconsAndTextsSection(tbl1)
    local var1 = useProfileInsightsToIconsAndTexts(tbl1.profileInsightIconItems)

    local var2 = useDesignTokens()
    local var3 = useTokens()

    local var4 = React.useCallback(function(tbl2, layoutOrder)
        return React.createElement(
            View,
            {
                tag = "auto-xy size-0 row align-y-center gap-xsmall padding-x-xsmall",
                LayoutOrder = layoutOrder
            },
            {
                Icon = React.createElement(Icon, { name = tbl2.icon, size = IconSize.XSmall, LayoutOrder = 1, variant = IconVariant.Filled }),
                Text = React.createElement(
                    FoundationText,
                    {
                        tag = "auto-xy size-0 text-align-x-left text-truncate-end text-body-medium",
                        Text = tbl2.text,
                        LayoutOrder = 2
                    }
                )
            }
        )
    end, { var2, var3 })

    local tbl2 = {}
    for k, value in pairs(var1) do
        table.insert(tbl2, (var4(value, k)))
    end

    return React.useMemo(function()
        return React.createElement(View, {
            tag = {
                ["row auto-y size-full-0 wrap align-x-left"] = true,
                ["gap-xsmall"] = tbl1.isVerticallyConstrained,
                ["gap-small"] = not tbl1.isVerticallyConstrained
            },
            LayoutOrder = tbl1.layoutOrder
        }, tbl2)
    end, { tbl1.profileInsightIconItems, tbl2 })
end

return SocialMetadataIconsAndTextsSection
