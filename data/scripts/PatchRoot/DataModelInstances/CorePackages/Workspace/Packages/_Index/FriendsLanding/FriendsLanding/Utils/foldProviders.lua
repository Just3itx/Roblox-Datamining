-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local Roact = require(FriendsLanding.dependencies).Roact

return function(arg1, arg2)
    for _, value in arg2 do
        arg1 = Roact.createElement(value[1], value[2], { arg1 })
    end

    return arg1
end
