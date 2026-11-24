-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent
local SignalsUtils = require(DataHydrationParent.SignalsUtils)
local FFlagBuildExperienceModelPickerData = require(DataHydrationParent.SharedFlags).FFlagBuildExperienceModelPickerData

local createChatSession = require(script.Parent.Parent.createChatSession)
local var1 = FFlagBuildExperienceModelPickerData and require(script.Parent.Parent.experimentOverride).isEnabled()
local _sessionDeps = require(script.Parent.Parent.ChatSession.sessionDeps)
local _types = require(script.Parent.Parent.types)

local function createAccountRegistry(arg1)
    local tbl1 = ({})
    local tbl2 = ({})
    local tbl3 = ({})

    local function registerCasSession(arg2, str1: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
        if typeof(str1) ~= "string" or str1 == "" then
            return
        end
        local var2 = tbl3[arg2]
        if var2 ~= nil and var2 ~= str1 and tbl2[var2] == arg2 then
            tbl2[var2] = nil
        end
        local var3 = tbl2[str1]
        if var3 ~= nil and var3 ~= arg2 then
            tbl3[var3] = nil
        end
        tbl2[str1] = arg2
        tbl3[arg2] = str1
    end

    local function projectKey(universeId: number?, placeId: number?, str1: string?): string -- Luacid: Inlined by compiler; 1 call site recovered
        if typeof(str1) == "string" and str1 ~= "" and (var1 or universeId == nil or placeId == nil) then
            return `session:{str1}`
        elseif universeId == nil or placeId == nil then
            return "anonymous"
        end
        return `{universeId}:{placeId}`
    end

    return {
        getSessionForProject = function(universeId: number?, placeId: number?, str1: string?)
            local str2 = projectKey(universeId, placeId, str1)

            if typeof(str1) == "string" and str1 ~= "" then
                local var2 = tbl2[str1]
                if var2 ~= nil and var2.getCasSessionId() == str1 then
                    var2.universeId = universeId or var2.universeId
                    var2.placeId = placeId or var2.placeId
                    tbl1[str2] = var2
                    if var1 and universeId ~= nil and placeId ~= nil then
                        tbl1[if universeId == nil then "anonymous" elseif placeId == nil then "anonymous" else `{universeId}:{placeId}`] = var2
                    end
                    return var2
                end
            end

            local var2 = tbl1[str2]
            if var2 ~= nil then
                if typeof(str1) ~= "string" or str1 == "" then
                    return var2
                end
                var2.setCasSessionId(str1)
                registerCasSession(var2, str1)
                return var2
            end
            local var3 = nil
            local chatSession = createChatSession({
                initialize = arg1.initialize,
                sessionNew = arg1.sessionNew,
                sessionLoad = arg1.sessionLoad,
                sessionPrompt = arg1.sessionPrompt,
                ingestSessionHistory = arg1.ingestSessionHistory,
                submitToolResult = arg1.submitToolResult,
                getActiveTurnHandle = arg1.getActiveTurnHandle,
                onCasSessionIdChanged = function(arg2)
                    if var3 ~= nil then
                        registerCasSession(var3, arg2)
                    end
                end
            }, universeId, placeId, str1)

            var3 = chatSession
            tbl1[str2] = chatSession
            if var1 and universeId ~= nil and placeId ~= nil then
                tbl1[if universeId == nil then "anonymous" elseif placeId == nil then "anonymous" else `{universeId}:{placeId}`] = chatSession
            end

            registerCasSession(chatSession, str1)
            return chatSession
        end,
        registerCasSession = registerCasSession,
        getSessionByCasSessionId = function(str1: string)
            local var2 = tbl2[str1]
            if var2 == nil or var2.getCasSessionId() == str1 then
                return var2
            end

            tbl2[str1] = nil
            return nil
        end
    }
end

return {
    createSessionRegistry = function(arg1)
        if not FFlagBuildExperienceModelPickerData then
            return (createAccountRegistry(arg1))
        end
        local sessionScopedSignal = SignalsUtils.createSessionScopedSignal(function()
            return (createAccountRegistry(arg1))
        end)
        return {
            getSessionForProject = function(arg2, arg3, arg4)
                return sessionScopedSignal(false).getSessionForProject(arg2, arg3, arg4)
            end,
            registerCasSession = function(arg2, arg3)
                sessionScopedSignal(false).registerCasSession(arg2, arg3)
            end,
            getSessionByCasSessionId = function(arg2)
                return sessionScopedSignal(false).getSessionByCasSessionId(arg2)
            end
        }
    end
}
