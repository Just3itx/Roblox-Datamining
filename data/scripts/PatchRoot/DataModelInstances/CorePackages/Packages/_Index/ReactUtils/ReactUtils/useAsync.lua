-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)

local function useAsync(func1: (...any) -> (...any), tbl1)
    local var1, var2 = React.useState({ status = "loading" })

    React.useEffect(function()
        var2({ status = "loading" })

        local var3 = task.spawn(function()
            xpcall(function()
                var2({ status = "ok", value = func1() })
            end, function(problem)
                var2({ status = "error", problem = problem })
            end)
        end)

        return function()
            task.cancel(var3)
        end
    end, tbl1)

    return var1
end

return useAsync
