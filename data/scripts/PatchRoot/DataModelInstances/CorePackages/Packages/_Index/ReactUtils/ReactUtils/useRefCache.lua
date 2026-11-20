-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)

local function useRefCache()
    local var1 = React.useRef(nil)

    if var1.current == nil then
        local current = ({})

        setmetatable(current, {
            __index = function(_, arg1)
                local ref = React.createRef()
                current[arg1] = ref
                return ref
            end,
            __tostring = function(arg1): string
                local str1 = "{"

                for k, value in pairs(arg1) do
                    str1 = ("%s\n\t%s -> %s"):format(str1, tostring(k), tostring(value))
                end

                return str1 .. "\n}"
            end
        })

        var1.current = current
    end

    return var1.current
end

return useRefCache
