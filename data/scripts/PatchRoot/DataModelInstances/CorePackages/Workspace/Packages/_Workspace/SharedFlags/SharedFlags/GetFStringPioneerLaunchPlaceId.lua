-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:10:48Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
game:DefineFastString("PioneerLaunchPlaceId", "")

return function(): number?
    local var1 = tonumber(game:GetFastString("PioneerLaunchPlaceId"))
    return if var1 and not (var1 <= 0) then var1 else nil
end
