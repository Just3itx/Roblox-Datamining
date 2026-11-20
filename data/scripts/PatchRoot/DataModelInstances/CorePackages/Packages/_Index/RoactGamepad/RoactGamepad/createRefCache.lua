-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Roact)

local function createRefCache()
    local refCache = ({})

    setmetatable(refCache, {
        __index = function(_, arg1)
            local ref = Roact.createRef()
            refCache[arg1] = ref

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

    return refCache
end

return createRefCache
