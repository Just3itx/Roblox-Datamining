-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformCommonParent = script:FindFirstAncestor("ProfilePlatformCommon").Parent
local getProfileRefreshSignal, var2 = require(ProfilePlatformCommonParent.Signals).createSignal(0)

return {
    notifyProfileRefresh = function()
        var2(os.clock())
    end,
    getProfileRefreshSignal = getProfileRefreshSignal
}
