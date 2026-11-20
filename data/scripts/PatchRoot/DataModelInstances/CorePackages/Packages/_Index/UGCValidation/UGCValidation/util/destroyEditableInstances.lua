-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Types = require(scriptParentParent.util.Types)

local function destroyHelper(tbl1)
    for _, value in tbl1 do
        for _, value2 in value do
            if value2.created and value2.instance then
                value2.instance:Destroy()
            end
        end
    end
end

return function(arg1, arg2)
    destroyHelper(arg1)
    destroyHelper(arg2)
end
