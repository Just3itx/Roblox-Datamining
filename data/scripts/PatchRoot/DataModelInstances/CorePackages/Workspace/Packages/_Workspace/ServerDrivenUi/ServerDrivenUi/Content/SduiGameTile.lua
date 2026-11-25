-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local React = require(ServerDrivenUiParent.React)
local Responsive = require(ServerDrivenUiParent.Responsive)
local GetInputModeStore = Responsive.GetInputModeStore
local AppBlox = require(ServerDrivenUiParent.AppBlox)
local Foundation = require(ServerDrivenUiParent.Foundation)
local Cryo = require(ServerDrivenUiParent.Cryo)
local DiscoveryAnalytics = require(ServerDrivenUiParent.DiscoveryAnalytics)
local Signals = require(ServerDrivenUiParent.Signals)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)
local localizeStrings = require(ServerDrivenUiParent.Localization).localizeStrings
local useTokens = Foundation.Hooks.useTokens
local usePreferences = Foundation.Hooks.usePreferences
local gameTileOverflowMenuAction = DiscoveryAnalytics.Events.gameTileOverflowMenuAction

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiBuilder = SduiCoreSystem.SduiBuilder
local SduiErrors = SduiCoreSystem.SduiErrors
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper
local SduiSharedContent = require(ServerDrivenUiParent.SduiSharedContent)
local SduiPlayButton = SduiSharedContent.SduiPlayButton
local SduiTileOverflowMenu = SduiSharedContent.SduiTileOverflowMenu
local SduiParsers = SduiCoreSystem.SduiParsers
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers
local useUidRefString = SduiCoreSystem.useUidRefString
local findAnalyticsFieldInAncestors = SduiCoreSystem.findAnalyticsFieldInAncestors
local VideoEndReason = require(ServerDrivenUiParent.VideoUtils).AnalyticsEnums.VideoEndReason

local GameTile = require(ServerDrivenUiParent.GameTile)
local default = GameTile.HoverTileCoordinator.default
local ZoomAnimatedFrame = GameTile.ZoomAnimatedFrame
local getGameTileHiddenStore = GameTile.getGameTileHiddenStore
local useTriggerGameTileFeedbackCallbacks = require(ServerDrivenUiParent.GameCollections).useTriggerGameTileFeedbackCallbacks
local getOverflowMenuSignalStore = AppBlox.getOverflowMenuSignalStore
local SduiTile = require(ServerDrivenUi.Content.SduiTile)
local SduiGameVideoThumbnail = require(ServerDrivenUi.Content.SduiGameVideoThumbnail)
local TileHoverShadow = require(ServerDrivenUi.Content.TileHoverShadow)
local SduiGameTileFooter = require(ServerDrivenUi.Content.SduiGameTileFooter)
local SduiHoldToPlay = require(ServerDrivenUi.FocusNavigation.SduiHoldToPlay)
local SduiDefaultTileImage = require(ServerDrivenUi.Content.SduiDefaultTileImage)

local FFlagSduiTileDisableLegacyHover = require(ServerDrivenUi.Flags).FFlagSduiTileDisableLegacyHover
local FFlagEnableGameJoinEarlyAccess = require(ServerDrivenUiParent.SharedFlags).FFlagEnableGameJoinEarlyAccess
local FFlagLuaAppSduiVideoThumbnail = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiVideoThumbnail
local FFlagLuaAppSduiGameTileFeedback = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiGameTileFeedback

local FFlagLuaAppSduiGameTileInteractionFeedback = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiGameTileInteractionFeedback
local FFlagSduiFixSearchTelemetry = require(ServerDrivenUiParent.SharedFlags).FFlagSduiFixSearchTelemetry

local bool1 = game:DefineFastFlag("SduiGameTileDisableDefaultPlayButtonOnHover", false)
local FFlagSduiGameTileEnableHoverInVR = require(ServerDrivenUiParent.SharedFlags).FFlagSduiGameTileEnableHoverInVR
local FFlagSduiGameTileDirectAction = require(ServerDrivenUiParent.SharedFlags).FFlagSduiGameTileDirectAction

local FFlagSduiGameTileUseFooterComponentAsDefault = require(ServerDrivenUiParent.SharedFlags).FFlagSduiGameTileUseFooterComponentAsDefault

local FFlagLuaAppSduiGameTileFooterTrailingComponent = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiGameTileFooterTrailingComponent
local FFlagSduiActiveFriendsFooterTreatment = require(ServerDrivenUiParent.SharedFlags).FFlagSduiActiveFriendsFooterTreatment

local signal = if FFlagLuaAppSduiGameTileFeedback then Signals.createSignal(false) else nil

return React.memo(function(arg1) -- name: SduiGameTile
    local var1 = useTokens()
    local var2 = usePreferences()
    local enableLegacyHoverState = not FFlagSduiTileDisableLegacyHover and arg1.enableLegacyHoverState
    local videoPlaybackContext = if FFlagLuaAppSduiVideoThumbnail then arg1.sduiContext.videoPlaybackContext else nil
    local var3 = React.useRef(nil)

    local current = useUidRefString().current

    local universeId = arg1.universeId
    local placeId = arg1.placeId

    local var4 = React.useRef(nil)
    local setGuiObject = React.useCallback(function(current2)
        var4.current = current2
        if arg1.setGuiObject then
            arg1.setGuiObject(current2)
        end
    end, { arg1.setGuiObject })

    local var6 = nil
    local var7 = nil
    local triggerFeedback = nil
    if FFlagLuaAppSduiGameTileFeedback then
        var6 = not (arg1.overflowMenuComponent == nil or arg1.collectionId == nil or arg1.collectionId == "")
            and arg1.hiddenStateComponent ~= nil

        local var8 = React.useMemo(function()
            if not var6 then
                return signal
            end

            local getHiddenGames = getGameTileHiddenStore(arg1.collectionId).getHiddenGames
            return Signals.createComputed(function(arg2): boolean
                return getHiddenGames(arg2)[universeId] == true
            end)
        end, { var6, arg1.collectionId, universeId })

        var7 = SignalsReact.useSignalState(var8)

        triggerFeedback = arg1.sduiContext.dependencies.triggerFeedback
    end

    local var8 = React.useRef(false)
    local setDisabledForHold = React.useCallback(function(current2: boolean)
        var8.current = current2
    end, {})
    local var10 = nil
    local var11 = nil
    if FFlagLuaAppSduiGameTileInteractionFeedback then
        local var12
        var10, var12 = useTriggerGameTileFeedbackCallbacks(triggerFeedback)
        var11 = var12
    end
    local useCallback = React.useCallback
    local function func1()
        arg1.sduiContext.dependencies.logger.reportCounter(
            SduiErrors.SduiCounterName.GameTileActivated,
            {
                name = GetInputModeStore(false).getLastInputType(false)
            },
            true
        )
        local function logFailure(arg2)
            local var12 = if arg2 then SduiParseHelpers.stringifyValue(arg2) else ""
            local var13 = SduiParseHelpers.stringifyValue(arg1.componentConfig)
            arg1.sduiContext.dependencies.logger.reportError(
                SduiErrors.SduiErrorType.FailedToExecuteAction,
                {
                    componentType = "GameTile",
                    message = `Error executing GameTile.onActivated error: '{var12}' config: {var13}`,
                    name = GetInputModeStore(false).getLastInputType(false)
                },
                arg1.sduiContext.appPage
            )
        end
        local success, result = pcall(function()
            if var8.current then
                arg1.sduiContext.dependencies.logger.reportCounter(
                    SduiErrors.SduiCounterName.GameTileActivatedWhenDisabled,
                    {
                        name = GetInputModeStore(false).getLastInputType(false)
                    }
                )

                return
            end

            if FFlagLuaAppSduiVideoThumbnail and videoPlaybackContext then
                videoPlaybackContext.videoPlaybackCoordinator:reset(VideoEndReason.TileClicked, nil, universeId, nil)
            end

            if arg1.onActivated then
                arg1.onActivated()
                return
            end
            local var12 = SduiParsers.safeParseCallback(
                {
                    actionType = SduiActionType.OpenGameDetails,
                    actionParams = { placeId = placeId, universeId = universeId }
                },
                arg1.sduiContext,
                arg1.analyticsContext
            )

            if not var12 then
                logFailure("Callback is nil after parsing")
                return
            end

            arg1.sduiContext.dependencies.logger.reportCounter(
                SduiErrors.SduiCounterName.GameTileActivatedExecuteCallback,
                {
                    name = GetInputModeStore(false).getLastInputType(false)
                },
                true
            )
            var12()
        end)

        if not success then
            logFailure(result)
        end

        if FFlagLuaAppSduiGameTileInteractionFeedback and var11 then
            var11()
        end
    end

    local onActivated = arg1.onActivated
    local sduiContext = arg1.sduiContext
    local analyticsContext = arg1.analyticsContext

    local componentConfig = arg1.componentConfig
    local var12 = if FFlagLuaAppSduiVideoThumbnail then videoPlaybackContext else nil
    local var13 = if FFlagLuaAppSduiGameTileInteractionFeedback then var11 else nil
    local var5 = useCallback(func1, { onActivated, sduiContext, analyticsContext, placeId, universeId, componentConfig, var12, var13 })

    local isSelected, var16 = React.useState(false)
    local isHovered, var18 = React.useState(false)

    local onSelectionGained = React.useCallback(function()
        var16(true)
        if arg1.setCustomConditionState then
            arg1.setCustomConditionState("selected", true)
        end
    end, { arg1.setCustomConditionState })

    local onSelectionLost = React.useCallback(function()
        var16(false)
        if arg1.setCustomConditionState then
            arg1.setCustomConditionState("selected", false)
        end
    end, { arg1.setCustomConditionState })

    if FFlagLuaAppSduiGameTileFeedback then
        React.useEffect(function()
            if var7 then
                getOverflowMenuSignalStore().closeMenu(current)
                onSelectionLost()
            end
        end, { var7, current, onSelectionLost })
    end

    local var21 = React.useRef(0)

    if isHovered == false then
        var21.current = 0
    end

    local default2 = default.default
    local onMouseEnter = React.useCallback(function()
        if var21.current == 0
            and current
            and (if FFlagSduiGameTileEnableHoverInVR then GetInputModeStore(false).getPreferredInputType(false) == Responsive.Input.Pointer else GetInputModeStore(false).getLastInputType(false) == Responsive.Input.Pointer)
        then
            default2:requestHover(current)
        end
        local var22 = var21
        var22.current += 1
    end, { current })
    local onMouseLeave = React.useCallback(function()
        local var23 = var21
        var23.current -= 1
        if var21.current < 0 then
            var21.current = 0
        end
        if var21.current == 0 and current then
            default2:cancelHover(current)
        end
    end, { current })

    React.useEffect(function()
        local var24 = current
        local bool2 = isHovered

        local connection = default2.changed:connect(function(arg2)
            local bool3 = arg2 == current
            var18(bool3)

            if arg1.setCustomConditionState and bool3 ~= bool2 then
                arg1.setCustomConditionState("hovered", bool3)
            end
            bool2 = bool3
        end)
        return function()
            default2:cancelHover(var24)
            var21.current = 0

            if connection ~= nil then
                connection:disconnect()
            end
        end
    end, { current, arg1.setCustomConditionState })

    local var24 = nil
    local var25

    if FFlagLuaAppSduiGameTileFeedback then
        var24 = React.useCallback(function(bool2: boolean)
            gameTileOverflowMenuAction({
                universeId = universeId,
                sortId = arg1.collectionId,
                actionType = if bool2 then "GameTileOverflowMenuClosed" else "GameTileOverflowMenuOpened"
            }, arg1.sduiContext.appPage)
        end, { universeId, arg1.collectionId, arg1.sduiContext.appPage })

        var25 = React.useCallback(function()
            local overflowMenuSignalStore = getOverflowMenuSignalStore()
            if triggerFeedback and not overflowMenuSignalStore.getIsMenuOpen(current) then
                triggerFeedback(
                    "TileLongPress",
                    "Press",
                    arg1.sduiContext.appPage or "Unknown",
                    {
                        universeId = universeId,
                        sortId = arg1.collectionId
                    }
                )
            end
            overflowMenuSignalStore.openMenu(current)
            var24(false)
        end, {
            triggerFeedback,
            current,
            arg1.sduiContext.appPage,
            arg1.collectionId,
            var24,
            universeId
        })
    else
        var25 = nil
    end

    local onActivatedEffect = React.useCallback(function()
        if isHovered then
            default2:reset()
        end
    end, { isHovered })

    local useMemo = React.useMemo
    local function func2()
        if arg1.ctaButtonComponent then
            return arg1.ctaButtonComponent
        end

        if not isHovered or bool1 and arg1.disableDefaultPlayButtonOnHover then
            return nil
        end

        local analyticsContext2 = SduiBuilder.buildAnalyticsContext({}, arg1.analyticsContext, {
            universeId = universeId,
            placeId = placeId,
            eventContext = if FFlagSduiFixSearchTelemetry then findAnalyticsFieldInAncestors("eventContext", arg1.analyticsContext, "ExperienceTile") else "ExperienceTile",
            referralSource = arg1.sduiContext.appPage
        })

        if not FFlagSduiTileDisableLegacyHover and arg1.enableLegacyHoverState then
            return React.createElement(SduiPlayButton, {
                universeId = universeId,
                placeId = placeId,
                buttonSize = "Medium",
                fillBehavior = "Fill",
                isPlayableWhenLoading = true,
                preferSecondaryPlayButton = true,
                sduiContext = arg1.sduiContext,
                analyticsContext = analyticsContext2,
                enableEarlyAccessState = not FFlagEnableGameJoinEarlyAccess and nil,
                onActivatedEffect = onActivatedEffect,
                enableUiBloxButton = arg1.enableUiBloxButton == nil or arg1.enableUiBloxButton,
                openGameDetailsOnPurchaseRequired = arg1.openGameDetailsOnPurchaseRequired == nil or arg1.openGameDetailsOnPurchaseRequired
            })
        end

        local localization = arg1.sduiContext.dependencies.localization
        local var27 = localizeStrings(localization, { Join = "Common.VisitGame.Label.Play" })

        return React.createElement(SduiPlayButton, {
            universeId = universeId,
            placeId = placeId,
            sduiContext = arg1.sduiContext,
            playableText = var27.Join,
            hidePlayableIcon = true,
            height = 40,
            width = UDim.new(0, 60),
            buttonSize = "Medium",
            analyticsContext = analyticsContext2,
            hideOptionalText = true,
            isPlayableWhenLoading = true,
            preferSecondaryPlayButton = true,
            enableEarlyAccessState = not FFlagEnableGameJoinEarlyAccess and nil,
            onActivatedEffect = onActivatedEffect,
            enableUiBloxButton = arg1.enableUiBloxButton == nil or arg1.enableUiBloxButton,
            openGameDetailsOnPurchaseRequired = arg1.openGameDetailsOnPurchaseRequired == nil or arg1.openGameDetailsOnPurchaseRequired
        })
    end

    local enableLegacyHoverState2 = arg1.enableLegacyHoverState

    local ctaButtonComponent = arg1.ctaButtonComponent
    local analyticsContext2 = arg1.analyticsContext
    local sduiContext2 = arg1.sduiContext

    local enableUiBloxButton = arg1.enableUiBloxButton
    local openGameDetailsOnPurchaseRequired = arg1.openGameDetailsOnPurchaseRequired
    local disableDefaultPlayButtonOnHover = if bool1 then arg1.disableDefaultPlayButtonOnHover else nil
    local var9 = useMemo(func2, {
        isHovered,
        enableLegacyHoverState2,
        universeId,
        placeId,
        ctaButtonComponent,
        analyticsContext2,
        sduiContext2,
        onActivatedEffect,
        enableUiBloxButton,
        openGameDetailsOnPurchaseRequired,
        disableDefaultPlayButtonOnHover
    })

    local var28 = if FFlagSduiTileDisableLegacyHover then nil else React.useCallback(function(offset: number, color3: Color3, offset2: number)
        if not arg1.enableLegacyHoverState then
            return nil
        end

        return React.createElement("Frame", {
            AutomaticSize = Enum.AutomaticSize.Y,
            Position = UDim2.new(0, -offset, 0, -offset),
            Size = UDim2.new(1, offset * 2, 0, 0),
            BackgroundColor3 = color3,
            BorderSizePixel = 0,
            BackgroundTransparency = 0,
            [React.Event.MouseEnter] = onMouseEnter,
            [React.Event.MouseLeave] = onMouseLeave,
            ref = var3
        }, {
            UIListLayout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill
                }
            ),
            UIPadding = React.createElement("UIPadding", {
                PaddingLeft = UDim.new(0, offset),
                PaddingRight = UDim.new(0, offset),
                PaddingBottom = UDim.new(0, offset),
                PaddingTop = UDim.new(0, offset * 2)
            }),
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, offset2) }),
            ctaButtonComponent = var9
        })
    end, {
        var9,
        onMouseEnter,
        onMouseLeave,
        arg1.enableLegacyHoverState
    })

    local element = nil
    if isSelected then
        if arg1.focusNavActionsComponent then
            element = React.cloneElement(arg1.focusNavActionsComponent, { extraLocalProps = { guiObject = var4.current } })
        elseif not arg1.disableHoldToPlay then
            local analyticsContext3 = SduiBuilder.buildAnalyticsContext(
                {},
                arg1.analyticsContext,
                {
                    eventContext = DiscoveryAnalytics.Constants.Context.HoldToPlayLauncher,
                    referralSource = arg1.sduiContext.appPage
                }
            )
            element = React.createElement(SduiHoldToPlay, {
                sduiContext = arg1.sduiContext,
                analyticsContext = analyticsContext3,
                universeId = universeId,
                placeId = arg1.placeId,
                guiObject = var4.current,
                setDisabledForHold = setDisabledForHold
            })
        end
    end

    local useMemo2 = React.useMemo
    local function func3()
        if arg1.disableDefaultFooterLogic then
            return arg1.footerComponent
        end
        return React.createElement(SduiGameTileFooter, {
            isHovered = isHovered,
            isSelected = isSelected,
            ageRatingText = arg1.ageRatingText,
            footerComponent = arg1.footerComponent,
            useFooterComponentAsDefault = if FFlagSduiGameTileUseFooterComponentAsDefault then arg1.useFooterComponentAsDefault else nil,
            sduiContext = arg1.sduiContext,
            universeId = universeId,
            placeId = placeId,
            analyticsContext = arg1.analyticsContext,
            ratingText = arg1.ratingText,
            playerCount = arg1.playerCount,
            metadataFontStyle = arg1.metadataFontStyle,
            activeFriendsFooterComponent = if FFlagSduiActiveFriendsFooterTreatment then arg1.activeFriendsFooterComponent else nil
        })
    end

    local ageRatingText = arg1.ageRatingText
    local disableDefaultFooterLogic = arg1.disableDefaultFooterLogic
    local footerComponent = arg1.footerComponent
    local useFooterComponentAsDefault = if FFlagSduiGameTileUseFooterComponentAsDefault then arg1.useFooterComponentAsDefault else nil
    local sduiContext3 = arg1.sduiContext
    local analyticsContext3 = arg1.analyticsContext
    local ratingText = arg1.ratingText
    local playerCount = arg1.playerCount
    local metadataFontStyle = arg1.metadataFontStyle
    local activeFriendsFooterComponent = if FFlagSduiActiveFriendsFooterTreatment then arg1.activeFriendsFooterComponent else nil
    local var29 = useMemo2(func3, {
        isHovered,
        isSelected,
        universeId,
        placeId,
        ageRatingText,
        disableDefaultFooterLogic,
        footerComponent,
        useFooterComponentAsDefault,
        sduiContext3,
        analyticsContext3,
        ratingText,
        playerCount,
        metadataFontStyle,
        activeFriendsFooterComponent
    })

    local var30 = if FFlagLuaAppSduiGameTileFooterTrailingComponent then React.useMemo(function()
        if not arg1.footerTrailingComponent then
            return var29
        end

        return React.createElement(
            "Frame",
            {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 0)
            },
            {
                UIListLayout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.Name,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill
                }),
                ["1_Footer"] = var29,
                ["2_FooterTrailing"] = arg1.footerTrailingComponent
            }
        )
    end, { arg1.footerTrailingComponent, var29 }) else nil

    local element2

    if FFlagLuaAppSduiGameTileFeedback and var6 and arg1.overflowMenuComponent and not var7 then
        element2 = React.createElement(SduiTileOverflowMenu, {
            componentConfig = arg1.overflowMenuComponent,
            debugName = "SduiGameTile.OverflowMenu",
            directActionComponentConfig = if FFlagSduiGameTileDirectAction then arg1.directActionComponent else nil,
            isHovered = isHovered,
            isSelected = isSelected,
            menuKey = current,
            onMenuOpenChanged = var24,
            parentRef = var4,
            sduiContext = arg1.sduiContext,
            zIndex = 5
        })
    else
        element2 = nil
    end

    local element3

    if FFlagLuaAppSduiVideoThumbnail and arg1.videoPlayer and not (FFlagLuaAppSduiGameTileFeedback and var7) then
        local var31 = arg1.cornerRadius or var1.Radius.Medium

        local imageComponent = arg1.imageComponent
        if not arg1.imageComponent and arg1.image ~= nil then
            imageComponent = React.createElement(SduiDefaultTileImage, {
                image = arg1.image,
                thumbnailBackgroundStyle = arg1.thumbnailBackgroundStyle,
                isContained = arg1.isContained,
                cardCornerRadius = var31
            })
        end

        element3 = React.createElement(SduiGameVideoThumbnail, {
            sduiContext = arg1.sduiContext,
            analyticsContext = arg1.analyticsContext,
            videoPlayer = arg1.videoPlayer,
            imageComponent = imageComponent,
            universeId = universeId,
            placeId = placeId,
            cornerRadius = var31,
            isHovered = isHovered,
            isSelected = isSelected,
            playbackCandidateRef = var4
        })
    else
        element3 = nil
    end

    local element4

    if FFlagLuaAppSduiGameTileFeedback and var7 and arg1.hiddenStateComponent then
        local imageComponent = React.createElement(getSduiComponentWrapper(arg1.hiddenStateComponent), {
            componentConfig = arg1.hiddenStateComponent,
            debugName = "SduiGameTile.HiddenState",
            extraLocalProps = { parentRef = var4 },
            sduiContext = arg1.sduiContext
        })

        element4 = React.createElement(SduiTile, {
            anchorPoint = arg1.anchorPoint,
            automaticSize = arg1.automaticSize,
            backgroundColor3 = arg1.backgroundColor3,
            backgroundStyle = arg1.backgroundStyle,
            containmentPadding = arg1.containmentPadding,
            cornerRadius = arg1.cornerRadius,
            imageAspectRatio = arg1.imageAspectRatio,
            imageComponent = imageComponent,
            isContained = arg1.isContained,
            isDisabled = true,
            isHovered = false,
            layoutOrder = arg1.layoutOrder,
            onMouseEnter = onMouseEnter,
            onMouseLeave = onMouseLeave,
            position = arg1.position,
            sduiContext = arg1.sduiContext,
            selectable = false,
            selectionOrder = arg1.selectionOrder,
            setGuiObject = setGuiObject,
            size = arg1.size,
            testId = "--sdui-game-tile",
            zIndex = arg1.zIndex
        })
    else
        local createElement = React.createElement
        local var31 = SduiTile
        local join = Cryo.Dictionary.join
        local tbl1 = {
            ctaButtonComponent = var9,
            onMouseEnter = onMouseEnter,
            onMouseLeave = onMouseLeave,
            onSelectionGained = onSelectionGained,
            onSelectionLost = onSelectionLost,
            onGuiStateChanged = 0,
            renderLegacyHoverState = 0,
            isHovered = 0,
            imageComponent = 0,
            setGuiObject = 0,
            onActivated = 0,
            onTouchLongPress = 0,
            thumbnailOverflowMenuComponent = 0,
            focusNavActionsComponent = 0,
            footerComponent = 0,
            testId = "--sdui-game-tile"
        }

        if not FFlagLuaAppSduiGameTileInteractionFeedback then
            var10 = nil
        end

        tbl1.onGuiStateChanged = var10

        if FFlagSduiTileDisableLegacyHover then
            var28 = nil
        end

        tbl1.renderLegacyHoverState = var28
        tbl1.isHovered = isHovered
        tbl1.imageComponent = FFlagLuaAppSduiVideoThumbnail and element3 or arg1.imageComponent
        tbl1.setGuiObject = setGuiObject
        tbl1.onActivated = var5
        if not (FFlagLuaAppSduiGameTileFeedback and element2) then
            var25 = nil
        end

        tbl1.onTouchLongPress = var25

        if not FFlagLuaAppSduiGameTileFeedback then
            element2 = nil
        end

        tbl1.thumbnailOverflowMenuComponent = element2
        tbl1.focusNavActionsComponent = element
        if not FFlagLuaAppSduiGameTileFooterTrailingComponent then
            var30 = var29
        end

        tbl1.footerComponent = var30
        element4 = createElement(var31, join(arg1, tbl1))
    end

    if not enableLegacyHoverState then
        return element4
    end

    local xSmall = var1.Gap.XSmall
    return React.createElement(ZoomAnimatedFrame, {
        isZoomEnabled = isHovered and not (FFlagLuaAppSduiGameTileFeedback and var7),
        expansionOffsetX = xSmall * 2,
        expansionOffsetTop = xSmall,
        expansionOffsetBottom = xSmall,
        reducedMotion = var2.reducedMotion
    }, {
        HoverShadow = if isHovered and not (FFlagLuaAppSduiGameTileFeedback and var7) and var3 then React.createElement(
            TileHoverShadow,
            {
                contentRef = var3,
                hoverPadding = arg1.containmentPadding,
                containmentPadding = arg1.containmentPadding
            }
        ) else nil,
        Tile = element4
    })
end)
