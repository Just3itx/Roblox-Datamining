-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function PlayerSearchPredicate(arg1, arg2, arg3): boolean
    return arg1 == nil
        or arg1 == ""
        or (if arg3 and string.find(utf8.nfdnormalize(arg3):lower(), utf8.nfdnormalize(arg1):lower(), 1, true) ~= nil then true else string.find(arg2:lower(), arg1:lower(), 1, true) ~= nil)
end

return PlayerSearchPredicate
