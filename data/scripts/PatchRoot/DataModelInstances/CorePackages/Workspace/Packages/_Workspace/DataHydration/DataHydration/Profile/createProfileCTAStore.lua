-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local Cryo = require(DataHydrationParent.Cryo)
local Promise = require(DataHydrationParent.Promise)
local var1 = require(DataHydrationParent.Loggers).Logger:new(script.Name)

local Requests = require(DataHydration.Profile.Requests)
local _ProfileCTAEnums = require(DataHydration.Profile.Enums.ProfileCTAEnums)
local hydratePresenceFromProfileMetadata = require(DataHydration.Profile.hydratePresenceFromProfileMetadata)

local FFlagProfileCTAHydratePresenceFromMetadata = require(DataHydration.Flags.FFlagProfileCTAHydratePresenceFromMetadata)

local FFlagJoinabilityCTARefactor = require(DataHydrationParent.SharedFlags).FFlagJoinabilityCTARefactor
local FFlagUserListActionsV2 = require(DataHydrationParent.SharedFlags).FFlagUserListActionsV2

game:DefineFastInt("ProfileCTAStoreProcessDelaySec", 1)
local function func1(): number -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetFastInt("ProfileCTAStoreProcessDelaySec")
end

local queueProcessDelaySec = game:DefineFastInt("ProfileJoinUserActionsProcessDelaySec", 0)

local tbl1 = {{ component = "Actions", excludeContextualActions = true }}

local tbl2 = {{
    component = "Actions",
    excludeContextualActions = true,
    isActionsV2Supported = true,
    supportedActions = require(DataHydration.Profile.UserListSupportedActions)
}}

local tbl3 = {{ component = "JoinUserActions" }}

local function createProfileCTAStore(tbl4)
    local cache = createDataCache()
    local dataCache = if FFlagJoinabilityCTARefactor then createDataCache() else nil
    local var2 = if FFlagJoinabilityCTARefactor and tbl4 and tbl4.components then tbl4.components elseif FFlagUserListActionsV2 then tbl2 else tbl1
    local var3 = if FFlagJoinabilityCTARefactor then if var2[1] then var2[1].component else "Actions" else "Actions"

    local function fetchComponent(tbl5, tbl6, str1: string, bool1: boolean?) -- Luacid: Inlined by compiler; 1 call site recovered
        local var4 = Cryo.Dictionary.keys(tbl5)
        return Requests.GetUserProfileCTA(var4, tbl6):andThen(function(arg1)
            local result = ({})
            if arg1.responseBody and arg1.responseBody.profiles then
                for _, value in var4 do
                    local str2 = tostring(value)
                    local var5 = arg1.responseBody.profiles[str2]
                    result[str2] = not (var5 and var5.components) and {} or var5.components[str1] or {}

                    if FFlagProfileCTAHydratePresenceFromMetadata and bool1 then
                        hydratePresenceFromProfileMetadata(str2, var5 and var5.metadata)
                    end
                end
            end
            return result
        end)
    end

    local dataResolver = createDataResolver({
        cache = cache,
        queueProcessDelaySec = func1(),
        requestBatchSize = 25,
        fetchFn = function(tbl5)
            if FFlagJoinabilityCTARefactor then
                return fetchComponent(tbl5, var2, var3, true)
            end

            local var4 = Cryo.Dictionary.keys(tbl5)
            local getUserProfileCta = Requests.GetUserProfileCTA
            local var5 = if FFlagUserListActionsV2 then tbl2 else nil

            return getUserProfileCta(var4, var5):andThen(function(arg1)
                local result = ({})
                if arg1.responseBody and arg1.responseBody.profiles then
                    for _, value in var4 do
                        local str1 = tostring(value)
                        local var6 = arg1.responseBody.profiles[str1]
                        result[str1] = not (var6 and var6.components) and {} or var6.components.Actions or {}

                        if FFlagProfileCTAHydratePresenceFromMetadata then
                            hydratePresenceFromProfileMetadata(str1, var6 and var6.metadata)
                        end
                    end
                end
                return result
            end):catch(function(_)
                return {}
            end)
        end
    })

    local dataResolver2 = if FFlagJoinabilityCTARefactor then createDataResolver({
        cache = dataCache,
        queueProcessDelaySec = queueProcessDelaySec,
        requestBatchSize = 25,
        replaceItems = true,
        logError = function(arg1)
            var1:warning(`Failed to fetch JoinUserActions: {tostring(arg1)}`)
        end,
        fetchFn = function(tbl5)
            local var4 = fetchComponent(tbl5, tbl3, tbl3[1].component, true)

            local joinUserActionsTelemetry = require(DataHydration.Profile.JoinUserActionsTelemetry)

            return var4:andThen(function<T>(arg1: T): T
                joinUserActionsTelemetry.logFetchResult("Success")
                return arg1
            end):catch(function(arg1)
                joinUserActionsTelemetry.logFetchResult("Failed")
                return Promise.reject(arg1)
            end)
        end
    }) else nil

    return {
        getCTA = function(str1: string, bool1: boolean?)
            local var4

            if bool1 == nil then
                var4 = nil
            else
                local bool2 = bool1 == true

                var4 = function(_)
                    return bool2
                end
            end
            return dataResolver.getAndFetchItem(str1, var4)
        end,
        getBatchCTAs = function(tbl5, tbl6)
            local func2

            if tbl6 then
                local num2 = 0
                func2 = function(_): boolean
                    num2 += 1
                    local var4 = tbl5[num2]
                    return if var4 then tbl6[var4] == true else false
                end
            else
                func2 = nil
            end

            return dataResolver.getAndFetchItems(tbl5, func2)
        end,
        getJoinUserActions = FFlagJoinabilityCTARefactor and function(str1: string, bool1: boolean?)
            local var4

            if bool1 == nil then
                var4 = nil
            else
                local bool2 = bool1 == true

                var4 = function(_)
                    return bool2
                end
            end
            return dataResolver2.getAndFetchItem(str1, var4)
        end or nil,
        clear = function()
            cache.clear()
            dataResolver.clear()
            if FFlagJoinabilityCTARefactor then
                dataCache.clear()
                dataResolver2.clear()
            end
        end,
        dispose = function()
            dataResolver.dispose()
            if FFlagJoinabilityCTARefactor then
                dataResolver2.dispose()
            end
        end
    }
end

return createProfileCTAStore
