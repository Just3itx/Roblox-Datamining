-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local TextChannelWindowParent = script:FindFirstAncestor("TextChannelWindow").Parent

local SocialLuaAnalytics = require(TextChannelWindowParent.SocialLuaAnalytics)
local LoggingProtocol = require(TextChannelWindowParent.LoggingProtocol)

local module = {}

function module.getChannelCategory(str1: string?): string
    if not str1 or str1 == "" then
        return "none"
    end

    if str1:match("^RBXGeneral") then
        return "general"
    end

    if str1:match("^RBXTeam") then
        return "team"
    end

    if str1:match("^RBXWhisper") then
        return "whisper"
    end

    if str1:match("^RBXSystem") then
        return "system"
    end

    return "custom"
end

function module.getEnableProtectedChat()
    if game:GetEngineFeature("TextChatServiceProtectedChatEnabled") then
        return TextChatService:IsProtectedChatEnabled()
    end
    return false
end

local emitter = SocialLuaAnalytics.Telemetry.createEmitter({
    shouldUseTelemetryService = true,
    telemetryImpl = LoggingProtocol.default,
    defaultTelemetryConfig = {
        throttlingThousandths = 10000,
        links = "https://roblox.atlassian.net/wiki/spaces/SOCIAL/pages/4918804707"
    },
    getSharedInfo = function()
        return {
            enableProtectedChat = module.getEnableProtectedChat()
        }
    end
})

local function passthroughCounterBackend() -- Luacid: unused: defined but never referenced
    return {
        type = "RobloxTelemetryCounter",
        format = function(tbl1, tbl2)
            local var1 = table.clone(tbl1)
            var1.enable_protected_chat = tostring(tbl2.enableProtectedChat)
            return var1
        end
    }
end

module.Counters = {
    Mount = SocialLuaAnalytics.Telemetry.new({
        name = "TextChannelWindowMount",
        description = "Mount outcome per occurrence. result = success | failed | deferred.",
        lastUpdated = { 26, 7, 7 },
        backendsList = {{
            type = "RobloxTelemetryCounter",
            format = function(tbl1, tbl2)
                local var1 = table.clone(tbl1)
                var1.enable_protected_chat = tostring(tbl2.enableProtectedChat)
                return var1
            end
        }},
        throttlingThousandths = game:DefineFastInt("TCWMountCountThrottlePerMyriad", 10000)
    }),
    Send = SocialLuaAnalytics.Telemetry.new({
        name = "TextChannelWindowSend",
        description = "Send outcome per occurrence. result = success | failure.",
        lastUpdated = { 26, 7, 7 },
        backendsList = {{
            type = "RobloxTelemetryCounter",
            format = function(tbl1, tbl2)
                local var1 = table.clone(tbl1)
                var1.enable_protected_chat = tostring(tbl2.enableProtectedChat)
                return var1
            end
        }},
        throttlingThousandths = game:DefineFastInt("TCWSendCountThrottlePerMyriad", 10000)
    }),
    MessageReceived = SocialLuaAnalytics.Telemetry.new({
        name = "TextChannelWindowMessageReceived",
        description = "Receive outcome by TextChatMessage.Status.",
        lastUpdated = { 26, 7, 7 },
        backendsList = {{
            type = "RobloxTelemetryCounter",
            format = function(tbl1, tbl2)
                local var1 = table.clone(tbl1)
                var1.enable_protected_chat = tostring(tbl2.enableProtectedChat)
                return var1
            end
        }},
        throttlingThousandths = game:DefineFastInt("TCWMessageReceivedCountThrottlePerMyriad", 1000)
    })
}

function module.emit(arg1, arg2)
    emitter.emit(arg1, arg2)
end

local bool1 = game:DefineFastFlag("TextChannelWindowEventStreamEnabled", false)

local bool2 = game:DefineFastFlag("TextChannelWindowMessageRenderedEnabled", false)
local num1 = game:DefineFastInt("TextChannelWindowMessageRenderedPermyriad", 0)

function module.getFFlagExpChatTelemetryEnabled(): boolean
    return bool1 and game:GetEngineFeature("ExpChatTelemetryEventTrigger")
end

function module.getFFlagExpChatUseUpdatedMessageRendered(): boolean
    return bool2 and game:GetEngineFeature("ExpChatAddMessageRenderedSurfaceFields")
end

function module.shouldSendMessageRenderedTelemetry(): boolean
    local localPlayer = game:GetService("Players").LocalPlayer
    return if localPlayer then localPlayer.UserId % 10000 < num1 else false
end

module.FIntTextChannelWindowScrollThrottleMs = game:DefineFastInt("TextChannelWindowScrollThrottleMs", 400)

local function throttle(callback: (...any) -> (...any), func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = nil
    return function()
        if var1 then
            return
        end
        callback()
        var1 = task.delay(func1() / 1000, function()
            var1 = nil
        end)
    end
end

function module.createOnScrollCallback(str1: string?)
    if not module.getFFlagExpChatTelemetryEnabled() then
        return nil
    end
    return throttle(function()
        TextChatService:SendExpChatWindowScroll("text_channel_window", str1 or "")
    end, function()
        return module.FIntTextChannelWindowScrollThrottleMs
    end)
end

return module
