-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)
local Localization = require(AvatarExperienceProfilePictureEditorParent.Localization)
local AvatarExperienceUIKit = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceUIKit)

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local useLocalization = Localization.Hooks.useLocalization

local TextKeys = require(AvatarExperienceProfilePictureEditor.Common.TextKeys)
local SectionTitle = require(AvatarExperienceProfilePictureEditor.Components.SectionTitle.SectionTitle)
local AssetPickerGridBody = require(script.Parent.AssetPickerGridBody)
local _AssetPickerTile = require(script.Parent.AssetPickerTile)
local _getAssetPickerStatus = require(AvatarExperienceProfilePictureEditor.Utils.getAssetPickerStatus)
local getGridMetrics = require(AvatarExperienceProfilePictureEditor.Utils.getGridMetrics)

local WidgetHeader = AvatarExperienceUIKit.WidgetComponents.WidgetHeader

local function AssetPickerGrid(tbl1)
    local status = tbl1.status or "ready"
    local var1 = useTokens()
    local containerWidth = tbl1.containerWidth
    local var2 = useLocalization({ details = TextKeys.DetailsButton })

    local tileSize = tbl1.tileSize
    local medium = var1.Gap.Medium
    local shimmerTileCount = tbl1.shimmerTileCount or 30
    local labels = React.useMemo(function()
        return {
            details = var2.details
        }
    end, { var2.details })

    local var4 = React.useMemo(function()
        return getGridMetrics({
            containerWidth = containerWidth,
            minTileSize = tileSize,
            gap = medium,
            horizontalPadding = var1.Padding.XLarge,
            strokeInset = var1.Padding.XSmall
        })
    end, {
        containerWidth,
        tileSize,
        medium,
        var1.Padding.XLarge,
        var1.Padding.XSmall
    })
    local title = tbl1.title or ""
    local num1 = 1
    local tbl2 = {}
    if tbl1.bannerComponent then
        tbl2.Banner = React.createElement(View, { tag = "size-full-0 auto-y", LayoutOrder = num1 }, { Banner = tbl1.bannerComponent })

        num1 += 1
    end
    if status ~= "ready" or #tbl1.items > 0 then
        tbl2.Grid = React.createElement(
            View,
            { tag = "size-full-0 auto-y padding-x-xsmall padding-y-xsmall", LayoutOrder = num1 },
            {
                Content = React.createElement(AssetPickerGridBody, {
                    status = status,
                    items = tbl1.items,
                    selectedId = tbl1.selectedId,
                    itemsPerRow = var4.itemsPerRow,
                    gap = medium,
                    shimmerTileCount = shimmerTileCount,
                    onSelect = tbl1.onSelect,
                    onDetailsActivated = tbl1.onDetailsActivated,
                    labels = labels,
                    onRetry = tbl1.onRetry
                })
            }
        )
        num1 += 1
    end
    if tbl1.footerComponent then
        tbl2.Footer = React.createElement(
            View,
            { tag = "size-full-0 auto-y padding-y-medium", LayoutOrder = num1 },
            {
                Footer = tbl1.footerComponent
            }
        )
    end
    local num2 = 1
    local tbl3 = {}

    if title ~= "" then
        local header = if tbl1.seeAllCallback then React.createElement(WidgetHeader, { titleText = title, seeAllCallback = tbl1.seeAllCallback }) else React.createElement(SectionTitle, { title = title })
        tbl3.Title = React.createElement(View, { tag = "auto-xy padding-x-xlarge", LayoutOrder = num2 }, { Header = header })

        num2 += 1
    end

    tbl3.Body = React.createElement(View, { tag = "col gap-small size-full-0 auto-y padding-x-xlarge", LayoutOrder = num2 }, tbl2)

    return React.createElement(View, { tag = "col size-full-0 auto-y", LayoutOrder = tbl1.layoutOrder }, tbl3)
end

return AssetPickerGrid
