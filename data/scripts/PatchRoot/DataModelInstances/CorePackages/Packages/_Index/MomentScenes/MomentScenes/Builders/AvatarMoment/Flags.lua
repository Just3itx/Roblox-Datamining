-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentScenesParent = script:FindFirstAncestor("MomentScenes").Parent
local SafeFlags = require(MomentScenesParent.SafeFlags)

return {
    MomentScenesAvatarMomentUserId = SafeFlags.createGetFFlag("MomentScenesAvatarMomentUserId")(),
    MomentScenesAvatarMomentDefaultClothing = SafeFlags.createGetFFlag("MomentScenesAvatarMomentDefaultClothing")()
}
