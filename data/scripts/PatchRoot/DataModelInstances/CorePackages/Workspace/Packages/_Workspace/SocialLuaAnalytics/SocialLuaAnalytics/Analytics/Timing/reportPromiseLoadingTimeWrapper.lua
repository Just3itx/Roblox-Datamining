-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalytics = script:FindFirstAncestor("SocialLuaAnalytics")
local SocialLuaAnalyticsParent = SocialLuaAnalytics.Parent

local Promise = require(SocialLuaAnalyticsParent.Promise)
local RetrievalStatus = require(SocialLuaAnalyticsParent.Http).Enum.RetrievalStatus

local EventTypes = require(SocialLuaAnalytics.Analytics.Enums).EventTypes

local _LuauPolyfill = require(SocialLuaAnalyticsParent.LuauPolyfill)

local Timers = require(script.Parent.Timers)

local function reportPromiseLoadingTimeWrapper(arg1, func1: (...any) -> (...any), tbl1)
    local function reportPromiseLoadingTime(...)
        local tbl2 = { ... }

        local var1 = Timers()
        local var2 = var1.start()

        local function func2(status: string, arg2)
            if not tbl1 or not tbl1.fireEvent then
                return
            end

            local var3 = var1.stop(var2)
            local var4 = func1(unpack(tbl2)) or {}

            tbl1.fireEvent(
                EventTypes.LoadingTime,
                {
                    fetch = var4.fetch,
                    nextPage = var4.nextPage,
                    status = status,
                    result = arg2
                },
                var3
            )
        end

        return arg1(...):andThen(function<T>(arg2: T): T
            pcall(function()
                func2(RetrievalStatus.Done, arg2)
            end)
            return arg2
        end):catch(function(arg2)
            pcall(function()
                func2(RetrievalStatus.Failed)
            end)
            return Promise.reject(arg2)
        end)
    end

    return reportPromiseLoadingTime
end

return reportPromiseLoadingTimeWrapper
