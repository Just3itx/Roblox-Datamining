-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local UserModel = require(SocialLibraries.dependencies).UserModel

return {
    [UserModel.PresenceType.OFFLINE] = "",
    [UserModel.PresenceType.ONLINE] = "rbxasset://textures/ui/LuaChat/graphic/gr-indicator-online-14x14.png",
    [UserModel.PresenceType.IN_GAME] = "rbxasset://textures/ui/LuaChat/graphic/gr-indicator-ingame-14x14.png",
    [UserModel.PresenceType.IN_STUDIO] = "rbxasset://textures/ui/LuaChat/graphic/gr-indicator-instudio-14x14.png"
}
