-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new(log)
    local tbl1 = { log = log, lastContext = nil }

    setmetatable(tbl1, module)
    return tbl1
end

function module.newSink(arg1, maxLevel)
    return {
        maxLevel = maxLevel,
        log = function(arg2, arg3, lastContext)
            if lastContext ~= arg1.lastContext then
                arg1.lastContext = lastContext
                arg1.log(arg2, arg3, lastContext)
            end
        end
    }
end

return module
