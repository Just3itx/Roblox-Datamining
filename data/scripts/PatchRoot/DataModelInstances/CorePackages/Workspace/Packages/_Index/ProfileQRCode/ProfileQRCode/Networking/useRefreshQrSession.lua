-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent
local useDispatch = require(ProfileQRCodeParent.RoactUtils).Hooks.RoactRodux.useDispatch

local refreshQrSession = require(ProfileQRCode.Networking.refreshQrSession)

return function()
    local var1 = useDispatch()

    return function()
        return var1(refreshQrSession.API()):catch(function() end)
    end
end
