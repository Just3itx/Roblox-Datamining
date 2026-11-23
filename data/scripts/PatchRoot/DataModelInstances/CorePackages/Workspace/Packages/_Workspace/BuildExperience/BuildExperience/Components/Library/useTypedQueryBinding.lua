-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local function useTypedQueryBinding(str1: string?)
    local var1, var2 = React.useBinding(str1 or "")
    local var3 = React.useRef({})

    React.useEffect(function()
        local str2 = str1 or ""
        local current = var3.current
        local var4 = table.find(current, str2)
        if var4 ~= nil then
            for _ = 1, var4 do
                table.remove(current, 1)
            end
            return
        end
        table.clear(current)
        if var1:getValue() ~= str2 then
            var2(str2)
        end
    end, { str1 })

    return var1, (React.useCallback(function(str2: string)
        table.insert(var3.current, str2)
        var2(str2)
    end, { var2 }))
end

return useTypedQueryBinding
