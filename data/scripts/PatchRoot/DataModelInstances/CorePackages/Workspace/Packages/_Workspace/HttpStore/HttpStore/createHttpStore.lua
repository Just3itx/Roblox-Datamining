-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local InternalHttpStore = require(scriptParentParent.InternalHttpStore)
local _Signals = require(scriptParentParent.Signals)

local createErrorStatusHandler = require(scriptParent.Handlers.createErrorStatusHandler)
local GetHttpStore = InternalHttpStore.GetHttpStore

local _Types = require(scriptParent.Types)
local HttpSessionTracker = require(scriptParent.HttpSessionTracker)

local function createHttpStore(arg1, arg2)
    local httpStore = GetHttpStore(arg2)
    local tbl1 = ({})

    return {
        fetch = function(str1: string, arg3)
            local var1 = HttpSessionTracker.currentSession()
            if tbl1[var1] == nil then
                tbl1[var1] = {}
            end

            local var2, cancelRequest = httpStore.fetch(str1, arg3)

            local getFetchSignal = createErrorStatusHandler(arg1)(var2)

            tbl1[var1][str1] = { getFetchSignal = getFetchSignal, cancelRequest = cancelRequest }

            return getFetchSignal, cancelRequest
        end,
        cancelAll = function()
            local var1 = HttpSessionTracker.currentSession()
            if tbl1[var1] then
                for _, value in tbl1[var1] do
                    value.cancelRequest()
                end
            end
            tbl1[var1] = nil
            HttpSessionTracker.cancelAll()
            local var2 = HttpSessionTracker.currentSession()
            tbl1[var2] = {}
        end
    }
end

return createHttpStore
