-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent
local createOrGetProfileShareUrl = require(ProfileQRCode.Networking.createOrGetProfileShareUrl)
local useDispatch = require(ProfileQRCodeParent.RoactUtils).Hooks.RoactRodux.useDispatch

return function()
    local var1 = useDispatch()

    return function()
        return var1(createOrGetProfileShareUrl.API()):catch(function() end)
    end
end
