-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local isEnabled = game:DefineFastFlag("DebugMyStatsExperienceStats", false)

local var1 = nil
local var2 = nil
local var3 = nil

local function roundSec(num1: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return math.floor(num1 * 1000 + 0.5) / 1000
end

local function timelineFields()
    local now = os.clock()
    local tbl1 = {
        tSec = roundSec(now - (var1 or now))
    }
    if var2 ~= nil then
        tbl1.timeline = var2
    end
    if var3 ~= nil then
        tbl1.dtSec = roundSec(now - var3)
    end
    var3 = now
    return tbl1
end

local function mergeTimeline(detail)
    local tbl1 = timelineFields()
    if detail == nil then
        return tbl1
    end
    if typeof(detail) ~= "table" then
        return {
            detail = detail,
            tSec = tbl1.tSec,
            dtSec = tbl1.dtSec,
            timeline = tbl1.timeline
        }
    end
    local var4 = table.clone(detail)
    for value, value2 in tbl1 do
        var4[value] = value2
    end
    return var4
end

local function encode(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(HttpService.JSONEncode, HttpService, arg1)
    if success and typeof(result) == "string" then
        return result
    end
    return tostring(arg1)
end

local function previewString(arg1, num1: number?) -- Luacid: unused: defined but never referenced
    if typeof(arg1) ~= "string" then
        return nil
    end
    local num2 = num1 or 120

    if #arg1 <= num2 then
        return arg1
    end

    return string.sub(arg1, 1, num2) .. "..."
end

local function formatRequestState(arg1)
    if typeof(arg1) ~= "table" then
        return {
            raw = tostring(arg1)
        }
    end

    return {
        status = arg1.status,
        error = arg1.error,
        errorCode = arg1.errorCode,
        result = arg1.result
    }
end

return {
    isEnabled = function()
        return isEnabled
    end,
    log = function(str1: string, str2: string, detail)
        if not isEnabled then
            return
        end

        local str3 = ` | {encode((mergeTimeline(detail)))}`
        if str1 == "warn" then
            warn(`[MyStats] {str2}{str3}`)
            return
        end
        print(`[MyStats] {str2}{str3}`)
    end,
    resetTimeline = function(str1: string?)
        var1 = os.clock()
        var2 = str1
        var3 = nil
    end,
    timelineFields = timelineFields,
    formatStudioAskUserQuestions = function(arg1)
        if typeof(arg1) ~= "table" then
            return {
                raw = tostring(arg1)
            }
        end
        local num1 = 0
        local num2 = 0
        local question = nil
        local title = nil

        for _, value in arg1 do
            if typeof(value) ~= "table" then
                continue
            end

            num1 += 1
            if question == nil then
                question = value.question

                if typeof(question) ~= "string" then
                    question = nil
                elseif not (#question <= 120) then
                    question = string.sub(question, 1, 120) .. "..."
                end
            end
            local options = value.options
            if typeof(options) ~= "table" then
                continue
            end

            for _, option in options do
                num2 += 1
                if title ~= nil or typeof(option) ~= "table" then
                    continue
                end

                title = option.title

                if typeof(title) ~= "string" then
                    title = nil
                elseif not (#title <= 120) then
                    title = string.sub(title, 1, 120) .. "..."
                end
            end
        end

        return {
            questionCount = num1,
            totalOptionCount = num2,
            firstQuestion = question,
            firstOption = title
        }
    end,
    formatToolResultPayload = function(arg1)
        if typeof(arg1) ~= "table" then
            return {
                raw = tostring(arg1)
            }
        end
        local content = arg1.content
        local text = if typeof(content) == "table" then content.text else nil
        local tbl1 = {
            sessionId = arg1.sessionId,
            turnId = arg1.turnId,
            referenceId = arg1.referenceId,
            isError = arg1.isError,
            textLength = typeof(text) == "string" and #text or nil,
            textPreview = 0
        }

        if typeof(text) ~= "string" then
            text = nil
        elseif not (#text <= 160) then
            text = string.sub(text, 1, 160) .. "..."
        end

        tbl1.textPreview = text
        return tbl1
    end,
    formatRequestState = formatRequestState,
    formatTurnState = function(arg1)
        if typeof(arg1) ~= "table" then
            return {
                raw = tostring(arg1)
            }
        end

        return {
            status = arg1.status,
            isDone = arg1.isDone,
            error = arg1.error,
            errorCode = arg1.errorCode,
            stopReason = arg1.stopReason,
            assistantTextLength = typeof(arg1.assistantText) == "string" and #arg1.assistantText or nil,
            toolCallCount = arg1.toolCallCount,
            sessionId = arg1.sessionId
        }
    end,
    rpcFailureMessage = function(str1: string, arg1): string
        local var4 = formatRequestState(arg1)
        local status = var4.status
        if status == "failed" then
            local errorCode = var4.errorCode
            local error = var4.error or "unknown error"
            if errorCode ~= nil then
                return `{str1} failed ({errorCode}): {error}`
            end
            return `{str1} failed: {error}`
        elseif status == "pending" then
            return `{str1} timed out (still pending)`
        else
            return `{str1} ended with unexpected state (status={tostring(status)})`
        end
    end,
    LOG_PREFIX = "[MyStats]"
}
