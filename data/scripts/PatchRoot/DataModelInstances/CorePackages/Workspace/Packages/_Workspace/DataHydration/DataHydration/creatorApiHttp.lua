-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpService = game:GetService("HttpService")

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBuilder = require(DataHydrationParent.UrlBuilder)
local UrlBase = UrlBuilder.UrlBase

local withCsrfRetry = require(DataHydration.withCsrfRetry)

local module = {}

function module.baseUrl(tbl1)
    return (tbl1 or {}).baseUrl or UrlBase.APIS
end

function module.withoutRestrictedAcceptHeader(arg1)
    return {
        request = function(arg2, func1: (...any) -> (...any))
            local tbl1

            if arg2.headers == nil then
                tbl1 = nil
            else
                tbl1 = {}
                for k, header in arg2.headers do
                    if string.lower(k) ~= "accept" then
                        tbl1[k] = header
                    end
                end
            end

            local var1 = table.clone(arg2)
            var1.headers = tbl1
            return arg1.request(var1, func1)
        end
    }
end

function module.readNetwork(tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.readNetwork or tbl2.network
    if var1 ~= nil then
        return module.withoutRestrictedAcceptHeader(var1)
    end
    local requestInternalNetwork = HttpClient.createRequestInternalNetwork()
    local withoutRestrictedAcceptHeader = module.withoutRestrictedAcceptHeader
    if tbl2.retryReads ~= false then
        requestInternalNetwork = HttpClient.withRetry(requestInternalNetwork)
    end

    return withoutRestrictedAcceptHeader(requestInternalNetwork)
end

function module.mutatingNetwork(tbl1)
    local tbl2 = tbl1 or {}
    return module.withoutRestrictedAcceptHeader(
        tbl2.mutatingNetwork or tbl2.network or withCsrfRetry(HttpClient.createRequestInternalNetwork())
    )
end

function module.imagePart(tbl1)
    return {
        name = "imageFile",
        value = tbl1.content,
        fileName = tbl1.fileName,
        contentType = tbl1.contentType
    }
end

function module.buildMultipartBody(tbl1): string
    local tbl2 = {}
    for _, value in tbl1 do
        table.insert(
            tbl2,
            "--"
                .. "-------CreatorMonetizationFormBoundary"
                    .. "\r\n"
                        .. (if value.fileName ~= nil then ("Content-Disposition: form-data; name=\"%s\"; filename=\"%s\""):format(value.name, value.fileName) else ("Content-Disposition: form-data; name=\"%s\""):format(value.name))
                            .. "\r\n" .. (if value.contentType == nil then "" else "Content-Type: " .. value.contentType .. "\r\n") .. "\r\n" .. value.value .. "\r\n"
        )
    end
    table.insert(tbl2, "---------CreatorMonetizationFormBoundary--\r\n")
    return table.concat(tbl2)
end

local function tryJsonDecode(buf) -- Luacid: Inlined by compiler; 2 call sites recovered
    if buf == nil or buf == "" then
        return nil
    end
    if typeof(buf) == "buffer" then
        buf = buffer.tostring(buf)
    end

    local success, result = pcall(HttpService.JSONDecode, HttpService, buf)
    return if success then result else nil
end

local function isOk(statusCode: number): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return statusCode >= 200 and statusCode < 300
end

function module.errorFrom(arg1)
    local var1 = tryJsonDecode(arg1.responseBody)
    if typeof(var1) == "table" then
        local var2 = var1.errorMessage or var1.message
        if typeof(var2) == "string" then
            if typeof(var1.errorCode) == "string" then
                var2 = `{var1.errorCode}: {var2}`
            end

            return var2, arg1.statusCode
        end
    end
    local var2 = if typeof(arg1.responseBody) == "buffer" then buffer.tostring(arg1.responseBody) else arg1.responseBody or ""

    return ("http %d: %s"):format(arg1.statusCode, var2), arg1.statusCode
end

function module.jsonDecoder(func1: (...any) -> (...any))
    return function(arg1)
        if isOk(arg1.statusCode) then
            return func1((tryJsonDecode(arg1.responseBody))), nil, nil
        end

        local var1, var2 = module.errorFrom(arg1)
        return nil, var1, var2
    end
end

function module.noContentDecoder(func1: (...any) -> (...any))
    return function(arg1)
        if isOk(arg1.statusCode) then
            return func1(), nil, nil
        end

        local var1, var2 = module.errorFrom(arg1)
        return nil, var1, var2
    end
end

function module.multipart(networkImpl, method: string, url: string, tbl1, analyticsKey: string, decode: (...any) -> (...any))
    return HttpClient.asPromise(
        HttpClient.createRequest({
            networkImpl = networkImpl,
            method = method,
            url = url,
            body = module.buildMultipartBody(tbl1),
            headers = {},
            encode = HttpClient.encodeRaw("multipart/form-data; boundary=-------CreatorMonetizationFormBoundary"),
            decode = decode,
            analyticsKey = analyticsKey
        })
    )
end

function module.json(networkImpl, method: string, url: string, body, analyticsKey: string, decode: (...any) -> (...any))
    return HttpClient.asPromise(
        HttpClient.createRequest({
            networkImpl = networkImpl,
            method = method,
            url = url,
            body = body,
            headers = {},
            decode = decode,
            analyticsKey = analyticsKey
        })
    )
end

function module.get(tbl1, url: string, analyticsKey: string, func1: (...any) -> (...any))
    return HttpClient.asPromise(
        HttpClient.createRequest({
            networkImpl = module.readNetwork(tbl1),
            method = "GET",
            url = url,
            body = nil,
            headers = {},
            analyticsKey = analyticsKey,
            decode = module.jsonDecoder(func1)
        })
    )
end

function module.withQuery(str1: string, tbl1)
    local tbl2 = ({})
    for value, value2 in tbl1 do
        if value2 ~= nil and value2 ~= "" then
            tbl2[value] = value2
        end
    end
    if next(tbl2) == nil then
        return str1
    end
    return UrlBuilder.UrlBuilder.addQueryString(str1, tbl2)
end

return module
