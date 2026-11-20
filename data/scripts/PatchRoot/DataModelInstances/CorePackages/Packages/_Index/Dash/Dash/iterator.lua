-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)

local function iterator(arg1)
    if typeof(arg1) == "function" then
        return arg1
    elseif typeof(arg1) == "table" then
        if #arg1 > 0 then
            return ipairs(arg1)
        end
        return pairs(arg1)
    else
        return nil
    end
end

return iterator
