-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    FIntGameIconSmallSizePx = game:DefineFastInt("LuaAppGameIconSmallSizePx", 150),
    FIntGameIconLargeSizePx = game:DefineFastInt("LuaAppGameIconLargeSizePx", 512),
    sizeString = function(num1: number): string
        return string.format("%dx%d", num1, num1)
    end
}
