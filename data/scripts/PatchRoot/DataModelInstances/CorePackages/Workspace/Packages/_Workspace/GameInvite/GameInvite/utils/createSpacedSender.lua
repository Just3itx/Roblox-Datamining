-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent

local Promise = require(GameInviteParent.Promise)

return function(options)
    local num1 = 0

    return {
        send = function(func1: (...any) -> (...any))
            return Promise.new(function(arg1, arg2)
                local var1 = options.now()
                local num2 = math.max(var1, num1)
                num1 = num2 + options.minIntervalSeconds

                local function dispatch() -- Luacid: Inlined by compiler; 1 call site recovered
                    Promise.try(func1):andThen(arg1, arg2)
                end

                local var2 = num2 - var1
                if var2 <= 0 then
                    dispatch()
                    return
                end

                options.delay(var2, dispatch)
            end)
        end,
        options = options
    }
end
