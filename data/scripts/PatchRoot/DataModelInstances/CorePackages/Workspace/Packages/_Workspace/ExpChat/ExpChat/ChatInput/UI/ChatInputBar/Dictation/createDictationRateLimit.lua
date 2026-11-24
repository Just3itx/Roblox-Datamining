-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local Signal = require(ExpChatParent.AppCommonLib).Signal
local var1 = require(ExpChatParent.ExpChatShared).Logger:new("ExpChat/" .. script.Name)

local function createDictationRateLimit(tbl1)
    local signal = Signal.new()

    return {
        stopRequested = signal,
        onIncomingMessage = function(arg1, userId: number?): boolean
            if not tbl1.getIsListening() or userId == nil then
                return false
            end
            if arg1.Status ~= Enum.TextChatMessageStatus.Floodchecked then
                return false
            end

            local textSource = arg1.TextSource
            if textSource ~= nil and textSource.UserId ~= userId then
                return false
            end

            local success, result = pcall(function()
                signal:fire()
            end)
            if not success then
                var1:error("Failed to stop dictation after a rate limit: {}", tostring(result))
            end
            return true
        end,
        getStoppedMessage = function(arg1)
            local success, result = pcall(function()
                return arg1:FormatByKey("CoreScripts.TextChat.MessageStatus.Warning.DictationRateLimited")
            end)
            return if success then result else ""
        end
    }
end
return createDictationRateLimit
