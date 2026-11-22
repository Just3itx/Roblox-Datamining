-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local HomeParent = script:FindFirstAncestor("Home").Parent

local Signals = require(HomeParent.Signals)

local function newSessionId(): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return HttpService:GenerateGUID(false):lower()
end

local str1 = ""
local CommittedSignal, var2 = Signals.createSignal(nil)

local module = {}

function module.Get(_): string
    if str1 == "" then
        str1 = newSessionId()
    end
    return str1
end

function module.Refresh(_)
    str1 = newSessionId()
    return str1
end

function module.Adopt(_, str2: string): boolean
    if str2 == "" then
        return false
    end
    str1 = str2:lower()
    return true
end

function module.Commit(tbl1, requestId: string?): boolean
    local sessionId = tbl1:Get()
    local var4 = CommittedSignal(false)
    if var4 ~= nil and var4.sessionId == sessionId then
        return false
    end

    var2({ sessionId = sessionId, requestId = requestId })
    return true
end

function module.GetCommitted(_)
    return CommittedSignal(false)
end

function module.GetCommittedSignal(_)
    return CommittedSignal
end

return module
