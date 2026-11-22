-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local React = require(SocialTabsPageParent.React)
local useSignalProfileInsightsByUserId = require(SocialTabsPageParent.ProfileInsights).useSignalProfileInsightsByUserId

local usePageSize = require(SocialTabsPage.Hooks.usePageSize)

local function useMutualsList(userId: string)
    local var1 = usePageSize()

    local var2, isLoading = useSignalProfileInsightsByUserId({ userId = userId, rankingStrategy = "tc_info_boost" })

    local var4 = not var2 and {} or not var2.mutualFriends and {} or var2.mutualFriends

    local var5, var6 = React.useState(var1)

    React.useEffect(function()
        var6(var1)
    end, { userId, var1 })

    return {
        mutualFriends = React.useMemo(function()
            local result = {}
            local var7 = var5
            local num1 = #var4

            for i = 1, math.min(var7, num1) do
                table.insert(result, var4[i])
            end
            return result
        end, { var4, var5 }),
        isLoading = isLoading,
        hasMore = var5 < #var4,
        loadMore = React.useCallback(function()
            var6(function(num1: number): number
                return math.min(num1 + var1, #var4)
            end)
        end, { var4, var1 }),
        totalCount = #var4
    }
end

return useMutualsList
