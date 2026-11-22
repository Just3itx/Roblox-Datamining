-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent
local configureRoduxUsers = require(ProfileQRCode.Networking.configureRoduxUsers)
local useDispatch = require(ProfileQRCodeParent.RoactUtils).Hooks.RoactRodux.useDispatch

return function()
    local var1 = useDispatch()

    return function(str1: string)
        return var1(configureRoduxUsers.GetUserV2FromUserId.API(str1))
    end
end
