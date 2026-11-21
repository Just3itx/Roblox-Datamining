-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)
local AvatarExperienceUIKit = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceUIKit)

local View = Foundation.View
local Radius = Foundation.Enums.Radius
local Grid = AvatarExperienceUIKit.GridComponents.Grid
local ItemCardThumbnailSkeleton = AvatarExperienceUIKit.ItemCardComponents.ItemCardThumbnailSkeleton

local AssetPickerErrorBody = require(script.Parent.AssetPickerErrorBody)
local AssetPickerTile = require(script.Parent.AssetPickerTile)
local _getAssetPickerStatus = require(AvatarExperienceProfilePictureEditor.Utils.getAssetPickerStatus)

local function buildLoadingItems(shimmerTileCount: number)
    local loadingItems = {}
    for i = 1, shimmerTileCount do
        table.insert(loadingItems, { id = "shimmer_" .. i })
    end

    return loadingItems
end

local function AssetPickerGridBody(tbl1)
    if tbl1.status == "error" then
        return React.createElement(AssetPickerErrorBody, { onRetry = tbl1.onRetry })
    end

    local bool1 = tbl1.status == "loading"
    local items = if bool1 then buildLoadingItems(tbl1.shimmerTileCount) else tbl1.items

    return React.createElement(Grid, {
        itemsPerRow = tbl1.itemsPerRow,
        items = items,
        gapVertical = tbl1.gap,
        gapHorizontal = tbl1.gap,
        getItemId = function(arg1)
            return arg1.id
        end,
        renderItem = bool1 and function(arg1)
            return React.createElement(
                View,
                {
                    tag = "size-full-0 auto-y",
                    LayoutOrder = arg1.index,
                    aspectRatio = {
                        AspectRatio = 1,
                        AspectType = Enum.AspectType.FitWithinMaxSize,
                        DominantAxis = Enum.DominantAxis.Width
                    }
                },
                {
                    Shimmer = React.createElement(ItemCardThumbnailSkeleton, { radius = Radius.Medium })
                }
            )
        end or function(arg1)
            local item = arg1.item
            return React.createElement(AssetPickerTile, {
                item = item,
                selectedId = tbl1.selectedId,
                onSelect = tbl1.onSelect,
                onDetailsActivated = tbl1.onDetailsActivated,
                labels = tbl1.labels,
                layoutOrder = arg1.index
            })
        end,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    })
end

return AssetPickerGridBody
