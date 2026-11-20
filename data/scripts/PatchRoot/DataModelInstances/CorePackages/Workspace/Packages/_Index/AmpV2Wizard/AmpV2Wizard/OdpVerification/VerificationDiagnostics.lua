-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local _Types = require(script.Parent.Types)

local function boundedIdentifier(arg1): string? -- Luacid: Inlined by compiler; 4 call sites recovered
    return if typeof(arg1) == "string" and #arg1 <= 128 and string.match(arg1, "^[%w_%-]+$") then arg1 else nil
end

local function boundedMessage(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) ~= "string" or arg1 == "" then
        return nil, nil
    end
    if #arg1 <= 2048 then
        return arg1, false
    end

    return string.sub(arg1, 1, utf8.offset(arg1, 0, 2049) - 1), true
end

return {
    beginAttempt = function(str1: string, method, presentation: string, str2: string?, str3: string?)
        local localPlayer = Players.LocalPlayer
        return {
            schemaVersion = 1,
            attemptId = HttpService:GenerateGUID(false),
            flowId = boundedIdentifier(str2),
            analyticsSessionId = boundedIdentifier(str3),
            odpSessionId = boundedIdentifier(str1),
            childUserIdAtStart = if localPlayer and localPlayer.UserId > 0 then localPlayer.UserId else nil,
            method = method,
            presentation = presentation
        }
    end,
    completeFailure = function(arg1, failureOrigin: string, str1: string?, num1: number?, arg2, arg3)
        local var1 = table.clone(arg1)
        var1.clientOccurredAtMs = DateTime.now().UnixTimestampMillis
        var1.failureOrigin = failureOrigin
        var1.inquiryId = boundedIdentifier(str1)
        if num1 then
            var1.elapsedSinceNativeLaunchMs = math.max(0, math.floor((os.clock() - num1) * 1000))
        end
        if typeof(arg2) == "EnumItem" then
            var1.nativeResultType = arg2.Name
        end

        local debugMessage, debugMessageTruncated = boundedMessage(arg3)
        var1.debugMessage = debugMessage
        var1.debugMessageTruncated = debugMessageTruncated
        return var1
    end
}
