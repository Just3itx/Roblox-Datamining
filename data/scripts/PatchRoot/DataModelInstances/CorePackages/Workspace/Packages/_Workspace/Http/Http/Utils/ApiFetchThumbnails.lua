-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Http = script:FindFirstAncestor("Http")
local HttpParent = Http.Parent

local Cryo = require(HttpParent.Cryo)
local ArgCheck = require(HttpParent.ArgCheck)
local PromiseUtilities = require(HttpParent.AppCommonLib).Utils.PromiseUtilities
local FetchSubdividedThumbnails = require(script.Parent.FetchSubdividedThumbnails)

local PerformFetch = require(Http.PerformFetch)

local function convertToId(targetId): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return tostring(targetId)
end

local module = {}

local function KeyMapper(arg1)
    local targetId = arg1.targetId
    local var1 = arg1.iconSize and "." .. arg1.iconSize or ""
    local var2 = arg1.requestName and "." .. arg1.requestName or ""
    return "luaapp.thumbnails." .. convertToId(targetId) .. var1 .. var2
end

module.KeyMapper = KeyMapper

local function subdivideIdsArray(tbl1, num1: number)
    local result = {}
    for i = 1, #tbl1, num1 do
        table.insert(result, (Cryo.List.getRange(tbl1, i, i + num1 - 1)))
    end
    return result
end

function module.Fetch(arg1, arg2, arg3, requestName, arg4, arg5, arg6)
    local iconSize = arg3 or "150x150"
    ArgCheck.isType(arg2, "table", "targetIds")
    ArgCheck.isType(requestName, "string", "requestName")
    ArgCheck.isNonNegativeNumber(#arg2, "targetIds count")

    local tbl1 = {}
    local tbl2 = {}

    for _, targetId in pairs(arg2) do
        table.insert(tbl1, { targetId = targetId, iconSize = iconSize, requestName = requestName })
    end

    local tbl3 = subdivideIdsArray(tbl1, 100)
    for _, value in ipairs(tbl3) do
        local fetch = FetchSubdividedThumbnails.Fetch
        table.insert(tbl2, arg6:dispatch(fetch(arg1, value, KeyMapper, requestName, arg4, arg5)))
    end

    return PromiseUtilities.Batch(tbl2)
end

function module.GetFetchingStatus(arg1, targetId, iconSize, requestName)
    local getStatus = PerformFetch.GetStatus

    local tbl1 = { targetId = targetId, requestName = requestName, iconSize = iconSize }
    local var1 = tbl1.iconSize and "." .. tbl1.iconSize or ""
    local var2 = tbl1.requestName and "." .. tbl1.requestName or ""
    return getStatus(arg1, "luaapp.thumbnails." .. convertToId(tbl1.targetId) .. var1 .. var2)
end

return module
