-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)

local ChatActiveFilter = require(AppChat.Analytics.Enums.ChatActiveFilter)
local ChatLandingTelemetryEvents = require(AppChat.Components.ChatLanding.ChatLandingTelemetryEvents)
local ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)
local ChatLandingTelemetryState = require(AppChat.Contexts.TelemetryState.ChatLandingTelemetryState)
local useTelemetry = require(AppChat.Telemetry.useTelemetry)

local function useChatSearchSession(bool1: boolean, bool2: boolean)
    local var1 = ChatLandingTelemetryState.useMergeState()
    local var2 = useTelemetry(ChatLandingTelemetryLayer.Context)
    local var3 = React.useRef(nil)
    local var4 = React.useRef(nil)

    local var5 = React.useRef(var2.emit)
    var5.current = var2.emit

    local var6 = React.useCallback(function()
        if var3.current == nil then
            return
        end
        var3.current = nil
        var1({ searchSessionId = Cryo.None, activeFilters = Cryo.None })
    end, { var1 })

    if bool1 and var3.current == nil then
        var3.current = HttpService:GenerateGUID(false)

        local tbl1 = {
            searchSessionId = var3.current,
            activeFilters = { if bool2 then ChatActiveFilter.SearchServer else ChatActiveFilter.SearchClient }
        }
        var1(tbl1)
    elseif not bool1 then
        var6()
    end

    React.useEffect(function()
        if not bool1 then
            return
        end

        local current = var3.current
        if current == nil or var4.current == current then
            return
        end
        var4.current = current
        var5.current(ChatLandingTelemetryEvents.SearchStarted, {})
    end, {
        bool1,
        bool2,
        var1,
        var6
    })

    React.useEffect(function()
        return var6
    end, {})
end

return useChatSearchSession
