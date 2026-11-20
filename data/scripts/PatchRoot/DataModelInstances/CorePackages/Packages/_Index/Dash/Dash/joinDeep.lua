-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local None = require(scriptParent.None)
local _Types = require(scriptParent.Types)
local forEach = require(scriptParent.forEach)

local function joinDeep(tbl1, tbl2)
    local var1 = table.clone(tbl1)

    forEach(tbl2, function(arg1, arg2)
        if typeof(tbl1[arg2]) == "table" and typeof(arg1) == "table" then
            var1[arg2] = joinDeep(tbl1[arg2], arg1)
        elseif arg1 == None then
            var1[arg2] = nil
        else
            var1[arg2] = arg1
        end
    end)
    return var1
end

return joinDeep
