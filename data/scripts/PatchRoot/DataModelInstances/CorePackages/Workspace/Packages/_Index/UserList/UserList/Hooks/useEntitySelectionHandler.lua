-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local useDispatch = require(UserListParent.RoactUtils).Hooks.RoactRodux.useDispatch
local NavigateDown = require(UserListParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(UserListParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(UserListParent.RobloxAppNavigation).NavigationCommands else nil
local AppPage = require(UserListParent.RobloxAppEnums).AppPage
local Enums = require(UserList.Common.Enums)
local _Types = require(UserList.Common.Types)

local FFlagUserListRowSelectionOriginSource = require(UserList.Flags.FFlagUserListRowSelectionOriginSource)

local function useEntitySelectionHandler(callback: ((...any) -> (...any))?, arg1)
    local var1 = useDispatch()

    return (React.useCallback(function(detail: string, contact)
        if callback then
            callback(detail, contact)
            return
        end
        local tbl1 = {
            name = AppPage.ProfilePlatform,
            detail = detail,
            extraProps = {
                profileType = if contact == Enums.EntityType.Contact then Enums.EntityType.Contact else Enums.EntityType.User,
                friendshipOriginSourceType = if FFlagUserListRowSelectionOriginSource and arg1 then arg1.friendshipOriginSourceType else nil
            }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        var1(NavigateDown(tbl1))
    end, { callback, var1, arg1 or false }))
end

return useEntitySelectionHandler
