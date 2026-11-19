-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local ScriptContext = game:GetService("ScriptContext")

local React = require(CorePackages.Packages.React)

local FFlagCoreScriptErrorReporterIncludeScriptContext = require(script.Parent.Parent.Flags.FFlagCoreScriptErrorReporterIncludeScriptContext)

local function isCoreScript(coreScript)
    return coreScript:IsDescendantOf(CoreGui)
        or coreScript:IsDescendantOf(CorePackages)
        or FFlagCoreScriptErrorReporterIncludeScriptContext
            and coreScript:IsA("CoreScript")
            and coreScript:IsDescendantOf(ScriptContext)
end

local function createCoreScriptErrorHandler(tbl1)
    local piiFilter = tbl1.piiFilter
    local rateLimiter = tbl1.rateLimiter
    local var1 = tbl1.isReportableScript or isCoreScript

    return function(str1: string, str2: string, arg1, str3: string?)
        if arg1 == nil or not var1(arg1) then
            return
        end

        local var2, var3 = React.unstable_parseReactError(str1)

        local message = var2.message

        local var4 = var2.stack or str2

        local var5 = str3 or var3

        local var6 = piiFilter:cleanPii(message)
        local var7 = piiFilter:cleanPii(var4)
        local var8 = if var5 == nil then nil else piiFilter:cleanPii(var5)

        if rateLimiter ~= nil then
            local var9 = var6 .. var7
            if rateLimiter:isRateLimited(var9) then
                return
            end
            rateLimiter:increment(var9)
        end

        for _, reporter in tbl1.reporters do
            reporter:reportErrorDeferred(var6, var7, var8)
        end

        if tbl1.onErrorReported ~= nil then
            tbl1.onErrorReported()
        end
    end
end

return createCoreScriptErrorHandler
