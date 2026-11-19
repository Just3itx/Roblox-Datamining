-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function initializeShopMenuController(arg1, tbl1)
    tbl1:connect(function(arg2)
        arg1:SetMenuIsOpen(arg2, "in_experience_shop")
    end)
end

return initializeShopMenuController
