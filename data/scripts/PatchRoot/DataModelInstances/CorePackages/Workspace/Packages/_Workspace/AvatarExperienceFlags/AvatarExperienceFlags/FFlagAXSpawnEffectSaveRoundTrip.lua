-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T15:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local bool1 = game:DefineFastFlag("AXSpawnEffectSaveRoundTrip", false)

local bool2 = Enum.AvatarAssetType:FromValue(97) ~= nil

return bool1 and bool2
