-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:41:22Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Http = script:FindFirstAncestor("Http")
local HttpParent = Http.Parent

local Thumbnail = require(Http.Models).Thumbnail
local PerformFetch = require(Http.PerformFetch)

local ArgCheck = require(HttpParent.ArgCheck)
local Promise = require(HttpParent.Promise)
local Result = require(HttpParent.Result)

local tutils = require(HttpParent.tutils)

local num1 = math.max(0, tonumber(settings():GetFVariable("LuaAppNonFinalThumbnailMaxRetries")) or 0)

local num2 = math.max(0, tonumber(settings():GetFVariable("LuaAppThumbnailsApiRetryTimeMultiplier")) or 0)

local module = {}

function module._fetchIcons(arg1, arg2, arg3, iconSize, keyMapper, requestName, arg4, arg5)
    local function keyMapperForCurrentRequestNameAndSize(targetId) -- Luacid: Inlined by compiler; 2 call sites recovered
        return keyMapper({ targetId = targetId, requestName = requestName, iconSize = iconSize })
    end

    local function getTableOfFailedResults(arg6)
        local tableOfFailedResults = {}
        for _, targetId in pairs(arg6) do
            tableOfFailedResults[keyMapperForCurrentRequestNameAndSize(targetId)] = Result.new(false, { targetId = targetId })
        end

        return tableOfFailedResults
    end

    return arg4(arg2, arg3, iconSize):andThen(function(arg6)
        local tableOfFailedResults = getTableOfFailedResults(arg3)
        local tbl1 = ({})

        local data = arg6 and arg6.responseBody and arg6.responseBody.data
        if typeof(data) == "table" then
            for _, value in pairs(data) do
                if not Thumbnail.isCompleteThumbnailData(value) then
                    continue
                end

                local targetId = tostring(value.targetId)
                local bool1

                if Thumbnail.checkStateIsFinal(value.state) then
                    tbl1[targetId] = Thumbnail.fromThumbnailData(value, iconSize)
                    bool1 = true
                else
                    bool1 = false
                end

                tableOfFailedResults[keyMapperForCurrentRequestNameAndSize(targetId)] = Result.new(bool1, value)
            end
        end

        arg1:dispatch(arg5(tbl1))
        return Promise.resolve(tableOfFailedResults)
    end, function(_)
        local tableOfFailedResults = getTableOfFailedResults(arg3)
        return Promise.resolve(tableOfFailedResults)
    end)
end

function module._fetch(arg1, arg2, arg3, iconSize, keyMapper, requestName, arg4, arg5)
    return module._fetchIcons(arg1, arg2, arg3, iconSize, keyMapper, requestName, arg4, arg5):andThen(function(arg6)
        local tbl1 = ({})
        local var1 = arg6

        if _G.__TESTEZ_RUNNING_TEST__ then
            num1 = 1
            num2 = 0.001
        end

        local function retry(arg7)
            local tbl2 = {}

            for k, value in pairs(var1) do
                local var2, var3 = value:unwrap()

                if var2 and Thumbnail.checkStateIsFinal(var3.state) then
                    tbl1[k] = value
                else
                    table.insert(tbl2, var3)
                end
            end

            if tutils.fieldCount(tbl2) == 0 then
                return Promise.resolve(tbl1)
            end

            return Promise.new(function(callback, _)
                coroutine.wrap(function()
                    wait(num2 * math.pow(2, arg7 - 1))
                    callback()
                end)()
            end):andThen(function()
                return module._fetchIcons(arg1, arg2, arg3, iconSize, keyMapper, requestName, arg4, arg5)
            end):andThen(function(arg8)
                var1 = arg8
                if arg7 > 1 then
                    return retry(arg7 - 1)
                end
                return Promise.resolve(tbl1)
            end)
        end

        return retry(num1)
    end)
end

function module.Fetch(arg1, arg2, keyMapper, requestName, arg3, arg4)
    ArgCheck.isType(arg2, "table", "requests")
    ArgCheck.isType(requestName, "string", "requestName")
    ArgCheck.isNonNegativeNumber(#arg2, "requests count")

    module.KeyMapper = keyMapper
    return PerformFetch.Batch(arg2, keyMapper, function(arg5, arg6)
        local tbl1 = {}
        local iconSize = nil

        for _, value in ipairs(arg6) do
            local targetId = value.targetId
            iconSize = value.iconSize
            table.insert(tbl1, targetId)
        end
        return module._fetch(arg5, arg1, tbl1, iconSize, keyMapper, requestName, arg3, arg4)
    end)
end

return module
