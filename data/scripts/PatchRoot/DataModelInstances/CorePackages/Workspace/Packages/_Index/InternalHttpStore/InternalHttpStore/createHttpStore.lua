-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent

local scriptParentParent = scriptParent.Parent

local Signals = require(scriptParentParent.Signals)
local FFlagDisableLegacyReportToDiag = require(scriptParentParent.SharedFlags.FFlagDisableLegacyReportToDiag)

local HttpSessionTracker = require(scriptParent.HttpSessionTracker)
local createFetchSignal = require(scriptParent.createFetchSignal)
local createCancelRequestHandler = require(scriptParent.GlobalHandlers.createCancelRequestHandler)
local createNetworkStatsHandler = require(scriptParent.GlobalHandlers.createNetworkStatsHandler)
local createGrafanaLoggingHandler = require(scriptParent.GlobalHandlers.createGrafanaLoggingHandler)

local _HttpStoreTypes = require(scriptParent.HttpStoreTypes)

local tbl1 = ({})

local function createHTTPStore()
    return {
        fetch = function(str1: string?, arg1)
            if str1 and tbl1[str1] then
                return tbl1[str1].getFetchSignal, tbl1[str1].cancelRequest
            end

            local var1, var2 = createFetchSignal(arg1)

            local getFetchSignal = createCancelRequestHandler(var1)
            local networkStatsHandler = if FFlagDisableLegacyReportToDiag then nil else createNetworkStatsHandler(getFetchSignal)
            local grafanaLoggingHandler = createGrafanaLoggingHandler(getFetchSignal)

            local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
                if networkStatsHandler then
                    networkStatsHandler()
                end
                grafanaLoggingHandler()
                var2()
            end

            local func2

            if str1 then
                local effect = Signals.createEffect(function(arg2)
                    local var3 = getFetchSignal(arg2)
                    if var3.status == "Success" or var3.status == "Failed" then
                        tbl1[str1] = nil
                    end
                end)

                func2 = function()
                    effect()
                    func1()
                    tbl1[str1] = nil
                end

                tbl1[str1] = { getFetchSignal = getFetchSignal, cancelRequest = func2 }
            else
                func2 = func1
            end

            return getFetchSignal, func2
        end,
        cancelAll = function()
            for _, value in tbl1 do
                value.cancelRequest()
            end
            tbl1 = {}

            HttpSessionTracker.cancelAll()
        end
    }
end

return createHTTPStore
