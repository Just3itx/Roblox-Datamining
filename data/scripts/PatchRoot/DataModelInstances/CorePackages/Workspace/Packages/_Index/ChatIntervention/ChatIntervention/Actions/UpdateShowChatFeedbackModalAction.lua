-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatIntervention = script:FindFirstAncestor("ChatIntervention")
return require(ChatIntervention.Parent.Rodux).makeActionCreator(script.Name, function(isShow: boolean)
    return { isShow = isShow }
end)
