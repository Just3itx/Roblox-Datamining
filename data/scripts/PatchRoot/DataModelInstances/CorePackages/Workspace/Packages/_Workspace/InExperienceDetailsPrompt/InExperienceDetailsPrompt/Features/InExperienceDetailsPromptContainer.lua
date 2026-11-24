-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local InExperienceDetailsPromptParent = script:FindFirstAncestor("InExperienceDetailsPrompt").Parent
local React = require(InExperienceDetailsPromptParent.React)
local SignalsReact = require(InExperienceDetailsPromptParent.SignalsReact)
local DiscoveryEventErrorLogger = require(InExperienceDetailsPromptParent.DiscoveryUtils).DiscoveryEventErrorLogger

local DataHydration = require(InExperienceDetailsPromptParent.DataHydration)
local Game = DataHydration.Game
local VotesUtils = Game.VotesUtils

local EnumGameDetailErrorTypes = require(InExperienceDetailsPromptParent.DiscoveryTypes).EnumGameDetailErrorTypes

local DiscoveryAnalytics = require(InExperienceDetailsPromptParent.DiscoveryAnalytics)
local fireInExperienceDetailsPromptClosedEvent = DiscoveryAnalytics.Events.fireInExperienceDetailsPromptClosedEvent

local fireInExperienceDetailsPromptPlayButtonClickedEvent = DiscoveryAnalytics.Events.fireInExperienceDetailsPromptPlayButtonClickedEvent
local fireInExperienceDetailsPromptLoadedEvent = DiscoveryAnalytics.Events.fireInExperienceDetailsPromptLoadedEvent

local FocusNavigationUtils = require(InExperienceDetailsPromptParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot

local InExperienceDetailsPrompt = require(script.Parent.InExperienceDetailsPrompt)
local FFlagLuaAppIedpOverlayAndNavigationFix = require(InExperienceDetailsPromptParent.SharedFlags).FFlagLuaAppIedpOverlayAndNavigationFix
local FFlagLuaAppIedpFixPlayButton = require(InExperienceDetailsPromptParent.SharedFlags).FFlagLuaAppIedpFixPlayButton

local var1 = if FFlagLuaAppIedpOverlayAndNavigationFix then "InExperienceDetailsPromptClose" else nil

local function getGameDetailErrorType(failed, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if failed == DataHydration.DataStatus.Failed then
        return EnumGameDetailErrorTypes.NetworkError
    end

    if arg1 and arg1.isUnavailable == true then
        return EnumGameDetailErrorTypes.ExperienceUnavailable
    end

    return nil
end

local function InExperienceDetailsPromptContainer(tbl1)
    local gameInfoStore = Game.getGameInfoStore(false)
    local ageRecommendationStore = Game.getAgeRecommendationStore(false)
    local playabilityStore = Game.getPlayabilityStore(false)
    local votesStore = Game.getVotesStore(false)

    local andFetchGameInfo = gameInfoStore.getAndFetchGameInfo(tbl1.universeId)
    local andFetchAgeRecommendation = ageRecommendationStore.getAndFetchAgeRecommendation(tbl1.universeId)
    local andFetchPlayability = playabilityStore.getAndFetchPlayability(tbl1.universeId)
    local andFetchVote = votesStore.getAndFetchVote(tbl1.universeId)

    local var2 = SignalsReact.useSignalState(andFetchGameInfo.data)
    local ageRecommendation = SignalsReact.useSignalState(andFetchAgeRecommendation.data)
    local playability = SignalsReact.useSignalState(andFetchPlayability.data)
    local var5 = SignalsReact.useSignalState(andFetchVote.data)

    local gameInfoRetrievalStatus = SignalsReact.useSignalState(andFetchGameInfo.status)
    local playabilityRetrievalStatus = SignalsReact.useSignalState(andFetchPlayability.status)
    local var8 = if var2 and var2.rootPlaceId then tonumber(var2.rootPlaceId) else nil
    local gameDetailErrorType = getGameDetailErrorType(gameInfoRetrievalStatus, var2)
    local focusRootRef = useFocusRoot(
        {
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
            isIsolated = true,
            isAutoFocusRoot = true
        }
    )

    local onJoin = React.useCallback(function()
        if tbl1.onJoin then
            tbl1.onJoin(var8)
        end
        if var8 then
            fireInExperienceDetailsPromptClosedEvent({
                targetUniverseId = tbl1.universeId,
                targetRootPlaceId = var8,
                closeReason = Enum.PromptExperienceDetailsResult.TeleportAttempted.Name,
                isFullyLoaded = not (gameInfoRetrievalStatus == DataHydration.DataStatus.NotReady)
                    and playabilityRetrievalStatus ~= DataHydration.DataStatus.NotReady,
                isPlayable = playability and playability.isPlayable,
                playabilityStatus = playability and playability.playabilityStatus,
                gameInfoErrorType = gameDetailErrorType
            })
        end
        fireInExperienceDetailsPromptPlayButtonClickedEvent({
            targetUniverseId = tbl1.universeId,
            targetRootPlaceId = var8,
            playabilityRetrievalStatus = playabilityRetrievalStatus
        })
    end, {
        tbl1.onClose,
        var8,
        tbl1.universeId,
        gameInfoRetrievalStatus,
        playabilityRetrievalStatus,
        playability,
        gameDetailErrorType,
        tbl1.onJoin
    })

    local isPlayable = playability and playability.isPlayable
    local playabilityStatus = playability and playability.playabilityStatus

    local onClose = React.useCallback(function()
        tbl1.onClose()
        fireInExperienceDetailsPromptClosedEvent({
            targetUniverseId = tbl1.universeId,
            targetRootPlaceId = var8,
            gameInfoErrorType = gameDetailErrorType,
            closeReason = Enum.PromptExperienceDetailsResult.PromptClosed.Name,
            isPlayable = isPlayable,
            playabilityStatus = playabilityStatus,
            isFullyLoaded = not (gameInfoRetrievalStatus == DataHydration.DataStatus.NotReady)
                and playabilityRetrievalStatus ~= DataHydration.DataStatus.NotReady
        })
    end, {
        tbl1.onClose,
        tbl1.universeId,
        var8,
        gameDetailErrorType,
        isPlayable,
        playabilityStatus,
        gameInfoRetrievalStatus,
        playabilityRetrievalStatus
    })

    local var12 = nil
    if FFlagLuaAppIedpOverlayAndNavigationFix then
        var12 = React.useRef(nil)

        React.useEffect(function()
            ContextActionService:BindCoreAction(var1, function(arg1, userInputState): Enum.ContextActionResult
                if arg1 == var1 and userInputState == Enum.UserInputState.Begin then
                    if var12.current and var12.current.close then
                        var12.current.close()
                    else
                        DiscoveryEventErrorLogger.reportError(
                            "InExperienceDetailsPromptCloseError",
                            "SheetRef containing close function is not defined",
                            {
                                sheetRef = var12,
                                universeId = tbl1.universeId
                            }
                        )
                    end
                end
                return Enum.ContextActionResult.Pass
            end, false, Enum.KeyCode.ButtonB, Enum.KeyCode.Escape, Enum.KeyCode.ButtonStart)

            return function()
                ContextActionService:UnbindCoreAction(var1)
            end
        end, { tbl1.universeId })
    end

    local var13 = React.useRef(false)
    React.useEffect(function()
        if var13.current
            or gameInfoRetrievalStatus == DataHydration.DataStatus.NotReady
            or playabilityRetrievalStatus == DataHydration.DataStatus.NotReady
        then
            return
        end
        fireInExperienceDetailsPromptLoadedEvent({
            targetUniverseId = tbl1.universeId,
            gameInfoRetrievalStatus = gameInfoRetrievalStatus,
            playabilityRetrievalStatus = playabilityRetrievalStatus,
            targetRootPlaceId = var8,
            isPlayable = isPlayable,
            playabilityStatus = playabilityStatus,
            gameInfoErrorType = gameDetailErrorType
        })
        var13.current = true
    end, {
        tbl1.universeId,
        gameInfoRetrievalStatus,
        playabilityRetrievalStatus,
        var8,
        isPlayable,
        playabilityStatus,
        gameDetailErrorType
    })

    return React.createElement(InExperienceDetailsPrompt, {
        name = var2 and var2.name,
        imageUri = var2 and `rbxthumb://type=GameIcon&id={tbl1.universeId}&w=150&h=150`,
        creator = var2 and var2.creator,
        ageRecommendation = ageRecommendation,
        rating = var5 and VotesUtils.getRatingDisplayText(var5),
        playability = playability,
        errorType = gameDetailErrorType,
        rootPlaceId = if FFlagLuaAppIedpFixPlayButton then var8 else nil,
        onJoin = onJoin,
        onClose = onClose,
        focusRootRef = focusRootRef,
        sheetRef = if FFlagLuaAppIedpOverlayAndNavigationFix then var12 else nil,
        playabilityRetrievalStatus = playabilityRetrievalStatus
    })
end

return InExperienceDetailsPromptContainer
