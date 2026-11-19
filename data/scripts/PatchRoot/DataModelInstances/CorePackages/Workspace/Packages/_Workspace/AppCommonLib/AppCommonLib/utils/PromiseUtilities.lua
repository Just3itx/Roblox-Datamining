-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppCommonLibParent = script:FindFirstAncestor("AppCommonLib").Parent

local Result = require(AppCommonLibParent.Result)
local Promise = require(AppCommonLibParent.Promise)

local module = {}

function module.Batch(arg1, callback: ((...any) -> (...any))?)
    assert(type(arg1) == "table", "PromiseUtilities expects a list of Promises!")

    local num1 = 0

    for _, value in pairs(arg1) do
        assert(Promise.is(value), "PromiseUtilities expects a list of Promises!")
        num1 += 1
    end

    return Promise.new(function(callback2, _)
        local num2 = 0
        local tbl1 = ({})

        local function promiseCompleted(arg2, bool1: boolean, arg3) -- Luacid: Inlined by compiler; 2 call sites recovered
            tbl1[arg2] = Result.new(bool1, arg3)
            num2 += 1

            if num2 == num1 then
                callback2(tbl1)
            end
        end

        if next(arg1) == nil then
            callback2(tbl1)
        end

        for k, value in pairs(arg1) do
            value:andThen(function(arg2, ...)
                local select = select

                if select("#", ...) > 0 then
                    warn("Promises in PromiseUtilities.Batch should not return tuple")
                end
                promiseCompleted(k, true, arg2)
            end, function(arg2)
                promiseCompleted(k, false, arg2)
                if callback then
                    callback(arg2)
                end
            end)
        end
    end)
end

function module.CountResults(arg1)
    local num1 = 0
    local num2 = 0

    for _, value in pairs(arg1) do
        local var1, _ = value:unwrap()
        if not var1 then
            num2 += 1
        end
        num1 += 1
    end

    return {
        successCount = num1 - num2,
        failureCount = num2,
        totalCount = num1
    }
end

return module
