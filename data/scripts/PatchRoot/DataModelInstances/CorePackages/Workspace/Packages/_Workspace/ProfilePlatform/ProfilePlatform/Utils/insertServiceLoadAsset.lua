-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(assetId: number): Instance
    return game:GetService("InsertService"):LoadAsset(assetId)
end
