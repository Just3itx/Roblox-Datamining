-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:00:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SponsoredTiles = script:FindFirstAncestor("SponsoredTiles")
local SponsoredTilesParent = SponsoredTiles.Parent
local GameTile = require(SponsoredTilesParent.GameTile)

local formatExperienceThumbnail = GameTile.formatExperienceThumbnail
local useIsHoveredTile = GameTile.useIsHoveredTile
local useNavigateToGameDetails = GameTile.useNavigateToGameDetails
local GameTileThumbnailBadges = GameTile.GameTileThumbnailBadges
local getAvailableGameTileOverflowMenuItems = GameTile.getAvailableGameTileOverflowMenuItems
local SpanTileOverflowMenu = require(SponsoredTiles.SpanTileOverflowMenu.SpanTileOverflowMenu)
local TwoByOneGameTileTelemetry = require(SponsoredTilesParent.SponsoredTilesTelemetry).TwoByOneGameTileTelemetry
local _types = require(SponsoredTiles.types)
local HiddenTileContent = GameTile.HiddenTileContent
local HoverTileCoordinator = GameTile.HoverTileCoordinator

local React = require(SponsoredTilesParent.React)
local Foundation = require(SponsoredTilesParent.Foundation)
local ButtonSize = Foundation.Enums.ButtonSize
local useTokens = Foundation.Hooks.useTokens
local Image = Foundation.Image
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local Responsive = require(SponsoredTilesParent.Responsive)
local AppBlox = require(SponsoredTilesParent.AppBlox)
local getOverflowMenuSignalStore = AppBlox.getOverflowMenuSignalStore
local useOverflowMenuOpen = AppBlox.useOverflowMenuOpen
local useTriggerFeedback = require(SponsoredTilesParent.InteractionFeedback).useTriggerFeedback
local ImpressionsTagUtility = require(SponsoredTilesParent.Impressions).ImpressionsTagUtility
local GetTextSize = require(SponsoredTilesParent.Style).GetTextSize
local PlayButton = require(SponsoredTilesParent.GamePlayButton).PlayButton
local useOnPlayButtonCallback = require(SponsoredTilesParent.GamePlayButton).useOnPlayButtonCallback
local usePlayButtonState = require(SponsoredTilesParent.GamePlayButton).usePlayButtonState
local useLocalization = require(SponsoredTilesParent.Localization).Hooks.useLocalization
local useRoactService = require(SponsoredTilesParent.RobloxAppHooks).useRoactService
local RoactServiceTags = require(SponsoredTilesParent.RoactServiceTags)
local RoactNetworking = RoactServiceTags.RoactNetworking
local AppSessionService = RoactServiceTags.AppSessionService
local RobloxAppSessionization = require(SponsoredTilesParent.RobloxAppSessionization)
local SetGamePlaySession = RobloxAppSessionization.SetGamePlaySession
local SessionType = RobloxAppSessionization.SessionType
local SharedFlags = require(SponsoredTilesParent.SharedFlags)
local sponsoredGamesRecordClick = require(SponsoredTilesParent.DiscoveryAnalytics).Requests.sponsoredGamesRecordClick
local GameCollectionItemTypes = require(SponsoredTilesParent.DiscoveryTypes).GameCollectionItemTypes
local useValidTileBadges = GameTile.useValidTileBadges
local useTagAsViewportAutoplayCandidate = require(SponsoredTilesParent.VideoUtils).useTagAsViewportAutoplayCandidate
local useTagAsSponsoredAdViewabilityCandidate = require(SponsoredTilesParent.SponsoredAdViewability).useTagAsSponsoredAdViewabilityCandidate

local FFlagLuaAppSponsoredTileBadgeContentPadding = require(SponsoredTiles.Flags.FFlagLuaAppSponsoredTileBadgeContentPadding)

local maxWidth = game:DefineFastInt("LuaAppTwoByOneTileSmallScreenBreakpoint", 600)

local num2 = game:DefineFastInt("LuaAppTwoByOneTileLogoHeightPercentLandscape", 20)

local num3 = game:DefineFastInt("LuaAppTwoByOneTileLogoHeightPercentSquare", 36)

local num4 = game:DefineFastInt("LuaAppTwoByOneTileGradientStartOpacityPercent", 30)

local num5 = game:DefineFastInt("LuaAppTwoByOneTileGradientEndOpacityPercent", 100)
local num6 = game:DefineFastInt("LuaAppTwoByOneTileGradientWidthPercent", 50)
local FFlagLuaAppHomePageFirstImageLoadObserver = SharedFlags.FFlagLuaAppHomePageFirstImageLoadObserver
local FFlagLuaAppFeatureTileHapticsFix = SharedFlags.FFlagLuaAppFeatureTileHapticsFix
local FFlagLuaAppTileVideoCandidateOnly = SharedFlags.FFlagLuaAppTileVideoCandidateOnly
local FFlagLuaAppDemoModePlayButtonTelemetry = SharedFlags.FFlagLuaAppDemoModePlayButtonTelemetry
local FFlagLuaAppHomeThumbnailPrefetch = SharedFlags.FFlagLuaAppHomeThumbnailPrefetch
local FFlagLuaAppSduiSponsoredTwoByOneTile = SharedFlags.FFlagLuaAppSduiSponsoredTwoByOneTile
local FFlagLuaAppEnableReportExperience = SharedFlags.FFlagLuaAppEnableReportExperience
local resolveGameTileThumbnailUri = if FFlagLuaAppHomeThumbnailPrefetch then GameTile.resolveGameTileThumbnailUri else nil
local str1 = if FFlagLuaAppFeatureTileHapticsFix then "TileLongPress" else "TwoByOneTileLongPress"
local white = Color3.new(1, 1, 1)
local black = Color3.new(0, 0, 0)

local yScale = num2 / 100
local num7 = num3 / 100
local num8 = num4 / 100
local num9 = num5 / 100
local num10 = num6 / 100

local tbl1 = {
    Default = { ctaStyle = nil, onCtaActivation = "JoinGame", onTileActivation = "OpenEdp" },
    Variant1 = { ctaStyle = nil, onCtaActivation = nil, onTileActivation = "JoinGame" },
    Variant2 = {
        ctaStyle = "StandardLight",
        onCtaActivation = "OpenEdp",
        onTileActivation = "JoinGame"
    },
    Variant3 = {
        ctaStyle = "OverMedia",
        onCtaActivation = "OpenEdp",
        onTileActivation = "JoinGame"
    }
}

return function(tbl2)
    local var1 = useNavigateToGameDetails()
    local var2 = useRoactService(RoactNetworking)
    local var3 = useRoactService(AppSessionService)

    local var4 = useLocalization({ sponsoredText = "Feature.GamePage.Label.Sponsored", joinButtonText = "Common.VisitGame.Label.Play" })
    local playableText = if tbl2.ctaText then tbl2.ctaText else var4.joinButtonText
    local var6 = tbl1[tbl2.tileVariant] or tbl1.Default

    local var7 = useTokens()
    local uDim = UDim.new(0, var7.Radius.Medium)
    local offset, offset2, var8, var9, var10, offset3, var11, yOffset, var12

    if Responsive.useResponsive({{ Key = "Smaller", maxWidth = maxWidth }}) == "Smaller" then
        offset = var7.Padding.Medium
        offset2 = var7.Padding.Medium
        var8 = var7.Typography.TitleLarge
        var9 = var7.Typography.BodySmall
        var10 = var7.Typography.CaptionSmall
        offset3 = var7.Gap.XXSmall
        var11 = ButtonSize.Small
        yOffset = var7.Size.Size_800
        var12 = var7.Typography.TitleSmall
    else
        offset = var7.Padding.Large
        offset2 = var7.Padding.Large
        var8 = var7.Typography.HeadingMedium
        var9 = var7.Typography.BodyMedium
        var10 = var7.Typography.CaptionMedium
        offset3 = var7.Gap.XSmall
        var11 = ButtonSize.Medium
        yOffset = var7.Size.Size_1000
        var12 = var7.Typography.TitleMedium
    end

    local var13 = var7.Padding.Large * 4

    local width = React.useMemo(function(): UDim
        local textSize = GetTextSize(playableText, var12.FontSize, var12.Font, Vector2.new(math.huge, math.huge))

        return UDim.new(0, textSize.X + var13)
    end, { playableText, var12, var13 })

    local color3 = if var6.ctaStyle == "StandardLight" then var7.Color.Extended.White.White_20.Color3 else var7.LightMode.ActionOverMedia.Background.Color3
    local transparency = if var6.ctaStyle == "StandardLight" then var7.Color.Extended.White.White_20.Transparency else var7.LightMode.ActionOverMedia.Background.Transparency
    local var15 = tonumber(tbl2.logoAspectRatio)
    local aspectRatio = if var15 then if var15 > 0 then var15 else 1 else 1
    local yScale2 = if aspectRatio == 3 then yScale else num7
    local universeId = tbl2.universeId
    local placeId = tbl2.placeId

    local var17 = useValidTileBadges(universeId, tbl2.topicId, tbl2.badgeOverride)

    local hoverKey = tbl2.hoverKey
    local isSelected, var19 = React.useState(false)
    local var20 = React.useRef(nil)
    local var21 = useTriggerFeedback()
    local var22 = useOverflowMenuOpen(hoverKey)

    local isHovered = useIsHoveredTile(var20, hoverKey, true)

    local var24 = React.useRef(false)

    local useCallback = React.useCallback
    local function func1()
        if tbl2.isSponsored and tbl2.adId and not (FFlagLuaAppSduiSponsoredTwoByOneTile and tbl2.disableSponsoredClickRecording) then
            sponsoredGamesRecordClick(var2, tbl2.adId)
        end
    end

    local isSponsored = tbl2.isSponsored
    local adId = tbl2.adId
    local disableSponsoredClickRecording = if FFlagLuaAppSduiSponsoredTwoByOneTile then tbl2.disableSponsoredClickRecording else nil
    local var25 = useCallback(func1, { var2, isSponsored, adId, disableSponsoredClickRecording })

    local var26 = React.useCallback(function()
        var24.current = false
    end, {})

    local useCallback2 = React.useCallback
    local function func2()
        if FFlagLuaAppSduiSponsoredTwoByOneTile and tbl2.onOpenGameDetails then
            tbl2.onOpenGameDetails()
        else
            local tbl3 = {
                index = tbl2.index,
                placeIdOverride = tbl2.placeIdOverride,
                experienceJoinData = {
                    launchData = if tbl2.launchDataOverride then tbl2.launchDataOverride else nil,
                    tileType = GameCollectionItemTypes.GameCollectionItemType.TwoByOneTile,
                    nativeAdData = tbl2.adId
                }
            }

            var1(universeId, tbl3)

            if not FFlagLuaAppSduiSponsoredTwoByOneTile then
                TwoByOneGameTileTelemetry.logTwoByOneTileViewGameDetailsActivated()
            end

            if tbl2.reportGameDetailOpened then
                tbl2.reportGameDetailOpened(tbl2.index, universeId)
            end
        end

        if FFlagLuaAppSduiSponsoredTwoByOneTile then
            TwoByOneGameTileTelemetry.logTwoByOneTileViewGameDetailsActivated()
        end
    end

    local index = tbl2.index
    local placeIdOverride = tbl2.placeIdOverride
    local launchDataOverride = tbl2.launchDataOverride
    local reportGameDetailOpened = tbl2.reportGameDetailOpened
    local adId2 = tbl2.adId
    local onOpenGameDetails = if FFlagLuaAppSduiSponsoredTwoByOneTile then tbl2.onOpenGameDetails else nil
    local var27 = useCallback2(
        func2,
        {
            var1,
            universeId,
            index,
            placeIdOverride,
            launchDataOverride,
            reportGameDetailOpened,
            adId2,
            onOpenGameDetails
        }
    )

    local var28 = React.useCallback(function()
        var19(true)
        if tbl2.onSelectionGained then
            tbl2.onSelectionGained()
        end
    end, { tbl2.onSelectionGained })

    local var29 = React.useCallback(function()
        var19(false)
        if tbl2.onSelectionLost then
            tbl2.onSelectionLost()
        end
    end, { tbl2.onSelectionLost })

    local isSponsored2 = tbl2.isSponsored
    local useMemo = React.useMemo
    local function func3()
        return getAvailableGameTileOverflowMenuItems({
            isSponsored = isSponsored2,
            enableSponsoredFeedback = tbl2.enableSponsoredFeedback,
            enableReportAd = tbl2.enableReportAd,
            enableReportExperience = if FFlagLuaAppEnableReportExperience then tbl2.enableReportExperience else nil,
            enableExplicitFeedback = tbl2.enableExplicitFeedback
        })
    end

    local enableSponsoredFeedback = tbl2.enableSponsoredFeedback
    local enableReportAd = tbl2.enableReportAd
    local enableReportExperience = if FFlagLuaAppEnableReportExperience then tbl2.enableReportExperience else nil
    local availableMenuItems = useMemo(
        func3,
        {
            isSponsored2,
            enableSponsoredFeedback,
            enableReportAd,
            enableReportExperience,
            tbl2.enableExplicitFeedback
        }
    )

    local useCallback3 = React.useCallback
    local function func4()
        local current = var24.current
        var24.current = true
        if FFlagLuaAppSduiSponsoredTwoByOneTile and current == false and tbl2.onTouchLongPress then
            tbl2.onTouchLongPress()
            return
        end

        if current ~= false or next(availableMenuItems) == nil then
            return
        end

        if var21 and not var22 then
            local tbl3 = {
                universeId = universeId,
                sortId = tbl2.topicId
            }

            var21(str1, "Press", tbl2.appPage or "Unknown", tbl3)
        end
        getOverflowMenuSignalStore().openMenu(hoverKey)
    end

    local appPage = tbl2.appPage
    local topicId = tbl2.topicId
    local onTouchLongPress = if FFlagLuaAppSduiSponsoredTwoByOneTile then tbl2.onTouchLongPress else nil
    local var31 = useCallback3(func4, { hoverKey, appPage, topicId, var21, availableMenuItems, var22, universeId, onTouchLongPress })

    local reportExperienceLaunched = React.useCallback(function(str2: string?)
        if var3 then
            SetGamePlaySession(var3, SessionType.StructuralIdentifier.GamePlayFromHoverTile, true)
        end

        if isHovered then
            HoverTileCoordinator.default:reset()
        end

        if not tbl2.reportExperienceLaunched then
            return
        end

        local tbl3 = {
            placeId = placeId,
            universeId = universeId,
            adId = tbl2.adId,
            tileType = GameCollectionItemTypes.GameCollectionItemType.TwoByOneTile,
            placeIdOverride = tbl2.placeIdOverride,
            launchDataOverride = tbl2.launchDataOverride
        }
        local reportExperienceLaunched = tbl2.reportExperienceLaunched

        local appPage2 = tbl2.appPage
        local twoByOneTile = GameCollectionItemTypes.GameCollectionItemType.TwoByOneTile
        local twoByOneTile2 = GameCollectionItemTypes.GameCollectionItemType.TwoByOneTile
        local index2 = tbl2.index
        if not FFlagLuaAppDemoModePlayButtonTelemetry then
            str2 = nil
        end

        reportExperienceLaunched(tbl3, appPage2, twoByOneTile, twoByOneTile2, index2, str2)
    end, {
        var3,
        tbl2.reportExperienceLaunched,
        placeId,
        universeId,
        tbl2.appPage,
        tbl2.index,
        tbl2.adId,
        tbl2.placeIdOverride,
        tbl2.launchDataOverride,
        isHovered
    })

    local var33 = usePlayButtonState(var2, universeId)

    local var34 = useOnPlayButtonCallback

    local appPage2 = tbl2.appPage
    local str2 = "TwoByOneTile"
    local var35 = nil
    local str3 = "TwoByOneTile"
    local tbl3 = {
        launchData = tbl2.launchDataOverride,
        tileType = GameCollectionItemTypes.GameCollectionItemType.TwoByOneTile,
        nativeAdData = tbl2.adId
    }
    local var36 = if tbl2.placeIdOverride then tbl2.placeIdOverride else tbl2.placeId
    local var37 = var34(universeId, appPage2, str2, var35, str3, tbl3, var36)

    local onActivated = React.useCallback(function()
        TwoByOneGameTileTelemetry.logTwoByOneTileGameJoinInitiated()
        TwoByOneGameTileTelemetry.logTwoByOneTileCtaActivated()
        var25()
    end, { var25 })

    local var39 = React.useCallback(function()
        TwoByOneGameTileTelemetry.logTwoByOneTileCtaActivated()
        var25()
        var27()
    end, { var25, var27 })
    local var40 = React.useCallback(function()
        TwoByOneGameTileTelemetry.logTwoByOneTileGameJoinInitiated()

        var37(var33.playButtonState, reportExperienceLaunched)
    end, { var37, var33.playButtonState, reportExperienceLaunched })

    local var41 = React.useCallback(function()
        if var24.current then
            var24.current = false
            return
        end

        if isHovered then
            HoverTileCoordinator.default:reset()
        end

        TwoByOneGameTileTelemetry.logTwoByOneTileActivated()
        var25()

        if var6.onTileActivation == "OpenEdp" then
            var27()
        elseif var6.onTileActivation == "JoinGame" then
            var40()
        end
    end, {
        isHovered,
        var6.onTileActivation,
        var27,
        var40,
        var25
    })

    local image = if FFlagLuaAppHomeThumbnailPrefetch then resolveGameTileThumbnailUri({
        placeId = placeId,
        useGridTile = true,
        isEmphasized = true,
        perEntryWideAssetId = tbl2.wideAssetId,
        topicId = tbl2.topicId
    }) else formatExperienceThumbnail(tbl2.wideAssetId, placeId, true)
    local ageRatingLabel = tbl2.ageRatingLabel

    local ref = React.useRef(nil)
    React.useEffect(function()
        ImpressionsTagUtility.AddTag(ref, tbl2.impressionsTag, tbl2.index)
        return function()
            ImpressionsTagUtility.RemoveTag(ref, tbl2.impressionsTag, tbl2.index)
        end
    end, { tbl2.impressionsTag, tbl2.index })

    local var44 = useTagAsViewportAutoplayCandidate

    local videoPlaybackContext = tbl2.videoPlaybackContext
    var44(ref, videoPlaybackContext, not FFlagLuaAppTileVideoCandidateOnly and nil)

    local var45 = nil
    if tbl2.isSponsored and tbl2.adId ~= nil then
        var45 = not tbl2.isHidden
            and {
                encryptedAdTrackingData = tbl2.adId,
                tileType = GameCollectionItemTypes.GameCollectionItemType.TwoByOneTile,
                mediaType = "image"
            }
            or var45
    end

    useTagAsSponsoredAdViewabilityCandidate(ref, var45)

    if tbl2.isHidden then
        local createElement = React.createElement
        local str4 = "Frame"
        local tbl4 = {
            Size = if FFlagLuaAppSduiSponsoredTwoByOneTile then tbl2.rootSize else nil,
            LayoutOrder = tbl2.layoutOrder,
            ZIndex = tbl2.zIndex,
            BackgroundTransparency = 1,
            ref = ref
        }
        local tbl5 = {
            TwoByOneTileContainer = React.createElement("TextButton", {
                Size = tbl2.size or UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                ref = var20,
                Selectable = false,
                SelectionOrder = tbl2.SelectionOrder
            }, {
                HiddenTileContent = if FFlagLuaAppSduiSponsoredTwoByOneTile and tbl2.renderHiddenState then tbl2.renderHiddenState(var20) else React.createElement(
                    HiddenTileContent,
                    {
                        appPage = tbl2.appPage,
                        collectionId = tbl2.topicId,
                        setGameHidden = tbl2.setGameHidden,
                        universeId = universeId,
                        parentRef = var20,
                        isSponsored = isSponsored2
                    }
                )
            })
        }
        return createElement(str4, tbl4, tbl5)
    end

    local createElement = React.createElement
    local str4 = "Frame"
    local tbl4 = {
        Size = if FFlagLuaAppSduiSponsoredTwoByOneTile then tbl2.rootSize else nil,
        LayoutOrder = tbl2.layoutOrder,
        ZIndex = tbl2.zIndex,
        BackgroundTransparency = 1,
        ref = ref
    }
    local tbl5 = { TwoByOneTileContainer = 0 }
    local createElement2 = React.createElement
    local str5 = "TextButton"
    local tbl6 = {
        Size = tbl2.size or UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        ref = var20,
        SelectionOrder = tbl2.SelectionOrder,
        [React.Event.TouchLongPress] = var31,
        [React.Event.Activated] = var41,
        [React.Event.SelectionGained] = var28,
        [React.Event.SelectionLost] = var29,
        [React.Change.GuiState] = var26
    }
    local tbl7 = {
        BackgroundImage = React.createElement(
            "ImageLabel",
            {
                [React.Tag] = if FFlagLuaAppHomePageFirstImageLoadObserver then "observed-image" else nil,
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                Image = image,
                ScaleType = Enum.ScaleType.Crop,
                ZIndex = 0
            },
            {
                UICorner = React.createElement("UICorner", { CornerRadius = uDim })
            }
        ),
        GradientOverlayLeft = React.createElement("Frame", {
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 0, 1, 0),
            Size = UDim2.new(num10, 0, 1, 0),
            BackgroundColor3 = white,
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            ZIndex = 1
        }, {
            UICorner = React.createElement("UICorner", { CornerRadius = uDim }),
            UIGradientLeft = React.createElement("UIGradient", {
                Rotation = 0,
                Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, num8), NumberSequenceKeypoint.new(1, num9) }),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, black), ColorSequenceKeypoint.new(1, black) })
            })
        }),
        GradientOverlayBottom = React.createElement("Frame", {
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 0, 1, 0),
            Size = UDim2.new(1, 0, num10, 0),
            BackgroundColor3 = white,
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            ZIndex = 1
        }, {
            UICorner = React.createElement("UICorner", { CornerRadius = uDim }),
            UIGradientBottom = React.createElement("UIGradient", {
                Rotation = 90,
                Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, num9), NumberSequenceKeypoint.new(1, num8) }),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, black), ColorSequenceKeypoint.new(1, black) })
            })
        }),
        TileBadge = 0,
        ContentOverlay = 0,
        OverflowMenu = 0
    }

    if var17 then
        local createElement3 = React.createElement
        local str6 = "Frame"
        local tbl8 = {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ZIndex = 2
        }

        local tbl9 = {
            Badge = React.createElement(
                GameTileThumbnailBadges,
                {
                    tileBadgesByPosition = var17,
                    padding = if FFlagLuaAppSponsoredTileBadgeContentPadding then offset else nil
                }
            )
        }
        var17 = createElement3(str6, tbl8, tbl9)
    end

    tbl7.TileBadge = var17

    local createElement3 = React.createElement
    local str6 = "Frame"
    local tbl8 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ZIndex = 3
    }

    local tbl9 = {
        UIPadding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, offset),
            PaddingRight = UDim.new(0, offset),
            PaddingTop = UDim.new(0, offset2),
            PaddingBottom = UDim.new(0, offset2)
        }),
        Logo = tbl2.logoImageAssetId
            and React.createElement(Image, {
                Position = UDim2.new(1, 0, 0, 0),
                AnchorPoint = Vector2.new(1, 0),
                Image = "rbxassetid://" .. tostring(tbl2.logoImageAssetId),
                Size = UDim2.new(1, 0, yScale2, 0),
                aspectRatio = aspectRatio
            }),
        HeaderFrame = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Position = UDim2.new(0, 0, 0.47, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1
        }, {
            UIListLayout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, offset3)
                }
            ),
            Headline = React.createElement("TextLabel", {
                LayoutOrder = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = tbl2.headline or "",
                FontFace = normalizeFontFace(var8.Font),
                TextSize = var8.FontSize,
                TextColor3 = white,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true
            }),
            Subtitle = React.createElement("TextLabel", {
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = tbl2.subtitle or "",
                FontFace = normalizeFontFace(var9.Font),
                TextSize = var9.FontSize,
                TextColor3 = white,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true
            })
        }),
        JoinButtonContainer = 0,
        ViewGameDetailsButton = 0,
        BottomRightLabel = 0
    }
    local var46

    if var6.onCtaActivation == "JoinGame" then
        local createElement4 = React.createElement
        local str7 = "Frame"
        local tbl10 = {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 1)
        }
        local tbl11 = {
            JoinButton = React.createElement(PlayButton, {
                universeId = universeId,
                placeId = if tbl2.placeIdOverride then tbl2.placeIdOverride else placeId,
                referralSource = tbl2.appPage,
                eventContext = "TwoByOneTile",
                launchSource = "TwoByOneTile",
                playableText = playableText,
                hidePlayableIcon = true,
                buttonSize = var11,
                width = width,
                preferSecondaryPlayButton = true,
                onActivated = onActivated,
                reportExperienceLaunched = reportExperienceLaunched,
                experienceJoinData = tbl2.launchDataOverride and {
                    launchData = tbl2.launchDataOverride
                } or nil
            })
        }
        var46 = createElement4(str7, tbl10, tbl11)
    else
        var46 = false
    end

    tbl9.JoinButtonContainer = var46
    local element

    if var6.onCtaActivation == "OpenEdp" then
        element = React.createElement(
            "TextButton",
            {
                Size = UDim2.new(width.Scale, width.Offset, 0, yOffset),
                Position = UDim2.new(0, 0, 1, 0),
                AnchorPoint = Vector2.new(0, 1),
                BackgroundColor3 = color3,
                BackgroundTransparency = transparency,
                Text = playableText,
                TextColor3 = var7.LightMode.ActionOverMedia.Foreground.Color3,
                FontFace = normalizeFontFace(var12.Font),
                TextSize = var12.FontSize,
                [React.Event.Activated] = var39
            },
            {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var7.Radius.Medium) })
            }
        )
    else
        element = false
    end

    tbl9.ViewGameDetailsButton = element

    tbl9.BottomRightLabel = React.createElement("TextLabel", {
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.new(0, 0, 0, var10.FontSize * var10.LineHeight),
        BackgroundTransparency = 1,
        Text = ageRatingLabel,
        TextSize = var10.FontSize,
        FontFace = normalizeFontFace(var10.Font),
        TextColor3 = var7.Color.Extended.Gray.Gray_400.Color3,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextTruncate = Enum.TextTruncate.SplitWord,
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, 0, 1, 0)
    })
    tbl7.ContentOverlay = createElement3(str6, tbl8, tbl9)
    local element2

    if FFlagLuaAppSduiSponsoredTwoByOneTile and tbl2.renderOverflowMenu then
        element2 = tbl2.renderOverflowMenu({ isHovered = isHovered, isSelected = isSelected, menuKey = hoverKey, parentRef = var20 })
    else
        element2 = React.createElement(SpanTileOverflowMenu, {
            hoverKey = hoverKey,
            parentRef = var20,
            zIndex = 4,
            universeId = universeId,
            placeId = placeId,
            adId = tbl2.adId,
            payerName = tbl2.payerName,
            sponsoredUserCohort = tbl2.sponsoredUserCohort,
            appPage = tbl2.appPage,
            topicId = tbl2.topicId,
            isSponsored = tbl2.isSponsored,
            setGameHidden = tbl2.setGameHidden or function() end,
            isHovered = isHovered,
            isSelected = isSelected,
            availableMenuItems = availableMenuItems
        })
    end

    tbl7.OverflowMenu = element2
    tbl5.TwoByOneTileContainer = createElement2(str5, tbl6, tbl7)
    return createElement(str4, tbl4, tbl5)
end
