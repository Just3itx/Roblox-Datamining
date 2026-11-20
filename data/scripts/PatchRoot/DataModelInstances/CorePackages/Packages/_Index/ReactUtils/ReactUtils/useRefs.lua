-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)

local function useRefs(current: number, current2)
    local var1 = React.useRef({})

    local var2 = React.useRef(current)

    if #var1.current < current then
        for _ = 1, current - #var1.current do
            local ref = React.createRef()
            ref.current = current2
            table.insert(var1.current, ref)
        end
    elseif current < var2.current then
        for i = current + 1, var2.current do
            var1.current[i].current = current2
        end
    end

    var2.current = current

    return (React.useMemo(function()
        return table.move(var1.current, 1, current, 1, {})
    end, { current }))
end

return useRefs
