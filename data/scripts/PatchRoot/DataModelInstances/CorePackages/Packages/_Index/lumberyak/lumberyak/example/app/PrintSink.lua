-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:01:18Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Logger = require(script.Parent.Parent.Parent.Logger)

local module = {}

function module.new(maxLevel)
    local tbl1 = { maxLevel = maxLevel }

    setmetatable(tbl1, module)
    return tbl1
end

function module.log(_, arg1, arg2)
    if arg2.level == Logger.Levels.Error then
        error(arg1, 5)
    elseif arg2.level == Logger.Levels.Warning then
        warn(arg1)
    else
        print(arg1)
    end
end

return module
