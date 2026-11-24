-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local HttpClient = require(DataHydrationParent.HttpClient)
local Promise = require(DataHydrationParent.Promise)
local FFlagMomentsRenderAvatarPostsInFeed = require(DataHydrationParent.SharedFlags).FFlagMomentsRenderAvatarPostsInFeed

local function nonEmptyString(arg1): string? -- Luacid: Inlined by compiler; 4 call sites recovered
    return if type(arg1) == "string" and arg1 ~= "" then arg1 else nil
end

local function normalizeLookByOutfit(arg1)
    if type(arg1) ~= "table" then
        return nil, `Type table required, got {type(arg1)}.`
    end
    if type(arg1.look) ~= "table" then
        return {}, "look normalization failed with: \"look\" is absent or not a table"
    end

    local look = arg1.look
    local lookId = look.lookId
    if type(lookId) ~= "string" then
        return nil, "look normalization failed with: required field \"lookId\" is absent or not a string"
    end

    local tbl1

    if FFlagMomentsRenderAvatarPostsInFeed then
        tbl1 = table.clone(look)
        tbl1.lookId = lookId
        local outfitId = if type(look.outfitId) == "number" then look.outfitId else nil
        tbl1.outfitId = outfitId
        tbl1.name = nonEmptyString(look.name)
        tbl1.description = nonEmptyString(look.description)
        local totalPrice = if type(look.totalPrice) == "number" then look.totalPrice else nil
        tbl1.totalPrice = totalPrice
        local items = look.items
        tbl1.items = type(items) ~= "table" and {} or look.items
        tbl1.itemCount = #tbl1.items
    else
        tbl1 = {
            lookId = lookId,
            outfitId = if type(look.outfitId) == "number" then look.outfitId else nil,
            name = nonEmptyString(look.name),
            description = nonEmptyString(look.description),
            totalPrice = if type(look.totalPrice) == "number" then look.totalPrice else nil,
            itemCount = type(look.items) == "table" and #look.items or 0
        }
    end
    return { look = tbl1 }, nil
end

local function isLookNotFound(arg1): boolean
    if type(arg1) ~= "table" then
        return false
    end
    if arg1.responseCode ~= 400 then
        return false
    end

    local result = nil
    local response = arg1.response
    if type(response) == "table" then
        result = response.responseBody
    elseif type(arg1.errorMessage) == "string" then
        local _, var1 = string.find(arg1.errorMessage, "^http %d+: ")
        if var1 then
            result = string.sub(arg1.errorMessage, var1 + 1)
        end
    end
    if type(result) == "string" then
        local jsonDecode = HttpService.JSONDecode
        local success
        success, result = pcall(jsonDecode, HttpService, result)
        if not success then
            result = nil
        end
    end

    return type(result) == "table" and result.errorCode == 98
end

local function fetchLookByOutfit(num1: number, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.baseUrl or Http.Url.APIS_URL

    local var2 = HttpClient.fetch({
        network = tbl2.network,
        method = "GET",
        url = var1 .. "look-api/v2/looks/by-outfit/" .. tostring(num1),
        analyticsKey = "look-api.get-by-outfit",
        decode = function(arg1)
            local var2, _ = normalizeLookByOutfit(arg1)
            return var2 or {}
        end
    })

    return HttpClient.asPromise(var2):catch(function(arg1)
        if isLookNotFound(arg1) then
            return {}
        end
        return Promise.reject(arg1)
    end)
end

return fetchLookByOutfit
