-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local RecommendationContextType = require(SocialLibraries.dependencies).RoduxFriends.Enums.RecommendationContextType

local function func1(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1.mutualFriendsCount then
        return tbl1.mutualFriendsCount
    end

    return tbl1.mutualFriendsList and #tbl1.mutualFriendsList or 0
end

return function(tbl1)
    local var1 = nil
    local var2 = nil

    local var3 = nil
    local var4 = if tbl1.contextType then tbl1.contextType.rawValue() or nil else nil
    local var5 = func1(tbl1)

    if var4 == RecommendationContextType.MutualFriends.rawValue() and var5 > 0 then
        var1 = { path = "icons/status/player/friend" }

        var3 = function(arg1)
            if arg1 then
                return tostring(var5) .. " " .. string.lower(arg1)
            end

            return nil
        end

        var2 = if var5 == 1 then "Feature.Friends.Label.SingularMutualFriend" else "Feature.Friends.Label.MutualFriends"
    elseif var4 == RecommendationContextType.Frequents.rawValue() then
        var2 = "Feature.Friends.Label.Frequent"
    end

    return {
        icon = var1,
        label = { formatter = var3, text = nil, textKey = var2 }
    }
end
