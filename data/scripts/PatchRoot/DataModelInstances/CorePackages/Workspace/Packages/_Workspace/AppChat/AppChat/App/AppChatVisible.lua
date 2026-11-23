-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bindableEvent = Instance.new("BindableEvent")

return {
    BindableEvent = bindableEvent,
    setAppChatVisible = function(bool1: boolean)
        bindableEvent:Fire(bool1)
    end
}
