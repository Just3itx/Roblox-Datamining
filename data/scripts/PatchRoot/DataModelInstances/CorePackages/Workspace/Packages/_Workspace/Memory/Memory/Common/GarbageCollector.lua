-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
function trigger()
    return collectgarbage("collect")
end

function module.collect()
    pcall(trigger)
    pcall(trigger)
    task.wait()
end

return module
