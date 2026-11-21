-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local FriendsRoduxParent = script:FindFirstAncestor("FriendsRodux").Parent
local llama = require(FriendsRoduxParent.llama)

local getDeepValue = require(scriptParentParent.getDeepValue)

return function(arg1)
    local keyPath = arg1.keyPath
    return function(arg2, arg3, arg4): boolean
        local deepValue = getDeepValue(arg2, keyPath .. ".byUserId")
        return not not (deepValue[arg3] ~= nil and llama.List.find(deepValue[arg3], arg4))
    end
end
