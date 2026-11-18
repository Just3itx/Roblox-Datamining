-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:41:01Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Http = script:FindFirstAncestor("Http")
local HttpParent = Http.Parent

local Result = require(HttpParent.Result)
local Promise = require(HttpParent.Promise)

local PromiseUtilities = require(HttpParent.AppCommonLib).Utils.PromiseUtilities
local RetrievalStatus = require(Http.Enum).RetrievalStatus
local BatchUpdateFetchingStatus = require(Http.Actions).BatchUpdateFetchingStatus

local module = {}

local tbl1 = ({})

function module.ClearOutstandingPromiseStatus()
    tbl1 = {}
end

local function singleFetchKeymapper<T>(arg1: T): T
    return arg1
end

function module.GetStatus(arg1, arg2)
    assert(typeof(arg1) == "table")
    assert(typeof(arg2) == "string")
    assert(#arg2 > 0)
    return arg1.FetchingStatus[arg2] or RetrievalStatus.NotStarted
end

function module.Single(arg1, arg2)
    assert(typeof(arg1) == "string")
    assert(typeof(arg2) == "function")
    assert(#arg1 > 0)

    return function(arg3)
        return module.Batch({ arg1 }, singleFetchKeymapper, function(arg4, arg5)
            assert(#arg5 == 1)

            local var1 = arg2(arg4)
            assert(Promise.is(var1))

            return var1:andThen(function(...)
                assert(#{ ... } <= 1)
                return Promise.resolve({ [arg1] = Result.new(true, (...)) })
            end, function(...)
                assert(#{ ... } <= 1)
                return Promise.resolve({ [arg1] = Result.new(false, (...)) })
            end)
        end)(arg3):andThen(function(arg4)
            local var1, var2 = arg4[arg1]:unwrap()
            if var1 then
                return Promise.resolve(var2)
            end
            return Promise.reject(var2)
        end)
    end
end

function module.Batch(arg1, arg2, arg3)
    assert(typeof(arg1) == "table")
    assert(typeof(arg2) == "function")
    assert(typeof(arg3) == "function")

    return function(arg4)
        local tbl2 = {}
        local tbl3 = ({})
        local tbl4 = ({})

        for _, value in ipairs(arg1) do
            local var1 = arg2(value)
            local var2 = tbl1[var1]

            if var2 then
                tbl4[var1] = var2
            else
                table.insert(tbl2, value)
                tbl3[value] = var1
            end
        end

        local var1 = nil
        local promise = Promise.new(function(arg5)
            var1 = arg5
        end)

        local var2

        if #tbl2 > 0 then
            local tbl5 = {}
            for _, key in pairs(tbl3) do
                table.insert(tbl5, { key = key, status = RetrievalStatus.Fetching })
                tbl1[key] = promise
            end
            if #tbl5 > 0 then
                arg4:dispatch(BatchUpdateFetchingStatus(tbl5))
            end

            var2 = arg3(arg4, tbl2)
            assert(Promise.is(var2))
        else
            var2 = Promise.resolve({})
        end

        var2:andThen(function(arg5)
            local var3 = arg5 or {}

            return PromiseUtilities.Batch(tbl4):andThen(function(arg6)
                local tbl5 = ({})
                for k, value in pairs(arg6) do
                    local _, var4 = value:unwrap()
                    tbl5[k] = var4[k]
                end

                return var3, tbl5
            end)
        end, function()
            assert(false, "PerformFetch fetchFunctor should never reject")
        end):andThen(function(arg5, arg6)
            local tbl5 = {}
            for _, key in pairs(tbl3) do
                local var3 = arg5[key]
                if Result.is(var3) then
                    arg6[key] = var3
                else
                    arg6[key] = Result.error()
                end

                local status = arg6[key]:unwrap() and RetrievalStatus.Done or RetrievalStatus.Failed
                table.insert(tbl5, { key = key, status = status })

                tbl1[key] = nil
            end
            if #tbl5 > 0 then
                arg4:dispatch(BatchUpdateFetchingStatus(tbl5))
            end

            return arg6
        end):andThen(function(arg5)
            var1(arg5)
        end)

        return promise
    end
end

return module
