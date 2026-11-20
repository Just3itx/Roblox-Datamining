-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local var1 = require(scriptParent.class)("Symbol", function(name: string)
    return { name = name }
end)

function var1.toString(arg1): string
    return ("Symbol(%s)"):format(arg1.name)
end

return var1
