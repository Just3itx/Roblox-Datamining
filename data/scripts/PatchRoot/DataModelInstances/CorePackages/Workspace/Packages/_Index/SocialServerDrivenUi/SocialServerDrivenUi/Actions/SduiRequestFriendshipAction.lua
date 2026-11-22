-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUi = script:FindFirstAncestor("SocialServerDrivenUi")
local SocialServerDrivenUiParent = SocialServerDrivenUi.Parent

local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

local FriendsStore = require(SocialServerDrivenUiParent.DataHydration).Friends.FriendsStore
local friendsStoreChallengeNetwork = require(SocialServerDrivenUi.Networking.friendsStoreChallengeNetwork)

local FFlagEnableFriendsStoreChallengeInterceptor = require(SocialServerDrivenUiParent.SharedFlags).FFlagEnableFriendsStoreChallengeInterceptor
local SetCurrentToastMessage = require(SocialServerDrivenUiParent.ToastRodux).Actions.SetCurrentToastMessage
local Enums = require(SocialServerDrivenUiParent.FriendsNetworking).Enums

local firePlayerFriendAddTelemetry = require(SocialServerDrivenUi.Analytics.firePlayerFriendAddTelemetry)

local FFlagSduiSearchPeoplePlayerTileTelemetry = require(SocialServerDrivenUiParent.SharedFlags).FFlagSduiSearchPeoplePlayerTileTelemetry

local var1 = Enums.FriendshipOriginSourceType.PlayerSearch.rawValue()

return function(arg1, arg2, arg3)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg3.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.RequestFriendship,
                message = "Missing actionParams"
            },
            arg3.appPage
        )
        return
    end

    local targetUserId = actionParams.targetUserId
    if targetUserId == nil or targetUserId == "" then
        arg3.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.RequestFriendship,
                message = "Missing actionParam: targetUserId",
                propName = "targetUserId"
            },
            arg3.appPage
        )
        return
    end

    local source = actionParams.source
    if typeof(source) ~= "string" or source == "" then
        source = var1
    end
    local requestFriendship = FriendsStore.get().RequestFriendship

    local var2 = nil
    local var3 = if FFlagEnableFriendsStoreChallengeInterceptor then friendsStoreChallengeNetwork else nil

    requestFriendship(targetUserId, source, var2, var3):andThen(function()
        arg3.dependencies.dispatch(
            SetCurrentToastMessage({ toastMessage = "Feature.Friends.Action.FriendRequestSent", isLocalized = false })
        )
    end):catch(function()
        arg3.dependencies.dispatch(
            SetCurrentToastMessage({ toastMessage = "Feature.Toast.NetworkingError.SomethingIsWrong", isLocalized = false })
        )
    end)

    if FFlagSduiSearchPeoplePlayerTileTelemetry then
        firePlayerFriendAddTelemetry(targetUserId, arg2, arg3)
    end
end
