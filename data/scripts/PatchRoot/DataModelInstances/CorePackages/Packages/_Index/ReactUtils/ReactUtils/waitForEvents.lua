-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local ReactRoblox = require(ReactUtilsParent.ReactRoblox)

local function waitForEvents() -- Luacid: Inlined by compiler; 1 call site recovered
    task.wait(0)
end

return (setmetatable({
    act = function() -- name: actWaitForEvents
        ReactRoblox.act(function()
            waitForEvents()
        end)
    end
}, { __call = waitForEvents }))
