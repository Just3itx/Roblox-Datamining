-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local Signals = require(AuthCommonParent.Signals)

return function()
    local getFido2Available, setFido2Available = Signals.createSignal(false)
    local getFido2SupportsDeviceBoundOnly, setFido2SupportsDeviceBoundOnly = Signals.createSignal(false)
    local getPasswordsAvailable, setPasswordsAvailable = Signals.createSignal(false)
    local getV2InterfaceSupported, setV2InterfaceSupported = Signals.createSignal(false)

    return {
        getFido2Available = getFido2Available,
        setFido2Available = setFido2Available,
        getFido2SupportsDeviceBoundOnly = getFido2SupportsDeviceBoundOnly,
        setFido2SupportsDeviceBoundOnly = setFido2SupportsDeviceBoundOnly,
        getPasswordsAvailable = getPasswordsAvailable,
        setPasswordsAvailable = setPasswordsAvailable,
        getV2InterfaceSupported = getV2InterfaceSupported,
        setV2InterfaceSupported = setV2InterfaceSupported
    }
end
