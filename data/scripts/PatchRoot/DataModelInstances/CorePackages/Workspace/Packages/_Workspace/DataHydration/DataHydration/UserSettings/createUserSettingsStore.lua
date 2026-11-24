-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _Signals = require(DataHydrationParent.Signals)
local Promise = require(DataHydrationParent.Promise)
local _HttpClient = require(DataHydrationParent.HttpClient)
local LocalUserIdStore = require(DataHydrationParent.LocalUserIdStore).LocalUserIdStore

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local userSettingsRequests = require(script.Parent.userSettingsRequests)
local _UserSettingsStoreTypes = require(script.Parent.UserSettingsStoreTypes)

local function resolveLocalUserId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return LocalUserIdStore.getCurrentUserId(arg1)
end

local function createUserSettingsStore(tbl1)
    local tbl2 = {
        network = (tbl1 or {}).network
    }
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        fetchFn = function(_: string, _)
            return userSettingsRequests.fetchSettingsAndOptions(tbl2)
        end
    })

    local function getAndFetchUserSettings(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        return dataResolver.getAndFetchItem(resolveLocalUserId(arg1))
    end

    local function getUserSettings(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        return dataResolver.getCachedItem(resolveLocalUserId(arg1))
    end

    local function fetchUserSettings() -- Luacid: Inlined by compiler; 1 call site recovered
        return dataResolver.fetchItem(resolveLocalUserId(false))
    end

    local function getAccountTheme(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        local var1 = getUserSettings(arg1).data(arg1)
        local accountTheme = var1 and var1.accountTheme
        return accountTheme and accountTheme.currentValue
    end

    local function writeAccountThemeToCache(str1: string, currentValue: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        cache.updateItem(str1, { accountTheme = { currentValue = currentValue } })
    end

    return {
        getAndFetchUserSettings = getAndFetchUserSettings,
        getUserSettings = getUserSettings,
        fetchUserSettings = fetchUserSettings,
        getAccountTheme = getAccountTheme,
        getAndFetchAccountTheme = function(arg1)
            local var1 = getAndFetchUserSettings(arg1).data(arg1)
            local accountTheme = var1 and var1.accountTheme
            return accountTheme and accountTheme.currentValue
        end,
        getAccountThemeStatus = function(arg1)
            return getUserSettings(arg1).status(arg1)
        end,
        updateAccountTheme = function(accountTheme: string)
            local var1 = resolveLocalUserId(false)
            local accountTheme2 = getAccountTheme(false)
            writeAccountThemeToCache(var1, accountTheme)

            return userSettingsRequests.postUserSettings({ accountTheme = accountTheme }, tbl2):catch(function(arg1)
                if resolveLocalUserId(false) ~= var1 then
                    return Promise.reject(arg1)
                end

                if accountTheme2 ~= nil then
                    writeAccountThemeToCache(var1, accountTheme2)
                else
                    fetchUserSettings()
                end

                return Promise.reject(arg1)
            end)
        end,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createUserSettingsStore
