-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastInt("LuaAppRecommendedGamesCount", 6)

return function(): number
    local fastInt = game:GetFastInt("LuaAppRecommendedGamesCount")
    if fastInt > 20 then
        warn("Maximum Recommended Games Fetch Count has exceeded 20: ", fastInt)
    end
    return fastInt
end
