-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(vector2: Vector2?, arg1)
    vector2 = vector2 or Vector2.new(0, 0)
    assert(vector2, "")

    return if arg1 and arg1.screenSize then arg1.screenSize else vector2
end
