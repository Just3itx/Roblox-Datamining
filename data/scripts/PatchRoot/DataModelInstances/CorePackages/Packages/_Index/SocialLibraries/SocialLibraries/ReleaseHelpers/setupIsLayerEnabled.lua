-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getDeepValue = require(script.Parent.Parent.Dictionary.getDeepValue)

return function(tbl1)
    return function(arg1)
        return getDeepValue((arg1 or {})[tbl1.layerName] or {}, tbl1.variantName) or false
    end
end
