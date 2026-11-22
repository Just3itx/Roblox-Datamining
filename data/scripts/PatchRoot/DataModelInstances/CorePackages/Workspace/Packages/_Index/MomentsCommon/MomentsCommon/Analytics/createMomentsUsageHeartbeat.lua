-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")

local createMomentsSessionHeartbeat = require(script.Parent.createMomentsSessionHeartbeat)
local FIntMomentsUsageMinCreditedGapSec = require(MomentsCommon.Flags.FIntMomentsUsageMinCreditedGapSec)

local function createMomentsUsageHeartbeat(num1: number, callback: (...any) -> (...any), callback2: ((...any) -> (...any))?, arg1, func1: ((...any) -> (...any))?)
    local var1 = func1 or os.clock
    local var2 = nil

    local function send() -- Luacid: Inlined by compiler; 3 call sites recovered
        var2 = var1()
        callback()
    end

    local function sendEdge() -- Luacid: Inlined by compiler; 1 call site recovered
        if var2 ~= nil and not (var1() - var2 >= FIntMomentsUsageMinCreditedGapSec) then
            return
        end

        send()
    end
    local momentsSessionHeartbeat = createMomentsSessionHeartbeat(num1, function(_: string)
        send()
    end, arg1)

    local bool1 = false
    local bool2 = true
    local bool3 = false
    local getIsWatching = false
    local bool5 = false

    local function reconcile()
        local bool6 = bool1 and bool2
        local bool7 = bool6 and not bool3
        local bool8 = bool7 ~= bool5
        local bool9 = bool6 ~= getIsWatching

        bool5 = bool7
        getIsWatching = bool6
        if bool8 then
            if bool7 then
                momentsSessionHeartbeat.start("watch_tab")
            else
                momentsSessionHeartbeat.stop()
            end

            sendEdge()
        end

        if bool9 and callback2 ~= nil then
            callback2(bool6)
        end
    end

    return {
        setTabFocused = function(bool6: boolean)
            bool1 = bool6
            reconcile()
        end,
        setForegrounded = function(bool6: boolean)
            bool2 = bool6
            reconcile()
        end,
        setSuspended = function(bool6: boolean)
            bool3 = bool6
            reconcile()
        end,
        getIsWatching = function()
            return getIsWatching
        end,
        stop = function()
            bool1 = false
            reconcile()
        end
    }
end

return createMomentsUsageHeartbeat
