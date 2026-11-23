-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local function getNewGameChatDraftKey(arg1)
    local var1 = arg1 or Players.LocalPlayer

    if var1 == nil or var1.UserId <= 0 then
        return nil
    end

    return "newGame:" .. tostring(var1.UserId)
end

return getNewGameChatDraftKey
