-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ToastRoduxParent = script:FindFirstAncestor("ToastRodux").Parent
return require(ToastRoduxParent.Rodux).makeActionCreator(script.Name, function(toastMessage)
    assert(type(toastMessage) == "table", "SetCurrentToastMessage action expects toastMessage to be a table")

    return { toastMessage = toastMessage }
end)
