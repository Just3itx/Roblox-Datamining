-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isPlatformInviteUIEnabled(): boolean
    return game:GetEngineFeature("PlatformFriendsService") and game:GetService("PlatformFriendsService"):IsInviteFriendsEnabled()
end

return isPlatformInviteUIEnabled
