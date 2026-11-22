-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialProofParent = script:FindFirstAncestor("SocialProof").Parent

local React = require(SocialProofParent.React)
local Foundation = require(SocialProofParent.Foundation)
local RoactUtils = require(SocialProofParent.RoactUtils)

local UserList = require(SocialProofParent.UserList)
local VerticalUserList = UserList.VerticalUserList.VerticalUserList
local EntityType = UserList.Enums.EntityType

local NavigateDown = require(SocialProofParent.NavigationRodux).Thunks.NavigateDown
local NavigateBack = require(SocialProofParent.NavigationRodux).Thunks.NavigateBack
local FFlagSignalsNavP3Dispatch = require(SocialProofParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SocialProofParent.RobloxAppNavigation).NavigationCommands else nil
local AppPage = require(SocialProofParent.RobloxAppEnums).AppPage

local Sheet = Foundation.Sheet
local View = Foundation.View
local FoundationText = Foundation.Text

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useTokens = Foundation.Hooks.useTokens
local useNavigationProps = require(SocialProofParent.RobloxAppNavigation).useNavigationProps

local Dash = require(SocialProofParent.Dash)

local snapPoints = { 0.7 }

local function SocialProofVerticalUserListSheet()
    local var1 = useDispatch()
    local var2 = useNavigationProps(function(_, arg1)
        return {
            userIds = arg1.userIds,
            title = arg1.title
        }
    end)

    local var3 = useTokens()

    local title = var2.title

    local entities = React.useMemo(function()
        return Dash.map(var2.userIds, function(arg1)
            return {
                id = tostring(arg1),
                type = EntityType.User
            }
        end)
    end, { var2.userIds })

    local onRowSelected = React.useCallback(function(detail: string, _)
        local tbl2 = {
            name = AppPage.ProfilePlatform,
            detail = detail,
            extraProps = {
                profileType = EntityType.User
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.back(true)
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2), true)
            return
        end
        var1(NavigateBack(true))
        var1(NavigateDown(tbl2, true))
    end, { var1, NavigateBack, NavigateDown })

    local onClose = React.useCallback(function(arg1)
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.back(arg1)
            return
        end
        var1(NavigateBack(arg1))
    end, { var1, NavigateBack })

    return React.createElement(Sheet.Root, {
        preferCenterSheet = true,
        onClose = onClose,
        snapPoints = snapPoints
    }, {
        Header = React.createElement(Sheet.Header, { hasCloseAffordance = true }, {
            Title = React.createElement(View, { tag = "size-full auto-xy align-x-center" }, {
                TitleText = React.createElement(FoundationText, {
                    tag = "auto-xy text-align-x-left",
                    Text = title,
                    fontStyle = var3.Typography.HeadingSmall,
                    textStyle = var3.Color.Content.Emphasis,
                    RichText = true
                })
            })
        }),
        Content = React.createElement(Sheet.Content, nil, {
            UserListContainer = React.createElement(View, { tag = "size-full auto-y" }, {
                UserList = React.createElement(
                    VerticalUserList,
                    {
                        entities = entities,
                        onRowSelected = onRowSelected,
                        initialRowCount = #var2.userIds
                    }
                )
            })
        })
    })
end
return SocialProofVerticalUserListSheet
