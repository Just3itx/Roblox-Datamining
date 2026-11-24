-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local withCsrfRetry = require(DataHydration.withCsrfRetry)
local _PlaceVersionHistoryStoreTypes = require(script.Parent.PlaceVersionHistoryStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function debugRestore(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    print(`[PlaceVersionHistoryRestoreDebug] {str1}`)
end

local function debugNote(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    print(`[PlaceVersionHistoryNoteDebug] {str1}`)
end

local function bodyPreview(buf: buffer): string
    if buf == nil then
        return "nil"
    end

    local str1 = if typeof(buf) == "buffer" then buffer.tostring(buf) else tostring(buf)
    local var1 = string.gsub(str1, "[\r\n]+", " ")

    if #var1 > 500 then
        return string.sub(var1, 1, 500) .. "..."
    end

    return var1
end

local function appendQuery(str1: string, tbl1): string
    local bool1 = false
    local tbl2 = {}
    for value, value2 in tbl1 do
        if value2 ~= nil then
            local str2 = tostring(value2)
            table.insert(tbl2, ("%s=%s"):format(value, str2))
            bool1 = true
        end
    end

    if bool1 then
        return str1 .. (if string.find(str1, "?", 1, true) == nil then "?" else "&") .. table.concat(tbl2, "&")
    end

    return str1
end

local function historyUrl(str1: string, num1: number, arg1)
    local str2 = ("%s/place-version-history-api/v1/%d/history"):format(str1, num1)
    if arg1 == nil then
        return (appendQuery(str2, { pageSize = 100 }))
    end
    return (appendQuery(str2, { cursor = arg1.cursor, pageSize = arg1.pageSize or arg1.limit, isPublished = arg1.isPublished }))
end

local function notesUrl(str1: string, placeId: number, version: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return ("%s/place-version-history-api/v1/%d/version/%s/notes"):format(str1, placeId, version)
end

local function revertUrl(str1: string, assetId: number, assetVersionNumber: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return ("%s/v1/assets/%d/revert-version?assetVersionNumber=%d"):format(str1, assetId, assetVersionNumber)
end

local function rollbackUrl(str1: string, placeId: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return ("%s/universes/v1/places/%d/rollback"):format(str1, placeId)
end

local function resolveBase(tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local tbl2 = tbl1 or {}
    return tbl2.network, tbl2.baseUrl or UrlBase.APIS
end

local function resolveDevelopBase(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return (tbl1 or {}).developBaseUrl or UrlBase.new("develop")
end

local function resolveMutatingNetwork(tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return (tbl1 or {}).network or withCsrfRetry(HttpClient.createRequestInternalNetwork())
end

local function toNumber(newVersionNumber) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(newVersionNumber) == "number" then
        return newVersionNumber
    elseif type(newVersionNumber) == "string" then
        return tonumber(newVersionNumber)
    end

    return nil
end

local module = { DEFAULT_HISTORY_PAGE_SIZE = 100 }

function module.fetchHistory(num1: number, tbl1, arg1)
    local network, var1 = resolveBase(tbl1)
    local url = historyUrl(var1, num1, arg1)
    local var2 = fetch({
        network = network,
        method = "GET",
        url = url,
        analyticsKey = "place-version-history.get-history",
        decode = function<T>(arg2: T): T
            return arg2
        end
    })
    return asPromise(var2)
end

function module.revertVersion(assetId: number, assetVersionNumber: number, tbl1)
    local url = revertUrl(resolveDevelopBase(tbl1), assetId, assetVersionNumber)

    local var1 = fetch
    local tbl2 = {
        network = resolveMutatingNetwork(tbl1),
        method = "POST",
        url = url,
        body = {},
        analyticsKey = "place-version-history.revert-version",
        legacy = true,
        decode = 0
    }

    function tbl2.decode(_)
        return { assetId = assetId, assetVersionNumber = assetVersionNumber }
    end

    local var2 = var1(tbl2)

    return asPromise(var2)
end

function module.rollbackPlace(placeId: number, versionToRollback: number, message: string?, published: boolean?, tbl1)
    local _network, var1 = resolveBase(tbl1)
    local url = rollbackUrl(var1, placeId)

    local var2 = fetch({
        network = resolveMutatingNetwork(tbl1),
        method = "POST",
        url = url,
        body = { versionToRollback = versionToRollback, message = message, published = published },
        analyticsKey = "place-version-history.rollback-place",
        analytics = function(_, arg1, arg2, arg3, arg4, arg5)
            if arg3 == nil then
                if arg5 ~= "succeeded" then
                    debugRestore(
                        `request failed method={arg1} url={arg2} status={arg5} durationMs={math.floor(arg4)} response=nil`
                    )
                end
            elseif arg5 ~= "succeeded" or not (arg3.statusCode >= 200 and arg3.statusCode < 300) then
                local statusCode = arg3.statusCode
                local httpError = arg3.httpError
                debugRestore(
                    `request failed method={arg1} url={arg2} status={arg5} httpStatus={statusCode} httpError={tostring(httpError)} durationMs={math.floor(arg4)} body="{bodyPreview(arg3.responseBody)}"`
                )
            end
        end,
        decode = function(arg1)
            return {
                placeId = placeId,
                versionToRollback = versionToRollback,
                newVersionNumber = toNumber(arg1.newVersionNumber),
                message = message
            }
        end
    })
    return asPromise(var2)
end

function module.addVersionNote(placeId: number, version: string, body, tbl1)
    local _network, var1 = resolveBase(tbl1)
    local var2 = if body.title == nil then "nil" else tostring(#body.title)
    local var3 = if body.description == nil then "nil" else tostring(#body.description)

    local var4 = fetch({
        network = resolveMutatingNetwork(tbl1),
        method = "POST",
        url = notesUrl(var1, placeId, version),
        body = body,
        analyticsKey = "place-version-history.add-note",
        analytics = function(_, arg1, arg2, arg3, arg4, arg5)
            if arg3 == nil then
                if arg5 ~= "succeeded" then
                    debugNote(
                        `request failed method={arg1} url={arg2} status={arg5} durationMs={math.floor(arg4)} titleLength={var2} descriptionLength={var3} response=nil`
                    )
                end
            elseif arg5 ~= "succeeded" or not (arg3.statusCode >= 200 and arg3.statusCode < 300) then
                local statusCode = arg3.statusCode
                local httpError = arg3.httpError
                debugNote(
                    `request failed method={arg1} url={arg2} status={arg5} httpStatus={statusCode} httpError={tostring(httpError)} durationMs={math.floor(arg4)} titleLength={var2} descriptionLength={var3} body="{bodyPreview(arg3.responseBody)}"`
                )
            end
        end,
        decode = function(arg1)
            return {
                placeId = placeId,
                version = version,
                placeVersion = arg1.placeVersion
            }
        end
    })
    return asPromise(var4)
end

return module
