-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1): boolean
    local joinData = arg1:GetJoinData()
    joinData = joinData and tonumber(joinData.ReferredByPlayerId)
    return joinData == nil or joinData == 0
end
