-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent
local useAppPolicy = require(ProfilePlatformParent.UniversalAppPolicy).useAppPolicy

local FFlagProfilePlatformEnableCurrencyTransfer = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableCurrencyTransfer

return function()
    return useAppPolicy(function(arg1)
        if FFlagProfilePlatformEnableCurrencyTransfer then
            return (arg1.getCanRenderTransferOnProfile())
        end

        return false
    end)
end
