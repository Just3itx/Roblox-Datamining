-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent

local Foundation = require(SduiSharedContentParent.Foundation)
local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local SduiComponentType = SduiCoreSystem.SduiComponentType
local SduiParsers = SduiCoreSystem.SduiParsers
local getSduiComponentRegistry = SduiCoreSystem.getSduiComponentRegistry

local parseBooleanProp_ = SduiParsers.parseBooleanProp_
local parseCallbackProp_ = SduiParsers.parseCallbackProp_
local parseColorTokenProp_ = SduiParsers.parseColorTokenProp_
local parseIntegerProp_ = SduiParsers.parseIntegerProp_
local parseNumberProp_ = SduiParsers.parseNumberProp_
local parseStringProp_ = SduiParsers.parseStringProp_
local parseUDim2Prop_ = SduiParsers.parseUDim2Prop_
local parseUiComponentProp_ = SduiParsers.parseUiComponentProp_
local parseVector2Prop_ = SduiParsers.parseVector2Prop_
local getLuaTableEnumParser = SduiParsers.getLuaTableEnumParser
local FFlagSduiCardComponent = require(SduiSharedContentParent.SharedFlags).FFlagSduiCardComponent
local FFlagSduiContentRowStateLayer = require(SduiSharedContent.Flags.FFlagSduiContentRowStateLayer)
local FFlagSduiCollectionSlotsLayout = require(SduiSharedContent.Flags.FFlagSduiCollectionSlotsLayout)
local FFlagSDUIContentRowSelectable = require(SduiSharedContent.Flags.FFlagSDUIContentRowSelectable)
local FFlagSduiListComponents = require(SduiSharedContentParent.SharedFlags).FFlagSduiListComponents
local FFlagSduiAccordionComponent = require(SduiSharedContentParent.SharedFlags).FFlagSduiAccordionComponent
local FFlagSduiExpandableListItem = require(SduiSharedContentParent.SharedFlags).FFlagSduiExpandableListItem
local FFlagSduiBannerComponent = require(SduiSharedContentParent.SharedFlags).FFlagSduiBannerComponent
local FFlagSduiSheetComponent = require(SduiSharedContentParent.SharedFlags).FFlagSduiSheetComponent
local FFlagSduiSystemBannerComponent = require(SduiSharedContentParent.SharedFlags).FFlagSduiSystemBannerComponent
local FFlagSduiBannerContextComponent = require(SduiSharedContentParent.SharedFlags).FFlagSduiBannerContextComponent
local FFlagSduiViewportVisibilityComponent = require(SduiSharedContentParent.SharedFlags).FFlagSduiViewportVisibilityComponent
local FFlagSduiInteractableTileWrapper = require(SduiSharedContentParent.SharedFlags).FFlagSduiInteractableTileWrapper
local FFlagSduiDevStoreSeeAllSupport = require(SduiSharedContentParent.SharedFlags).FFlagSduiDevStoreSeeAllSupport
local FFlagSduiPlayWithReward = require(SduiSharedContentParent.SharedFlags).FFlagSduiPlayWithReward
local FFlagSduiPlayWithRewardRefactor = require(SduiSharedContentParent.SharedFlags).FFlagSduiPlayWithRewardRefactor
local FFlagSduiShimmerTextComponentEnabled = require(SduiSharedContentParent.SharedFlags).FFlagSduiShimmerTextComponentEnabled
local FFlagSduiTooltipComponentEnabled = require(SduiSharedContentParent.SharedFlags).FFlagSduiTooltipComponentEnabled
local FFlagSduiRevealTextComponentEnabled = require(SduiSharedContentParent.SharedFlags).FFlagSduiRevealTextComponentEnabled
local FFlagSduiAiOverviewEnabled = require(SduiSharedContentParent.SharedFlags).FFlagSduiAiOverviewEnabled
local FFlagSduiPreferredTextSizeLineBudgets = require(SduiSharedContentParent.SharedFlags).FFlagSduiPreferredTextSizeLineBudgets

local FFlagSduiVerticalListWithImpressionsEnabled = require(SduiSharedContentParent.SharedFlags).FFlagSduiVerticalListWithImpressionsEnabled

local FFlagSduiCollectionCarouselPlaceholderItem = require(SduiSharedContentParent.SharedFlags).FFlagSduiCollectionCarouselPlaceholderItem
local FFlagLuaAppSduiVideoThumbnail = require(SduiSharedContentParent.SharedFlags).FFlagLuaAppSduiVideoThumbnail
local FFlagEnableGameJoinEarlyAccess = require(SduiSharedContentParent.SharedFlags).FFlagEnableGameJoinEarlyAccess
local FFlagSduiReactionsComponent = require(SduiSharedContentParent.SharedFlags).FFlagSduiReactionsComponent
local FFlagSduiMuralSection = require(SduiSharedContentParent.SharedFlags).FFlagSduiMuralSection

local function registerSharedUiComponents()
    local tbl1 = {
        [SduiComponentType.DetailsPageImageHeader] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiDetailsPageImageHeader)
            end
        },
        [SduiComponentType.AvatarGroup] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiAvatarGroup)
            end
        },
        [SduiComponentType.Card] = FFlagSduiCardComponent and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiCard)
            end
        } or nil,
        [SduiComponentType.Coachmark] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiCoachmark)
            end
        },
        [SduiComponentType.Banner] = FFlagSduiBannerComponent and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiBanner)
            end
        } or nil,
        [SduiComponentType.Sheet] = FFlagSduiSheetComponent and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiSheet)
            end
        } or nil,
        [SduiComponentType.SystemBanner] = FFlagSduiSystemBannerComponent and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiSystemBanner)
            end
        } or nil,
        [SduiComponentType.BannerContext] = FFlagSduiBannerContextComponent and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiBannerContext)
            end
        } or nil,
        [SduiComponentType.ViewportVisibility] = FFlagSduiViewportVisibilityComponent and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiViewportVisibility)
            end
        } or nil,
        [SduiComponentType.InteractableTileWrapper] = FFlagSduiInteractableTileWrapper and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiInteractableTileWrapper)
            end
        } or nil,
        [SduiComponentType.CircleIcon] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiCircleIcon)
            end
        },
        [SduiComponentType.Icon] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiIcon)
            end,
            propParsers = {
                name = getLuaTableEnumParser(Foundation.Enums.IconName, "string"),
                style = parseColorTokenProp_,
                size = getLuaTableEnumParser(Foundation.Enums.IconSize, "string"),
                variant = getLuaTableEnumParser(Foundation.Enums.IconVariant, "string"),
                anchorPoint = parseVector2Prop_,
                layoutOrder = parseIntegerProp_,
                position = parseUDim2Prop_,
                visible = parseBooleanProp_,
                zIndex = parseNumberProp_,
                testId = parseStringProp_
            }
        },
        [SduiComponentType.IconButton] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiIconButton)
            end
        },
        [SduiComponentType.LinkText] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiLinkText)
            end
        },
        [SduiComponentType.ShimmerText] = FFlagSduiShimmerTextComponentEnabled and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiShimmerText)
            end
        } or nil,
        [SduiComponentType.RevealText] = FFlagSduiRevealTextComponentEnabled and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiRevealText)
            end
        } or nil,
        [SduiComponentType.LineLimitedText] = FFlagSduiPreferredTextSizeLineBudgets and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiLineLimitedText)
            end
        } or nil,
        [SduiComponentType.CollectionSlotsLayout] = FFlagSduiCollectionSlotsLayout and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiCollectionSlotsLayout)
            end
        } or nil,
        [SduiComponentType.ContentRatingLabel] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiContentRatingLabel)
            end
        },
        [SduiComponentType.MediaGallery] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiMediaGallery)
            end
        },
        [SduiComponentType.VideoPlayer] = FFlagLuaAppSduiVideoThumbnail and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiVideoPlayer)
            end
        } or nil,
        [SduiComponentType.ActionBar] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiActionBar)
            end
        },
        [SduiComponentType.PlayButtonContextualMessage] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiPlayButtonContextualMessage)
            end
        },
        [SduiComponentType.PlusEarlyAccessUpsell] = FFlagEnableGameJoinEarlyAccess and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiPlusEarlyAccessUpsell)
            end
        } or nil,
        [SduiComponentType.PlayWithReward] = if FFlagSduiPlayWithRewardRefactor then nil else FFlagSduiPlayWithReward and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiPlayWithReward)
            end
        } or nil,
        [SduiComponentType.ContentRow] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiContentRow)
            end,
            propParsers = {
                leading = parseUiComponentProp_,
                content = parseUiComponentProp_,
                trailing = parseUiComponentProp_,
                onActivated = parseCallbackProp_,
                stateLayerAffordance = if FFlagSduiContentRowStateLayer then getLuaTableEnumParser(Foundation.Enums.StateLayerAffordance, "string") else nil,
                selectable = if FFlagSDUIContentRowSelectable then parseBooleanProp_ else nil,
                tag = parseStringProp_,
                leadingTag = parseStringProp_,
                contentTag = parseStringProp_,
                trailingTag = parseStringProp_,
                layoutOrder = parseIntegerProp_,
                position = parseUDim2Prop_,
                zIndex = parseNumberProp_,
                testId = parseStringProp_
            }
        },
        [SduiComponentType.ListRoot] = FFlagSduiListComponents and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiListRoot)
            end
        } or nil,
        [SduiComponentType.ExpandableListItem] = FFlagSduiExpandableListItem and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiExpandableListItem)
            end
        } or nil,
        [SduiComponentType.ListItem] = FFlagSduiListComponents and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiListItem)
            end
        } or nil,
        [SduiComponentType.Accordion] = FFlagSduiAccordionComponent and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiAccordion)
            end
        } or nil,
        [SduiComponentType.AccordionItem] = FFlagSduiAccordionComponent and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiAccordionItem)
            end
        } or nil,
        [SduiComponentType.SubscriptionCell] = FFlagSduiDevStoreSeeAllSupport and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiSubscriptionCell)
            end
        } or nil,
        [SduiComponentType.Tooltip] = FFlagSduiTooltipComponentEnabled and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiTooltip)
            end
        } or nil,
        [SduiComponentType.FilterPillsCarousel] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiFilterPillsCarousel)
            end
        },
        [SduiComponentType.Placeholder] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiPlaceholder)
            end
        },
        [SduiComponentType.PlaceholderTile] = FFlagSduiCollectionCarouselPlaceholderItem and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiPlaceholderTile)
            end
        } or nil,
        [SduiComponentType.PlaceholderWrapper] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiPlaceholderWrapper)
            end
        },
        [SduiComponentType.Skeleton] = {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiSkeleton)
            end
        },
        [SduiComponentType.AiOverview] = FFlagSduiAiOverviewEnabled and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiAiOverview)
            end
        } or nil,
        [SduiComponentType.VerticalListWithImpressions] = FFlagSduiVerticalListWithImpressionsEnabled and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiVerticalListWithImpressions)
            end
        } or nil,
        [SduiComponentType.Reactions] = FFlagSduiReactionsComponent and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiReactions)
            end
        } or nil,
        [SduiComponentType.MuralSection] = FFlagSduiMuralSection and {
            getLazyComponent = function()
                return require(SduiSharedContent.Components.SduiMuralSection)
            end
        } or nil
    }

    getSduiComponentRegistry().registerComponentDefinitions(tbl1)
end

return registerSharedUiComponents
