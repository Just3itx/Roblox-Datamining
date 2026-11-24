-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = { require(script.Parent.MessageEffect).ChatWindowEnlarge }

local function getChatWindowMessageEffects(tbl2)
    local chatWindowMessageEffects = {}
    if tbl2 then
        for _, value in tbl1 do
            if table.find(tbl2, value) then
                table.insert(chatWindowMessageEffects, value)
            end
        end
    end
    return chatWindowMessageEffects
end

return getChatWindowMessageEffects
