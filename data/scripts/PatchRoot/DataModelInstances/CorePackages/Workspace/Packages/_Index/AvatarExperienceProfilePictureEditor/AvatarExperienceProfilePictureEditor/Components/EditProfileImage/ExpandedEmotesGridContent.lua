-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)
local Localization = require(AvatarExperienceProfilePictureEditorParent.Localization)

local View = Foundation.View
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize
local useLocalization = Localization.Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens

local ScrollSection = require(AvatarExperienceProfilePictureEditor.Components.ScrollSection)
local SectionHeader = require(AvatarExperienceProfilePictureEditor.Components.SectionTitle.SectionHeader)
local AssetPickerGrid = require(AvatarExperienceProfilePictureEditor.Components.AssetPicker.AssetPickerGrid)
local VirtualizedFeedContainer = require(AvatarExperienceProfilePictureEditor.Components.AssetPicker.VirtualizedFeedContainer)
local getAssetPickerStatus = require(AvatarExperienceProfilePictureEditor.Utils.getAssetPickerStatus)
local TextKeys = require(AvatarExperienceProfilePictureEditor.Common.TextKeys)

local useEditProfileImageActions = require(AvatarExperienceProfilePictureEditor.Context.EditProfileImageActionsContext).useEditProfileImageActions

local function ExpandedEmotesGridContent(tbl1)
    local var1 = useTokens()
    local var2 = useEditProfileImageActions()
    local var3 = useLocalization({
        emotes = TextKeys.Emotes,
        details = TextKeys.DetailsButton,
        recommendations = TextKeys.Recommendations,
        shopForMore = TextKeys.ShopForMore
    })
    local labels = React.useMemo(function()
        return {
            details = var3.details
        }
    end, { var3.details })
    local status = getAssetPickerStatus(tbl1.emotesLoading, tbl1.emotesError)
    local var5 = status ~= "ready" or tbl1.useInternalScroll
    local element = React.createElement(
        View,
        {
            tag = {
                ["auto-xy padding-x-xlarge"] = var5,
                ["auto-xy padding-x-xlarge padding-bottom-medium"] = not var5
            }
        },
        {
            Title = React.createElement(SectionHeader, { title = var3.emotes, onBack = tbl1.onTitleBack })
        }
    )

    if status ~= "ready" then
        return React.createElement(
            ScrollSection,
            {
                layoutOrder = tbl1.layoutOrder,
                pinHeader = true,
                useInternalScroll = true,
                header = element
            },
            {
                OwnedEmotes = React.createElement(AssetPickerGrid, {
                    status = status,
                    items = tbl1.ownedEmoteItems,
                    onRetry = tbl1.onRetryEmotes,
                    selectedId = tbl1.selectedEmoteId,
                    onSelect = tbl1.onSelectEmote,
                    onDetailsActivated = var2.onOpenEmoteDetails,
                    tileSize = tbl1.tileSize,
                    containerWidth = tbl1.containerWidth,
                    layoutOrder = 1
                })
            }
        )
    end

    local element2

    if tbl1.hasMoreEmotes or tbl1.isLoadingMoreEmotes or tbl1.hasLoadMoreEmotesError then
        element2 = nil
    else
        element2 = React.createElement(View, { tag = "col size-full-0 auto-y padding-top-xlarge" }, {
            Recommendations = React.createElement(AssetPickerGrid, {
                title = var3.recommendations,
                items = tbl1.recommendedEmoteItems,
                selectedId = tbl1.selectedEmoteId,
                onSelect = tbl1.onSelectEmote,
                onDetailsActivated = var2.onOpenEmoteDetails,
                footerComponent = React.createElement(Button, {
                    text = var3.shopForMore,
                    variant = ButtonVariant.Standard,
                    size = InputSize.Medium,
                    fillBehavior = FillBehavior.Fill,
                    onActivated = var2.onShopForMoreEmotes
                }),
                tileSize = tbl1.tileSize,
                containerWidth = tbl1.containerWidth,
                layoutOrder = 2
            })
        })
    end

    local createElement = React.createElement
    local var6 = View
    local tbl2 = {
        tag = {
            ["col grow gap-medium size-full-0 padding-top-xlarge"] = var5,
            ["col grow size-full-0 padding-top-xlarge"] = not var5
        },
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = {
        Header = if var5 then element else nil,
        FeedContainer = 0
    }
    local createElement2 = React.createElement
    local var7 = View
    local tbl4 = {
        tag = "grow size-full-0",
        LayoutOrder = if var5 then 2 else 1
    }
    local tbl5 = { Feed = 0 }
    local createElement3 = React.createElement
    local var8 = VirtualizedFeedContainer
    local tbl6 = {
        items = tbl1.ownedEmoteItems,
        selectedId = tbl1.selectedEmoteId,
        onSelect = tbl1.onSelectEmote,
        onDetailsActivated = var2.onOpenEmoteDetails,
        labels = labels,
        minTileSize = tbl1.tileSize,
        initialContainerWidth = tbl1.containerWidth,
        gap = var1.Gap.Medium,
        horizontalPadding = var1.Padding.XLarge,
        strokeInset = var1.Padding.XSmall,
        onMoreItems = tbl1.onMoreEmotes,
        hasMoreItems = tbl1.hasMoreEmotes,
        isLoadingMore = tbl1.isLoadingMoreEmotes,
        hasLoadMoreError = tbl1.hasLoadMoreEmotesError,
        onRetryLoadMore = tbl1.onMoreEmotes,
        listHeaderComponent = 0,
        listFooterComponent = 0
    }

    if var5 then
        element = nil
    end

    tbl6.listHeaderComponent = element
    tbl6.listFooterComponent = element2
    tbl5.Feed = createElement3(var8, tbl6)
    tbl3.FeedContainer = createElement2(var7, tbl4, tbl5)
    return createElement(var6, tbl2, tbl3)
end

return ExpandedEmotesGridContent
