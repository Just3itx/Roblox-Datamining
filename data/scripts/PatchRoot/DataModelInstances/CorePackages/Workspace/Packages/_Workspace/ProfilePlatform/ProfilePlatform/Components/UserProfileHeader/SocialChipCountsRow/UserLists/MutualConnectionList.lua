-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Constants = require(ProfilePlatform.Common.Constants)

local React = require(ProfilePlatformParent.React)
local UserList = require(ProfilePlatformParent.UserList)
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local useNavigationProps = require(ProfilePlatformParent.RobloxAppNavigation).useNavigationProps
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local InputUi = require(ProfilePlatformParent.InputUi)
local NavigateDown = require(ProfilePlatformParent.NavigationRodux).Thunks.NavigateDown
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local Enums = require(ProfilePlatform.Common.Enums)
local TextKeys = require(ProfilePlatform.Common.TextKeys)

local UserListViewAdaptor = UserList.Components.UserListViewAdaptor
local useScreenSize = RobloxAppHooks.useScreenSize
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local getSafeAreaSize = InputUi.getSafeAreaSize
local useProfileCardWidth = require(ProfilePlatform.Hooks.useProfileCardWidth)
local useProfileCardWidth2 = require(ProfilePlatformParent.ProfilePlatformCommon).Hooks.useProfileCardWidth
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)
local FFlagProfilePlatformNewProfileHeader = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformNewProfileHeader

local FFlagSwitchProfileWidthHookToSocialCommon = require(ProfilePlatformParent.SharedFlags).FFlagSwitchProfileWidthHookToSocialCommon
local FFlagSignalsNavP3Dispatch = require(ProfilePlatformParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil
local FFlagMutualConnectionsListPagination = require(ProfilePlatformParent.SharedFlags).FFlagMutualConnectionsListPagination
local FFlagEnableSplitPane = require(ProfilePlatformParent.SharedFlags).FFlagEnableSplitPane
local SplitPane = if FFlagEnableSplitPane then require(ProfilePlatformParent.SplitPane) else nil
local useSignalState = require(ProfilePlatformParent.SignalsReact).useSignalState

local function MutualConnectionList(_)
    local var1 = useDispatch()
    local var2 = useNavigationProps(function(_, arg1)
        return {
            mutualFriendIds = arg1.mutualFriendIds
        }
    end)

    local var3 = useScreenSize()
    local var4 = useSelector(function(arg1)
        return arg1.GlobalGuiInset
    end)
    local safeAreaSize = getSafeAreaSize(var3, var4)
    local bool1 = if FFlagProfilePlatformNewProfileHeader then useProfileFormFactor().formFactor == Enums.ProfileFormFactor.Wide else false
    local var5 = if FFlagProfilePlatformNewProfileHeader then if FFlagSwitchProfileWidthHookToSocialCommon then useProfileCardWidth2() else useProfileCardWidth(bool1) else math.min(safeAreaSize.X.Offset, Constants.MAXIMUM_CONTAINER_WIDTH)
    local xScale = var5 / safeAreaSize.X.Offset
    local bool2

    if FFlagEnableSplitPane then
        local store = SplitPane.SplitPaneStore.getStore()
        local var6 = useSignalState(store.getSupportPaneModeIfActive)
        if var6 == nil then
            bool2 = false
        else
            bool2 = SplitPane.SplitPaneVariant.getProfileSplitPaneEligibility(var6) ~= nil
        end
    else
        bool2 = false
    end

    if FFlagEnableSplitPane then
        xScale = if bool2 then 1 else xScale
    end

    local wideModePeekViewLayout = {
        position = UDim2.fromScale(1, 0),
        size = UDim2.fromScale(xScale, 1),
        anchorPoint = Vector2.new(1, 0)
    }

    local mutualFriendIds = var2.mutualFriendIds
    local var6 = if FFlagMutualConnectionsListPagination then mutualFriendIds else nil
    local var7, var8

    if FFlagMutualConnectionsListPagination then
        local var9, var10 = React.useState(25)

        React.useEffect(function()
            var10(25)
        end, { mutualFriendIds })

        var7 = React.useCallback(function()
            var10(function(num1: number): number
                return math.min(num1 + 25, #mutualFriendIds)
            end)
        end, { mutualFriendIds })

        var6 = React.useMemo(function()
            if not (var9 < #mutualFriendIds) then
                return mutualFriendIds
            end

            local result = {}
            for i = 1, var9 do
                table.insert(result, mutualFriendIds[i])
            end
            return result
        end, { mutualFriendIds, var9 })

        if var9 < #mutualFriendIds then
            var8 = true
        else
            var8 = false
        end
    else
        var8 = nil
        var7 = nil
    end

    local var9 = useLocalization({
        mutualConnections = {
            TextKeys.MutualConnectionsTitle,
            numConnections = #mutualFriendIds
        },
        mutualConnection = TextKeys.MutualConnectionTitle
    })

    if #mutualFriendIds == 0 then
        return nil
    end

    local title = if #mutualFriendIds == 1 then var9.mutualConnection else var9.mutualConnections
    local createElement = React.createElement
    local var11 = UserListViewAdaptor
    local tbl2 = {
        users = 0,
        title = 0,
        wideModePeekViewLayout = 0,
        onUserSelected = 0,
        hasMore = 0,
        onLoadMore = 0
    }

    if not FFlagMutualConnectionsListPagination then
        var6 = mutualFriendIds
    end

    tbl2.users = var6
    tbl2.title = title
    tbl2.wideModePeekViewLayout = wideModePeekViewLayout
    function tbl2.onUserSelected(detail)
        local tbl3 = {
            name = AppPage.ProfilePlatform,
            detail = detail,
            extraProps = {
                profileType = Enums.ProfileTypes.User,
                source = Enums.Sources.MutualConnectionsList
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
            return
        end
        var1(NavigateDown(tbl3))
    end

    if not FFlagMutualConnectionsListPagination then
        var8 = nil
    end

    tbl2.hasMore = var8
    if not FFlagMutualConnectionsListPagination then
        var7 = nil
    end

    tbl2.onLoadMore = var7
    return createElement(var11, tbl2)
end

return MutualConnectionList
