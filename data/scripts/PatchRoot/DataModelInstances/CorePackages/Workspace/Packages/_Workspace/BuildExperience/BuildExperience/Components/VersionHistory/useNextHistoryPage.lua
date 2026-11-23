-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local _PlaceVersionHistory = require(BuildExperienceParent.DataHydration.PlaceVersionHistory)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local function useNextHistoryPage(num1: number, num2: number, arg1)
    local nextCursor = if arg1 == nil or not arg1.hasMore then nil else arg1.nextCursor
    local var1 = SignalsReact.useSignalState(num1.getIsFetchingMoreHistory(num2))
    local var2, var3 = React.useState(nil)

    return React.useCallback(function()
        if nextCursor == nil or nextCursor == var2 or var1 then
            return
        end
        local var4 = nextCursor
        num1.fetchMoreHistory(num2, var4):catch(function()
            var3(var4)
        end)
    end, {
        num1,
        num2,
        nextCursor,
        var2,
        var1
    })
end
return useNextHistoryPage
