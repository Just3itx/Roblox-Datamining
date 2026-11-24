-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local var1, var2 = require(DataHydrationParent.Signals).createSignal(nil)

local function updateOpenChat(chatOpenId: string, universeId: number?, sessionId: string?)
    local var3 = var1(false)
    if var3 == nil or var3.chatOpenId ~= chatOpenId or var3.universeId == universeId and var3.sessionId == sessionId then
        return
    end

    var2(table.freeze({ chatOpenId = chatOpenId, universeId = universeId, sessionId = sessionId }))
end

local module = {}

function module.open(chatOpenId: string, universeId: number?)
    local var3 = var1(false)
    if var3 == nil or var3.chatOpenId ~= chatOpenId then
        var2(table.freeze({ chatOpenId = chatOpenId, universeId = universeId }))
    end
end

function module.close(chatOpenId: string)
    local var3 = var1(false)
    if var3 ~= nil and var3.chatOpenId == chatOpenId then
        var2(nil)
    end
end

function module.setUniverseId(chatOpenId: string, universeId: number?)
    local var3 = var1(false)
    updateOpenChat(chatOpenId, universeId, if var3 == nil then nil else var3.sessionId)
end

function module.setSessionId(chatOpenId: string, sessionId: string?)
    local var3 = var1(false)
    updateOpenChat(chatOpenId, if var3 == nil then nil else var3.universeId, sessionId)
end

function module.getChatOpenId()
    local var3 = var1(false)
    return if var3 == nil then nil else var3.chatOpenId
end

function module.getSessionId()
    local var3 = var1(false)
    return if var3 == nil then nil else var3.sessionId
end

function module.getChatOpenIdForUniverse(universeId: number?)
    local var3 = var1(false)
    return if var3 == nil or var3.universeId ~= universeId then nil else var3.chatOpenId
end

function module.resolveEventIds(chatOpenId: string?, sessionId: string?, universeId: number?)
    local var3 = var1(false)
    if var3 == nil
        or not (if chatOpenId ~= nil then chatOpenId == var3.chatOpenId elseif sessionId ~= nil then sessionId == var3.sessionId elseif universeId ~= nil then universeId == var3.universeId else var3.universeId == nil)
    then
        return chatOpenId, nil
    end

    return var3.chatOpenId, var3.sessionId
end

return module
