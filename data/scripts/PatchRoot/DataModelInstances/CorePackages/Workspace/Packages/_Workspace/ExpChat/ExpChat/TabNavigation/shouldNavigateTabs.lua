-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function shouldNavigateTabs(tbl1)
    return if tbl1.isTabBarVisible and not (tbl1.tabCount <= 1) then tbl1.isChatFocused else false
end

return shouldNavigateTabs
