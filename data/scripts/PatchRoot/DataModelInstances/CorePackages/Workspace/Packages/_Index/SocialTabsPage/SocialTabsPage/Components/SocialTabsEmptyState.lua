-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPageParent = script:FindFirstAncestor("SocialTabsPage").Parent

local React = require(SocialTabsPageParent.React)
local Foundation = require(SocialTabsPageParent.Foundation)
local View = Foundation.View
local Image = Foundation.Image
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local FoundationCloudAssets = require(SocialTabsPageParent.FoundationCloudAssets)
local Assets = FoundationCloudAssets.Assets
FoundationCloudAssets.preloadAsset("pictograms/collaborators")
local var1 = Assets["pictograms/collaborators"] or {}

local function SocialTabsEmptyState(tbl1)
    local var2 = useTokens()
    local yOffset = 180 * var2.Config.UI.Scale
    local xOffset = 320 * var2.Config.UI.Scale

    return React.createElement(View, { tag = "col align-x-center align-y-center size-full" }, {
        EmptyContainer = React.createElement(View, { tag = "col align-x-center size-full-0 auto-y" }, {
            Illustration = React.createElement(Image, {
                LayoutOrder = 1,
                Image = var1.assetId,
                imageStyle = var2.Color.Content.Emphasis,
                ScaleType = Enum.ScaleType.Fit,
                Size = UDim2.new(0, xOffset, 0, yOffset),
                tag = "position-top-center anchor-top-center"
            }),
            EmptyText = React.createElement(FoundationText, { LayoutOrder = 2, tag = "size-full-0 auto-y text-body-medium", Text = tbl1.text })
        })
    })
end

return SocialTabsEmptyState
