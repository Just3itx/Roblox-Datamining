-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent
local React = require(AvatarExperienceProfilePictureEditorParent.React)
local RoactNavigation = require(AvatarExperienceProfilePictureEditorParent.RoactNavigation)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)
local View = Foundation.View
local ScrollView = Foundation.ScrollView
local Visibility = Foundation.Enums.Visibility
local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens
local useLocalization = require(AvatarExperienceProfilePictureEditorParent.Localization).Hooks.useLocalization
local FocusNavigatorWrapper = require(script.Parent.FocusNavigatorWrapper)
local CombinedCarouselsContent = require(script.Parent.CombinedCarouselsContent)
local ExpandedEmotesGridContent = require(script.Parent.ExpandedEmotesGridContent)
local AssetGridScrollSection = require(script.Parent.AssetGridScrollSection)
local EditProfileImageFooter = require(script.Parent.EditProfileImageFooter)
local EditProfileImageActionsContext = require(AvatarExperienceProfilePictureEditor.Context.EditProfileImageActionsContext)
local useGuiInset = require(AvatarExperienceProfilePictureEditor.Hooks.useGuiInset).useGuiInset

local useEditProfileImageLayout = require(AvatarExperienceProfilePictureEditor.Hooks.useEditProfileImageLayout).useEditProfileImageLayout
local useEditProfileImageViewModel = require(AvatarExperienceProfilePictureEditor.Hooks.useEditProfileImageViewModel)
local FramesPlusUpsellBar = require(script.Parent.FramesPlusUpsellBar)
local RobloxPlusUpsellBanner = require(AvatarExperienceProfilePictureEditorParent.RobloxSubscriptionPurchaseApp).Components.RobloxPlusUpsellBanner
local FFlagProfileFramesUpsellFreeTrial = require(AvatarExperienceProfilePictureEditor.Flags.FFlagProfileFramesUpsellFreeTrial)
local RotatableAvatarPreview = require(script.Parent.RotatableAvatarPreview)
local Enums = require(AvatarExperienceProfilePictureEditor.Common.Enums)
local Constants = require(AvatarExperienceProfilePictureEditor.Constants)
local TextKeys = require(AvatarExperienceProfilePictureEditor.Common.TextKeys)
local SharedFlags = require(AvatarExperienceProfilePictureEditorParent.SharedFlags)
local FFlagAXEnableProfileTab = SharedFlags.FFlagAXEnableProfileTab
local FFlagSplitPaneProfileEditFillPane = SharedFlags.FFlagSplitPaneProfileEditFillPane
local FFlagEditProfileImageR15UpgradePrompt = SharedFlags.FFlagEditProfileImageR15UpgradePrompt
local EditProfileImageAnalytics = require(AvatarExperienceProfilePictureEditor.Analytics.EditProfileImageAnalytics)

local function renderFramesPlusUpsellBanner(arg1)
    return React.createElement(
        FramesPlusUpsellBar,
        {
            layoutOrder = arg1.LayoutOrder,
            actionText = arg1.actionText,
            onSubscribeActivated = arg1.onActivated
        }
    )
end

local function createSplitLayout(tbl1, yOffset: number)
    local options = React.createElement(View, { tag = "col grow size-full-0", LayoutOrder = 2 }, { [tbl1.activeView] = tbl1.options })

    return {
        Preview = React.createElement(View, {
            tag = "align-x-center position-top-right anchor-top-right",
            Size = UDim2.new(1 - Constants.SplitControlsPaneWidthScale, 0, 0, yOffset),
            ZIndex = 0
        }, {
            AvatarPreview = tbl1.avatarPreview
        }),
        LeftPane = React.createElement(View, {
            tag = "col size-full-full bg-surface-0",
            Size = UDim2.fromScale(Constants.SplitControlsPaneWidthScale, 1),
            LayoutOrder = 1,
            ZIndex = 1
        }, {
            Header = tbl1.header,
            Options = options,
            Footer = tbl1.footer
        }),
        CloseButton = if tbl1.header then nil else tbl1.closeButton
    }
end

local function createStackedLayout(tbl1, xOffset: number, yOffset: number)
    local tbl2 = { StackedContent = 0, CloseButton = 0 }
    local createElement = React.createElement
    local var1 = View
    local tbl3 = { tag = "col size-full-full" }

    local tbl4 = {
        TitleHeader = tbl1.header,
        Preview = React.createElement(View, {
            tag = "col gap-medium size-full-0 auto-y",
            LayoutOrder = 2
        }, {
            ProfilePhotoRow = React.createElement(View, {
                tag = "align-x-center size-full-0 auto-y",
                LayoutOrder = 1
            }, {
                PreviewClipHost = React.createElement(
                    "Frame",
                    {
                        Size = UDim2.fromOffset(xOffset, yOffset),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        ClipsDescendants = true
                    },
                    {
                        AvatarPreview = tbl1.avatarPreview
                    }
                )
            })
        }),
        ScrollBody = 0,
        Footer = 0
    }
    local element

    if tbl1.activeView == "emotes" then
        element = React.createElement(
            View,
            { testId = "virtualized-emotes-body", tag = "col grow size-full-0", LayoutOrder = 3 },
            {
                Emotes = tbl1.options
            }
        )
    else
        local createElement2 = React.createElement
        local var2 = ScrollView
        local tbl5 = {
            testId = "portrait-scroll-body",
            tag = "grow size-full-0",
            LayoutOrder = 3,
            selection = { Selectable = false },
            scroll = {
                ScrollingDirection = Enum.ScrollingDirection.Y,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.fromScale(0, 0),
                scrollBarVisibility = Visibility.Auto
            }
        }
        local tbl6 = {
            Content = React.createElement(View, { tag = "col size-full-0 auto-y" }, { [tbl1.activeView] = tbl1.options })
        }
        element = createElement2(var2, tbl5, tbl6)
    end

    tbl4.ScrollBody = element

    tbl4.Footer = tbl1.footer
    tbl2.StackedContent = createElement(var1, tbl3, tbl4)

    tbl2.CloseButton = tbl1.closeButton
    return tbl2
end

local function EditProfileImageBody(tbl1)
    local var1 = useTokens()
    local guiInset = useGuiInset()
    local tbl2 = {
        editProfilePicture = TextKeys.EditProfilePicture
    }
    if FFlagProfileFramesUpsellFreeTrial then
        tbl2.profileFramesUnlockBanner = TextKeys.ProfileFramesUnlockBanner
        tbl2.subscribe = TextKeys.Subscribe
        tbl2.tryItForFree = TextKeys.TryItForFree
    end
    local var3 = useLocalization(tbl2)
    local bool1 = tbl1.showCloseButton ~= false

    local var4 = useEditProfileImageLayout(
        {
            guiInset = guiInset,
            containerSize = if FFlagSplitPaneProfileEditFillPane then tbl1.containerSize else nil
        }
    )
    local cutoutFieldOfViewDeg = var4.cutoutFieldOfViewDeg

    local var5 = useEditProfileImageViewModel({
        mode = tbl1.mode,
        initialFrameAssetId = tbl1.initialFrameAssetId,
        initialFrameSelectionRequestId = tbl1.initialFrameSelectionRequestId,
        onClose = tbl1.onClose,
        onSaveSuccess = tbl1.onSaveSuccess,
        cutoutFieldOfViewDeg = cutoutFieldOfViewDeg
    })
    local navigation = var5.navigation
    local emotes = var5.emotes
    local frames = var5.frames
    local preview = var5.preview
    local footer = var5.footer

    local activeView = navigation.activeView
    local onSelect = emotes.onSelect
    if FFlagEditProfileImageR15UpgradePrompt then
        local accountRigType = tbl1.accountRigType
        onSelect = React.useCallback(function(selectedEmoteId: string)
            local onPromptR15Upgrade = tbl1.onPromptR15Upgrade

            if accountRigType == Enum.HumanoidRigType.R6 and selectedEmoteId ~= emotes.selectedEmoteId and onPromptR15Upgrade then
                onPromptR15Upgrade(function()
                    emotes.onSelect(selectedEmoteId)
                end)
                return
            end
            emotes.onSelect(selectedEmoteId)
        end, {
            accountRigType,
            emotes.selectedEmoteId,
            emotes.onSelect,
            tbl1.onPromptR15Upgrade
        })
    end

    React.useEffect(function()
        EditProfileImageAnalytics.logPageView({ mode = tbl1.mode })
    end, { tbl1.mode })

    local onActivated = React.useCallback(function()
        EditProfileImageAnalytics.logClose({ mode = tbl1.mode, activeView = activeView })

        navigation.onLeaveScreen()
    end, { tbl1.mode, activeView, navigation.onLeaveScreen })

    local bool2 = tbl1.mode == Enums.EditProfileImageMode.FramesOnly

    local element = if frames.shouldShowUpsell then if FFlagProfileFramesUpsellFreeTrial then React.createElement(
        RobloxPlusUpsellBanner,
        {
            message = var3.profileFramesUnlockBanner,
            subscribeText = var3.subscribe,
            freeTrialText = var3.tryItForFree,
            onActivated = function()
                frames.onOpenSubscriptionUpsell("banner")
            end,
            showPlusIcon = true,
            testId = "FramesPlusUpsellBar",
            renderBanner = renderFramesPlusUpsellBanner
        }
    ) else React.createElement(FramesPlusUpsellBar, {
        onSubscribeActivated = function()
            frames.onOpenSubscriptionUpsell("banner")
        end
    }) else nil

    local cutoutTopOffset = var4.cutoutTopOffset
    local cutoutSize = var4.cutoutSize
    local previewHeight = var4.previewHeight
    local visiblePreviewHeight = var4.visiblePreviewHeight
    local previewWidth = var4.previewWidth
    local useInternalScroll = var4.mode == "split"
    local safeWidth = if useInternalScroll then math.floor(var4.safeWidth * Constants.SplitControlsPaneWidthScale + 0.5) else var4.safeWidth
    local closeButtonTopOffset = var4.closeButtonTopOffset
    local onTitleBack = if bool2 then if useInternalScroll then onActivated else nil else navigation.onTitleBack
    local element2

    if activeView == "frames" then
        if frames.show then
            element2 = React.createElement(AssetGridScrollSection, {
                title = frames.localizedTitle,
                titleLeadingIconName = IconName.RobloxPlus,
                onTitleBack = onTitleBack,
                layoutOrder = 3,
                useInternalScroll = useInternalScroll,
                gridProps = {
                    items = frames.items,
                    isLoading = frames.isLoading,
                    hasError = frames.hasError,
                    onRetry = frames.onRetry,
                    bannerComponent = element,
                    selectedId = frames.selectedFrameId,
                    onSelect = frames.onSelect,
                    tileSize = 96,
                    containerWidth = safeWidth
                }
            })
        else
            element2 = React.createElement(View, { tag = "size-full-0", LayoutOrder = 3 })
        end
    elseif activeView == "emotes" then
        element2 = React.createElement(ExpandedEmotesGridContent, {
            layoutOrder = 3,
            tileSize = 96,
            containerWidth = safeWidth,
            onTitleBack = onTitleBack,
            useInternalScroll = useInternalScroll,
            ownedEmoteItems = emotes.ownedItems,
            recommendedEmoteItems = emotes.recommendedItems,
            emotesLoading = emotes.isLoading,
            emotesError = emotes.hasError,
            hasMoreEmotes = emotes.hasMore,
            isLoadingMoreEmotes = emotes.isLoadingMore,
            hasLoadMoreEmotesError = emotes.hasLoadMoreError,
            onMoreEmotes = emotes.onMore,
            onRetryEmotes = emotes.onRetry,
            selectedEmoteId = emotes.selectedEmoteId,
            onSelectEmote = onSelect
        })
    else
        element2 = React.createElement(CombinedCarouselsContent, {
            layoutOrder = 3,
            tileSize = 96,
            showFrames = frames.show,
            useInternalScroll = useInternalScroll,
            emoteItems = emotes.items,
            emotesLoading = emotes.isLoading,
            emotesError = emotes.hasError,
            onRetryEmotes = emotes.onRetry,
            selectedEmoteId = emotes.selectedEmoteId,
            onSelectEmote = onSelect,
            onExpandEmotes = navigation.onExpandEmotes,
            frameItems = frames.items,
            framesLoading = frames.isLoading,
            framesError = frames.hasError,
            onRetryFrames = frames.onRetry,
            selectedFrameId = frames.selectedFrameId,
            onSelectFrame = frames.onSelect,
            onExpandFrames = navigation.onExpandFrames,
            framesBannerComponent = element
        })
    end

    local element3 = React.createElement(EditProfileImageFooter, {
        footerCta = footer.cta,
        isSaving = footer.isSaving,
        localizedSubscribeLabel = footer.subscribeLabel,
        localizedSaveLabel = footer.saveLabel,
        selectedEmoteId = emotes.selectedEmoteId,
        layoutOrder = 4,
        onSave = footer.onSave,
        onOpenProfileFramesSubscriptionUpsell = frames.onOpenSubscriptionUpsell,
        renderRecommendedEmotePurchaseFooter = tbl1.renderRecommendedEmotePurchaseFooter
    })

    local avatarPreview = React.createElement(RotatableAvatarPreview, {
        userId = preview.localUserId or "",
        width = previewWidth,
        height = previewHeight,
        fillContainer = false,
        cutoutSize = cutoutSize,
        cutoutTopOffset = cutoutTopOffset,
        isCameraControlBarDisabled = not useInternalScroll,
        fieldOfViewDeg = Constants.CameraFieldOfViewDeg,
        fieldOfViewForDistanceScaleDeg = cutoutFieldOfViewDeg,
        distanceScale = preview.distanceScale,
        committedYRotDeg = preview.yRotDeg,
        emoteAssetId = emotes.selectedEmoteId,
        rigTypeOverride = if FFlagEditProfileImageR15UpgradePrompt then tbl1.accountRigType else nil,
        frameImage = frames.selectedImage,
        onYRotDegChanged = preview.onYRotDegChanged,
        onDistanceScaleChanged = preview.onDistanceScaleChanged
    })

    local bool4 = not (bool2 or navigation.onTitleBack)
    local bool5 = bool1 and not useInternalScroll and (bool4 or bool2)

    local button = React.createElement(IconButton, {
        icon = if bool2 then IconName.ChevronLargeLeft else IconName.X,
        size = IconSize.Medium,
        variant = ButtonVariant.Utility,
        isCircular = true,
        onActivated = onActivated
    })
    local element6

    if bool5 then
        element6 = React.createElement(View, {
            tag = "position-top-left auto-xy",
            Position = if useInternalScroll then UDim2.fromScale(Constants.SplitControlsPaneWidthScale, 0) else nil,
            ref = navigation.closeButtonRef,
            padding = {
                top = UDim.new(0, closeButtonTopOffset),
                left = UDim.new(0, var1.Padding.XLarge)
            },
            ZIndex = 10
        }, { Button = button })
    else
        element6 = nil
    end

    local headerBar = Foundation.HeaderBar
    local element7

    if useInternalScroll and bool4 and bool1 then
        element7 = React.createElement(
            View,
            {
                tag = "size-full-0 auto-y",
                LayoutOrder = 1,
                ref = navigation.closeButtonRef
            },
            {
                Bar = React.createElement(headerBar.Root, nil, {
                    Leading = React.createElement(headerBar.Leading, nil, {
                        Actions = React.createElement(headerBar.Actions, { actions = {{ id = "close", icon = IconName.X, onActivated = onActivated }} }),
                        Title = React.createElement(
                            FoundationText,
                            {
                                Text = var3.editProfilePicture,
                                tag = "auto-xy text-heading-small content-emphasis"
                            }
                        )
                    })
                })
            }
        )
    else
        element7 = nil
    end

    local tbl3 = {
        activeView = activeView,
        avatarPreview = avatarPreview,
        closeButton = element6,
        header = element7,
        footer = element3,
        options = element2
    }
    local var8 = if useInternalScroll then createSplitLayout(tbl3, previewHeight) else createStackedLayout(tbl3, previewWidth, visiblePreviewHeight)
    return React.createElement(FocusNavigatorWrapper, {
        onClose = navigation.onBack
    }, {
        NavigationEvents = React.createElement(RoactNavigation.NavigationEvents, { onDidFocus = navigation.onDidFocus }),
        Root = React.createElement(View, {
            tag = FFlagAXEnableProfileTab and {
                ["bg-surface-0"] = not useInternalScroll,
                ["size-full-full"] = true
            }
                or (if useInternalScroll then "size-full-full" else "size-full-full bg-surface-0")
        }, var8)
    })
end

local function EditProfileImage(tbl1)
    local value = React.useMemo(function()
        return {
            onOpenEmoteDetails = tbl1.onOpenEmoteDetails,
            onPrepareRecommendedEmotePurchase = tbl1.onPrepareRecommendedEmotePurchase,
            onShopForMoreEmotes = tbl1.onShopForMoreEmotes
        }
    end, { tbl1.onOpenEmoteDetails, tbl1.onPrepareRecommendedEmotePurchase, tbl1.onShopForMoreEmotes })

    return React.createElement(
        EditProfileImageActionsContext.Provider,
        { value = value },
        React.createElement(EditProfileImageBody, {
            mode = tbl1.mode,
            initialFrameAssetId = tbl1.initialFrameAssetId,
            initialFrameSelectionRequestId = tbl1.initialFrameSelectionRequestId,
            showCloseButton = tbl1.showCloseButton,
            onClose = tbl1.onClose,
            onSaveSuccess = tbl1.onSaveSuccess,
            onPromptR15Upgrade = tbl1.onPromptR15Upgrade,
            accountRigType = tbl1.accountRigType,
            renderRecommendedEmotePurchaseFooter = tbl1.renderRecommendedEmotePurchaseFooter,
            containerSize = if FFlagSplitPaneProfileEditFillPane then tbl1.containerSize else nil
        })
    )
end

return EditProfileImage
