-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
return require(AppChatParent.Rodux).makeActionCreator(script.Name, function(arg1)
    return {
        screen = arg1.screen,
        params = arg1.params
    }
end)
