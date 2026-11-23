-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)

local ChatLandingTelemetryEvents = require(AppChat.Components.ChatLanding.ChatLandingTelemetryEvents)
local ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)
local ChatSearchResultType = require(AppChat.Analytics.Enums.ChatSearchResultType)
local _useConversationSearch = require(AppChat.Hooks.useConversationSearch)
local useTelemetry = require(AppChat.Telemetry.useTelemetry)

local function useChatSearchResultsTelemetry(arg1, num1: number?)
    local var1 = useTelemetry(ChatLandingTelemetryLayer.Context)
    local var2 = React.useRef(var1.emit)
    var2.current = var1.emit
    local var3 = React.useRef(nil)

    local var4 = React.useRef({ query = "", startedAt = 0 })
    local var5 = React.useRef({ query = "", startedAt = 0 })

    local debouncedQuery = arg1.debouncedQuery

    if var5.current.query ~= debouncedQuery then
        var4.current = {
            query = debouncedQuery,
            startedAt = if debouncedQuery == "" then 0 else os.clock()
        }
    end

    React.useLayoutEffect(function()
        var5.current = var4.current
    end, { debouncedQuery })

    local searchResultCount = num1 == nil and #arg1.items or num1
    local hasError = arg1.hasError
    local var7 = not (debouncedQuery == "") and arg1.isActive and not arg1.isAwaitingResults

    React.useEffect(function()
        if not var7 then
            if debouncedQuery == "" then
                var3.current = nil
            end

            return
        end

        if var3.current == debouncedQuery then
            return
        end

        var3.current = debouncedQuery

        var2.current(ChatLandingTelemetryEvents.SearchResultsRendered, {
            searchResultCount = searchResultCount,
            searchResultType = if hasError then ChatSearchResultType.Error elseif searchResultCount == 0 then ChatSearchResultType.NoResults else ChatSearchResultType.Results,
            searchLatencyMs = math.round((os.clock() - var5.current.startedAt) * 1000)
        })
    end, {
        var7,
        debouncedQuery,
        searchResultCount,
        hasError
    })
end
return useChatSearchResultsTelemetry
