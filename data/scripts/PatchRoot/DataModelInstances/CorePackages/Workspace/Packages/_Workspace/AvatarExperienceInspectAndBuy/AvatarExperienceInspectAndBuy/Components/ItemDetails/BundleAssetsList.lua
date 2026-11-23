-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local AvatarExperienceUIKit = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceUIKit)
local ItemCardThumbnail = AvatarExperienceUIKit.ItemCardComponents.ItemCardThumbnail
local ItemCardHeader = AvatarExperienceUIKit.ItemCardComponents.ItemCardHeader
local ItemCard = AvatarExperienceUIKit.ItemCardComponents.ItemCard
local ViewType = require(AvatarExperienceInspectAndBuy.Enums.ViewType)
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local getItemWidth = require(AvatarExperienceInspectAndBuy.Utils.itemDetailsUtils).getItemWidth

local function BundleAssetsList(tbl1)
    local var1 = useTokens()
    local itemData = tbl1.itemData
    local bool1 = tbl1.view == ViewType.WideLandscape
    local bool2 = tbl1.view == ViewType.Compact
    local var2, var3 = React.useBinding(Vector2.new(0, 0))

    local tbl2 = ({})
    local num1 = if bool1 or bool2 then 4 else 6

    if itemData.assetsInBundle then
        for value, value2 in itemData.assetsInBundle do
            local var4 = "AssetItemCard" .. value
            local createElement = React.createElement
            local var5 = ItemCard

            local tbl3 = {
                Size = var2:map(function(vector2: Vector2): UDim2
                    local itemWidth = getItemWidth(vector2.X, num1, var1.Gap.Medium)
                    return UDim2.new(0, itemWidth, 1, 0)
                end),
                AutomaticSize = Enum.AutomaticSize.Y,
                headerSlot = React.createElement(
                    ItemCardHeader,
                    { LayoutOrder = 1 },
                    React.createElement(ItemCardThumbnail, { url = "rbxthumb://type=Asset&id=" .. value2.id .. "&w=420&h=420" })
                ),
                footerSlot = if value2.name then React.createElement(Foundation.Text, {
                    tag = "auto-y text-body-small content-emphasis text-truncate-split text-align-x-left size-full-0 text-wrap",
                    LayoutOrder = 2,
                    Text = value2.name
                }) else nil
            }

            tbl2[var4] = createElement(var5, tbl3)
        end
    end

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var3(arg1.AbsoluteSize)
    end, {})

    return React.createElement(Foundation.View, {
        tag = "auto-y size-full-0 col align-x-left align-y-top gap-small",
        LayoutOrder = tbl1.LayoutOrder or 5,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }, {
        IncludedPartsLabel = React.createElement(Foundation.View, {
            tag = "auto-xy padding-top-xxlarge",
            LayoutOrder = 1
        }, {
            Label = React.createElement(
                Foundation.Text,
                {
                    tag = "text-title-medium text-align-x-left content-emphasis",
                    Text = tbl1.headerLabel,
                    LayoutOrder = 1
                }
            )
        }),
        BundleAssets = React.createElement(
            Foundation.View,
            {
                tag = "auto-y size-full-0 padding-y-small row align-x-left align-y-top gap-medium wrap",
                LayoutOrder = 2
            },
            tbl2
        )
    })
end

return BundleAssetsList
