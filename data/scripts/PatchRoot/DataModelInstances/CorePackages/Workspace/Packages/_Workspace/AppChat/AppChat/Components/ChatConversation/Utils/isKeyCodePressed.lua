-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local ArgCheck = require(AppChatParent.ArgCheck)

return function(arg1, ...)
    ArgCheck.isType(arg1, "table", "isKeyCodePressed.pressedKeys")

    local tbl1 = { ... }

    for _, value in ipairs(arg1) do
        for _, value2 in ipairs(tbl1) do
            if value.KeyCode == value2 then
                return true
            end
        end
    end

    return false
end
