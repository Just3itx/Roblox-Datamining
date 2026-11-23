-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionService = game:GetService("SessionService")

local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local String = require(AppChatParent.LuauPolyfill).String

local SessionType = require(AppChatParent.RobloxAppSessionization).SessionType

local str1 = game:DefineFastString("AppChatSessionName", "ChatPage")

local getCount = 0
local getReservations = 0

local module = {}

local function createL3Session(sessionService)
    local level2a = SessionType.StructuralIdentifier.Level2a
    if not sessionService:SessionExists(level2a) then
        return
    end

    sessionService:SetSession(level2a, str1, str1)

    local sessionTag = sessionService:GetSessionTag(level2a)

    if game:GetEngineFeature("SessionGetSessionID") and String.startsWith(sessionTag, "ingame") then
        local sessionId = sessionService:GetSessionID(level2a)
        sessionService:SetMetadata(str1, "InGameSessionId", sessionId)
    end
end

local function destroyL3Session(sessionService) -- Luacid: Inlined by compiler; 1 call site recovered
    if sessionService:SessionExists(str1) then
        sessionService:RemoveSession(str1)
    end
end

function module.acquire(arg1)
    local sessionService = arg1 or SessionService
    if getReservations > 0 then
        getReservations -= 1
        return
    end
    getCount += 1
    if getCount == 1 then
        createL3Session(sessionService)
    end
end

function module.release(arg1)
    local sessionService = arg1 or SessionService
    getCount -= 1
    if getCount == 0 then
        destroyL3Session(sessionService)
    end
end

function module.reserve(arg1)
    local sessionService = arg1 or SessionService
    getReservations += 1
    getCount += 1
    if getCount == 1 then
        createL3Session(sessionService)
    end
end

function module.getCount()
    return getCount
end

function module.getReservations()
    return getReservations
end

function module._resetForTesting()
    getCount = 0
    getReservations = 0
end

return module
