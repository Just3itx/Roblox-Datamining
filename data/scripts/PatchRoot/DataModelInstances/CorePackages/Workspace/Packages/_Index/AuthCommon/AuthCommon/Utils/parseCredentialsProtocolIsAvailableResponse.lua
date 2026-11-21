-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local GetFFlagLuaAppSignupPasskeyAvailabilityPreflight = require(AuthCommonParent.SharedFlags).GetFFlagLuaAppSignupPasskeyAvailabilityPreflight

return function(arg1)
    local bool1 = true
    local bool2 = false
    local bool3 = false
    local isAvailable, supportsDeviceBoundOnly

    if arg1.FIDO2 ~= nil then
        isAvailable = arg1.FIDO2.isAvailable
        supportsDeviceBoundOnly = arg1.FIDO2.supportsDeviceBoundOnly
        if GetFFlagLuaAppSignupPasskeyAvailabilityPreflight() then
            bool1 = arg1.FIDO2.supportsPasskeyCreationOnDevice ~= false
        end

        bool3 = true
    else
        isAvailable = arg1.isAvailable or false
        supportsDeviceBoundOnly = arg1.supportsDeviceBoundOnly or false
    end

    if arg1.password ~= nil then
        bool2 = arg1.password.isAvailable
    end

    return {
        fido2Available = isAvailable,
        fido2SupportsDeviceBoundOnly = supportsDeviceBoundOnly,
        fido2SupportsPasskeyCreationOnDevice = bool1,
        passwordsAvailable = bool2,
        v2InterfaceSupported = bool3
    }
end
