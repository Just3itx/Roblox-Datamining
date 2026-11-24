-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)
local _Signals = require(DataHydrationParent.Signals)
local FFlagBuildExperienceModelPickerData = require(DataHydrationParent.SharedFlags).FFlagBuildExperienceModelPickerData
local experimentOverride = require(script.Parent.Parent.experimentOverride)
local var1 = FFlagBuildExperienceModelPickerData and experimentOverride.isEnabled()

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local fetchPreviewSpecs = require(script.Parent.fetchPreviewSpecs)
local _PreviewSpecsTypes = require(script.Parent.PreviewSpecsTypes)

local function createPreviewSpecsStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(_: string, _)
            return fetchPreviewSpecs(tbl3)
        end
    })
    local function func1(_): string
        return "preview-specs"
    end
    if var1 then
        local num1 = 0
        func1 = require(DataHydrationParent.SignalsUtils).createSessionScopedSignal(function(): string
            num1 += 1
            return `preview-specs:{num1}`
        end)
    end

    return {
        getCachedPreviewSpecs = function(arg1)
            return (dataResolver.getCachedItem(func1(arg1)))
        end,
        getAndFetchPreviewSpecs = function(arg1)
            return (dataResolver.getAndFetchItem(func1(arg1)))
        end,
        refreshPreviewSpecs = function()
            if not var1 then
                dataResolver.clear()
            end
            return (dataResolver.fetchItem(func1(false)))
        end,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createPreviewSpecsStore
