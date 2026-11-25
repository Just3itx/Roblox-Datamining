-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local Cryo = require(SquadsCoreParent.Cryo)
local Signals = require(SquadsCoreParent.Signals)

local createComputed = Signals.createComputed

local getSubscribedScheduledSquads = require(SquadsCore.NetworkRequests).getSubscribedScheduledSquads
local getScheduledSquadStatus = require(SquadsCore.NetworkRequests).getScheduledSquadStatus
local _Types = require(SquadsCore.Types)

return function()
    local var1, var2 = Signals.createSignal({})

    local var3, var4 = Signals.createSignal({})

    local computed = createComputed(function(arg1)
        return var1(arg1)
    end)

    local getScheduledSquadsStatus = createComputed(function(arg1)
        return var3(arg1)
    end)

    local function func1(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        local var5 = var3(false)
        var4(Cryo.Dictionary.join(var5, { [arg1.scheduledGroupUpId] = arg1 }))
    end

    return {
        getSubscribedScheduledSquads = computed,
        getScheduledSquadsStatus = getScheduledSquadsStatus,
        fetchSubscribedScheduledSquads = function()
            getSubscribedScheduledSquads(function(arg1)
                var2(arg1)
            end, nil)
        end,
        fetchAndCacheScheduledSquadStatus = function(num1: number, callback: ((...any) -> (...any))?)
            getScheduledSquadStatus(num1, function(arg1)
                func1(arg1)

                if callback then
                    callback()
                end
            end, function()
                if callback then
                    callback()
                end
            end)
        end
    }
end
