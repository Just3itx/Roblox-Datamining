-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Promise = require(InExperienceShopParent.Promise)
local FFlagEnableShopDebugLogging = require(InExperienceShop.Flags.FFlagEnableShopDebugLogging)

return {
    log = function(str1: string)
        if FFlagEnableShopDebugLogging then
            print("[ShopDebug]", str1)
        end
    end,
    logLazy = function(func1: (...any) -> (...any))
        if FFlagEnableShopDebugLogging then
            print("[ShopDebug]", func1())
        end
    end,
    startTimer = function()
        if FFlagEnableShopDebugLogging then
            return os.clock()
        end
        return nil
    end,
    logElapsed = function(str1: string, num1: number?)
        if FFlagEnableShopDebugLogging and num1 ~= nil then
            print("[ShopDebug]", str1, string.format("(%.3fs)", os.clock() - num1))
        end
    end,
    logElapsedLazy = function(func1: (...any) -> (...any), num1: number?)
        if FFlagEnableShopDebugLogging and num1 ~= nil then
            print("[ShopDebug]", func1(), string.format("(%.3fs)", os.clock() - num1))
        end
    end,
    tracePromise = function(arg1, tbl1)
        if not FFlagEnableShopDebugLogging then
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
