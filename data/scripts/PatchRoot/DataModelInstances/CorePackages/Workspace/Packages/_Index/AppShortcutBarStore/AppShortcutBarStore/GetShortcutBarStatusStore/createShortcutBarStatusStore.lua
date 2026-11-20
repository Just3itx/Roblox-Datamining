-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppShortcutBarStoreParent = script:FindFirstAncestor("AppShortcutBarStore").Parent

local Signals = require(AppShortcutBarStoreParent.Signals)
local SignalsReact = require(AppShortcutBarStoreParent.SignalsReact)

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
