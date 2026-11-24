-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatSharedParent = script:FindFirstAncestor("ExpChatShared").Parent
return require(ExpChatSharedParent.Rodux).makeActionCreator(script.Name, function(arg1)
    return {
        team = arg1.team,
        isChatCoreGuiEnabled = arg1.isChatCoreGuiEnabled == nil or arg1.isChatCoreGuiEnabled,
        isTouchEnabled = arg1.isTouchEnabled,
        isGamepadEnabled = arg1.isGamepadEnabled
    }
end)
