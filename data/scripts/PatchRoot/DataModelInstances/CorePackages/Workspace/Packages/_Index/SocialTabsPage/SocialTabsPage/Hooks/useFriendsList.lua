-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local React = require(SocialTabsPageParent.React)
local Dash = require(SocialTabsPageParent.Dash)
local useDispatch = require(SocialTabsPageParent.RoactUtils).Hooks.RoactRodux.useDispatch

local FindFriendsFromUserId = require(SocialTabsPage.Networking.NetworkingFriends).FindFriendsFromUserId

local usePageSize = require(SocialTabsPage.Hooks.usePageSize)

local function mapPageItemsToFriends(arg1)
    local result = {}

    for _, value in (Dash.map(arg1, function(arg2)
        return {
            id = tostring(arg2.id),
            hasVerifiedBadge = arg2.hasVerifiedBadge or false
        }
    end)) do
        local var1 = tonumber(value.id)
        if var1 ~= nil and var1 > 0 then
            table.insert(result, value)
        end
    end
    return result
end

local function useFriendsList(tbl1)
    local var1 = useDispatch()
    local limit = usePageSize()
    local bool1 = tbl1.skip == true or not tbl1.targetUserId or tbl1.targetUserId == ""

    local friends, var4 = React.useState({})
    local loading, var6 = React.useState(not bool1)
    local error, var8 = React.useState(nil)
    local var9, var10 = React.useState(nil)
    local var11 = React.useRef(0)
    local var12 = React.useRef(false)
    local var13 = React.useRef(true)

    React.useEffect(function()
        return function()
            var13.current = false
        end
    end, {})

    local var14 = React.useCallback(function(str1: string, str2: string?, current: number)
        local bool2 = not str2 or str2 == ""

        if bool2 then
            var6(true)
        end
        var12.current = true
        var8(nil)

        var1(FindFriendsFromUserId.API(str1, { limit = limit, cursor = str2 and str2 ~= "" and str2 or nil })):andThen(
            function(arg1)
                if var11.current ~= current or not var13.current then
                    var12.current = false
                    return
                end

                local responseBody = if arg1 then arg1.responseBody else nil
                local pageItems = if responseBody then responseBody.PageItems else nil
                local nextCursor = if responseBody and responseBody.NextCursor and responseBody.NextCursor ~= "" then responseBody.NextCursor else nil
                var10(nextCursor)

                if pageItems then
                    local tbl2 = mapPageItemsToFriends(pageItems)
                    if bool2 then
                        var4(tbl2)
                    else
                        var4(function(tbl3)
                            local var14 = table.clone(tbl3)
                            for _, value in tbl2 do
                                table.insert(var14, value)
                            end
                            return var14
                        end)
                    end
                elseif bool2 then
                    var4({})
                end

                if bool2 then
                    var6(false)
                end
                var12.current = false
            end
        ):catch(
            function(arg1)
                if var11.current ~= current or not var13.current then
                    var12.current = false
                    return
                end
                var8(arg1)
                if bool2 then
                    var6(false)
                end
                var12.current = false
            end
        )
    end, { var1, limit })

    React.useEffect(function()
        if bool1 then
            return nil
        end

        local var15 = var11
        var15.current += 1
        local current = var11.current
        var10(nil)
        var4({})
        var14(tbl1.targetUserId, nil, current)

        return nil
    end, { bool1, tbl1.targetUserId, var14 })

    return {
        friends = friends,
        loading = loading,
        hasMore = var9 ~= nil,
        fetchMore = React.useCallback(function()
            if var12.current or not var9 then
                return
            end
            var14(tbl1.targetUserId, var9, var11.current)
        end, { var9, var14, tbl1.targetUserId }),
        refresh = React.useCallback(function()
            local var15 = var11
            var15.current += 1
            local current = var11.current
            var10(nil)
            var4({})
            var14(tbl1.targetUserId, nil, current)
        end, { var14, tbl1.targetUserId }),
        error = error
    }
end

return useFriendsList
