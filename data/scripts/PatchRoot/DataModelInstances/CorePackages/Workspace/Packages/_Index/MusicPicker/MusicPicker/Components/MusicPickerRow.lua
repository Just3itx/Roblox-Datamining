-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MusicPicker = script:FindFirstAncestor("MusicPicker")
local MusicPickerParent = MusicPicker.Parent

local BuilderIcons = require(MusicPickerParent.BuilderIcons)
local Foundation = require(MusicPickerParent.Foundation)
local React = require(MusicPickerParent.React)
local RoactUtils = require(MusicPickerParent.RoactUtils)

local Image = Foundation.Image
local IconButton = Foundation.IconButton
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View
local getRbxThumb = Foundation.Utility.getRbxThumb

local useAssetFetchStatus = RoactUtils.Hooks.useAssetFetchStatus

local MusicPickerContext = require(MusicPicker.Context.MusicPickerContext)
local _MusicPickerTypes = require(MusicPicker.Types.MusicPickerTypes)

local PlayLarge = BuilderIcons.Icon.PlayLarge
local PauseLarge = BuilderIcons.Icon.PauseLarge
local Bookmark = BuilderIcons.Icon.Bookmark

local function MusicPickerRow(tbl1)
    local item = tbl1.item
    local var1 = React.useContext(MusicPickerContext)

    local bool1 = var1.previewingId == item.id
    local bool2 = var1.savedIds[item.id] == true

    local image = getRbxThumb(Foundation.Enums.ThumbnailType.Asset, item.thumbnailAssetId)
    local bool3 = useAssetFetchStatus(image) == Enum.AssetFetchStatus.Success

    local onActivated = React.useCallback(function()
        tbl1.onSelect(item.id)
    end, { tbl1.onSelect, item.id })

    local var2 = React.useCallback(function()
        var1.togglePreview(item.id)
    end, { var1.togglePreview, item.id })

    local var3 = React.useCallback(function()
        var1.toggleSaved(item.id)
    end, { var1.toggleSaved, item.id })

    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        onActivated = onActivated,
        tag = "row align-x-left align-y-center gap-medium size-full-0 auto-y padding-x-xsmall padding-y-small radius-medium"
    }
    local tbl3 = {
        Thumbnail = React.createElement(Image, {
            BackgroundTransparency = 1,
            cornerRadius = UDim.new(0, 8),
            Image = image,
            LayoutOrder = 1,
            ScaleType = Enum.ScaleType.Fit,
            tag = "position-center-center anchor-center-center size-1200"
        }, {
            Skeleton = if bool3 then nil else React.createElement(Skeleton, { radius = Radius.Medium, Size = UDim2.fromScale(1, 1) })
        }),
        MusicInfo = React.createElement(View, {
            LayoutOrder = 2,
            tag = "col shrink gap-xxsmall size-full-0 auto-y"
        }, {
            Title = React.createElement(FoundationText, {
                Text = item.title or "",
                tag = "auto-xy text-title-medium text-align-x-left text-align-y-top text-truncate-end content-emphasis"
            }),
            Artist = React.createElement(FoundationText, {
                Text = item.artist or "",
                tag = "auto-xy text-body-small text-align-x-left text-align-y-top text-truncate-end content-neutral"
            })
        }),
        Controls = 0
    }

    local createElement2 = React.createElement
    local var6 = View
    local tbl4 = { LayoutOrder = 3, tag = "row align-x-right align-y-center gap-small auto-xy" }

    local tbl5 = {
        PreviewButton = React.createElement(IconButton, {
            icon = if bool1 then PauseLarge else PlayLarge,
            isCircular = true,
            LayoutOrder = 1,
            onActivated = var2,
            size = Foundation.Enums.IconSize.Small,
            variant = Foundation.Enums.ButtonVariant.Standard
        }),
        SaveButton = 0
    }
    local element

    if var1.showSaveButton then
        element = React.createElement(IconButton, {
            icon = {
                name = Bookmark,
                variant = if bool2 then BuilderIcons.IconVariant.Filled else BuilderIcons.IconVariant.Regular
            },
            isCircular = true,
            LayoutOrder = 2,
            onActivated = var3,
            size = Foundation.Enums.IconSize.Small,
            variant = Foundation.Enums.ButtonVariant.Utility
        })
    else
        element = nil
    end

    tbl5.SaveButton = element
    tbl3.Controls = createElement2(var6, tbl4, tbl5)
    return createElement(var5, tbl2, tbl3)
end

return MusicPickerRow
