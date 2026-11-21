-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)
local AvatarExperienceCommon = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceCommon)
local AvatarExperienceUIKit = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceUIKit)

local View = Foundation.View
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local CatalogItemCard = AvatarExperienceCommon.Components.CatalogItemCard.CatalogItemCard
local ItemCardThumbnail = AvatarExperienceUIKit.ItemCardComponents.ItemCardThumbnail

local function buildPresentationSlot(name, url: string?)
    local element = nil
    local bool1 = false

    if name then
        element = React.createElement(Icon, { name = name, size = IconSize.Large })
        bool1 = true
    elseif url then
        element = React.createElement(ItemCardThumbnail, { url = url })
    end

    if element == nil then
        return nil
    end

    return React.createElement(
        View,
        {
            tag = {
                ["align-x-center align-y-center size-full padding-small"] = bool1,
                ["size-full padding-small"] = not bool1
            }
        },
        { Content = element }
    )
end

local function AssetPickerTile(tbl1)
    local item = tbl1.item
    local isSelected = item.id == tbl1.selectedId
    local onDetailsActivated = tbl1.onDetailsActivated
    local bool2 = isSelected and onDetailsActivated ~= nil

    return React.createElement(CatalogItemCard, {
        title = item.label,
        presentationSlot = buildPresentationSlot(item.iconName, item.image),
        priceLineContent = item.priceLineContent,
        isSelected = isSelected,
        onActivated = function()
            tbl1.onSelect(item.id)
        end,
        onOverlayButtonActivated = bool2 and onDetailsActivated and function()
            onDetailsActivated(item.id)
        end or nil,
        overlayButtonText = if bool2 then tbl1.labels.details else nil,
        headerAspectRatio = 1,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = tbl1.layoutOrder
    })
end

return AssetPickerTile
