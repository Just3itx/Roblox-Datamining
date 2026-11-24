-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {
    Unknown = "unknown",
    Profile = "profile",
    Chat = "chat",
    BuyRobux = "buyRobux",
    InExperience = "inExperience"
}

tbl1.toEnumInteger = {
    [tbl1.Unknown] = 0,
    [tbl1.Profile] = 1,
    [tbl1.Chat] = 2,
    [tbl1.BuyRobux] = 3,
    [tbl1.InExperience] = 4
}

return tbl1
