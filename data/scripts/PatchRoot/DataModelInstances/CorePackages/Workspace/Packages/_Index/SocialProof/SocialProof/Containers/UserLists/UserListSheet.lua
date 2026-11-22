-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialProofParent = script:FindFirstAncestor("SocialProof").Parent

local React = require(SocialProofParent.React)
local RoactUtils = require(SocialProofParent.RoactUtils)
local NavigateBack = require(SocialProofParent.NavigationRodux).Thunks.NavigateBack
local FFlagSignalsNavP3Dispatch = require(SocialProofParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SocialProofParent.RobloxAppNavigation).NavigationCommands else nil
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local UserList = require(SocialProofParent.UserList)
local VerticalUserList = UserList.VerticalUserList.VerticalUserList
local EntityType = UserList.Enums.EntityType
local Foundation = require(SocialProofParent.Foundation)
local Button = Foundation.Button
local View = Foundation.View
local FoundationText = Foundation.Text
local Sheet = Foundation.Sheet
local useLocalization = require(SocialProofParent.Localization).Hooks.useLocalization

local snapPoints = { 0.55, 1 }

return function(tbl2)
    local var1 = useDispatch()

    local onClose = React.useCallback(function()
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.back(true)
            return
        end
        var1(NavigateBack(true))
    end, { var1 })

    local var3 = useLocalization({ showMore = "Feature.Friends.Action.ShowMore" })

    local entities = React.useMemo(function()
        local result = {}
        for _, user in ipairs(tbl2.users) do
            table.insert(result, { id = tostring(user), type = EntityType.User })
        end
        return result
    end, { tbl2.users })

    local onRowSelected = React.useCallback(function(str1: string)
        if tbl2.onUserSelected then
            tbl2.onUserSelected(str1)
        end
    end, { tbl2.onUserSelected })

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl3 = { onClose = onClose, preferCenterSheet = true, snapPoints = snapPoints }
    local tbl4 = {
        Header = React.createElement(Sheet.Header, { hasCloseAffordance = true }, {
            Title = if tbl2.title then React.createElement(View, {
                tag = "align-x-left size-full auto-y"
            }, {
                TitleText = React.createElement(
                    FoundationText,
                    {
                        tag = "auto-xy text-heading-small text-align-x-left content-emphasis",
                        Text = tbl2.title
                    }
                )
            }) else nil
        }),
        Content = 0
    }

    local createElement2 = React.createElement
    local content = Sheet.Content
    local var6 = nil
    local tbl5 = {
        ListContainer = React.createElement(View, { tag = "size-full auto-y padding-y-large" }, {
            UserList = React.createElement(
                VerticalUserList,
                {
                    entities = entities,
                    onRowSelected = onRowSelected,
                    initialRowCount = #tbl2.users,
                    layoutOrder = 1
                }
            ),
            ShowMoreButton = if tbl2.hasMore and tbl2.onLoadMore then React.createElement(Button, { LayoutOrder = 2, onActivated = tbl2.onLoadMore, text = var3.showMore }) else nil
        })
    }
    tbl4.Content = createElement2(content, var6, tbl5)
    return createElement(root, tbl3, tbl4)
end
