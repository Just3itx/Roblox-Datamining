-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)
local Localization = require(AvatarExperienceProfilePictureEditorParent.Localization)
local AvatarExperienceUIKit = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceUIKit)

local View = Foundation.View
local ScrollView = Foundation.ScrollView
local Visibility = Foundation.Enums.Visibility
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens
local useLocalization = Localization.Hooks.useLocalization
local SectionTitle = require(AvatarExperienceProfilePictureEditor.Components.SectionTitle.SectionTitle)
local SectionTitleWithAction = require(AvatarExperienceProfilePictureEditor.Components.SectionTitle.SectionTitleWithAction)
local AssetPickerErrorBody = require(script.Parent.AssetPickerErrorBody)
local AssetPickerTile = require(script.Parent.AssetPickerTile)
local _getAssetPickerStatus = require(AvatarExperienceProfilePictureEditor.Utils.getAssetPickerStatus)
local TextKeys = require(AvatarExperienceProfilePictureEditor.Common.TextKeys)
local WidgetLayout = AvatarExperienceUIKit.WidgetComponents.WidgetLayout
local ItemCardThumbnailSkeleton = AvatarExperienceUIKit.ItemCardComponents.ItemCardThumbnailSkeleton

local function AssetPickerCarousel(tbl1)
    local status = tbl1.status or "ready"
    local var1 = useTokens()
    local var2 = useLocalization({ details = TextKeys.DetailsButton })

    local tileSize = tbl1.tileSize
    local shimmerTileCount = tbl1.shimmerTileCount or 8
    local labels = React.useMemo(function()
        return {
            details = var2.details
        }
    end, { var2.details })

    local tbl2 = React.useMemo(function()
        local result = {}
        for layoutOrder, item in tbl1.items do
            local var4 = "Asset_" .. item.id
            local createElement = React.createElement
            local var5 = View
            local tbl2 = {
                tag = "size-full-0 auto-y",
                Size = UDim2.fromOffset(tileSize, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = layoutOrder
            }
            local tbl3 = {
                Tile = React.createElement(AssetPickerTile, {
                    item = item,
                    selectedId = tbl1.selectedId,
                    onSelect = tbl1.onSelect,
                    onDetailsActivated = tbl1.onDetailsActivated,
                    labels = labels
                })
            }
            result[var4] = createElement(var5, tbl2, tbl3)
        end

        if tbl1.trailingCarouselComponent then
            result.Trailing = tbl1.trailingCarouselComponent
        end
        return result
    end, {
        tbl1.items,
        tbl1.selectedId,
        tileSize,
        tbl1.onSelect,
        tbl1.onDetailsActivated,
        labels,
        tbl1.trailingCarouselComponent
    })

    local title = tbl1.title or ""
    local bool1 = status == "ready" and tbl1.onTitleActivated ~= nil
    local num1 = 1
    local tbl3 = {}
    if tbl1.bannerComponent then
        tbl3.Banner = React.createElement(View, { tag = "size-full-0 auto-y", LayoutOrder = num1 }, { Banner = tbl1.bannerComponent })

        num1 += 1
    end

    if status == "error" then
        tbl3.Error = React.createElement(AssetPickerErrorBody, { onRetry = tbl1.onRetry, layoutOrder = num1 })
    else
        if status == "loading" then
            tbl2 = {}
            for layoutOrder = 1, shimmerTileCount do
                local str1 = "Shimmer_" .. layoutOrder
                local createElement = React.createElement
                local var4 = ItemCardThumbnailSkeleton
                local tbl4 = {
                    Size = UDim2.fromOffset(tileSize, tileSize),
                    radius = Radius.Medium,
                    LayoutOrder = layoutOrder
                }
                tbl2[str1] = createElement(var4, tbl4)
            end
        end

        local var4 = table.clone(tbl2)

        var4.CarouselStrokeInset = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, var1.Padding.XSmall),
            PaddingBottom = UDim.new(0, var1.Padding.XSmall),
            PaddingLeft = UDim.new(0, var1.Padding.XSmall),
            PaddingRight = UDim.new(0, var1.Padding.XSmall)
        })

        tbl3.List = React.createElement(ScrollView, {
            tag = "size-full-0 auto-y",
            testId = "asset-picker-carousel-scroll",
            LayoutOrder = num1,
            selection = { Selectable = false },
            layout = {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                Padding = UDim.new(0, var1.Gap.Medium),
                SortOrder = Enum.SortOrder.LayoutOrder
            },
            scroll = {
                ScrollingDirection = Enum.ScrollingDirection.X,
                AutomaticSize = Enum.AutomaticSize.Y,
                AutomaticCanvasSize = Enum.AutomaticSize.X,
                CanvasSize = UDim2.fromScale(0, 0),
                scrollBarVisibility = Visibility.None
            }
        }, var4)
    end

    return React.createElement(WidgetLayout, {
        LayoutOrder = tbl1.layoutOrder,
        padding = {
            left = UDim.new(0, var1.Padding.XLarge),
            right = UDim.new(0, var1.Padding.XLarge)
        },
        headerSlot = if title == "" then nil elseif bool1 then React.createElement(
            SectionTitleWithAction,
            {
                title = title,
                leadingIconName = tbl1.titleLeadingIconName,
                variant = "expand",
                onActivated = tbl1.onTitleActivated
            }
        ) else React.createElement(SectionTitle, { title = title, leadingIconName = tbl1.titleLeadingIconName }),
        contentSlot = React.createElement(View, { tag = "col gap-small size-full-0 auto-y" }, tbl3)
    })
end

return AssetPickerCarousel
