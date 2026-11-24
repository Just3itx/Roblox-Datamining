-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Cryo = require(DataHydrationParent.Cryo)
local _HttpClient = require(DataHydrationParent.HttpClient)

local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)

local fetchUniverseConfiguration = require(script.Parent.fetchUniverseConfiguration)
local getPrivacyTypeForAudiences = require(script.Parent.getPrivacyTypeForAudiences)
local _UniverseConfigurationStoreTypes = require(script.Parent.UniverseConfigurationStoreTypes)

local function createUniverseConfigurationStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local num1 = 0
    local tbl4 = ({})

    local singleEntityResolver = createSingleEntityResolver(function(num2: number)
        num1 += 1
        local var1 = num1
        return fetchUniverseConfiguration.fetchSummary(num2, tbl3):andThen(function(arg1)
            local var2 = tbl4[num2]
            if var2 == nil then
                return arg1
            end
            if var1 <= var2.generation then
                return Cryo.Dictionary.join(arg1, var2.patch)
            end

            tbl4[num2] = nil
            return arg1
        end)
    end)
    local singleEntityResolver2 = createSingleEntityResolver(function(num2: number)
        return fetchUniverseConfiguration.fetchConfiguration(num2, tbl3)
    end)
    local singleEntityResolver3 = createSingleEntityResolver(function(num2: number)
        return fetchUniverseConfiguration.fetchTeamCreate(num2, tbl3)
    end)

    local function getSummaryPatch(arg1): {[any]: any}?
        local tbl5 = {}
        if arg1.name ~= nil then
            tbl5.name = arg1.name
        end
        if arg1.description ~= nil then
            tbl5.description = arg1.description
        end
        if arg1.isArchived ~= nil then
            tbl5.isArchived = arg1.isArchived
        end
        if arg1.audiences ~= nil then
            tbl5.audiences = arg1.audiences
            tbl5.privacyType = getPrivacyTypeForAudiences(arg1.audiences)
        end

        return if next(tbl5) == nil then nil else tbl5
    end

    local function updateSummary(num2: number, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        local var1 = singleEntityResolver.get(num2).data(false)
        if var1 == nil then
            return
        end

        local var2 = Cryo.Dictionary.join(var1, arg1)
        singleEntityResolver.update(num2, var2)
    end

    return {
        getSummary = singleEntityResolver.get,
        fetchSummary = singleEntityResolver.fetch,
        refreshSummary = function(num2: number)
            return fetchUniverseConfiguration.fetchSummary(num2, tbl3):andThen(function<T>(arg1: T): T
                singleEntityResolver.cache.replaceItem(tostring(num2), arg1)
                return arg1
            end)
        end,
        getAndFetchSummary = singleEntityResolver.getAndFetch,
        updateSummary = updateSummary,
        getConfiguration = singleEntityResolver2.get,
        fetchConfiguration = singleEntityResolver2.fetch,
        refreshConfiguration = function(num2: number)
            return fetchUniverseConfiguration.fetchConfiguration(num2, tbl3):andThen(function<T>(arg1: T): T
                singleEntityResolver2.cache.replaceItem(tostring(num2), arg1)
                return arg1
            end)
        end,
        getAndFetchConfiguration = singleEntityResolver2.getAndFetch,
        updateConfiguration = function(num2: number, arg1)
            local var1 = singleEntityResolver2.get(num2).data(false)
            if var1 == nil then
                return
            end

            local var2 = Cryo.Dictionary.join(var1, arg1)
            singleEntityResolver2.update(num2, var2)
        end,
        patchConfiguration = function(num2: number, arg1)
            return fetchUniverseConfiguration.patchConfiguration(num2, arg1, tbl3):andThen(function(arg2)
                singleEntityResolver2.update(num2, arg2)
                singleEntityResolver2.update(num2, arg1)

                local patch = getSummaryPatch(arg1)
                if patch ~= nil and singleEntityResolver.get(num2).data(false) ~= nil then
                    tbl4[num2] = { generation = num1, patch = patch }

                    updateSummary(num2, patch)
                end

                return (singleEntityResolver2.get(num2).data(false))
            end)
        end,
        getTeamCreate = singleEntityResolver3.get,
        fetchTeamCreate = singleEntityResolver3.fetch,
        getAndFetchTeamCreate = singleEntityResolver3.getAndFetch,
        setTeamCreate = function(num2: number, bool1: boolean)
            return fetchUniverseConfiguration.setTeamCreate(num2, bool1, tbl3):andThen(function<T>(arg1: T): T
                singleEntityResolver3.update(num2, arg1)
                return arg1
            end)
        end,
        clear = function()
            num1 = 0
            tbl4 = {}
            singleEntityResolver.clear()
            singleEntityResolver2.clear()
            singleEntityResolver3.clear()
        end,
        dispose = function()
            singleEntityResolver.dispose()
            singleEntityResolver2.dispose()
            singleEntityResolver3.dispose()
        end
    }
end
return createUniverseConfigurationStore
