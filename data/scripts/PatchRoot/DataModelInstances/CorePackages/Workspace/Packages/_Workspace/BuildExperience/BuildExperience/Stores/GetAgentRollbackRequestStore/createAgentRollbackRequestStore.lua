-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Promise = require(BuildExperienceParent.Promise)
local Signals = require(BuildExperienceParent.Signals)

local function createAgentRollbackRequestStore()
    local num1 = 0
    local tbl1 = ({})
    local var1 = nil
    local var2 = nil

    local function getRequestSignal(num2: number) -- Luacid: Inlined by compiler; 13 call sites recovered
        local tbl2 = tbl1[num2]
        if tbl2 == nil then
            local getIsPending, setIsPending = Signals.createSignal(false)
            tbl2 = { getIsPending = getIsPending, setIsPending = setIsPending }

            tbl1[num2] = tbl2
        end
        return tbl2
    end

    local function turnStarterMatchesTarget(tbl2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return not (var1 == nil or var1.target.placeId ~= tbl2.placeId)
            and (tbl2.universeId == nil or var1.target.universeId == tbl2.universeId)
    end

    local function finishRequest(tbl2, str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
        if var2 ~= tbl2 then
            return
        end
        var2 = nil
        getRequestSignal(tbl2.target.placeId).setIsPending(false)
        if str1 == nil then
            tbl2.resolve()
            return
        end
        tbl2.reject(str1)
    end

    local function beginRequest(tbl2)
        if var2 ~= nil then
            return nil, Promise.reject("agent_rollback_busy")
        end

        if not turnStarterMatchesTarget(tbl2) then
            return nil, Promise.reject("agent_rollback_no_turn_starter")
        end

        num1 += 1
        local id = num1
        local var3 = var1
        return id, (Promise.new(function(resolve, reject)
            var2 = {
                id = id,
                target = {
                    universeId = if tbl2.universeId ~= nil then tbl2.universeId else var3.target.universeId,
                    placeId = tbl2.placeId
                },
                resolve = resolve,
                reject = reject
            }
            getRequestSignal(tbl2.placeId).setIsPending(true)
        end))
    end
    local function setRequestData(id: number, tbl2)
        local var3 = var2
        if var3 == nil or var3.id ~= id then
            return false
        end

        if not turnStarterMatchesTarget(var3.target) then
            if var2 == var3 then
                var2 = nil
                getRequestSignal(var3.target.placeId).setIsPending(false)

                var3.reject("agent_rollback_start_failed")
            end

            return false
        end
        local var4 = var1
        if var4 == nil then
            if var2 == var3 then
                var2 = nil
                getRequestSignal(var3.target.placeId).setIsPending(false)

                var3.reject("agent_rollback_start_failed")
            end

            return false
        end
        local success, result = pcall(var4.startTurn, {
            id = id,
            universeId = var3.target.universeId,
            placeId = var3.target.placeId,
            versionNumber = tbl2.versionNumber,
            noteTitle = tbl2.noteTitle,
            noteDescription = tbl2.noteDescription
        }, function()
            finishRequest(var3, nil)
        end, function()
            local var5 = var3

            if var2 ~= var5 then
                return
            end
            var2 = nil
            getRequestSignal(var5.target.placeId).setIsPending(false)

            var5.reject("agent_rollback_start_failed")
        end)

        if not (success and result) and var2 == var3 then
            var2 = nil
            getRequestSignal(var3.target.placeId).setIsPending(false)

            var3.reject("agent_rollback_start_failed")
        end

        return success and result
    end

    return {
        getIsPendingForPlaceId = function(num2: number)
            return getRequestSignal(num2).getIsPending
        end,
        registerTurnStarter = function(target, registration, startTurn: (...any) -> (...any)): boolean
            if var1 ~= nil and var1.registration ~= registration then
                return false
            end
            local var3 = var2

            if var3 ~= nil and (var3.target.placeId ~= target.placeId or var3.target.universeId ~= target.universeId) and var2 == var3 then
                var2 = nil
                getRequestSignal(var3.target.placeId).setIsPending(false)

                var3.reject("agent_rollback_start_failed")
            end

            var1 = { target = target, registration = registration, startTurn = startTurn }

            return true
        end,
        unregisterTurnStarter = function(registration)
            if var1 == nil or var1.registration ~= registration then
                return
            end
            var1 = nil
            local var3 = var2
            if var3 == nil then
                return
            end

            if var2 ~= var3 then
                return
            end
            var2 = nil
            getRequestSignal(var3.target.placeId).setIsPending(false)

            var3.reject("agent_rollback_start_failed")
        end,
        beginRequest = beginRequest,
        setRequestData = setRequestData,
        failRequest = function(id: number): boolean
            local var3 = var2
            if var3 == nil or var3.id ~= id then
                return false
            end

            if var2 == var3 then
                var2 = nil
                getRequestSignal(var3.target.placeId).setIsPending(false)

                var3.reject("agent_rollback_start_failed")
            end

            return true
        end,
        cancelRequestForPlaceId = function(placeId: number): boolean
            local var3 = var2
            if var3 == nil or var3.target.placeId ~= placeId then
                return false
            end

            if var2 == var3 then
                var2 = nil
                getRequestSignal(var3.target.placeId).setIsPending(false)

                var3.reject("agent_rollback_cancelled")
            end

            return true
        end,
        request = function(tbl2, tbl3)
            local var3, var4 = beginRequest(tbl2)
            if var3 ~= nil then
                setRequestData(var3, tbl3)
            end
            return var4
        end,
        reset = function()
            local var3 = var2

            if var3 ~= nil and var2 == var3 then
                var2 = nil
                getRequestSignal(var3.target.placeId).setIsPending(false)

                var3.reject("agent_rollback_start_failed")
            end

            var1 = nil
        end
    }
end
return createAgentRollbackRequestStore
