-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local EventIngestService = game:GetService("EventIngestService")
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local FFlagLuaAppDefaultHttpRetry = require(AppChatParent.SharedFlags).FFlagLuaAppDefaultHttpRetry
local _types = require(AppChat.types)

local Constants = require(AppChat.Constants)
local constructGameThumbnailUrl = require(AppChat.Utils.constructGameThumbnailUrl)

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local Signals = require(AppChatParent.Signals)

local EventStream = require(AppChatParent.Analytics).AnalyticsReporters.EventStream
local memo = React.memo
local useCallback = React.useCallback
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useIsExternalNavigationAvailable = require(AppChat.Hooks.useIsExternalNavigationAvailable)
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useMemo = React.useMemo
local useSignalState = require(AppChatParent.SignalsReact).useSignalState

local Logger = require(AppChatParent.Loggers).Logger
local logger = Logger.new(Logger, "GameCardContainer")

local withLocalization = require(AppChatParent.Localization).withLocalization
local GameParams = require(AppChatParent.ExperienceService).GameParams
local EventIngest = require(AppChatParent.Analytics).AnalyticsReporters.EventIngest

local ApiFetchGameDetails = require(AppChatParent.GameDetailRodux).GameDetails.ApiFetchGameDetails
local ApiFetchPlayabilityStatus = require(AppChatParent.PlayabilityRodux).PlayabilityStatus.ApiFetchPlayabilityStatus
local ReportAnEvent = require(script.Parent.ReportAnEvent)

local AppSessionService = require(AppChatParent.RoactServiceTags).AppSessionService
local SessionType = require(AppChatParent.RobloxAppSessionization).SessionType
local RoactServices = require(AppChatParent.RoactServices).RoactServices
local RoactAnalyticsCommonGameEvents = require(AppChatParent.RoactServiceTags).RoactAnalyticsCommonGameEvents

local GameCardGroupable = require(script.Parent.GameCardGroupable)
local GameAssetCard = require(script.Parent.GameAssetCard)
local _MessageGroupShape = require(AppChat.Components.ChatConversation.Grouping.MessageGroupShape)
local DataHydration = require(AppChatParent.DataHydration)
local RoundedVariant = require(AppChat.Enums.RoundedVariant)

local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local ChatConversationTelemetryLayer = require(AppChat.Telemetry.Layers.ChatConversationTelemetryLayer)
local ChatConversationTelemetryEvents = require(script.Parent.Parent.Parent.ChatConversationTelemetryEvents)

local AppGame = RoactServices.AppGame
local ExperienceService = require(AppChatParent.ExperienceService).ExperienceService

local SetGamePlaySession = require(AppChatParent.RobloxAppSessionization).SetGamePlaySession

local HttpRequest = require(AppChatParent.HttpRequest)
local networkImpl = HttpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        logger:info("Fetching: {}", string.format("[ requestMethod = %q, url = %q ]", arg2, arg1))
        return HttpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3)
    end,
    maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("GameCardContainerHttpRetryCount", 4) else nil
})

local EnumScreens = require(AppChat.EnumScreens)
local bool1 = game:DefineFastFlag("AppChatShutdownBeforeLaunch", false)
local FFlagAppChatEarlyTestingLinks = require(AppChat.Flags.FFlagAppChatEarlyTestingLinks)

local tbl1 = {
    networkImpl = networkImpl,
    eventStream = EventStream.new(RbxAnalyticsService),
    eventIngest = EventIngest.new(EventIngestService),
    placeId = nil,
    universeId = nil,
    conversationId = nil,
    luaChatPlayTogetherEnabled = nil,
    onDetailsOpened = function() end,
    onPlayButtonActivated = function(arg1)
        local placeId = arg1.placeId
        local senderUserId = arg1.senderUserId

        SetGamePlaySession(arg1.sessionService, SessionType.StructuralIdentifier.GamePlayFromChat, true)

        ReportAnEvent(arg1, "clickBtnFromLinkCardInChat", "touch")

        if not placeId then
            return
        end

        local function func1(joinAttemptId: string?)
            arg1 = Cryo.Dictionary.join(arg1, { joinAttemptId = joinAttemptId })

            ReportAnEvent(arg1, "gamePlayIntent", "PlayGameFromLinkCard")
        end

        local params = if FFlagAppChatEarlyTestingLinks and arg1.isEarlyTesting then GameParams.fromParams({ placeId = placeId, isEarlyTesting = true }) else GameParams.fromParams({ userId = senderUserId, placeId = placeId })

        if bool1 then
            game:Shutdown()
        end
        ExperienceService:LaunchExperience(params, "PlayGameFromLinkCard", func1)
    end,
    openDetails = function(arg1)
        local universeId = arg1.universeId
        local placeId = arg1.placeId

        ReportAnEvent(arg1, "clickLinkCardInChat", "touch")
        arg1.onDetailsOpened()

        arg1.openGameDetailsPage(universeId, "LuaChatAssetCard")

        local reportOpenGameDetailFromChat = arg1.analytics and arg1.analytics.reportOpenGameDetailFromChat
        if reportOpenGameDetailFromChat then
            reportOpenGameDetailFromChat(placeId, arg1.conversationId, universeId, "GameDetailFromLinkCard")
        end
    end
}

local function getGameDetails(arg1, universeId) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.GameDetails[universeId] or {}
end

local function getGamePlayabilityStatus(arg1, universeId) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.PlayabilityStatus[universeId] or {}
end

function GameCardContainer(arg1)
    local var2 = Cryo.Dictionary.join(tbl1, arg1)
    if not var2.universeId then
        assert("universeId does not exist", "universeId does not exist")
    end

    local details = useSelector(useCallback(function(arg2)
        return (getGameDetails(arg2, var2.universeId))
    end, { var2.universeId }))

    local playabilityStatus = useSelector(useCallback(function(arg2)
        return (getGamePlayabilityStatus(arg2, var2.universeId))
    end, { var2.universeId }))

    local gameThumbnail = constructGameThumbnailUrl(var2.placeId, Constants.GameCard.THUMBNAIL_WIDTH, Constants.GameCard.THUMBNAIL_HEIGHT)

    local gameIcon = `rbxthumb://type=GameIcon&id={var2.universeId}&w={150}&h={150}`

    local var6 = useIsExternalNavigationAvailable({ EnumScreens.GameDetail })

    local placeId = var2.placeId or details.rootPlaceId
    local name = details.name
    local description = details.description or ""
    local price = details.price or 0

    local var8 = useDispatch()
    local function fetchGameData(arg2, arg3)
        var8(ApiFetchGameDetails.Fetch(arg2, { arg3 }))
        var8(ApiFetchPlayabilityStatus.Fetch(arg2, { arg3 }))
    end

    local votesStore = DataHydration.Game.getVotesStore(false)

    local signal = Signals.createSignal(nil)
    local status = Signals.createSignal("NotReady")

    local var9 = useMemo(function()
        if var2.universeId then
            return votesStore.getAndFetchVotes({ var2.universeId })[var2.universeId] or {
                data = signal,
                status = status
            }
        end

        return { data = signal, status = status }
    end, { votesStore, var2.universeId })

    local var10 = useSignalState(var9.data)
    local votesStatus = useSignalState(var9.status)

    local gameRating = useMemo(function()
        if var10 and var10.upVotes and var10.downVotes then
            local var12 = var10.upVotes + var10.downVotes
            if var12 > 0 then
                return tostring(math.floor(var10.upVotes / var12 * 100)) .. "%"
            end
        end
        return "--"
    end, { var10 })

    local var13 = useTelemetry(ChatConversationTelemetryLayer.Context)

    useEffect(function()
        local universeId = var2.universeId

        if not universeId then
            return
        end

        fetchGameData(var2.networkImpl, universeId)
    end, { var2.universeId, var2.networkImpl })

    local var14 = useCallback(function()
        var13.emit(
            ChatConversationTelemetryEvents.GameCardThumbnailClicked,
            {
                universeId = var2.universeId,
                placeId = placeId
            }
        )
        var2.openDetails(var2)
    end, {
        var13,
        var2.openDetails,
        var2.universeId,
        placeId
    })
    local var15 = useCallback(function()
        var13.emit(
            ChatConversationTelemetryEvents.GameCardPlayButtonClicked,
            {
                universeId = var2.universeId,
                placeId = placeId
            }
        )
        var2.onPlayButtonActivated(var2)
    end, {
        var13,
        var2.onPlayButtonActivated,
        var2.universeId,
        placeId,
        var2.isEarlyTesting
    })
    local var16 = useCallback(function()
        var13.emit(ChatConversationTelemetryEvents.GameCardMetadataClicked, { universeId = var2.universeId, placeId = placeId })

        var2.openDetails(var2)
    end, {
        var13,
        var2.openDetails,
        var2.universeId,
        placeId
    })

    local function renderCard(arg2)
        local isLoading = not (arg2.universeId and arg2.gameName)
            or not arg2.gameThumbnail
            or arg2.votesStatus == "NotReady"
            or not arg2.gamePlayerCount
        local onThumbnailActivated = if arg2.openDetails then var14 else nil
        local onPlayButtonActivated = if arg2.onPlayButtonActivated then var15 else nil
        local onMetadataActivated = if arg2.openDetails then var16 else nil

        if arg2.groupShape then
            return React.createElement(GameAssetCard, {
                gameName = arg2.gameName,
                gameThumbnail = arg2.gameThumbnail,
                gameRating = arg2.gameRating,
                gamePlayerCount = arg2.gamePlayerCount,
                isLoading = isLoading,
                onPlayButtonActivated = onPlayButtonActivated,
                playButtonLabel = arg2.playButtonLabel,
                onThumbnailActivated = onThumbnailActivated,
                onMetadataActivated = onMetadataActivated,
                groupShape = arg2.groupShape,
                mediaRef = arg2.mediaRef,
                LayoutOrder = arg2.layoutOrder
            })
        end

        local bool3 = if arg2.isPlayButtonEnabled and arg2.playabilityStatus then arg2.playabilityStatus.isPlayable == true else false

        if FFlagAppChatEarlyTestingLinks and arg2.isPlayButtonEnabled and arg2.isEarlyTesting then
            bool3 = true
        end

        local thumbnailRoundedVariant = if arg2.isStartOfGroup then RoundedVariant.Top elseif arg2.isIncoming then RoundedVariant.TopRight else RoundedVariant.TopLeft
        return React.createElement(GameCardGroupable, {
            gameName = arg2.gameName,
            gameDescription = arg2.gameDescription,
            gameThumbnail = arg2.gameThumbnail,
            gameRating = arg2.gameRating,
            gamePlayerCount = arg2.gamePlayerCount,
            thumbnailAspectRatio = 16 / 9,
            thumbnailRoundedVariant = thumbnailRoundedVariant,
            shouldShowPlayButton = bool3,
            onPlayButtonActivated = onPlayButtonActivated,
            playButtonLabel = arg2.playButtonLabel,
            onThumbnailActivated = onThumbnailActivated,
            onMetadataActivated = onMetadataActivated,
            isRepliedTo = arg2.isRepliedTo,
            isIncoming = arg2.isIncoming,
            isPending = arg2.isPending,
            isLoading = isLoading,
            LayoutOrder = arg2.layoutOrder
        })
    end

    return withLocalization({
        purchaseGameText = "Feature.GameDetails.Heading.PurchaseGame",
        viewDetailsText = "Feature.Chat.Action.ViewAssetDetails",
        playText = "Common.VisitGame.Label.Play",
        noDescriptionText = "Feature.Chat.Label.NoDescriptionYet",
        previewText = "Feature.ExperienceDetails.PlayButtonText.Playtest"
    })(
        function(arg2)
            local var17 = Cryo.Dictionary.join(var2, {
                details = details,
                playabilityStatus = playabilityStatus,
                gameIcon = gameIcon,
                placeId = placeId,
                gameName = name,
                gameDescription = description,
                gamePrice = price,
                isPlayButtonEnabled = true,
                viewDetailsEnabled = var6[EnumScreens.GameDetail],
                fetchGameData = fetchGameData,
                gameThumbnail = gameThumbnail,
                gameRating = gameRating,
                gamePlayerCount = details.playing or 0,
                votesStatus = votesStatus,
                playButtonLabel = if FFlagAppChatEarlyTestingLinks and var2.isEarlyTesting then arg2.previewText else nil
            })

            return renderCard(var17)
        end
    )
end

return RoactServices.connect(
    {
        game = AppGame,
        sessionService = AppSessionService,
        analytics = RoactAnalyticsCommonGameEvents
    }
)(
    memo(GameCardContainer)
)
