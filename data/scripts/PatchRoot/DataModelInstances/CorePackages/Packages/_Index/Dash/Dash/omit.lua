-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local collectSet = require(scriptParent.collectSet)
local forEach = require(scriptParent.forEach)
local _Types = require(scriptParent.Types)

local function omit(tbl1, tbl2)
    local result = ({})
    local var1 = collectSet(tbl2)
    forEach(tbl1, function(_, arg1)
        if not var1[arg1] then
            result[arg1] = tbl1[arg1]
        end
    end)
    return result
end

return omit
