-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local EnumScreens = require(AppChat.EnumScreens)
local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)
local SearchRow = require(AppChatParent.SocialCommon.SearchRow)

local React = require(AppChatParent.React)
local SignalsReact = require(AppChatParent.SignalsReact)
local useSignalBinding = SignalsReact.useSignalBinding
local useSignalState = SignalsReact.useSignalState
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)
local ChatLandingTelemetryEvents = require(AppChat.Components.ChatLanding.ChatLandingTelemetryEvents)

local function getFilterText(arg1)
    return GetTopBarStore(arg1).getScreenTopBar(EnumScreens.ChatLanding)(arg1).filterText or ""
end

local function getShouldAutoFocus(arg1)
    return GetTopBarStore(arg1).getScreenTopBar(EnumScreens.ChatLanding)(arg1).shouldAutoFocusCenter or false
end

local function ChatLandingSearchRow(tbl1)
    local bool1 = tbl1.hasExit ~= false
    local reportFocusAsSearchEntry = tbl1.reportFocusAsSearchEntry
    local setScreenTopBar = GetTopBarStore(false).setScreenTopBar

    local text = useSignalBinding(getFilterText)
    local shouldAutoFocus = useSignalState(getShouldAutoFocus)

    local var3 = useTelemetry(ChatLandingTelemetryLayer.Context)
    local var4 = useLocalization({ cancelText = "Feature.Chat.Action.Cancel", placeholder = "Feature.Chat.Label.SearchWord" })

    React.useEffect(function()
        if shouldAutoFocus then
            setScreenTopBar(EnumScreens.ChatLanding, { shouldAutoFocusCenter = false })
        end
    end, { shouldAutoFocus, setScreenTopBar })

    local onChanged = React.useCallback(function(filterText: string)
        setScreenTopBar(EnumScreens.ChatLanding, { filterText = filterText })
    end, { setScreenTopBar })

    local var6 = React.useCallback(function()
        setScreenTopBar(EnumScreens.ChatLanding, { shouldRenderCenter = false, filterText = "" })
    end, { setScreenTopBar })

    local var7 = React.useCallback(function()
        var3.emit(ChatLandingTelemetryEvents.ChatLandingSearchBtnClicked, {})
    end, { var3 })

    local createElement = React.createElement
    local var8 = SearchRow
    local tbl2 = {
        text = text,
        placeholder = var4.placeholder,
        onChanged = onChanged,
        onExit = 0,
        exitVariant = 0,
        cancelText = 0,
        shouldAutoFocus = 0,
        onFocusGained = 0,
        height = 0,
        paddingHorizontal = 0,
        LayoutOrder = 0,
        testId = 0,
        exitTestId = "ChatLandingSearch"
    }

    if not bool1 then
        var6 = nil
    end

    tbl2.onExit = var6
    tbl2.exitVariant = tbl1.exitVariant
    tbl2.cancelText = var4.cancelText
    tbl2.shouldAutoFocus = shouldAutoFocus
    if not reportFocusAsSearchEntry then
        var7 = nil
    end

    tbl2.onFocusGained = var7
    tbl2.height = tbl1.height
    tbl2.paddingHorizontal = tbl1.paddingHorizontal
    tbl2.LayoutOrder = tbl1.LayoutOrder
    tbl2.testId = tbl1.testId or "ChatSearchField"
    return createElement(var8, tbl2)
end

return ChatLandingSearchRow
