-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Http = script:FindFirstAncestor("Http")
local UpdateFetchingStatus = require(Http.Actions).UpdateFetchingStatus
local BatchUpdateFetchingStatus = require(Http.Actions).BatchUpdateFetchingStatus

local function createPerformFetchMiddleware(arg1)
    local tbl1 = {}
    local bool1 = false
    local var1 = arg1 or 0

    return function(arg2, arg3)
        local function runBatchDispatcher() -- Luacid: Inlined by compiler; 2 call sites recovered
            if bool1 then
                return
            end

            bool1 = true
            task.delay(var1, function()
                local var2 = tbl1
                tbl1 = {}
                bool1 = false

                arg3:dispatch(BatchUpdateFetchingStatus(var2, true))
            end)
        end

        return function(arg4)
            if arg4.type == UpdateFetchingStatus.name then
                table.insert(tbl1, arg4)
                runBatchDispatcher()
                return nil
            end

            if arg4.type ~= BatchUpdateFetchingStatus.name or arg4.shouldImmediatelyDispatch then
                return arg2(arg4)
            end

            for _, value in pairs(arg4.fetchingStatuses) do
                table.insert(tbl1, value)
            end

            runBatchDispatcher()
            return nil
        end
    end
end

return createPerformFetchMiddleware
