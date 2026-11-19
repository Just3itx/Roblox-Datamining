-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:41:14Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local None = require(scriptParent.None)
local _Types = require(scriptParent.Types)
local forEach = require(scriptParent.forEach)
local forEachArgs = require(scriptParent.forEachArgs)

local function assign(tbl1, ...)
    forEachArgs(function(tbl2)
        if tbl2 == nil or tbl2 == None then
            return
        end

        forEach(tbl2, function(arg1, arg2)
            if arg1 == None then
                tbl1[arg2] = nil
                return
            end
            tbl1[arg2] = arg1
        end)
    end, ...)

    return tbl1
end

return assign
