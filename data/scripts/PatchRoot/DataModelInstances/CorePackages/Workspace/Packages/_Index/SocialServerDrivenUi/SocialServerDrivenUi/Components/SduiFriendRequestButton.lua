-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUi = script:FindFirstAncestor("SocialServerDrivenUi")
local SocialServerDrivenUiParent = SocialServerDrivenUi.Parent

local React = require(SocialServerDrivenUiParent.React)
local RoactUtils = require(SocialServerDrivenUiParent.RoactUtils)
local Foundation = require(SocialServerDrivenUiParent.Foundation)
local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local SignalsReact = require(SocialServerDrivenUiParent.SignalsReact)
local SharedFlags = require(SocialServerDrivenUiParent.SharedFlags)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

local firePlayerFriendAddTelemetry = require(SocialServerDrivenUi.Analytics.firePlayerFriendAddTelemetry)
local SduiRequestFriendshipAction = require(SocialServerDrivenUi.Actions.SduiRequestFriendshipAction)
local getCurrentUserId = require(SocialServerDrivenUi.Common.getCurrentUserId)
local FriendsStore = require(SocialServerDrivenUiParent.DataHydration).Friends.FriendsStore
local friendsStoreChallengeNetwork = require(SocialServerDrivenUi.Networking.friendsStoreChallengeNetwork)

local FFlagEnableFriendsStoreChallengeInterceptor = require(SocialServerDrivenUiParent.SharedFlags).FFlagEnableFriendsStoreChallengeInterceptor
local SetCurrentToastMessage = require(SocialServerDrivenUiParent.ToastRodux).Actions.SetCurrentToastMessage
local Enums = require(SocialServerDrivenUiParent.FriendsNetworking).Enums

local SduiActionType = SduiCoreSystem.SduiActionType

local IconButton = Foundation.IconButton
local Enums2 = Foundation.Enums

local FFlagSduiSearchPeoplePlayerTileTelemetry = SharedFlags.FFlagSduiSearchPeoplePlayerTileTelemetry

local FFlagSduiFriendRequestButtonHideForSelf = require(SocialServerDrivenUi.Flags.FFlagSduiFriendRequestButtonHideForSelf)

local Small = Enums2.InputSize.Small
local var1 = Enums.FriendshipOriginSourceType.PlayerSearch.rawValue()

return React.memo(function(tbl1) -- name: SduiFriendRequestButton
    local userId = tbl1.userId
    local var2 = useDispatch()

    local var3 = SignalsReact.useSignalState(FriendsStore.get().GetFriendshipStatus(userId or "").data)

    local isDisabled = var3 == Enum.FriendStatus.FriendRequestSent or var3 == Enum.FriendStatus.FriendRequestReceived

    local onActivated = React.useCallback(function()
        if isDisabled or userId == nil then
            return
        end

        if tbl1.sduiContext then
            SduiRequestFriendshipAction(
                {
                    actionType = SduiActionType.RequestFriendship,
                    actionParams = {
                        targetUserId = userId,
                        source = tbl1.source
                    }
                },
                tbl1.analyticsContext,
                tbl1.sduiContext
            )
            return
        end

        local var4 = if typeof(tbl1.source) == "string" and tbl1.source ~= "" then tbl1.source else var1

        local requestFriendship = FriendsStore.get().RequestFriendship
        local var5 = userId

        local var6 = nil
        local var7 = if FFlagEnableFriendsStoreChallengeInterceptor then friendsStoreChallengeNetwork else nil

        requestFriendship(var5, var4, var6, var7):andThen(function()
            var2(SetCurrentToastMessage({ toastMessage = "Feature.Friends.Action.FriendRequestSent", isLocalized = false }))
        end):catch(function(_)
            var2(SetCurrentToastMessage({ toastMessage = "Feature.Toast.NetworkingError.SomethingIsWrong", isLocalized = false }))
        end)

        if FFlagSduiSearchPeoplePlayerTileTelemetry then
            firePlayerFriendAddTelemetry(userId, tbl1.analyticsContext, tbl1.sduiContext)
        end
    end, {
        isDisabled,
        userId,
        tbl1.source,
        var2,
        tbl1.analyticsContext,
        tbl1.sduiContext
    })

    if var3 == nil
        or var3 == Enum.FriendStatus.Friend
        or FFlagSduiFriendRequestButtonHideForSelf and userId ~= nil and userId == getCurrentUserId()
    then
        return nil
    end

    return React.createElement("TextButton", {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        Text = "",
        LayoutOrder = tbl1.layoutOrder,
        Visible = tbl1.visible == nil or tbl1.visible
    }, {
        Button = React.createElement(IconButton, {
            icon = "icons/common/plus_small",
            variant = Enums2.ButtonVariant.OverMedia,
            isDisabled = isDisabled,
            isCircular = true,
            size = tbl1.size or Small,
            onActivated = onActivated
        })
    })
end)
