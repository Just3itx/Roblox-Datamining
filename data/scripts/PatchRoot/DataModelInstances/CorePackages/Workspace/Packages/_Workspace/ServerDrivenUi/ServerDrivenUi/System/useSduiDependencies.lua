-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local React = require(ServerDrivenUiParent.React)
local LinkingProtocol = require(ServerDrivenUiParent.LinkingProtocol).LinkingProtocol
local useDispatch = require(ServerDrivenUiParent.RoactUtils).Hooks.RoactRodux.useDispatch
local LocalizationRoactContext = require(ServerDrivenUiParent.Localization).LocalizationRoactContext
local useNavigation = require(ServerDrivenUiParent.Navigation).useNavigation
local Foundation = require(ServerDrivenUiParent.Foundation)
local useCursor = Foundation.Hooks.useCursor
local FeedbackManagerInjectionContext = require(ServerDrivenUiParent.UIBlox).Core.Control.FeedbackManagerInjectionContext

local useRoactService = require(ServerDrivenUiParent.RobloxAppHooks).useRoactService
local RoactServiceTags = require(ServerDrivenUiParent.RoactServiceTags)
local AppEventIngestService = RoactServiceTags.AppEventIngestService
local AppSessionService = RoactServiceTags.AppSessionService
local RoactAnalyticsCommonGameEvents = RoactServiceTags.RoactAnalyticsCommonGameEvents
local RoactAnalytics = RoactServiceTags.RoactAnalytics
local RoactNetworking = RoactServiceTags.RoactNetworking

local SduiLogger = require(ServerDrivenUiParent.SduiCoreSystem).SduiLogger

local FFlagLuaAppSduiGameTileFeedback = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiGameTileFeedback

local function useSduiDependencies(instrumentation)
    local dispatch = useDispatch()
    local current = useNavigation()
    local appAnalytics = useRoactService(RoactAnalytics)
    local gameAnalytics = useRoactService(RoactAnalyticsCommonGameEvents)
    local eventIngest = useRoactService(AppEventIngestService)
    local sessionService = useRoactService(AppSessionService)

    local var7 = React.useRef(current)
    var7.current = current
    local getNavigation = React.useCallback(function()
        return var7.current
    end, { var7 })

    local networking = useRoactService(RoactNetworking)
    local localization = React.useContext(LocalizationRoactContext)
    local tileCursor = useCursor(Foundation.Enums.CursorType.RoundedRect)
    local cursors = React.useMemo(function()
        return { tileCursor = tileCursor }
    end, { tileCursor })

    local var13 = nil
    if FFlagLuaAppSduiGameTileFeedback then
        local var1 = React.useContext(FeedbackManagerInjectionContext)
        local var15 = React.useRef(var1)
        var15.current = var1

        var13 = React.useCallback(function(str1: string, arg2, str2: string?, tbl1)
            return var15.current(str1, arg2, str2, tbl1)
        end, { var15 })
    end

    local useMemo = React.useMemo
    local function func1()
        return {
            dispatch = dispatch,
            getNavigation = getNavigation,
            appAnalytics = appAnalytics,
            gameAnalytics = gameAnalytics,
            eventIngest = eventIngest,
            sessionService = sessionService,
            linkingProtocol = LinkingProtocol.default,
            logger = SduiLogger,
            cursors = cursors,
            instrumentation = instrumentation,
            localization = localization,
            networking = networking,
            triggerFeedback = if FFlagLuaAppSduiGameTileFeedback then var13 else nil
        }
    end

    local var14 = if FFlagLuaAppSduiGameTileFeedback then var13 else nil
    return (useMemo(func1, {
        dispatch,
        getNavigation,
        appAnalytics,
        gameAnalytics,
        eventIngest,
        instrumentation,
        sessionService,
        localization,
        networking,
        cursors,
        var14
    }))
end
return useSduiDependencies
