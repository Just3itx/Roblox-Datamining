-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local Signals = require(GroupsParent.Signals)
local HttpStore = require(GroupsParent.HttpStore)
local Http = require(GroupsParent.Http)
local _Types = require(Groups.Common.Types)

local FFlagLuaAppUseAppHttpStore = require(GroupsParent.SharedFlags).FFlagLuaAppUseAppHttpStore

local InternalHttpStore = require(GroupsParent.InternalHttpStore)

local GROUPS_URL = Http.Url.GROUPS_URL

local module = {}

local function createApiResponse(arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
    return Signals.createComputed(function(arg2)
        local var1 = arg1(arg2)

        if var1.status ~= "Success" then
            if var1.status ~= "Failed" then
                return { status = "Loading", data = nil, error = nil, statusCode = nil }
            end

            local response = var1.response
            return {
                status = "Failed",
                data = nil,
                error = if response then response.ErrorMessage else "Request failed",
                statusCode = if response then response.StatusCode else nil
            }
        end

        local success, result = pcall(HttpService.JSONDecode, HttpService, var1.response.Body)
        local tbl1 = {
            status = if success then "Success" else "Failed",
            data = 0,
            error = 0,
            statusCode = 0
        }

        if not success then
            result = nil
        end

        tbl1.data = result
        tbl1.error = if success then nil else "JSON parse error"
        tbl1.statusCode = var1.response.StatusCode
        return tbl1
    end)
end

function module.GetUserGroupsWithRoles(str1: string)
    local str2 = "GetUserGroupsWithRoles_" .. str1
    local url = string.format("%sv1/users/%s/groups/roles?includeLocked=true", GROUPS_URL, str1)

    local httpStore = InternalHttpStore.GetHttpStore()
    if FFlagLuaAppUseAppHttpStore then
        httpStore = HttpStore.Instance.get()
    end
    local var1, var2 = httpStore.fetch(str2, { Url = url, Method = "GET" })
    return createApiResponse(var1), var2
end

function module.GetPrimaryGroupRole(str1: string)
    local str2 = "GetPrimaryGroupRole_" .. str1
    local url = string.format("%sv1/users/%s/groups/primary/role", GROUPS_URL, str1)

    local httpStore = InternalHttpStore.GetHttpStore()
    if FFlagLuaAppUseAppHttpStore then
        httpStore = HttpStore.Instance.get()
    end
    local var1, var2 = httpStore.fetch(str2, { Url = url, Method = "GET" })
    return createApiResponse(var1), var2
end

function module.GetGroupPolicies(groupIds)
    local var1 = table.clone(groupIds)
    table.sort(var1)
    local str1 = "GetGroupPolicies_" .. table.concat(var1, "_")

    local url = string.format("%sv1/groups/policies", GROUPS_URL)
    local body = HttpService:JSONEncode({ groupIds = groupIds })

    local httpStore = InternalHttpStore.GetHttpStore()
    if FFlagLuaAppUseAppHttpStore then
        httpStore = HttpStore.Instance.get()
    end
    local var2, var3 = httpStore.fetch(str1, { Url = url, Method = "POST", Body = body, Headers = { ["Content-Type"] = "application/json" } })
    return createApiResponse(var2), var3
end

function module.GetGroupsMetadata()
    local url = string.format("%sv1/groups/metadata", GROUPS_URL)

    local httpStore = InternalHttpStore.GetHttpStore()
    if FFlagLuaAppUseAppHttpStore then
        httpStore = HttpStore.Instance.get()
    end
    local var1, var2 = httpStore.fetch("GetGroupsMetadata", { Url = url, Method = "GET" })
    return createApiResponse(var1), var2
end

function module.GetGroupRoles(str1: string)
    local str2 = "GetGroupRoles_" .. str1
    local url = string.format("%sv1/groups/%s/roles", GROUPS_URL, str1)

    local httpStore = InternalHttpStore.GetHttpStore()
    if FFlagLuaAppUseAppHttpStore then
        httpStore = HttpStore.Instance.get()
    end
    local var1, var2 = httpStore.fetch(str2, { Url = url, Method = "GET" })
    return createApiResponse(var1), var2
end

local function fetchGet(str1: string, url: string)
    local httpStore = InternalHttpStore.GetHttpStore()
    if FFlagLuaAppUseAppHttpStore then
        httpStore = HttpStore.Instance.get()
    end
    local var1, var2 = httpStore.fetch(str1, { Url = url, Method = "GET" })
    return createApiResponse(var1), var2
end

function module.GetGroupMembers(str1: string, input: string?, num1: number?)
    local num2 = num1 or 100
    local str2 = "GetGroupMembers_" .. str1 .. "_" .. (input or "") .. "_" .. tostring(num2)
    local str3 = string.format("%sv2/groups/%s/users?sortOrder=Asc&limit=%d", GROUPS_URL, str1, num2)
    if input then
        str3 ..= "&cursor=" .. HttpService:UrlEncode(input)
    end
    return fetchGet(str2, str3)
end

function module.GetGroupRoleMembers(str1: string, num1: number, input: string?, num2: number?)
    local num3 = num2 or 100
    local str2 = "GetGroupRoleMembers_" .. str1 .. "_" .. tostring(num1) .. "_" .. (input or "") .. "_" .. tostring(num3)
    local str3 = string.format("%sv2/groups/%s/users?roleSetId=%d&sortOrder=Asc&limit=%d", GROUPS_URL, str1, num1, num3)

    if input then
        str3 ..= "&cursor=" .. HttpService:UrlEncode(input)
    end
    return fetchGet(str2, str3)
end

return module
