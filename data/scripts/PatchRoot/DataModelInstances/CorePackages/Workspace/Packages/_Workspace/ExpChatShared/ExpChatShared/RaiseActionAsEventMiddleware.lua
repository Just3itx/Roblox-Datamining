-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ActionBindableEvent = require(script.Parent.ActionBindableEvent)

return function(callback, _)
    return function(arg1)
        ActionBindableEvent:Fire(arg1)
        callback(arg1)
    end
end
