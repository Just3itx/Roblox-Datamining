-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NextDataExpirationTimeRoduxParent = script:FindFirstAncestor("NextDataExpirationTimeRodux").Parent
return require(NextDataExpirationTimeRoduxParent.Rodux).makeActionCreator(script.Name, function(key: string, nextDataExpirationTime: number, namespace: string?)
    assert(type(key) == "string", "SetNextDataExpirationTime: key must be a string!")
    assert(
        type(nextDataExpirationTime) == "number" and nextDataExpirationTime > 0,
        "SetNextDataExpirationTime: nextDataExpirationTime must be a positive number!"
    )

    return { key = key, nextDataExpirationTime = nextDataExpirationTime, namespace = namespace }
end)
