-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MemStorageService = game:GetService("MemStorageService")

return {
    markUnsuccessfulJoin = function()
        MemStorageService:SetItem("CloudPlayUnsuccessfulJoin", "true")
    end,
    consumeUnsuccessfulJoin = function(): boolean
        if MemStorageService:GetItem("CloudPlayUnsuccessfulJoin") == "" then
            return false
        end
        MemStorageService:RemoveItem("CloudPlayUnsuccessfulJoin")
        return true
    end
}
