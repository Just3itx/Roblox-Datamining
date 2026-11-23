-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Signals = require(BuildExperienceParent.Signals)
local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)

local _chatTypes = require(BuildExperience.Chat.chatTypes)

local function resolveUniverseIdFromSessionLoad(result) -- Luacid: Inlined by compiler; 1 call site recovered
    if result == nil then
        return nil
    end
    local _meta = result._meta
    local _roblox = if _meta == nil then nil else _meta._roblox
    local universeId = if _roblox == nil then nil else _roblox.universeId
    return if typeof(universeId) == "number" and universeId ~= 0 then universeId else nil
end

local function gameIconForUniverseId(id: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return string.format("rbxthumb://type=GameIcon&id=%d&w=150&h=150", id)
end

local function makeTarget(num1: number?, sessionId: string?, arg1, experienceName: string)
    local universeId = num1 or 0
    local tbl1 = {
        universeId = universeId,
        placeId = if arg1 == nil then nil else arg1.rootPlaceId,
        sessionId = sessionId,
        experienceName = 0,
        gameIcon = 0
    }

    if arg1 ~= nil and arg1.name ~= "" then
        experienceName = arg1.name
    end

    tbl1.experienceName = experienceName
    tbl1.gameIcon = if universeId == 0 then nil else gameIconForUniverseId(universeId)
    return tbl1
end

local function resumeBuildChat(tbl1)
    local sessionId = tbl1.sessionId
    local bool1 = typeof(sessionId) == "string" and sessionId ~= ""
    local bool2 = not (tbl1.universeId == nil) and tbl1.universeId ~= 0

    if not (bool2 or bool1) then
        return nil
    end
    local fallbackExperienceName = tbl1.fallbackExperienceName

    local var1 = if not bool2 and bool1 then (tbl1.creatorAgentChatStore or CreatorAgentChat.getCreatorAgentChatStore()).sessionLoad(sessionId) else nil

    local configurationStore = tbl1.configurationStore
    local function getConfigurationStore() -- Luacid: Inlined by compiler; 1 call site recovered
        local var2 = configurationStore or UniverseConfiguration.getUniverseConfigurationStore()
        configurationStore = var2
        return var2
    end

    local bool3 = false

    return Signals.createEffect(function(arg1)
        if bool3 then
            return
        end

        local universeId

        if bool2 then
            universeId = tbl1.universeId
        elseif var1 == nil then
            universeId = nil
        else
            local var2 = var1.state(arg1)
            if var2.status == "pending" then
                return
            end
            if var2.status == "succeeded" then
                universeId = resolveUniverseIdFromSessionLoad(var2.result)
            else
                universeId = nil
            end
        end

        if universeId ~= nil then
            local var2 = getConfigurationStore().getAndFetchSummary(universeId)
            if var2.status(arg1) == "NotReady" then
                return
            end
            bool3 = true
            tbl1.onOpenChat((makeTarget(universeId, sessionId, var2.data(arg1), fallbackExperienceName)))
            return
        end

        bool3 = true
        tbl1.onOpenChat(
            {
                universeId = 0,
                placeId = nil,
                sessionId = sessionId,
                experienceName = fallbackExperienceName,
                gameIcon = nil
            }
        )
    end)
end

return resumeBuildChat
