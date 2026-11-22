-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionService = game:GetService("SessionService")

return {
    setPlayIntent = function(str1: string)
        if not SessionService:SessionExists("level2a") then
            return
        end
        SessionService:SetMetadata("level2a", "playIntentId", str1)
    end
}
