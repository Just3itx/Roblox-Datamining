-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:10:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsRoduxParent = script:FindFirstAncestor("FriendsRodux").Parent
local llama = require(FriendsRoduxParent.llama)

return function(arg1, tbl1)
    local tbl2 = ({})
    for _, value in pairs(tbl1) do
        tbl2[value] = llama.None
    end

    return llama.Dictionary.join(arg1, tbl2)
end
