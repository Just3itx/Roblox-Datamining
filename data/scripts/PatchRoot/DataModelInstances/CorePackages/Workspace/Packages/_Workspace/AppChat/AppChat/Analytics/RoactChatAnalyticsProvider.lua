-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local SocialLuaAnalytics = require(scriptParentParentParent.SocialLuaAnalytics)
local AnalyticsFactory = SocialLuaAnalytics.Analytics.AnalyticsFactory
local DefaultAnalyticsService = SocialLuaAnalytics.Analytics.DefaultAnalyticsService

local EventStreamActionList = require(script.Parent.EventStreamActionList)
local DiagActionList = require(script.Parent.DiagActionList)

local React = require(scriptParentParentParent.React)
local GetFFlagIsSquadEnabled = require(scriptParentParentParent.SharedFlags).GetFFlagIsSquadEnabled
local RoactChatAnalyticsContext = require(script.Parent.RoactChatAnalyticsContext)
local Logger = require(script.Parent.Logger)

local ChatEntryPointNames = require(scriptParentParentParent.SocialCommon).Enums.ChatEntryPointNames

local useSelector = require(scriptParentParentParent.RoactUtils).Hooks.RoactRodux.useSelector

return function(tbl1)
    local entryPoint = tbl1.entryPoint
    if not (entryPoint and ChatEntryPointNames[entryPoint]) then
        Logger:warning("entryPoint=" .. tostring(entryPoint) .. " is not a reigstered value.")
        entryPoint = ChatEntryPointNames.Unknown
    end

    local var1 = if GetFFlagIsSquadEnabled() then useSelector(function(arg1)
        local currentSquad = arg1.Squad and arg1.Squad.Squad and arg1.Squad.Squad.currentSquad
        return if currentSquad and currentSquad.squadId then currentSquad.squadId else nil
    end) else nil

    local playSessionId = RbxAnalyticsService:GetPlaySessionId()

    local value = React.useMemo(function()
        return AnalyticsFactory.setUpAnalyticsFactory({
            eventLists = { EventStream = EventStreamActionList, Diag = DiagActionList },
            analyticsImpl = {
                EventStream = DefaultAnalyticsService.EventStream,
                Diag = DefaultAnalyticsService.Diag
            },
            staticInfoForAllEvents = {
                squadId = if GetFFlagIsSquadEnabled() then var1 else nil,
                entryPoint = entryPoint,
                channelsApiEnabled = true,
                playSessionId = playSessionId
            }
        })()
    end, { var1, entryPoint, playSessionId })

    return React.createElement(RoactChatAnalyticsContext.Provider, { value = value }, tbl1.children)
end
