-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent

local IconWithTooltip = require(script.IconWithTooltip)
local InfoPeekView = require(script.InfoPeekView)
local CheckboxFeedbackFormModal = require(script.CheckboxFeedbackFormModal)
local CloseOnlyInteractiveAlert = require(script.CloseOnlyInteractiveAlert)
local ConfirmationDialog = require(script.ConfirmationDialog)
local FullscreenFrame = require(script.FullscreenFrame)
local FullscreenPageWithSafeArea = require(script.FullscreenPageWithSafeArea)
local ImagePile = require(script.ImagePile)
local InfoCarousel = require(script.InfoCarousel)
local InfoCarouselCell = require(script.InfoCarouselCell)
local InsetBackground = require(script.InsetBackground)
local Banner = require(script.Banner)
local BannerBadge = require(script.Banner.BannerBadge)
local ScrollingAppCarousel = require(script.ScrollingAppCarousel.ScrollingAppCarousel)
local InfoTable = require(script.InfoTable)
local InfoTableCell = require(script.InfoTableCell)
local ExpandableText = require(script.ExpandableText)
local AnimateScrollViewToSelectionHelper = require(script.AnimateScrollViewToSelectionHelper)
local Composer = require(script.Composer)

local SharedFlags = require(scriptParent.SharedFlags)
local FFlagUseAnimateScrollViewToSelectionHelper = SharedFlags.FFlagUseAnimateScrollViewToSelectionHelper
local FFlagLuaAppTextFeedbackFormModal = SharedFlags.FFlagLuaAppTextFeedbackFormModal

local _MediaGalleryTypes = require(script.MediaGallery.MediaGalleryTypes)

local tbl1 = {
    CloseOnlyInteractiveAlert = CloseOnlyInteractiveAlert,
    Composer = Composer,
    ConfirmationDialog = ConfirmationDialog,
    LoadingBar = require(script.LoadingBar),
    InlinePrompt = require(script.InlinePrompt),
    FullscreenFrame = FullscreenFrame,
    FullscreenPageWithSafeArea = FullscreenPageWithSafeArea,
    IconWithTooltip = IconWithTooltip,
    ImagePile = ImagePile,
    InfoPeekView = InfoPeekView,
    InfoCarousel = InfoCarousel,
    InfoCarouselCell = InfoCarouselCell,
    InsetBackground = InsetBackground,
    Banner = Banner,
    BannerBadge = BannerBadge
}

if not FFlagUseAnimateScrollViewToSelectionHelper then
    AnimateScrollViewToSelectionHelper = nil
end

tbl1.AnimateScrollViewToSelectionHelper = AnimateScrollViewToSelectionHelper

tbl1.ContentPosition = require(script.DetailsPage.ContentPosition)
tbl1.DetailsPageLayout = require(script.DetailsPageLayout)
tbl1.DetailsPageSelector = require(script.DetailsPage.DetailsPageSelector)
tbl1.DetailsPageTemplate = require(script.DetailsPage.DetailsPageTemplate)
tbl1.InfoTable = InfoTable
tbl1.InfoTableCell = InfoTableCell
tbl1.ScrollingAppCarousel = ScrollingAppCarousel

tbl1.CrossFadeAnimatedView = require(script.MediaGallery.CrossFadeAnimatedView)
tbl1.MediaGalleryCarousel = require(script.MediaGallery.MediaGalleryCarousel)
tbl1.MediaGalleryExpandableView = require(script.MediaGallery.MediaGalleryExpandableView)
tbl1.MediaGalleryFullScreen = require(script.MediaGallery.MediaGalleryFullScreen)
tbl1.MediaGalleryPreview = require(script.MediaGallery.MediaGalleryPreview)
tbl1.calcMediaGallerySizesFromWidth = require(script.MediaGallery.calcMediaGallerySizesFromWidth)
tbl1.useAnimateScrollViewToSelection = require(script.useAnimateScrollViewToSelection)
tbl1.ExpandableText = ExpandableText
tbl1.CheckboxFeedbackFormModal = CheckboxFeedbackFormModal
tbl1.TextFeedbackFormModal = if FFlagLuaAppTextFeedbackFormModal then require(script.TextFeedbackFormModal) else nil

tbl1.ProvideFeedbackToast = require(script.ProvideFeedbackToast)
tbl1.SnackbarWrapper = require(script.SnackbarWrapper)
tbl1.EmptyTile = require(script.EmptyTile)
tbl1.useCloseWithBackButton = require(script.DetailsPage.Hooks.useCloseWithBackButton)
tbl1.OverflowMenu = require(script.OverflowMenu.OverflowMenu)
tbl1.getOverflowMenuSignalStore = require(script.OverflowMenu.getOverflowMenuSignalStore)
tbl1.useOverflowMenuOpen = require(script.OverflowMenu.useOverflowMenuOpen)
tbl1["jest.config"] = script["jest.config"]
return tbl1
