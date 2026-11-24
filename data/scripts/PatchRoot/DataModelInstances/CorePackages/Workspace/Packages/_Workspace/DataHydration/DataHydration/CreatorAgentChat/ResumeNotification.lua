-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local LocalizationService = game:GetService("LocalizationService")

local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local AcpProtocol = require(script.Parent.Acp.AcpProtocol)
local Localization = require(DataHydrationParent.RobloxAppLocales).Localization
local parseFrame = require(script.Parent.Acp.parseFrame)
local _types = require(script.Parent.types)

local tbl1 = { studio_ask_user = true, ask_user = true, present_plan = true, propose_plan = true }

local function extractRawFrame(arg1)
    if typeof(arg1) == "string" then
        return arg1
    end
    if typeof(arg1) ~= "table" then
        return nil
    end
    for _, value in {
        "frame",
        "payload",
        "message",
        "data",
        "body"
    } do
        local var1 = arg1[value]
        if typeof(var1) == "string" and var1 ~= "" then
            return var1
        end
    end
    return nil
end

local function normalizeUniverseId(universeId) -- Luacid: Inlined by compiler; 4 call sites recovered
    if typeof(universeId) == "number" and universeId ~= 0 then
        return universeId
    end
    if typeof(universeId) ~= "string" or universeId == "" then
        return nil
    end

    local var1 = tonumber(universeId)
    return if var1 == nil or var1 == 0 then nil else var1
end

local function getUniverseId(params) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = normalizeUniverseId(params.universeId)
    if var1 ~= nil then
        return var1
    end

    local _roblox = params._meta and params._meta._roblox
    if typeof(_roblox) == "table" then
        return normalizeUniverseId(_roblox.universeId)
    end
    return nil
end

local function valueLooksLikeLocalTool(arg1): boolean -- Luacid: Inlined by compiler; 8 call sites recovered
    return typeof(arg1) == "string" and tbl1[string.lower(arg1)] == true
end

local function updateLooksLikeLocalTool(sessionUpdate) -- Luacid: Inlined by compiler; 1 call site recovered
    if valueLooksLikeLocalTool(sessionUpdate.kind) or valueLooksLikeLocalTool(sessionUpdate.title) then
        return true
    end

    local rawInput = sessionUpdate.rawInput
    return typeof(rawInput) == "table" and (valueLooksLikeLocalTool(rawInput.name) or valueLooksLikeLocalTool(rawInput.toolName))
end

local function getSessionUpdate(arg1)
    if arg1.kind ~= "notification" then
        return nil, nil, nil, nil
    end

    local notification = arg1.notification
    if notification.method ~= AcpProtocol.Notifications.SessionUpdate then
        return nil, nil, nil, nil
    end

    local params = notification.params
    local sessionId = params.sessionId
    local update = params.update
    if typeof(sessionId) ~= "string" or sessionId == "" or typeof(update) ~= "table" then
        return nil, nil, nil, nil
    end

    return update, sessionId, getUniverseId(params), params.pinForBuild == true
end

local function classifyFrame(arg1)
    local var1, sessionId, universeId, var4 = getSessionUpdate(arg1)
    if var1 == nil or sessionId == nil then
        return nil
    end
    if var4 ~= true then
        return nil
    end

    if var1.sessionUpdate == "state_change" and var1.state == "idle" then
        return { kind = "turn_end", sessionId = sessionId, universeId = universeId }
    end

    if var1.sessionUpdate == "tool_call_update" then
        local status = var1.status

        if status ~= "completed" and status ~= "failed" and status ~= "cancelled" and updateLooksLikeLocalTool(var1) then
            local toolCallId = var1.toolCallId
            local tbl2 = {
                kind = "local_tool_call",
                sessionId = sessionId,
                universeId = universeId,
                toolCallId = 0
            }

            if typeof(toolCallId) ~= "string" or toolCallId == "" then
                toolCallId = nil
            end

            tbl2.toolCallId = toolCallId
            return tbl2
        end
    end

    return nil
end

local function getNotificationId(tbl2): string -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl2.kind == "local_tool_call" and tbl2.toolCallId ~= nil then
        return `CreatorAgentResume-{tbl2.sessionId}-{tbl2.toolCallId}`
    end
    return `CreatorAgentResume-{tbl2.sessionId}-{tbl2.kind}`
end

local function getResumeDeepLink(tbl2): string
    local tbl3 = {}
    if tbl2.universeId ~= nil then
        local httpService = HttpService
        local universeId = tbl2.universeId
        table.insert(tbl3, `universeid={httpService:UrlEncode(tostring(universeId))}`)
    end
    table.insert(tbl3, `sessionid={HttpService:UrlEncode(tbl2.sessionId)}`)

    return `roblox://navigation/build?{table.concat(tbl3, "&")}`
end

local function getToastCopy(tbl2)
    local bool1 = tbl2.kind == "local_tool_call"
    local localization = Localization.new(LocalizationService.RobloxLocaleId)
    return {
        title = localization:Format(
            if bool1 then "Feature.Build.Notification.Title.NeedInput" else "Feature.Build.Notification.Title.Finished"
        ),
        label = localization:Format(
            if bool1 then "Feature.Build.Notification.Message.Continue" else "Feature.Build.Notification.Message.Review"
        ),
        dismiss = localization:Format("Feature.Build.Action.Dismiss"),
        resume = localization:Format("Feature.Build.Action.Resume")
    }
end

local function getActionEventParams(tbl2): string -- Luacid: Inlined by compiler; 1 call site recovered
    return HttpService:JSONEncode(
        {
            sessionId = tbl2.sessionId,
            universeId = tbl2.universeId,
            kind = tbl2.kind,
            deepLink = getResumeDeepLink(tbl2)
        }
    )
end

local function getToastVisualItems(tbl2, toastCopy, actionEventParams: string)
    local toastVisualItems = {}

    if tbl2.universeId ~= nil then
        table.insert(
            toastVisualItems,
            {
                thumbnail = {
                    id = tostring(tbl2.universeId),
                    idType = "gameThumbnail",
                    visualItemType = "thumbnail"
                }
            }
        )
    end

    table.insert(toastVisualItems, {
        textBody = {
            title = {
                text = toastCopy.title
            },
            label = {
                text = toastCopy.label
            },
            actions = {},
            eventName = "CreatorAgentResume",
            visualItemType = "textBody",
            actionEventParams = actionEventParams
        }
    })
    table.insert(toastVisualItems, {
        button = {
            label = {
                text = toastCopy.dismiss
            },
            actions = {{ actionType = "dismiss" }},
            buttonStyle = "Secondary",
            eventName = "CreatorAgentResumeDismiss",
            visualItemType = "button"
        }
    })

    table.insert(toastVisualItems, {
        button = {
            label = {
                text = toastCopy.resume
            },
            actions = {},
            buttonStyle = "Primary",
            eventName = "CreatorAgentResume",
            visualItemType = "button",
            actionEventParams = actionEventParams
        }
    })

    return toastVisualItems
end

return {
    NotificationType = "CreatorAgentResume",
    ResumeEventName = "CreatorAgentResume",
    CapRtnNamespace = AcpProtocol.CapRtnNamespace,
    classifyFrame = classifyFrame,
    classifyRtnDetail = function(arg1)
        local var1 = extractRawFrame(arg1)
        if var1 == nil then
            return nil
        end

        local var2 = parseFrame(var1)
        if var2 == nil then
            return nil
        end

        return (classifyFrame(var2))
    end,
    targetMatchesNotification = function(tbl2, tbl3): boolean
        if tbl2 == nil then
            return false
        end

        if tbl2.sessionId ~= nil and tbl2.sessionId ~= "" and tbl2.sessionId == tbl3.sessionId then
            return true
        end

        return not (tbl2.universeId == nil or tbl3.universeId == nil) and tbl2.universeId == tbl3.universeId
    end,
    getNotificationId = getNotificationId,
    getResumeDeepLink = getResumeDeepLink,
    buildToastNotification = function(tbl2)
        local toastCopy = getToastCopy(tbl2)
        local unixTimestampMillis = DateTime.now().UnixTimestampMillis
        local actionEventParams = getActionEventParams(tbl2)
        local id = getNotificationId(tbl2)
        local content = {
            currentState = "Default",
            notificationType = "CreatorAgentResume",
            id = 0,
            minVersion = 0,
            priority = 1,
            clientEventsPayload = 0,
            states = 0
        }
        local tbl4 = {
            notificationType = "CreatorAgentResume",
            deliverTimestamp = unixTimestampMillis,
            notificationReceivedTimestampMs = unixTimestampMillis,
            content = 0
        }
        content.id = id

        content.clientEventsPayload = {}
        content.states = {
            Default = {
                layoutKey = "CreatorAgentResume",
                name = "Default",
                timeOnScreenMs = 12000,
                visualItems = getToastVisualItems(tbl2, toastCopy, actionEventParams)
            }
        }
        tbl4.content = content
        return tbl4
    end
}
