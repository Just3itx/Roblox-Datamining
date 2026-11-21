-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Types)

local function unpackContent(arg1)
    if type(arg1) ~= "table" then
        return nil, nil
    end
    local var1, var2 = next(arg1)
    if type(var1) ~= "string" or var2 == nil or next(arg1, var1) ~= nil then
        return nil, nil
    end
    return var1, var2
end

return unpackContent
