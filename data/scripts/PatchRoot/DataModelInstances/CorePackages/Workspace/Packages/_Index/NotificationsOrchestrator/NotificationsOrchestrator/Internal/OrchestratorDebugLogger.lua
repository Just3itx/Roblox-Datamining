-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationsOrchestrator = script:FindFirstAncestor("NotificationsOrchestrator")
local NotificationsOrchestratorParent = NotificationsOrchestrator.Parent

local Promise = require(NotificationsOrchestratorParent.Promise)
local FFlagEnableOrchestratorDebugLogging = require(NotificationsOrchestrator.Flags.FFlagEnableOrchestratorDebugLogging)

return {
    log = function(str1: string)
        if FFlagEnableOrchestratorDebugLogging then
            print("[NotifOrchDebug]", str1)
        end
    end,
    logLazy = function(func1: (...any) -> (...any))
        if FFlagEnableOrchestratorDebugLogging then
            print("[NotifOrchDebug]", func1())
        end
    end,
    startTimer = function()
        if FFlagEnableOrchestratorDebugLogging then
            return os.clock()
        end
        return nil
    end,
    logElapsed = function(str1: string, num1: number?)
        if FFlagEnableOrchestratorDebugLogging and num1 ~= nil then
            print("[NotifOrchDebug]", str1, string.format("(%.3fs)", os.clock() - num1))
        end
    end,
    logElapsedLazy = function(func1: (...any) -> (...any), num1: number?)
        if FFlagEnableOrchestratorDebugLogging and num1 ~= nil then
            print("[NotifOrchDebug]", func1(), string.format("(%.3fs)", os.clock() - num1))
        end
    end,
    tracePromise = function(arg1, tbl1)
        if not FFlagEnableOrchestratorDebugLogging then
            return arg1
        end

        if tbl1.onSuccess then
            local onSuccess = tbl1.onSuccess
            arg1 = arg1:andThen(function<T>(arg2: T): T
                onSuccess(arg2)
                return arg2
            end)
        end
        if tbl1.onError then
            local onError = tbl1.onError
            arg1 = arg1:catch(function(arg2)
                onError(arg2)
                return Promise.reject(arg2)
            end)
        end
        return arg1
    end
}
