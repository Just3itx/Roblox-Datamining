-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local console = require(scriptParentParent.Shared).console

local tbl1 = ({})

local function warnOnce(str1: string, str2: string)
    if not tbl1[str1] then
        console.warn("The legacy Roact API '%s' is deprecated, and will be removed in a future release.\n\n%s", str1, str2)
    end

    tbl1[str1] = true
end

return warnOnce
