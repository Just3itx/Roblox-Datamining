-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:05:39Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local MemStorageService = game:GetService("MemStorageService")

return function(key: string, callback: (...any) -> (...any))
    if callback ~= nil and not MemStorageService:HasItem(key) then
        MemStorageService:SetItem(key, "true")
        callback()
    end
end
