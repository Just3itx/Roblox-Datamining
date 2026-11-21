-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)
local Localization = require(AvatarExperienceProfilePictureEditorParent.Localization)

local View = Foundation.View
local IconName = Foundation.Enums.IconName
local useLocalization = Localization.Hooks.useLocalization

local ScrollSection = require(AvatarExperienceProfilePictureEditor.Components.ScrollSection)
local AssetPickerCarousel = require(AvatarExperienceProfilePictureEditor.Components.AssetPicker.AssetPickerCarousel)
local _AssetPickerTile = require(AvatarExperienceProfilePictureEditor.Components.AssetPicker.AssetPickerTile)
local ShopMoreCarouselTile = require(AvatarExperienceProfilePictureEditor.Components.AssetPicker.ShopMoreCarouselTile)
local getAssetPickerStatus = require(AvatarExperienceProfilePictureEditor.Utils.getAssetPickerStatus)
local TextKeys = require(AvatarExperienceProfilePictureEditor.Common.TextKeys)

local useEditProfileImageActions = require(AvatarExperienceProfilePictureEditor.Context.EditProfileImageActionsContext).useEditProfileImageActions

local function CombinedCarouselsContent(tbl1)
    local var1 = useEditProfileImageActions()
    local var2 = useLocalization({ emotes = TextKeys.Emotes, frames = TextKeys.Frames, shopForMore = TextKeys.ShopForMore })

    local status = getAssetPickerStatus(tbl1.emotesLoading, tbl1.emotesError)
    local showFrames = tbl1.showFrames
    local trailingCarouselComponent = if status == "ready" then React.createElement(ShopMoreCarouselTile, {
        label = var2.shopForMore,
        tileSize = tbl1.tileSize,
        layoutOrder = #tbl1.emoteItems + 1,
        onActivated = var1.onShopForMoreEmotes
    }) else nil
    local createElement = React.createElement
    local var3 = ScrollSection
    local tbl2 = {
        layoutOrder = tbl1.layoutOrder,
        pinHeader = false,
        useInternalScroll = tbl1.useInternalScroll
    }
    local tbl3 = { Sections = 0 }
    local createElement2 = React.createElement
    local var4 = View
    local tbl4 = { tag = "col gap-xsmall size-full-0 auto-y" }

    local tbl5 = {
        Emotes = React.createElement(AssetPickerCarousel, {
            title = var2.emotes,
            status = status,
            onRetry = tbl1.onRetryEmotes,
            items = tbl1.emoteItems,
            selectedId = tbl1.selectedEmoteId,
            onSelect = tbl1.onSelectEmote,
            onDetailsActivated = var1.onOpenEmoteDetails,
            onTitleActivated = tbl1.onExpandEmotes,
            trailingCarouselComponent = trailingCarouselComponent,
            tileSize = tbl1.tileSize,
            layoutOrder = 1
        }),
        Frames = 0
    }
    local element2

    if showFrames then
        element2 = React.createElement(AssetPickerCarousel, {
            title = var2.frames,
            titleLeadingIconName = IconName.RobloxPlus,
            status = getAssetPickerStatus(tbl1.framesLoading, tbl1.framesError),
            onRetry = tbl1.onRetryFrames,
            bannerComponent = tbl1.framesBannerComponent,
            items = tbl1.frameItems,
            selectedId = tbl1.selectedFrameId,
            onSelect = tbl1.onSelectFrame,
            onTitleActivated = tbl1.onExpandFrames,
            tileSize = tbl1.tileSize,
            layoutOrder = 2
        })
    else
        element2 = nil
    end

    tbl5.Frames = element2
    tbl3.Sections = createElement2(var4, tbl4, tbl5)
    return createElement(var3, tbl2, tbl3)
end

return CombinedCarouselsContent
