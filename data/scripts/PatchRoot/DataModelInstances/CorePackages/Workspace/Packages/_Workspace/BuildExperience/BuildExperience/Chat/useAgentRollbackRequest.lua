-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local React = require(BuildExperienceParent.React)

local _chatTypes = require(script.Parent.chatTypes)
local GetAgentRollbackRequestStore = require(BuildExperience.Stores.GetAgentRollbackRequestStore)

local function useAgentRollbackRequest(tbl1)
    local agentRollbackRequestStore = GetAgentRollbackRequestStore(false)
    local var1 = React.useRef({})
    local var2 = React.useRef(nil)
    local stopRequestBeforeReceipt = React.useCallback(function(arg1): boolean
        local current = var2.current
        if current == nil then
            return false
        end

        var2.current = nil
        arg1.stop()
        current.rejectStartup()
        return true
    end, {})

    local var4 = React.useCallback(function(arg1, callback: (...any) -> (...any), rejectStartup: (...any) -> (...any)): boolean
        if tbl1.session == nil or tbl1.activeTurnHandleRef.current ~= nil then
            return false
        end

        var2.current = {
            requestId = arg1.id,
            rejectStartup = rejectStartup
        }
        tbl1.startRollbackTurn(arg1, function()
            local current = var2.current
            if current == nil or current.requestId ~= arg1.id then
                return
            end
            var2.current = nil
            callback()
        end, function()
            local current = var2.current
            if current == nil or current.requestId ~= arg1.id then
                return
            end
            var2.current = nil
            rejectStartup()
        end)
        return true
    end, { tbl1.session, tbl1.activeTurnHandleRef, tbl1.startRollbackTurn })

    React.useLayoutEffect(function()
        if tbl1.session == nil or tbl1.placeId == nil then
            agentRollbackRequestStore.unregisterTurnStarter(var1.current)
            return
        end
        agentRollbackRequestStore.registerTurnStarter(
            {
                universeId = tbl1.universeId,
                placeId = tbl1.placeId
            },
            var1.current,
            var4
        )
    end, {
        tbl1.universeId,
        tbl1.placeId,
        tbl1.session,
        var4,
        agentRollbackRequestStore
    })

    React.useLayoutEffect(function()
        local current = var1.current
        return function()
            agentRollbackRequestStore.unregisterTurnStarter(current)
        end
    end, { agentRollbackRequestStore })

    React.useEffect(function()
        return function()
            local current = tbl1.activeTurnHandleRef.current
            if current ~= nil then
                stopRequestBeforeReceipt(current)
            end
        end
    end, { tbl1.activeTurnHandleRef, stopRequestBeforeReceipt })

    return {
        stopRequestBeforeReceipt = stopRequestBeforeReceipt,
        cancelRequestBeforeTurnStarts = React.useCallback(function()
            return var2.current == nil and tbl1.placeId ~= nil and agentRollbackRequestStore.cancelRequestForPlaceId(tbl1.placeId)
        end, { tbl1.placeId, agentRollbackRequestStore })
    }
end

return useAgentRollbackRequest
