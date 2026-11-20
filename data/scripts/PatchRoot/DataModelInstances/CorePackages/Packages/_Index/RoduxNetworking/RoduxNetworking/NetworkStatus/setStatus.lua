-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EnumNetworkStatus = require(script.Parent.EnumNetworkStatus)
local buildActionName = require(script.Parent.buildActionName)
local Promise = require(script.Parent.Promise)

return function(arg1)
    local var1 = require(script.Parent.getStatus)(arg1)

    local function actionCreator(ids, keymapper, status) -- Luacid: Inlined by compiler; 3 call sites recovered
        return {
            ids = ids,
            keymapper = keymapper,
            status = status,
            type = buildActionName(arg1)
        }
    end

    local function filter(state, arg2, arg3)
        local result = {}
        for _, value in ipairs(arg2) do
            if var1(state, arg3(value)) ~= EnumNetworkStatus.Fetching then
                table.insert(result, value)
            end
        end
        return result
    end

    return function(arg2, arg3, keymapper, arg4)
        local tbl1 = filter(arg2:getState(), arg3, keymapper)

        if arg1.killRequestWithFilteredIds and #arg3 > 0 and #tbl1 == 0 then
            return Promise.reject("Request with provided IDs already fetching.")
        end

        arg2:dispatch((actionCreator(tbl1, keymapper, EnumNetworkStatus.Fetching)))

        return arg4(arg2, tbl1):andThen(function<T>(arg5: T): T
            arg2:dispatch((actionCreator(tbl1, keymapper, EnumNetworkStatus.Done)))
            return arg5
        end, function(arg5)
            arg2:dispatch((actionCreator(tbl1, keymapper, EnumNetworkStatus.Failed)))
            return Promise.reject(arg5)
        end)
    end
end
