-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Http = require(DataHydrationParent.Http)
local HttpClient = require(DataHydrationParent.HttpClient)

local withCsrfRetry = require(DataHydration.withCsrfRetry)
local _UserSettingsStoreTypes = require(script.Parent.UserSettingsStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function settingsAndOptionsUrl(): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `{Http.Url.APIS_URL}user-settings-api/v1/user-settings`
end

local function normalizeCachedUserSettings(arg1)
    if typeof(arg1) ~= "table" then
        return {}
    end
    local result = ({})
    for value, currentValue in arg1 do
        result[value] = { currentValue = currentValue }
    end
    return result
end

local function settingsUpdateUrl(): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `{Http.Url.APIS_URL}user-settings-api/v1/user-settings`
end

return {
    fetchSettingsAndOptions = function(tbl1)
        local network = tbl1 and tbl1.network or HttpClient.createRequestInternalNetwork()

        local var2 = fetch({
            method = "GET",
            url = settingsAndOptionsUrl(),
            analyticsKey = "user-settings.settings-and-options.get",
            network = network,
            decode = function(arg1)
                return (normalizeCachedUserSettings(arg1))
            end
        })
        return asPromise(var2)
    end,
    postUserSettings = function(body, tbl1)
        local var1 = tbl1 and tbl1.network or HttpClient.createRequestInternalNetwork()

        local var2 = fetch({
            method = "POST",
            url = settingsUpdateUrl(),
            body = body,
            analyticsKey = "user-settings.update.post",
            network = withCsrfRetry(var1),
            decode = function(_)
                return body
            end
        })
        return asPromise(var2)
    end
}
