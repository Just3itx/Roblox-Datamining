-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useTelemetry = require(AppChat.Telemetry.useTelemetry)

local _MessageFtuxTooltipVariant = require(script.Parent.MessageFtuxTooltipVariant)
local MessageFtuxTooltipDismissSignal = require(script.Parent.MessageFtuxTooltipDismissSignal)
local useMessageFtuxTooltipConfig = require(script.Parent.useMessageFtuxTooltipConfig)
local ChatConversationTelemetryEvents = require(AppChat.Components.ChatConversation.ChatConversationTelemetryEvents)
local ChatConversationTelemetryLayer = require(AppChat.Telemetry.Layers.ChatConversationTelemetryLayer)

local tbl1 = {
    GetItem = function(_, key: string): string
        return AppStorageService:GetItem(key)
    end,
    SetItem = function(_, key: string, str1: string)
        AppStorageService:SetItem(key, str1)
    end,
    Flush = function()
        AppStorageService:Flush()
    end
}

local function useMessageFtuxTooltip(tooltipVariant, tbl2)
    local var1 = tbl2 or tbl1
    local var2 = useMessageFtuxTooltipConfig(tooltipVariant)
    local current = useTelemetry(ChatConversationTelemetryLayer.Context)

    local var4 = React.useRef(current)
    var4.current = current
    local var5 = useLocalUserId() or ""
    local isDismissed, var7 = React.useState(true)
    local var8 = React.useRef({})

    local var9 = React.useCallback(function()
        var4.current.emit(
            ChatConversationTelemetryEvents.ConversationMessageFtuxTooltipImpression,
            { tooltipVariant = tooltipVariant }
        )
    end, { tooltipVariant })

    local var10 = React.useCallback(function()
        var4.current.emit(
            ChatConversationTelemetryEvents.ConversationMessageFtuxTooltipDismissed,
            { tooltipVariant = tooltipVariant }
        )
    end, { tooltipVariant })

    local handleDismiss = React.useCallback(function()
        if isDismissed then
            return
        end
        var10()
        var8.current[var5] = var2.textKey
        local success, _result = pcall(function()
            var1:SetItem(var2.storageKey, HttpService:JSONEncode(var8.current))
            var1:Flush()
        end)
        var7(success)
    end, {
        var2.storageKey,
        var2.textKey,
        var5,
        isDismissed,
        var1,
        var10
    })

    React.useEffect(function()
        local success, result = pcall(function()
            local item = var1:GetItem(var2.storageKey)
            return HttpService:JSONDecode(item)
        end)
        var8.current = not success and {} or result
        local bool1 = var8.current[var5] == var2.textKey
        var7(bool1)
        if not bool1 then
            var9()
        end
    end, {
        var2.storageKey,
        var2.textKey,
        var5,
        var1,
        var9
    })

    React.useEffect(function()
        if isDismissed then
            return
        end

        local connection = MessageFtuxTooltipDismissSignal.dismissed:connect(function(arg2)
            if arg2 == tooltipVariant then
                handleDismiss()
            end
        end)
        return function()
            connection:disconnect()
        end
    end, { tooltipVariant, handleDismiss, isDismissed })

    local var12 = useLocalization({ tooltipText = var2.textKey })

    return React.useMemo(function()
        return {
            text = var12.tooltipText,
            isDismissed = isDismissed,
            handleDismiss = handleDismiss
        }
    end, { var12.tooltipText, isDismissed, handleDismiss })
end

return useMessageFtuxTooltip
