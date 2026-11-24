-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpService = game:GetService("HttpService")

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local withCsrfRetry = require(DataHydration.withCsrfRetry)
local _AssetUserAuthStoreTypes = require(script.Parent.AssetUserAuthStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function resolveBase(tbl1) -- Luacid: Inlined by compiler; 4 call sites recovered
    local tbl2 = tbl1 or {}
    return tbl2.network, tbl2.baseUrl or UrlBase.APIS
end

local function resolveMutatingNetwork(tbl1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return (tbl1 or {}).network or withCsrfRetry(HttpClient.createRequestInternalNetwork())
end

local function buildMultipartBody(str1: string, str2: string?, str3: string?): string -- Luacid: unused: defined but never referenced
    local str4 = "---------PublishServiceCreateAsset\r\nContent-Disposition: form-data; name=\"request\"\r\nContent-Type: application/json\r\n\r\n" .. str1 .. "\r\n"
    if str2 then
        str4 = ((((str4 .. "---------PublishServiceCreateAsset\r\n") .. "Content-Disposition: form-data; name=\"fileContent\"; filename=\"contentToUpload\"\r\n") .. "Content-Type: " .. (str3 or "application/octet-stream") .. "\r\n") .. "\r\n")
            .. str2 .. "\r\n"
    end
    return str4 .. "---------PublishServiceCreateAsset--\r\n"
end

local createRequest = HttpClient.createRequest
local encodeRaw = HttpClient.encodeRaw
local decodeJson = HttpClient.decodeJson

local function multipartRequest(networkImpl, method: string, url: string, body: string, analyticsKey: string)
    local request = createRequest({
        networkImpl = networkImpl,
        method = method,
        url = url,
        body = body,
        headers = {},
        encode = encodeRaw("multipart/form-data; boundary=-------PublishServiceCreateAsset"),
        decode = decodeJson(function<T>(arg1: T): T
            return arg1
        end),
        analyticsKey = analyticsKey
    })
    return asPromise(request)
end

local module = {}

function module.patchAssetIcon(str1: string, body, tbl1)
    local _network, var1 = resolveBase(tbl1)
    local url = ("%s/assets/user-auth/v1/assets/%s?updateMask=icon"):format(var1, str1)
    local var2 = fetch({
        network = resolveMutatingNetwork(tbl1),
        method = "PATCH",
        url = url,
        body = body,
        analyticsKey = "asset-user-auth.patch-icon",
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

function module.updateIcon(str1: string, str2: string, tbl1)
    local _network, var1 = resolveBase(tbl1)
    local str3 = ("%s/assets/user-auth/v1/assets/%s?updateMask=icon"):format(var1, str1)
    local str4 = ("---------PublishServiceCreateAsset\r\nContent-Disposition: form-data; name=\"request\"\r\nContent-Type: application/json\r\n\r\n" .. HttpService:JSONEncode({ assetId = tonumber(str1), icon = `assets/{str2}` }) .. "\r\n")
        .. "---------PublishServiceCreateAsset--\r\n"

    return multipartRequest(resolveMutatingNetwork(tbl1), "PATCH", str3, str4, "asset-user-auth.update-icon")
end

function module.getPreviews(str1: string, tbl1)
    local tbl2 = tbl1 or {}
    local network = tbl2.network
    local url = ("%s/assets/user-auth/v1/assets/%s?readMask=previews"):format(tbl2.baseUrl or UrlBase.APIS, str1)
    local var1 = fetch({
        network = network,
        method = "GET",
        url = url,
        analyticsKey = "asset-user-auth.get-previews",
        decode = function(arg1)
            return arg1.previews or {}
        end
    })
    return asPromise(var1)
end

function module.updatePreviews(str1: string, previews, tbl1)
    local _network, var1 = resolveBase(tbl1)
    local str2 = ("%s/assets/user-auth/v1/assets/%s?updateMask=previews"):format(var1, str1)
    local str3 = ("---------PublishServiceCreateAsset\r\nContent-Disposition: form-data; name=\"request\"\r\nContent-Type: application/json\r\n\r\n" .. HttpService:JSONEncode({ assetId = tonumber(str1), previews = previews }) .. "\r\n")
        .. "---------PublishServiceCreateAsset--\r\n"

    return multipartRequest(resolveMutatingNetwork(tbl1), "PATCH", str2, str3, "asset-user-auth.update-previews")
end

function module.createImageAsset(str1: string, str2: string, arg1, tbl1)
    local _network, var1 = resolveBase(tbl1)
    local str3 = ("%s/assets/user-auth/v1/assets"):format(var1)
    local creator = arg1.groupId and {
        groupId = arg1.groupId
    } or {
        userId = arg1.userId or ""
    }
    local str4 = "---------PublishServiceCreateAsset\r\nContent-Disposition: form-data; name=\"request\"\r\nContent-Type: application/json\r\n\r\n"
        .. HttpService:JSONEncode({
            assetType = "Image",
            displayName = arg1.displayName or "Game Thumbnail",
            description = arg1.description or "Game thumbnail from capture",
            creationContext = { creator = creator }
        }) .. "\r\n"

    if str1 then
        str4 = ((((str4 .. "---------PublishServiceCreateAsset\r\n") .. "Content-Disposition: form-data; name=\"fileContent\"; filename=\"contentToUpload\"\r\n") .. "Content-Type: " .. (str2 or "application/octet-stream") .. "\r\n") .. "\r\n")
            .. str1 .. "\r\n"
    end
    local str5 = str4 .. "---------PublishServiceCreateAsset--\r\n"

    return multipartRequest(resolveMutatingNetwork(tbl1), "POST", str3, str5, "asset-user-auth.create-image-asset")
end

function module.fetchOperation(str1: string, tbl1)
    local tbl2 = tbl1 or {}
    local network = tbl2.network
    local url = ("%s/assets/user-auth/v1/operations/%s"):format(tbl2.baseUrl or UrlBase.APIS, str1)
    local var1 = fetch({
        network = network,
        method = "GET",
        url = url,
        analyticsKey = "asset-user-auth.get-operation",
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var1)
end

return module
