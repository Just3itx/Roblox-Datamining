-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local Cryo = require(ServerDrivenUiParent.Cryo)
local React = require(ServerDrivenUiParent.React)
local Foundation = require(ServerDrivenUiParent.Foundation)
local t = require(ServerDrivenUiParent.t)
local CollectionItemSize = require(ServerDrivenUiParent.CollectionViews).CollectionViewTypes.CollectionItemSize
local ItemHeightMode = require(ServerDrivenUi.Content.Collections.ItemHeightMode)

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiComponentType = SduiCoreSystem.SduiComponentType
local SduiParsers = SduiCoreSystem.SduiParsers
local getSduiComponentRegistry = SduiCoreSystem.getSduiComponentRegistry

local FFlagLuaAppRespectClipAncestorImpressions = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppRespectClipAncestorImpressions

local parseCallbackProp_ = SduiParsers.parseCallbackProp_
local parseUiComponentProp_ = SduiParsers.parseUiComponentProp_
local parseLazyUiComponentProp_ = SduiParsers.parseLazyUiComponentProp_
local parseIntegerProp_ = SduiParsers.parseIntegerProp_
local parseNumberProp_ = SduiParsers.parseNumberProp_
local parseUDim2Prop_ = SduiParsers.parseUDim2Prop_
local parseUDimProp_ = SduiParsers.parseUDimProp_
local parseImageStringProp_ = SduiParsers.parseImageStringProp_
local parseVector2Prop_ = SduiParsers.parseVector2Prop_
local parseColor3Prop_ = SduiParsers.parseColor3Prop_
local parseBooleanProp_ = SduiParsers.parseBooleanProp_
local parseGradientProp_ = SduiParsers.parseGradientProp_
local parseIconProp_ = SduiParsers.parseIconProp_
local parseTypographyTokenProp_ = SduiParsers.parseTypographyTokenProp_
local parseColorTokenProp_ = SduiParsers.parseColorTokenProp_
local parseImageSetOrImageProp_ = SduiParsers.parseImageSetOrImageProp_
local parseStringProp_ = SduiParsers.parseStringProp_
local parseFocusNavActionsProp_ = SduiParsers.parseFocusNavActionsProp_

local getArrayMetatableParser = SduiParsers.getArrayMetatableParser
local getEngineEnumParser = SduiParsers.getEngineEnumParser
local getLuaTableEnumParser = SduiParsers.getLuaTableEnumParser
local FFlagSduiTileDisableLegacyHover = require(ServerDrivenUi.Flags).FFlagSduiTileDisableLegacyHover
local FFlagSduiEnableHeroUnitBottomRow = require(ServerDrivenUi.Flags).FFlagSduiEnableHeroUnitBottomRow
local FFlagSduiExperienceDetailsSocialProof = require(ServerDrivenUiParent.SharedFlags).FFlagSduiExperienceDetailsSocialProof
local FFlagSduiChipAccessoryProps = require(ServerDrivenUiParent.SharedFlags).FFlagSduiChipAccessoryProps
local FFlagLuaAppDismissUnlockUpsell = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppDismissUnlockUpsell
local FFlagLuaAppSduiGameTileFeedback = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiGameTileFeedback
local FFlagSduiGameTileDirectAction = require(ServerDrivenUiParent.SharedFlags).FFlagSduiGameTileDirectAction
local FFlagSduiOptionSelectorCollection = require(ServerDrivenUiParent.SharedFlags).FFlagSduiOptionSelectorCollection

local FFlagSduiCollectionCarouselPlaceholderItem = require(ServerDrivenUiParent.SharedFlags).FFlagSduiCollectionCarouselPlaceholderItem
local FFlagSduiCollectionGridRevealRows = require(ServerDrivenUiParent.SharedFlags).FFlagSduiCollectionGridRevealRows
local FFlagSduiIndividualFeedItemSpacing = require(ServerDrivenUiParent.SharedFlags).FFlagSduiIndividualFeedItemSpacing

local FFlagLuaAppSduiSearchAutocompleteSuggestionComponent = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiSearchAutocompleteSuggestionComponent
local FFlagLuaAppHeroUnitSecondaryLabelText = require(ServerDrivenUi.FFlagLuaAppHeroUnitSecondaryLabelText)

local tbl1 = {}

local module = {}
module.__index = module

function module.new()
    local iconOverrides = {
        anchorPoint = parseVector2Prop_,
        automaticSize = getEngineEnumParser(Enum.AutomaticSize),
        backgroundColor3 = parseColor3Prop_,
        backgroundTransparency = parseNumberProp_,
        layoutOrder = parseIntegerProp_,
        position = parseUDim2Prop_,
        size = parseUDim2Prop_,
        zIndex = parseNumberProp_
    }

    local textOverrides = Cryo.Dictionary.union({
        richText = parseBooleanProp_,
        text = parseStringProp_,
        textTruncate = getEngineEnumParser(Enum.TextTruncate),
        textWrapped = parseBooleanProp_,
        textXAlignment = getEngineEnumParser(Enum.TextXAlignment),
        textYAlignment = getEngineEnumParser(Enum.TextYAlignment)
    }, iconOverrides)

    local layoutOverrides = {
        columnGap = parseNumberProp_,
        sideMargin = parseNumberProp_,
        numColumns = parseNumberProp_,
        fractionalItemAmount = parseNumberProp_,
        loadMoreThreshold = parseNumberProp_,
        verticalGap = parseNumberProp_
    }

    local tbl4 = {
        _registeredComponents = {
            [SduiComponentType.AttributionRow] = {
                component = require(ServerDrivenUiParent.SduiSharedContent).SduiAttributionRow,
                propParsers = {
                    layoutOrder = parseIntegerProp_,
                    position = parseUDim2Prop_,
                    size = parseUDim2Prop_,
                    onActivated = parseCallbackProp_,
                    rightButtonContent = parseUiComponentProp_,
                    title = parseStringProp_,
                    titleFontStyle = parseTypographyTokenProp_,
                    titleTextColor = parseColorTokenProp_,
                    subtitle = parseStringProp_,
                    subtitleFontStyle = parseTypographyTokenProp_,
                    subtitleTextColor = parseColor3Prop_,
                    subtitleIconName = getLuaTableEnumParser(Foundation.Enums.IconName, "string"),
                    subtitleIconSize = getLuaTableEnumParser(Foundation.Enums.IconSize, "string"),
                    subtitleIconStyle = parseColorTokenProp_,
                    subtitleIconVariant = getLuaTableEnumParser(Foundation.Enums.IconVariant, "string"),
                    subtitleBackgroundIconName = getLuaTableEnumParser(Foundation.Enums.IconName, "string"),
                    subtitleBackgroundIconStyle = parseColorTokenProp_,
                    subtitleOnActivated = parseCallbackProp_,
                    caption = parseStringProp_,
                    captionTextColor = parseColorTokenProp_,
                    captionFontStyle = parseTypographyTokenProp_,
                    textContainerSize = parseUDim2Prop_,
                    image = parseImageStringProp_,
                    imageSize = parseUDim2Prop_
                },
                propInterface = {
                    title = t.string,
                    subtitle = t.string
                }
            },
            [SduiComponentType.Button] = {
                component = require(ServerDrivenUiParent.SduiSharedContent).SduiButton,
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    cursorType = getLuaTableEnumParser(Foundation.Enums.CursorType, "string"),
                    fillBehavior = getLuaTableEnumParser(Foundation.Enums.FillBehavior, "string"),
                    icon = parseIconProp_,
                    inputDelay = parseNumberProp_,
                    isDisabled = parseBooleanProp_,
                    isLoading = parseBooleanProp_,
                    layoutOrder = parseIntegerProp_,
                    onActivated = parseCallbackProp_,
                    position = parseUDim2Prop_,
                    selectable = parseBooleanProp_,
                    size = getLuaTableEnumParser(Foundation.Enums.InputSize, "string"),
                    tag = parseStringProp_,
                    testId = parseStringProp_,
                    text = parseStringProp_,
                    variant = getLuaTableEnumParser(Foundation.Enums.ButtonVariant, "string"),
                    visible = parseBooleanProp_,
                    width = parseUDimProp_,
                    zIndex = parseNumberProp_
                }
            },
            [SduiComponentType.CollectionCarousel] = {
                component = require(ServerDrivenUi.Content.Collections.SduiCollectionCarousel),
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    position = parseUDim2Prop_,
                    size = parseUDim2Prop_,
                    collectionItemSize = getLuaTableEnumParser(CollectionItemSize, "string"),
                    itemHeightFromWidth = parseUDimProp_,
                    headerComponent = parseUiComponentProp_,
                    itemHeightMode = getLuaTableEnumParser(ItemHeightMode, "string"),
                    layoutOverrides = layoutOverrides,
                    numColumnsOverride = parseNumberProp_,
                    scrollingEnabledOverride = parseBooleanProp_,
                    maxItemsToShow = parseNumberProp_,
                    shouldUseFrameBoundsForImpressions = parseBooleanProp_,
                    respectClipAncestors = if FFlagLuaAppRespectClipAncestorImpressions then parseBooleanProp_ else nil,
                    backgroundMuralUrl = parseImageStringProp_,
                    onScrollToEnd = parseCallbackProp_,
                    scrollThresholdFromEnd = parseNumberProp_,
                    itemTemplateKey = parseStringProp_,
                    focusNavActionsComponent = parseUiComponentProp_,
                    disableSelectionOrder = parseBooleanProp_,
                    numItemsToRenderOffScreen = parseNumberProp_,
                    items = getArrayMetatableParser(parseLazyUiComponentProp_),
                    impressionEventName = parseStringProp_,
                    skipItemImpressionsLog = parseBooleanProp_,
                    enableHoverOverflow = parseBooleanProp_
                }
            },
            [SduiComponentType.VariableItemWidthCarousel] = {
                component = require(ServerDrivenUi.Content.Collections.SduiVariableItemWidthCarousel)
            },
            [SduiComponentType.CollectionCarouselPlaceholder] = {
                component = require(ServerDrivenUi.Content.Collections.SduiCollectionCarouselPlaceholder)
            },
            [SduiComponentType.PlaceholderTile] = FFlagSduiCollectionCarouselPlaceholderItem
                and {
                    component = require(ServerDrivenUiParent.SduiSharedContent).SduiPlaceholderTile
                }
                or nil,
            [SduiComponentType.OptionSelectorCollection] = FFlagSduiOptionSelectorCollection
                and {
                    component = require(ServerDrivenUi.Content.Collections.SduiOptionSelectorCollection)
                }
                or nil,
            [SduiComponentType.CollectionGrid] = {
                component = require(ServerDrivenUi.Content.Collections.SduiCollectionGrid),
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    position = parseUDim2Prop_,
                    size = parseUDim2Prop_,
                    bufferRowsBelowScreen = parseNumberProp_,
                    bufferRowsAboveScreen = parseNumberProp_,
                    collectionItemSize = getLuaTableEnumParser(CollectionItemSize, "string"),
                    disableRelativeGap = parseBooleanProp_,
                    focusNavActionsComponent = parseUiComponentProp_,
                    headerComponent = parseUiComponentProp_,
                    itemHeightFromWidth = parseUDimProp_,
                    itemTemplateKey = parseStringProp_,
                    layoutOverrides = layoutOverrides,
                    maxNumRows = parseNumberProp_,
                    shouldUseFrameBoundsForImpressions = parseBooleanProp_,
                    disableSelectionOrder = parseBooleanProp_,
                    items = getArrayMetatableParser(parseLazyUiComponentProp_),
                    thresholdRowsFromBottom = parseNumberProp_,
                    onReachedThresholdFromEnd = parseCallbackProp_,
                    impressionEventName = parseStringProp_,
                    skipItemImpressionsLog = parseBooleanProp_
                },
                propInterface = {
                    itemHeightFromWidth = t.UDim
                }
            },
            [SduiComponentType.RevealRowsButtonWithDivider] = FFlagSduiCollectionGridRevealRows
                and {
                    component = require(ServerDrivenUi.Content.Collections.SduiRevealRowsButtonWithDivider)
                }
                or nil,
            [SduiComponentType.Dialog] = {
                component = require(ServerDrivenUi.Content.SduiDialog),
                propParsers = {
                    size = getLuaTableEnumParser(Foundation.Enums.DialogSize, "string"),
                    image = parseStringProp_,
                    imageAspectRatio = parseNumberProp_,
                    titleText = parseStringProp_,
                    bodyText = parseStringProp_,
                    bodyComponent = parseUiComponentProp_,
                    actionsLabel = parseStringProp_,
                    actionsOrientation = getLuaTableEnumParser(Foundation.Enums.Orientation, "string"),
                    primaryButtonAction = parseCallbackProp_,
                    primaryButtonText = parseStringProp_,
                    primaryButtonIcon = parseIconProp_,
                    primaryButtonInputDelay = parseNumberProp_,
                    primaryButtonSideEffectAction = parseCallbackProp_,
                    secondaryButtonAction = parseCallbackProp_,
                    secondaryButtonText = parseStringProp_,
                    secondaryButtonIcon = parseIconProp_,
                    secondaryButtonInputDelay = parseNumberProp_,
                    secondaryButtonSideEffectAction = parseCallbackProp_,
                    onClose = parseCallbackProp_,
                    disablePortal = parseBooleanProp_,
                    hasBackdrop = parseBooleanProp_
                }
            },
            [SduiComponentType.Divider] = {
                component = require(ServerDrivenUi.Content.SduiDivider),
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    backgroundColor3 = parseColor3Prop_,
                    position = parseUDim2Prop_,
                    size = parseUDim2Prop_
                }
            },
            [SduiComponentType.FocusNavActions] = {
                component = require(ServerDrivenUi.FocusNavigation.SduiFocusNavActions),
                propParsers = { focusNavActions = parseFocusNavActionsProp_ },
                propInterface = {
                    focusNavActions = t.table
                }
            },
            [SduiComponentType.Fragment] = {
                component = React.Fragment
            },
            [SduiComponentType.GameTileActiveFriendsFooter] = {
                component = require(ServerDrivenUi.Content.SduiGameTileActiveFriendsFooter),
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    automaticSize = getEngineEnumParser(Enum.AutomaticSize),
                    backgroundColor3 = parseColor3Prop_,
                    layoutOrder = parseIntegerProp_,
                    position = parseUDim2Prop_,
                    size = parseUDim2Prop_,
                    zIndex = parseNumberProp_,
                    universeId = parseStringProp_,
                    iconWidth = parseNumberProp_,
                    maxAvatars = parseNumberProp_,
                    onActivated = parseCallbackProp_
                },
                propInterface = {
                    universeId = t.union(t.string, t.number)
                }
            },
            [SduiComponentType.HeroUnit] = {
                component = require(ServerDrivenUi.Content.SduiHeroUnit),
                propParsers = {
                    backgroundComponent = parseUiComponentProp_,
                    bottomRowComponent = parseUiComponentProp_,
                    ctaButtonComponent = parseUiComponentProp_,
                    gradient = parseGradientProp_,
                    headerComponent = parseUiComponentProp_,
                    onActivated = parseCallbackProp_,
                    overlayComponent = parseUiComponentProp_,
                    backgroundImage = parseImageStringProp_,
                    foregroundImage = parseImageStringProp_,
                    titleImage = parseImageStringProp_
                }
            },
            [SduiComponentType.HoldToPlay] = {
                component = require(ServerDrivenUi.FocusNavigation.SduiHoldToPlay),
                propParsers = { universeId = parseStringProp_, placeId = parseStringProp_ },
                propInterface = {
                    universeId = t.union(t.string, t.number)
                }
            },
            [SduiComponentType.Image] = {
                component = require(ServerDrivenUiParent.SduiSharedContent).SduiImage,
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    aspectRatio = parseNumberProp_,
                    automaticSize = getEngineEnumParser(Enum.AutomaticSize),
                    backgroundStyle = parseColorTokenProp_,
                    clipsDescendants = parseBooleanProp_,
                    cornerRadius = parseUDimProp_,
                    cursorType = getLuaTableEnumParser(Foundation.Enums.CursorType, "string"),
                    image = parseImageStringProp_,
                    imageStyle = parseColorTokenProp_,
                    layoutOrder = parseIntegerProp_,
                    onActivated = parseCallbackProp_,
                    position = parseUDim2Prop_,
                    resampleMode = getEngineEnumParser(Enum.ResamplerMode),
                    scaleType = getEngineEnumParser(Enum.ScaleType),
                    size = parseUDim2Prop_,
                    sizeConstraint = getEngineEnumParser(Enum.SizeConstraint),
                    tag = parseStringProp_,
                    tileSize = parseUDim2Prop_,
                    visible = parseBooleanProp_,
                    zIndex = parseNumberProp_
                }
            },
            [SduiComponentType.SingleItemCollection] = {
                component = require(ServerDrivenUi.Content.SduiSingleItemCollection),
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    automaticSize = getEngineEnumParser(Enum.AutomaticSize),
                    position = parseUDim2Prop_,
                    size = parseUDim2Prop_,
                    item = parseLazyUiComponentProp_,
                    impressionEventName = parseStringProp_,
                    skipItemImpressionsLog = parseBooleanProp_
                }
            },
            [SduiComponentType.PlayButton] = {
                component = require(ServerDrivenUiParent.SduiSharedContent).SduiPlayButton,
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    layoutOrder = parseIntegerProp_,
                    position = parseUDim2Prop_,
                    tag = parseStringProp_,
                    width = parseUDimProp_,
                    onActivatedEffect = parseCallbackProp_
                },
                propInterface = {
                    universeId = t.union(t.string, t.number)
                }
            },
            [SduiComponentType.SectionHeader] = {
                component = require(ServerDrivenUi.Content.SduiSectionHeader),
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    automaticSize = getEngineEnumParser(Enum.AutomaticSize),
                    layoutOrder = parseIntegerProp_,
                    position = parseUDim2Prop_,
                    size = parseUDim2Prop_,
                    zIndex = parseNumberProp_,
                    iconComponent = parseUiComponentProp_,
                    infoText = parseStringProp_,
                    onTitleActivated = parseCallbackProp_,
                    onSubtitleActivated = parseCallbackProp_,
                    onInfoIconActivated = parseCallbackProp_,
                    subtitleColor = parseColor3Prop_,
                    subtitleComponent = parseUiComponentProp_,
                    subtitleIcon = parseIconProp_,
                    subtitleIconWidth = parseNumberProp_,
                    subtitleFontStyle = parseTypographyTokenProp_,
                    subtitleGap = parseNumberProp_,
                    subtitleText = parseStringProp_,
                    titleColor = parseColor3Prop_,
                    titleComponent = parseUiComponentProp_,
                    titleGap = parseNumberProp_,
                    titleIcon = parseIconProp_,
                    titleIconWidth = parseNumberProp_,
                    titleFontStyle = parseTypographyTokenProp_,
                    titleText = parseStringProp_,
                    verticalGap = parseNumberProp_,
                    allowInteractionForDirectionalInput = parseBooleanProp_
                }
            },
            [SduiComponentType.SearchAutocompleteSuggestion] = FFlagLuaAppSduiSearchAutocompleteSuggestionComponent
                and {
                    component = require(ServerDrivenUi.Content.SduiSearchAutocompleteSuggestion),
                    propInterface = {
                        title = t.string,
                        isRich = t.optional(t.boolean)
                    }
                }
                or nil,
            [SduiComponentType.SeeAllTile] = {
                component = require(ServerDrivenUiParent.GameCollections).SeeAllTile,
                propParsers = {
                    layoutOrder = parseNumberProp_,
                    size = parseUDim2Prop_,
                    onActivated = parseCallbackProp_,
                    icon = parseIconProp_,
                    title = parseStringProp_
                }
            },
            [SduiComponentType.SlotOverlay] = {
                component = require(ServerDrivenUi.Content.SduiSlotOverlay),
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    automaticSize = getEngineEnumParser(Enum.AutomaticSize),
                    layoutOrder = parseIntegerProp_,
                    position = parseUDim2Prop_,
                    size = parseUDim2Prop_,
                    zIndex = parseNumberProp_,
                    topLeftSlot = parseUiComponentProp_,
                    topMiddleSlot = parseUiComponentProp_,
                    topRightSlot = parseUiComponentProp_,
                    centerLeftSlot = parseUiComponentProp_,
                    centerMiddleSlot = parseUiComponentProp_,
                    centerRightSlot = parseUiComponentProp_,
                    bottomLeftSlot = parseUiComponentProp_,
                    bottomMiddleSlot = parseUiComponentProp_,
                    bottomRightSlot = parseUiComponentProp_,
                    padding = parseNumberProp_
                }
            },
            [SduiComponentType.Text] = {
                component = require(ServerDrivenUiParent.SduiSharedContent).SduiText,
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    aspectRatio = parseNumberProp_,
                    automaticSize = getEngineEnumParser(Enum.AutomaticSize),
                    backgroundStyle = parseColorTokenProp_,
                    children = parseUiComponentProp_,
                    cornerRadius = parseUDimProp_,
                    cursorType = getLuaTableEnumParser(Foundation.Enums.CursorType, "string"),
                    fontStyle = parseTypographyTokenProp_,
                    isDisabled = parseBooleanProp_,
                    layoutOrder = parseIntegerProp_,
                    onActivated = parseCallbackProp_,
                    onSecondaryActivated = parseCallbackProp_,
                    padding = parseNumberProp_,
                    position = parseUDim2Prop_,
                    richText = parseBooleanProp_,
                    rotation = parseNumberProp_,
                    scale = parseNumberProp_,
                    selectable = parseBooleanProp_,
                    size = parseUDim2Prop_,
                    sizeConstraint = getEngineEnumParser(Enum.SizeConstraint),
                    tag = parseStringProp_,
                    testId = parseStringProp_,
                    text = parseStringProp_,
                    textStyle = parseColorTokenProp_,
                    textTruncate = getEngineEnumParser(Enum.TextTruncate),
                    textWrapped = parseBooleanProp_,
                    textXAlignment = getEngineEnumParser(Enum.TextXAlignment),
                    textYAlignment = getEngineEnumParser(Enum.TextYAlignment),
                    visible = parseBooleanProp_,
                    zIndex = parseNumberProp_
                }
            },
            [SduiComponentType.TextIconRow] = {
                component = require(ServerDrivenUi.Content.SduiTextIconRow),
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    automaticSize = getEngineEnumParser(Enum.AutomaticSize),
                    layoutOrder = parseIntegerProp_,
                    position = parseUDim2Prop_,
                    selectable = parseBooleanProp_,
                    size = parseUDim2Prop_,
                    zIndex = parseNumberProp_,
                    iconFirst = parseBooleanProp_,
                    onActivated = parseCallbackProp_,
                    text = parseStringProp_,
                    textColor = parseColor3Prop_,
                    fontStyle = parseTypographyTokenProp_,
                    gap = parseNumberProp_,
                    icon = parseIconProp_,
                    iconWidth = parseNumberProp_,
                    iconColor = parseColor3Prop_,
                    textOverrides = textOverrides,
                    iconOverrides = iconOverrides,
                    textFlexMode = getEngineEnumParser(Enum.UIFlexMode),
                    backgroundStyle = parseColorTokenProp_,
                    cornerRadius = parseUDimProp_
                }
            },
            [SduiComponentType.TextPill] = {
                component = require(ServerDrivenUi.Content.SduiTextPill),
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    backgroundColor3 = parseColor3Prop_,
                    position = parseUDim2Prop_,
                    size = parseUDim2Prop_,
                    textColor3 = parseColor3Prop_,
                    fontStyle = parseTypographyTokenProp_
                }
            },
            [SduiComponentType.Tile] = {
                component = require(ServerDrivenUi.Content.SduiTile),
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    automaticSize = getEngineEnumParser(Enum.AutomaticSize),
                    backgroundColor3 = parseColor3Prop_,
                    layoutOrder = parseNumberProp_,
                    position = parseUDim2Prop_,
                    selectionOrder = parseNumberProp_,
                    size = parseUDim2Prop_,
                    zIndex = parseNumberProp_,
                    backgroundImage = parseImageSetOrImageProp_,
                    backgroundImageComponent = parseUiComponentProp_,
                    backgroundStyle = parseColorTokenProp_,
                    containmentPadding = parseNumberProp_,
                    cornerRadius = parseNumberProp_,
                    ctaButtonComponent = parseUiComponentProp_,
                    footerComponent = parseUiComponentProp_,
                    image = parseImageStringProp_,
                    imageAspectRatio = parseNumberProp_,
                    imageComponent = parseUiComponentProp_,
                    isContained = parseBooleanProp_,
                    onActivated = parseCallbackProp_,
                    thumbnailBackgroundStyle = parseColorTokenProp_,
                    thumbnailOverlayComponent = parseUiComponentProp_,
                    titleComponent = parseUiComponentProp_,
                    titleFont = parseTypographyTokenProp_,
                    titleLines = parseIntegerProp_,
                    titleText = parseStringProp_,
                    enableLegacyHoverState = if FFlagSduiTileDisableLegacyHover then nil else parseBooleanProp_,
                    focusNavActionsComponent = parseUiComponentProp_,
                    bottomButtonComponent = parseUiComponentProp_,
                    bottomButtonGap = parseNumberProp_,
                    holdActionConfig = {
                        onHoldCompleted = parseCallbackProp_,
                        focusNavigationEventName = parseStringProp_,
                        keyCode = getEngineEnumParser(Enum.KeyCode)
                    }
                }
            },
            [SduiComponentType.TileFooter] = {
                component = require(ServerDrivenUi.Content.SduiTileFooter),
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    automaticSize = getEngineEnumParser(Enum.AutomaticSize),
                    layoutOrder = parseIntegerProp_,
                    position = parseUDim2Prop_,
                    selectable = parseBooleanProp_,
                    size = parseUDim2Prop_,
                    zIndex = parseNumberProp_,
                    sectionGap = parseNumberProp_,
                    textIconGap = parseNumberProp_,
                    fontStyle = parseTypographyTokenProp_,
                    iconColor = parseColor3Prop_,
                    iconWidth = parseNumberProp_,
                    leftIcon = parseIconProp_,
                    leftIconComponent = parseUiComponentProp_,
                    leftText = parseStringProp_,
                    leftTextFlexMode = getEngineEnumParser(Enum.UIFlexMode),
                    onActivated = parseCallbackProp_,
                    rightIcon = parseIconProp_,
                    rightIconComponent = parseUiComponentProp_,
                    rightText = parseStringProp_,
                    rightTextFlexMode = getEngineEnumParser(Enum.UIFlexMode),
                    textColor = parseColor3Prop_
                }
            },
            [SduiComponentType.View] = {
                component = require(ServerDrivenUiParent.SduiSharedContent).SduiView,
                propParsers = {
                    anchorPoint = parseVector2Prop_,
                    aspectRatio = parseNumberProp_,
                    automaticSize = getEngineEnumParser(Enum.AutomaticSize),
                    backgroundStyle = parseColorTokenProp_,
                    children = parseUiComponentProp_,
                    clipsDescendants = parseBooleanProp_,
                    cornerRadius = parseUDimProp_,
                    cursorType = getLuaTableEnumParser(Foundation.Enums.CursorType, "string"),
                    groupTransparency = parseNumberProp_,
                    isDisabled = parseBooleanProp_,
                    layoutOrder = parseIntegerProp_,
                    onActivated = parseCallbackProp_,
                    onSecondaryActivated = parseCallbackProp_,
                    padding = parseNumberProp_,
                    position = parseUDim2Prop_,
                    rotation = parseNumberProp_,
                    scale = parseNumberProp_,
                    selectable = parseBooleanProp_,
                    selectionGroup = parseBooleanProp_,
                    size = parseUDim2Prop_,
                    sizeConstraint = getEngineEnumParser(Enum.SizeConstraint),
                    tag = parseStringProp_,
                    testId = parseStringProp_,
                    visible = parseBooleanProp_,
                    zIndex = parseNumberProp_
                }
            }
        }
    }

    tbl4._registeredComponents[SduiComponentType.CountdownTextIconRow] = {
        component = require(ServerDrivenUi.Content.SduiCountdownTextIconRow),
        propParsers = Cryo.Dictionary.join(
            tbl4._registeredComponents[SduiComponentType.TextIconRow],
            {
                endTimestamp = parseNumberProp_,
                formatStringHoursMinutes = parseStringProp_,
                defaultString = parseStringProp_
            }
        )
    }
    local _registeredComponents = tbl4._registeredComponents
    local gameTile = SduiComponentType.GameTile
    local tbl5 = {
        component = require(ServerDrivenUi.Content.SduiGameTile),
        propParsers = Cryo.Dictionary.join(tbl4._registeredComponents[SduiComponentType.Tile].propParsers, {
            universeId = parseStringProp_,
            placeId = parseStringProp_,
            collectionId = if FFlagLuaAppSduiGameTileFeedback then parseStringProp_ else nil,
            hiddenStateComponent = if FFlagLuaAppSduiGameTileFeedback then parseLazyUiComponentProp_ else nil,
            overflowMenuComponent = if FFlagLuaAppSduiGameTileFeedback then parseLazyUiComponentProp_ else nil,
            directActionComponent = if FFlagSduiGameTileDirectAction then parseLazyUiComponentProp_ else nil,
            disableHoldToPlay = parseBooleanProp_,
            ratingText = parseStringProp_,
            playerCount = parseNumberProp_
        }),
        propInterface = {
            universeId = t.union(t.string, t.number),
            placeId = t.union(t.string, t.number)
        }
    }
    _registeredComponents[gameTile] = tbl5

    if FFlagLuaAppSduiGameTileFeedback then
        tbl4._registeredComponents[SduiComponentType.GameTileHiddenState] = {
            component = require(ServerDrivenUi.Content.SduiGameTileHiddenState)
        }
    end

    if FFlagSduiEnableHeroUnitBottomRow then
        local _registeredComponents2 = tbl4._registeredComponents
        local heroUnitBottomRow = SduiComponentType.HeroUnitBottomRow
        _registeredComponents2[heroUnitBottomRow] = {
            component = require(ServerDrivenUi.Content.SduiHeroUnitBottomRow),
            propParsers = {
                layoutOrder = parseIntegerProp_,
                position = parseUDim2Prop_,
                zIndex = parseNumberProp_,
                ctaButton = parseUiComponentProp_,
                labelText = parseStringProp_,
                secondaryLabelText = if FFlagLuaAppHeroUnitSecondaryLabelText then parseStringProp_ else nil,
                rightLabelContent = parseUiComponentProp_
            }
        }
    end

    tbl4._registeredComponents[SduiComponentType.Chip] = {
        component = require(ServerDrivenUiParent.SduiSharedContent).SduiChip,
        propParsers = {
            anchorPoint = parseVector2Prop_,
            layoutOrder = parseIntegerProp_,
            position = parseUDim2Prop_,
            text = parseStringProp_,
            leadingIconName = parseStringProp_,
            leadingIconVariant = getLuaTableEnumParser(Foundation.Enums.IconVariant, "string"),
            leadingIsCircular = parseBooleanProp_,
            leadingOnActivated = parseCallbackProp_,
            trailingIconName = parseStringProp_,
            trailingIconVariant = getLuaTableEnumParser(Foundation.Enums.IconVariant, "string"),
            trailingIsCircular = parseBooleanProp_,
            trailingOnActivated = parseCallbackProp_,
            onActivated = parseCallbackProp_,
            isChecked = parseBooleanProp_,
            size = getLuaTableEnumParser(Foundation.Enums.ChipSize, "string")
        },
        propInterface = FFlagSduiChipAccessoryProps and {
            leading = t.optional(t.table),
            trailing = t.optional(t.table)
        } or nil
    }

    tbl4._registeredComponents[SduiComponentType.DualActionChip] = {
        component = require(ServerDrivenUiParent.SduiSharedContent).SduiDualActionChip,
        propParsers = {
            anchorPoint = parseVector2Prop_,
            layoutOrder = parseIntegerProp_,
            position = parseUDim2Prop_,
            text = parseStringProp_,
            leadingIconName = parseStringProp_,
            leadingIconVariant = getLuaTableEnumParser(Foundation.Enums.IconVariant, "string"),
            leadingOnActivated = parseCallbackProp_,
            trailingIconName = parseStringProp_,
            trailingIconVariant = getLuaTableEnumParser(Foundation.Enums.IconVariant, "string"),
            trailingOnActivated = parseCallbackProp_
        }
    }
    tbl4._registeredComponents[SduiComponentType.AssociatedItemsRow] = {
        component = require(ServerDrivenUi.Content.SduiAssociatedItemsRow),
        propParsers = {
            layoutOrder = parseIntegerProp_,
            items = getArrayMetatableParser(parseLazyUiComponentProp_),
            footerComponent = parseUiComponentProp_
        }
    }

    tbl4._registeredComponents[SduiComponentType.ExperienceAssociatedItemsRow] = {
        component = require(ServerDrivenUi.Content.ExperienceDetails.ExperienceAssociatedItemsRow),
        propParsers = {
            layoutOrder = parseIntegerProp_,
            items = getArrayMetatableParser(parseLazyUiComponentProp_),
            universeId = parseStringProp_
        },
        propInterface = {
            universeId = t.string
        }
    }
    tbl4._registeredComponents[SduiComponentType.ExperienceDetailsVoteChip] = {
        component = require(ServerDrivenUi.Content.ExperienceDetails.ExperienceDetailsVoteChip),
        propParsers = { layoutOrder = parseIntegerProp_, universeId = parseStringProp_ },
        propInterface = {
            universeId = t.string
        }
    }
    tbl4._registeredComponents[SduiComponentType.ExperienceDetailsFavoriteChip] = {
        component = require(ServerDrivenUi.Content.ExperienceDetails.ExperienceDetailsFavoriteChip),
        propParsers = { layoutOrder = parseIntegerProp_, universeId = parseStringProp_ },
        propInterface = {
            universeId = t.string
        }
    }
    tbl4._registeredComponents[SduiComponentType.ExperienceDetailsNotifyChip] = {
        component = require(ServerDrivenUi.Content.ExperienceDetails.ExperienceDetailsNotifyChip),
        propParsers = { layoutOrder = parseIntegerProp_, universeId = parseStringProp_ },
        propInterface = {
            universeId = t.string
        }
    }
    tbl4._registeredComponents[SduiComponentType.ExperienceDetailsActiveChip] = {
        component = require(ServerDrivenUi.Content.ExperienceDetails.ExperienceDetailsActiveChip),
        propParsers = { layoutOrder = parseIntegerProp_, universeId = parseStringProp_ },
        propInterface = {
            universeId = t.string
        }
    }
    tbl4._registeredComponents[SduiComponentType.ExperienceDetailsShareChip] = {
        component = require(ServerDrivenUi.Content.ExperienceDetails.ExperienceDetailsShareChip),
        propParsers = { layoutOrder = parseIntegerProp_, universeId = parseStringProp_ },
        propInterface = {
            universeId = t.string
        }
    }
    tbl4._registeredComponents[SduiComponentType.ExperienceDetailsReportChip] = {
        component = require(ServerDrivenUi.Content.ExperienceDetails.ExperienceDetailsReportChip),
        propParsers = { layoutOrder = parseIntegerProp_, universeId = parseStringProp_ },
        propInterface = {
            universeId = t.string
        }
    }
    if FFlagSduiExperienceDetailsSocialProof then
        tbl4._registeredComponents[SduiComponentType.ExperienceDetailsConnectionsPlayedChip] = {
            component = require(ServerDrivenUi.Content.ExperienceDetails.ExperienceDetailsConnectionsPlayedChip),
            propParsers = { layoutOrder = parseIntegerProp_, universeId = parseStringProp_ },
            propInterface = {
                universeId = t.string
            }
        }
        tbl4._registeredComponents[SduiComponentType.ExperienceDetailsConnectionsPlayedTextRow] = {
            component = require(ServerDrivenUi.Content.ExperienceDetails.ExperienceDetailsConnectionsPlayedTextRow),
            propParsers = {
                layoutOrder = parseIntegerProp_,
                universeId = parseStringProp_,
                name = parseStringProp_
            },
            propInterface = {
                universeId = t.string,
                name = t.optional(t.string)
            }
        }
    end

    local _registeredComponents2 = tbl4._registeredComponents
    local verticalFeed = SduiComponentType.VerticalFeed
    _registeredComponents2[verticalFeed] = {
        component = require(ServerDrivenUiParent.SduiSharedContent).SduiVerticalFeed,
        propParsers = {
            layoutOrder = parseIntegerProp_,
            feedItems = getArrayMetatableParser(parseLazyUiComponentProp_),
            gapBetweenFeedItems = parseNumberProp_,
            gapAfterFirstFeedItem = if FFlagSduiIndividualFeedItemSpacing then parseNumberProp_ else nil,
            thresholdFromEnd = parseNumberProp_,
            onScrollToEnd = parseCallbackProp_,
            onRefresh = parseCallbackProp_,
            stickyItems = getArrayMetatableParser(parseUiComponentProp_),
            gapAfterStickyItems = parseIntegerProp_,
            gapBetweenStickyItems = parseIntegerProp_,
            stickyPaddingTop = parseIntegerProp_,
            stickyPaddingBottom = parseIntegerProp_,
            stickyBackgroundStyle = parseColorTokenProp_,
            stickyContentTag = parseStringProp_,
            backgroundStyle = parseColorTokenProp_
        }
    }

    tbl4._registeredComponents[SduiComponentType.BadgeTile] = {
        component = require(ServerDrivenUi.Content.SduiBadgeTile),
        propParsers = Cryo.Dictionary.join(
            tbl4._registeredComponents[SduiComponentType.Tile].propParsers,
            { imageCornerRadius = parseNumberProp_, imagePadding = parseNumberProp_ }
        )
    }
    tbl4._registeredComponents[SduiComponentType.Badge] = {
        component = require(ServerDrivenUiParent.SduiSharedContent).SduiBadge,
        propParsers = {
            anchorPoint = parseVector2Prop_,
            layoutOrder = parseIntegerProp_,
            position = parseUDim2Prop_,
            visible = parseBooleanProp_,
            zIndex = parseNumberProp_,
            text = parseStringProp_,
            icon = parseStringProp_,
            variant = getLuaTableEnumParser(Foundation.Enums.BadgeVariant, "string")
        }
    }

    tbl4._registeredComponents[SduiComponentType.SongTile] = {
        component = require(ServerDrivenUi.Content.SduiSongTile)
    }
    tbl4._registeredComponents[SduiComponentType.InfoTable] = {
        component = require(ServerDrivenUiParent.SduiSharedContent).SduiInfoTable,
        propParsers = {
            layoutOrder = parseIntegerProp_,
            gridTag = parseStringProp_,
            items = getArrayMetatableParser(parseLazyUiComponentProp_),
            numColumns = parseIntegerProp_,
            tag = parseStringProp_
        },
        propInterface = {
            items = t.array(t.table)
        }
    }
    tbl4._registeredComponents[SduiComponentType.InfoTableCell] = {
        component = require(ServerDrivenUiParent.AppBlox).InfoTableCell,
        propParsers = {
            labelComponent = parseUiComponentProp_,
            isLastInSingleColumn = parseBooleanProp_,
            numColumns = parseIntegerProp_,
            onActivated = parseCallbackProp_,
            valueComponent = parseUiComponentProp_
        },
        propInterface = {
            labelComponent = t.table,
            valueComponent = t.table,
            isLastInSingleColumn = t.optional(t.boolean)
        }
    }
    tbl4._registeredComponents[SduiComponentType.ExpandableText] = {
        component = require(ServerDrivenUiParent.SduiSharedContent).SduiExpandableText,
        propParsers = {
            layoutOrder = parseIntegerProp_,
            text = parseStringProp_,
            compactNumberOfLines = parseIntegerProp_,
            fontStyle = parseTypographyTokenProp_,
            textStyle = parseColorTokenProp_,
            pressedTextStyle = parseColorTokenProp_,
            expandedInitially = parseBooleanProp_,
            avoidBlankLineClip = parseBooleanProp_,
            onExpandChanged = parseCallbackProp_,
            headerComponent = parseUiComponentProp_
        },
        propInterface = {
            text = t.string
        }
    }
    tbl4._registeredComponents[SduiComponentType.OverflowMenu] = {
        component = require(ServerDrivenUiParent.SduiSharedContent).SduiOverflowMenu,
        propParsers = {
            anchorPoint = parseVector2Prop_,
            layoutOrder = parseIntegerProp_,
            position = parseUDim2Prop_,
            zIndex = parseNumberProp_,
            buttonVariant = getLuaTableEnumParser(Foundation.Enums.ButtonVariant, "string"),
            buttonSize = getLuaTableEnumParser(Foundation.Enums.InputSize, "string"),
            buttonIcon = getLuaTableEnumParser(Foundation.Enums.IconName, "string"),
            buttonIconBackgroundStyle = parseColorTokenProp_,
            menuItemSize = getLuaTableEnumParser(Foundation.Enums.InputSize, "string"),
            popoverAlign = getLuaTableEnumParser(Foundation.Enums.PopoverAlign, "string"),
            popoverSide = getLuaTableEnumParser(Foundation.Enums.PopoverSide, "string"),
            menuWidth = parseUDimProp_
        },
        propInterface = {
            items = t.table
        }
    }

    if FFlagLuaAppDismissUnlockUpsell then
        tbl4._registeredComponents[SduiComponentType.AgeCheckUpsellRow] = {
            component = require(ServerDrivenUi.Content.SduiAgeCheckUpsellRow),
            propParsers = {
                leading = parseUiComponentProp_,
                content = parseUiComponentProp_,
                trailing = parseUiComponentProp_,
                onActivated = parseCallbackProp_,
                tag = parseStringProp_,
                leadingTag = parseStringProp_,
                contentTag = parseStringProp_,
                trailingTag = parseStringProp_,
                layoutOrder = parseIntegerProp_,
                position = parseUDim2Prop_,
                zIndex = parseNumberProp_,
                testId = parseStringProp_
            }
        }
    end

    setmetatable(tbl4, module)
    return tbl4
end

function module:getComponentDefinition(arg1)
    return self._registeredComponents[arg1] or getSduiComponentRegistry().getComponentDefinition(arg1)
end

function module.doesComponentManageChildren(arg1, arg2)
    local componentDefinition = arg1:getComponentDefinition(arg2)
    return componentDefinition and componentDefinition.doesManageChildren or false
end

function module.getComponent(arg1, arg2)
    local componentDefinition = arg1:getComponentDefinition(arg2)
    return componentDefinition and componentDefinition.component
end

function module.getPropParsers(arg1, arg2)
    local componentDefinition = arg1:getComponentDefinition(arg2)
    return componentDefinition and componentDefinition.propParsers or tbl1
end

function module.getPropInterface(arg1, arg2)
    local componentDefinition = arg1:getComponentDefinition(arg2)
    return componentDefinition and componentDefinition.propInterface or nil
end

local tbl2 = {
    [parseUiComponentProp_] = true,
    [parseCallbackProp_] = true,
    [parseFocusNavActionsProp_] = true
}

function module.doesParserRequireRenderContext(_, arg1): boolean
    return if arg1 and tbl2[arg1] then true else typeof(arg1) == "table"
end

function module:registerComponent(arg1, arg2)
    self._registeredComponents[arg1] = arg2
end

return module
