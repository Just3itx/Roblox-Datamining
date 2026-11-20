-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local UserModel = require(SocialLibraries.dependencies).UserModel

return function(arg1, arg2, arg3)
    if arg1.pinnedGame and arg1.pinnedGame.universeId then
        return tostring(arg1.pinnedGame.universeId)
    end

    local tbl1 = {}
    for _, value in pairs(arg1.participants or {}) do
        local var1 = arg3[value]
        if var1 ~= nil and value ~= arg2 and var1.presence == UserModel.PresenceType.IN_GAME and var1.rootPlaceId then
            tbl1[var1.rootPlaceId] = tbl1[var1.rootPlaceId] or 0
            tbl1[var1.rootPlaceId] = tbl1[var1.rootPlaceId] + 1
        end
    end

    local var1 = nil
    local num1 = 0
    for k, value in pairs(tbl1) do
        if num1 < value then
            var1 = k
            num1 = value
        end
    end

    return var1 and tostring(var1) or nil
end
