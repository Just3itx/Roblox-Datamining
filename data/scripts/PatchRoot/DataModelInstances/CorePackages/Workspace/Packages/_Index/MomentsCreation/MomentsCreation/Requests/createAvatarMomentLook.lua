-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local Http = require(MomentsCreationParent.Http)
local HttpClient = require(MomentsCreationParent.HttpClient)

local url = Http.Url.APIS_URL .. "look-api/v1/avatar-moments/create"

local function bodyToString(responseBody): string -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(responseBody) == "string" then
        return responseBody
    elseif typeof(responseBody) == "buffer" then
        return buffer.tostring(responseBody)
    end
    return ""
end

local function createAvatarMomentLook(body, tbl1)
    local createRequest = HttpClient.createRequest
    local tbl2 = {
        networkImpl = if tbl1 and tbl1.network then tbl1.network else HttpClient.createRequestInternalNetwork(),
        method = "POST",
        url = url,
        headers = { ["Content-Type"] = "application/json" },
        body = body,
        analyticsKey = "moments-creation.create-avatar-moment-look",
        decode = 0
    }
    function tbl2.decode(arg1)
        local success, result = pcall(HttpService.JSONDecode, HttpService, (bodyToString(arg1.responseBody)))
        local outfitId = if success and type(result) == "table" and type(result.outfitId) == "number" then result.outfitId else nil
        return {
            statusCode = arg1.statusCode,
            outfitId = outfitId
        }
    end

    local request = createRequest(tbl2)

    return HttpClient.asPromise(request)
end

return createAvatarMomentLook
