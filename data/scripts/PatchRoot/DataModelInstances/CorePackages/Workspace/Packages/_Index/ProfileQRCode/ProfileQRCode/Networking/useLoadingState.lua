-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent
local useSelector = require(ProfileQRCodeParent.RoactUtils).Hooks.RoactRodux.useSelector
local createOrGetProfileShareUrl = require(ProfileQRCode.Networking.createOrGetProfileShareUrl)

return function()
    return useSelector(function(arg1)
        return createOrGetProfileShareUrl.getStatus(arg1)
    end)
end
