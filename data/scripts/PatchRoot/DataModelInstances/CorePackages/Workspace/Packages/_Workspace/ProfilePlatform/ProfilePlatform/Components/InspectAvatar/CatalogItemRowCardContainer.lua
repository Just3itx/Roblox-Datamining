-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)

local CatalogRowItemCard = require(ProfilePlatformParent.AvatarExperienceCommon).Components.CatalogItemCard.CatalogRowItemCard
local ItemCardThumbnail = require(ProfilePlatformParent.AvatarExperienceUIKit).ItemCardComponents.ItemCardThumbnail
local getPriceLineContent = require(ProfilePlatformParent.AvatarExperienceInspectAndBuy).Utils.getPriceLineContent

local View = Foundation.View
local Checkbox = Foundation.Checkbox
local useTokens = Foundation.Hooks.useTokens
local InputSize = Foundation.Enums.InputSize

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization

local FFlagProfileInspectAvatarBuyAll = require(ProfilePlatform.Flags.FFlagProfileInspectAvatarBuyAll)

local _Types = require(ProfilePlatform.Common.Types)
local ItemDisplayHelpers = require(script.Parent.ItemDisplayHelpers)

local function CatalogItemRowCardContainer(tbl1)
    local var1 = useTokens()
    local asset = tbl1.asset
    local id = asset.id

    local var2 = ItemDisplayHelpers.shouldShowBundleParts(asset)
    local var3 = useLocalization(
        var2 and {
            bundleParts = {
                "Feature.Catalog.Label.UsingBundleParts",
                count = asset.bundlePartsCount
            }
        } or {}
    )

    local url = ItemDisplayHelpers.getThumbnailUrl(asset)

    return React.createElement(
        View,
        {
            tag = "row align-y-top gap-medium",
            Size = UDim2.new(1, 0, 0, tbl1.rowHeight),
            LayoutOrder = tbl1.index
        },
        {
            ItemCheckbox = if FFlagProfileInspectAvatarBuyAll then nil else React.createElement(Checkbox, {
                label = "",
                isChecked = tbl1.isPurchasable and tbl1.isChecked,
                isDisabled = not tbl1.isPurchasable,
                size = InputSize.Small,
                onActivated = function(_: boolean)
                    tbl1.onToggleItem(id)
                end,
                LayoutOrder = 1
            }),
            ItemCard = React.createElement(View, { tag = "fill size-0-full", LayoutOrder = 2 }, {
                Card = React.createElement(CatalogRowItemCard, {
                    title = asset.name,
                    tag = "size-full",
                    presentationSlot = React.createElement(ItemCardThumbnail, { url = url }),
                    creator = asset.creator
                        and asset.creator.creatorName
                        and {
                            name = asset.creator.creatorName,
                            verified = asset.creator.creatorHasVerifiedBadge
                        }
                        or nil,
                    itemSubType = ItemDisplayHelpers.getItemTypeDisplayName(asset, tbl1.localizedStrings),
                    bundlePartsText = var3.bundleParts,
                    priceLineContent = getPriceLineContent(asset, var1, tbl1.priceStatusLocalized, { isShopContext = true }),
                    headerSize = UDim2.fromOffset(tbl1.rowHeight, tbl1.rowHeight),
                    footerSize = UDim2.fromScale(0, 1),
                    footerAutomaticSize = Enum.AutomaticSize.X,
                    onActivated = function()
                        tbl1.openItemDetails(id, asset.itemType or "Asset", tbl1.index)
                    end
                })
            })
        }
    )
end
return CatalogItemRowCardContainer
