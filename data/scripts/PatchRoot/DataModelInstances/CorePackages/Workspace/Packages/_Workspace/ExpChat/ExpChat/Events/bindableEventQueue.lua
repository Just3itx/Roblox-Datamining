-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local DispatchBindableEvent = require(ExpChat.DispatchBindableEvent)

local module = {
    queue = {}
}

function module.add(arg1, arg2)
    arg1.queue[#arg1.queue + 1] = arg2
end

function module.flush(arg1)
    if not #arg1.queue then
        return
    end

    for _, value in pairs(arg1.queue) do
        DispatchBindableEvent:Fire(value)
    end
end

return module
