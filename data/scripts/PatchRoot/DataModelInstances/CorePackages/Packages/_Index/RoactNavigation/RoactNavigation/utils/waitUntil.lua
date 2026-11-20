-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local ReactRoblox = require(scriptParentParentParent.Dev.ReactRoblox)

return function(arg1, arg2)
    arg2 = arg2 or 1
    local num1 = 0
    while num1 < arg2 and not arg1() do
        ReactRoblox.act(function()
            num1 += task.wait()
        end)
    end
end
