-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local useDispatch = require(UserListParent.RoactUtils).Hooks.RoactRodux.useDispatch
local View = require(UserListParent.Foundation).View
local NavigateDown = require(UserListParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(UserListParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(UserListParent.RobloxAppNavigation).NavigationCommands else nil
local AppPage = require(UserListParent.RobloxAppEnums).AppPage
local Constants = require(UserList.Common.Constants)

local UserRowWrapper = require(script.Parent.UserRowWrapper)

local function UserList2(tbl1)
    local var1 = useDispatch()

    local onActivated = React.useCallback(function(detail: string)
        if tbl1.onUserSelected then
            tbl1.onUserSelected(detail)
            return
        end

        local tbl2 = {
            name = AppPage.ProfilePlatform,
            detail = detail,
            extraProps = {
                profileType = Constants.PROFILE_TYPE
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var1(NavigateDown(tbl2))
    end, { tbl1.onUserSelected, var1 })

    if #tbl1.userIds == 0 then
        return nil
    end

    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        tag = "size-full-0 auto-y col gap-large",
        LayoutOrder = tbl1.layoutOrder or 0
    }
    local tbl3 = { UserRows = 0 }
    local createElement2 = React.createElement
    local fragment = React.Fragment

    local useMemo = React.useMemo

    local function func1()
        local result = ({})
        for layoutOrder, userId in ipairs(tbl1.userIds) do
            result[layoutOrder] = React.createElement(UserRowWrapper, { userId = userId, LayoutOrder = layoutOrder, onActivated = onActivated })
        end

        return result
    end

    tbl3.UserRows = createElement2(fragment, {}, unpack(useMemo(func1, { tbl1.userIds })))
    return createElement(var3, tbl2, tbl3)
end

return UserList2
