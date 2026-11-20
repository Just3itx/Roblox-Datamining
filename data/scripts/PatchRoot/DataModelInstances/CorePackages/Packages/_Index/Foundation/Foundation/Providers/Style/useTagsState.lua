-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent
local React = require(FoundationParent.React)

local function useTagsState()
    local var1, var2 = React.useState({})

    return var1, (React.useCallback(function(...)
        local tbl1 = {}

        for _, value in { ... } do
            for _, value2 in string.split(value, " ") do
                table.insert(tbl1, value2)
            end
        end

        var2(function(arg1)
            local bool1 = false

            for _, value in tbl1 do
                if arg1[value] ~= true then
                    bool1 = true
                    break
                end
            end

            if not bool1 then
                return arg1
            end

            local var3 = table.clone(arg1)
            for _, value in tbl1 do
                var3[value] = true
            end
            return var3
        end)
    end, { var2 }))
end

return useTagsState
