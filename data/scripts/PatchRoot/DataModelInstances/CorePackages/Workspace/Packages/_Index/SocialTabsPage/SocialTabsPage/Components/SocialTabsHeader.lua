-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local React = require(SocialTabsPageParent.React)
local Foundation = require(SocialTabsPageParent.Foundation)
local useNavigation = require(SocialTabsPageParent.Navigation).useNavigation
local useSocialTabsContext = require(SocialTabsPage.Contexts.useSocialTabsContext)
local FFlagSocialTabsPageSplitPaneLayout = require(SocialTabsPageParent.SharedFlags).FFlagSocialTabsPageSplitPaneLayout

local View = Foundation.View
local FoundationText = Foundation.Text
local IconButton = Foundation.IconButton
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local ButtonVariant = Foundation.Enums.ButtonVariant

local function SocialTabsHeader(tbl1)
    local var1 = useSocialTabsContext()
    local var2 = useNavigation()

    local onActivated = React.useCallback(function()
        var2.goBack()
    end, { var2 })

    return React.createElement(View, {
        tag = "row align-y-center gap-small size-full-0 auto-y padding-x-xlarge bg-surface-0",
        LayoutOrder = tbl1.layoutOrder
    }, {
        BackButton = if FFlagSocialTabsPageSplitPaneLayout and tbl1.hideBackButton then React.createElement(View, { Size = UDim2.fromOffset(36, 36), LayoutOrder = 1 }) else React.createElement(
            IconButton,
            {
                icon = IconName.ChevronLargeLeft,
                size = IconSize.Medium,
                variant = ButtonVariant.Utility,
                onActivated = onActivated,
                LayoutOrder = 1
            }
        ),
        Title = React.createElement(FoundationText, {
            tag = "fill auto-y text-heading-medium text-align-x-left text-truncate-end content-emphasis",
            LayoutOrder = 2,
            Text = var1.title or ""
        })
    })
end

return SocialTabsHeader
