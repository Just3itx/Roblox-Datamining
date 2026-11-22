-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bindableEvent = Instance.new("BindableEvent")

return {
    purchaseCompletedEvent = bindableEvent.Event,
    firePurchaseCompleted = function()
        bindableEvent:Fire()
    end
}
