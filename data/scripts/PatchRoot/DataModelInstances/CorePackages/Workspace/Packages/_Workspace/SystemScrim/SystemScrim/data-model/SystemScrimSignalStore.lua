-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SystemScrimParent = script:FindFirstAncestor("SystemScrim").Parent
local Signals = require(SystemScrimParent.Signals)

local function createDefaultStates()
    local visible, setVisibility = Signals.createSignal(false)
    local transparency, setTransparency = Signals.createSignal(1)
    local autoDismiss, setAutoDismiss = Signals.createSignal(true)

    return {
        visible = visible,
        setVisibility = setVisibility,
        transparency = transparency,
        setTransparency = setTransparency,
        autoDismiss = autoDismiss,
        setAutoDismiss = setAutoDismiss,
        backgroundScrimActivated = Instance.new("BindableEvent")
    }
end

return Signals.createComputed(function(_)
    return (createDefaultStates())
end)
