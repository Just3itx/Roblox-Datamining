-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local var1 = require(AppChat.Logger):new("AppChatPerf")
local TimeToInteractiveTracker = require(AppChatParent.TimeToInteractiveTracker).TimeToInteractiveTracker
local Milestone = TimeToInteractiveTracker.Milestone
local PageGate = require(AppChatParent.PageGate)
local FFlagEnablePLTPrefetchCallbacks = PageGate.FFlagEnablePLTPrefetchCallbacks
local Cryo = require(AppChatParent.Cryo)
local _SocialCommon = require(AppChatParent.SocialCommon)

local AppChatPerfEventInfo = require(AppChat.Telemetry.AppChatPerfEventInfo)
local _ChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext)

local tbl1 = { started = false, interactive = false, interactiveTimestamp = nil, eventName = nil }

local tbl2 = ({})

local function getTTIState(arg1) -- Luacid: Inlined by compiler; 9 call sites recovered
    if not tbl2[arg1] then
        tbl2[arg1] = table.clone(tbl1)
    end
    return tbl2[arg1]
end

local var2 = nil
local tbl3 = ({})

local getSharedContext = {
    category = AppChatPerfEventInfo.TTI_CATEGORY
}

local var3 = nil

local function matchConversation(tbl5)
    if tbl5.conversationId and var2 and tbl5.conversationId ~= var2 then
        return false, "conversation_id_mismatch"
    end
    return true, nil
end

local tbl5 = {
    getColdStart = function(_): boolean -- name: noColdStart
        return false
    end,
    isContextMatching = matchConversation,
    useBaseName = true,
    noInteractiveState = true
}

local tbl6 = {
    ChatLandingTTI = {
        getColdStart = function(tbl6): boolean
            return tbl6.coldStart == true
        end,
        isContextMatching = function(_) -- name: alwaysMatch
            return true, nil
        end
    },
    ChatConversationTTI = {
        getColdStart = function(tbl6): boolean
            local conversationId = tbl6.conversationId
            local bool1 = not (conversationId == nil) and not tbl3[conversationId]

            if conversationId then
                tbl3[conversationId] = true
            end
            return bool1
        end,
        isContextMatching = matchConversation,
        onStart = function(tbl6) -- name: onStartConversation
            local conversationId = tbl6.conversationId
            if conversationId == nil or conversationId == var2 then
                return
            end

            var2 = conversationId

            if var3 then
                var3("ChatConversationTTI")
            end
        end
    },
    MessageSendTTI = tbl5,
    MessageReceiveTTI = tbl5
}

local function buildTTIMetadata(arg1, tbl7)
    local tTiPage = AppChatPerfEventInfo.getTTIPage(arg1)
    return Cryo.Dictionary.join(getSharedContext, { subcategory = tTiPage, page = tTiPage }, tbl7 or {})
end

local module = {}

function module.setSharedContext(tbl7)
    getSharedContext = Cryo.Dictionary.join(getSharedContext, tbl7)
    var1:debug(
        "Shared context updated: placement={}, entryPoint={}, hasActiveParty={}",
        tbl7.placement or "nil",
        tbl7.entryPoint or "nil",
        tbl7.hasActiveParty or false
    )
end

function module.getSharedContext()
    return getSharedContext
end

function module.setOnConversationSwitch(func1: (...any) -> (...any))
    var3 = func1
end

function module.start(arg1, tbl7): boolean
    local var4 = tbl2[arg1]
    if var4 and var4.started then
        var1:debug("TTI Start ignored: {} (reason=already_started, eventName={})", arg1, var4.eventName)
        return false
    end

    local var5 = tbl6[arg1]

    if var5.onStart then
        var5.onStart(tbl7)
    end

    local coldStart = var5.getColdStart(tbl7)
    local eventName = if var5.useBaseName then AppChatPerfEventInfo.getTTIBaseName(arg1) else AppChatPerfEventInfo.buildTTIEventName(arg1, getSharedContext.placement, coldStart)
    tbl2[arg1] = {
        started = true,
        interactive = false,
        interactiveTimestamp = nil,
        eventName = eventName
    }

    var1:debug(
        "TTI Start: {} (coldStart={}, conversationId={}, entryPoint={})",
        eventName,
        coldStart,
        tbl7.conversationId,
        tbl7.entryPoint
    )

    TimeToInteractiveTracker.trackStart(eventName)
    TimeToInteractiveTracker.updateMetadata(
        eventName,
        buildTTIMetadata(arg1, Cryo.Dictionary.join(tbl7, { coldStart = coldStart }))
    )
    return true
end

function module.finish(arg1, tbl7): boolean
    local var4 = tbl6[arg1]
    local tTiState = getTTIState(arg1)

    if not tTiState.started then
        var1:debug("TTI End ignored: {} (reason=not_started)", arg1)
        return false
    end

    local var5, var6 = var4.isContextMatching(tbl7)
    if not var5 then
        var1:debug("TTI End ignored: {} (reason={})", arg1, var6 or "unknown")
        return false
    end

    local eventName = tTiState.eventName
    if eventName == nil then
        var1:debug("TTI End ignored: {} (reason=missing_event_name)", arg1)
        return false
    end

    var1:debug("TTI End: {} (numElementsRendered={})", eventName, tbl7.numElementsRendered)
    TimeToInteractiveTracker.updateMetadata(eventName, buildTTIMetadata(arg1, tbl7))

    if TimeToInteractiveTracker.trackMilestone then
        TimeToInteractiveTracker.trackMilestone(eventName, Milestone.SurfaceReady)
    end

    if FFlagEnablePLTPrefetchCallbacks and arg1 == "ChatLandingTTI" then
        PageGate.signal(PageGate.Page.Party, PageGate.Milestone.SurfaceReady)
    end

    TimeToInteractiveTracker.trackEnd(eventName)

    tTiState.started = false
    if not var4.noInteractiveState then
        tTiState.interactive = true
        tTiState.interactiveTimestamp = os.clock()
    end
    tTiState.eventName = nil
    return true
end

function module.cancel(arg1, _): boolean
    local tTiState = getTTIState(arg1)

    if not tTiState.started then
        var1:debug("TTI Cancel ignored: {} (reason=not_started)", arg1)
        return false
    end

    local eventName = tTiState.eventName
    if eventName == nil then
        var1:debug("TTI Cancel ignored: {} (reason=missing_event_name)", arg1)
        return false
    end

    var1:debug("TTI Cancel: {}", eventName)
    TimeToInteractiveTracker.resetEvent(eventName)

    tTiState.started = false
    tTiState.interactive = false
    tTiState.interactiveTimestamp = nil
    tTiState.eventName = nil
    return true
end

function module.isActive(arg1, tbl7)
    local var4 = tbl6[arg1]

    if not getTTIState(arg1).started then
        return false
    end

    return (var4.isContextMatching(tbl7))
end

function module.trackMilestone(arg1, arg2, tbl7): boolean
    if not TimeToInteractiveTracker.trackMilestone then
        return false
    end
    local var4 = tbl6[arg1]
    local tTiState = getTTIState(arg1)

    if not (tTiState.started and tTiState.eventName) then
        return false
    end
    if not var4.isContextMatching(tbl7) then
        return false
    end
    var1:debug("TTI Milestone: {} -> {}", tTiState.eventName, arg2)
    TimeToInteractiveTracker.trackMilestone(tTiState.eventName, arg2)
    return true
end

function module.trackSubphase(arg1, arg2, arg3, tbl7): boolean
    if not TimeToInteractiveTracker.trackSubphase then
        return false
    end
    local var4 = tbl6[arg1]
    local tTiState = getTTIState(arg1)

    if not (tTiState.started and tTiState.eventName) then
        return false
    end
    if not var4.isContextMatching(tbl7) then
        return false
    end
    var1:debug("TTI Subphase: {} -> {}.{}", tTiState.eventName, arg2, arg3)
    TimeToInteractiveTracker.trackSubphase(tTiState.eventName, arg2, arg3)
    return true
end

function module.trackRequest(arg1, arg2, str1: string, tbl7): boolean
    if not TimeToInteractiveTracker.trackRequest then
        return false
    end
    local var4 = tbl6[arg1]
    local tTiState = getTTIState(arg1)

    if not (tTiState.started and tTiState.eventName) then
        return false
    end
    if not var4.isContextMatching(tbl7) then
        return false
    end
    var1:debug("TTI Request: {} -> {}.{}", tTiState.eventName, arg2, str1)
    TimeToInteractiveTracker.trackRequest(tTiState.eventName, arg2, str1)
    return true
end

function module.getEventName(arg1)
    local tTiState = getTTIState(arg1)
    return if tTiState.started then tTiState.eventName else nil
end

module.Milestone = Milestone
module.Hooks = TimeToInteractiveTracker.Hooks

function module.isInteractive(arg1)
    return getTTIState(arg1).interactive
end

function module.getInteractiveTimestamp(arg1)
    return getTTIState(arg1).interactiveTimestamp
end

return module
