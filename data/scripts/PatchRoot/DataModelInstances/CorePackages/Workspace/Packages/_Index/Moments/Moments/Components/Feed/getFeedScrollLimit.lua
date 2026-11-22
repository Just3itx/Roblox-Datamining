-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getFeedScrollLimit(bool1: boolean, bool2: boolean, func1: (...any) -> (...any))
    if bool1 and not bool2 then
        return nil
    end

    local var1 = func1()
    if var1.getIsInfiniteScrollEnabled(false) then
        return nil
    end

    return (var1.getMaxMomentsBeforeEndState(false))
end

return getFeedScrollLimit
