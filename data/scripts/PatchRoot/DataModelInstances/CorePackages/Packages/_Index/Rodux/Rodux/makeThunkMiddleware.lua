-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function tracebackReporter(arg1)
    return debug.traceback(arg1)
end

local function makeThunkMiddleware(arg1)
    local function thunkMiddleware(arg2, arg3)
        return function(arg4)
            if typeof(arg4) ~= "function" then
                return arg2(arg4)
            end

            local success, result = xpcall(function()
                return arg4(arg3, arg1)
            end, tracebackReporter)

            if success then
                return result
            end

            arg3._errorReporter.reportReducerError(
                arg3:getState(),
                arg4,
                { message = "Caught error in thunk", thrownValue = result }
            )
            return nil
        end
    end

    return thunkMiddleware
end

return makeThunkMiddleware
