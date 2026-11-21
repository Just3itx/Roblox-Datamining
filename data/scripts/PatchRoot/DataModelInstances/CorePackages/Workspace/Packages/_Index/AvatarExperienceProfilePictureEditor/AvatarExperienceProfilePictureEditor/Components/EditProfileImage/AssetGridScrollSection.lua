-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local View = require(AvatarExperienceProfilePictureEditorParent.Foundation).View

local ScrollSection = require(AvatarExperienceProfilePictureEditor.Components.ScrollSection)
local _SectionTitle = require(AvatarExperienceProfilePictureEditor.Components.SectionTitle.SectionTitle)
local SectionHeader = require(AvatarExperienceProfilePictureEditor.Components.SectionTitle.SectionHeader)
local AssetPickerGrid = require(AvatarExperienceProfilePictureEditor.Components.AssetPicker.AssetPickerGrid)
local getAssetPickerStatus = require(AvatarExperienceProfilePictureEditor.Utils.getAssetPickerStatus)

local function AssetGridScrollSection(tbl1)
    return React.createElement(ScrollSection, {
        layoutOrder = tbl1.layoutOrder,
        pinHeader = true,
        useInternalScroll = tbl1.useInternalScroll,
        header = React.createElement(View, { tag = "auto-xy padding-x-xlarge" }, {
            Title = React.createElement(
                SectionHeader,
                {
                    title = tbl1.title,
                    leadingIconName = tbl1.titleLeadingIconName,
                    onBack = tbl1.onTitleBack
                }
            )
        })
    }, {
        Grid = React.createElement(AssetPickerGrid, {
            status = getAssetPickerStatus(tbl1.gridProps.isLoading, tbl1.gridProps.hasError),
            onRetry = tbl1.gridProps.onRetry,
            bannerComponent = tbl1.gridProps.bannerComponent,
            items = tbl1.gridProps.items,
            selectedId = tbl1.gridProps.selectedId,
            onSelect = tbl1.gridProps.onSelect,
            onDetailsActivated = tbl1.gridProps.onDetailsActivated,
            tileSize = tbl1.gridProps.tileSize,
            containerWidth = tbl1.gridProps.containerWidth,
            layoutOrder = tbl1.gridProps.layoutOrder
        })
    })
end

return AssetGridScrollSection
