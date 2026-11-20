-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppShortcutBarParent = script:FindFirstAncestor("AppShortcutBar").Parent

local Signals = require(AppShortcutBarParent.Signals)
local SignalsReact = require(AppShortcutBarParent.SignalsReact)

local function createShortcutBarStatusStore()
    local getShortcutBarVisible, setShortcutBarVisible = Signals.createSignal(false)
    local getShortcutBarReservedHeight, setShortcutBarReservedHeight = Signals.createSignal(0)

    return {
        getShortcutBarVisible = getShortcutBarVisible,
        setShortcutBarVisible = setShortcutBarVisible,
        useShortcutBarVisible = function()
            return SignalsReact.useSignalState(getShortcutBarVisible)
        end,
        getShortcutBarReservedHeight = getShortcutBarReservedHeight,
        setShortcutBarReservedHeight = setShortcutBarReservedHeight
    }
end

return createShortcutBarStatusStore
