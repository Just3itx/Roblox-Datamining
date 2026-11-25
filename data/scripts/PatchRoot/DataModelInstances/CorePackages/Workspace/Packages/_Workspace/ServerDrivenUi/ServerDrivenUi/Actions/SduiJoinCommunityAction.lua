-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local DataHydration = require(ServerDrivenUiParent.DataHydration)
local Signals = require(ServerDrivenUiParent.Signals)
local SetCurrentToastMessage = require(ServerDrivenUiParent.ToastRodux).Actions.SetCurrentToastMessage

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

local function SduiJoinCommunityAction(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.JoinCommunity,
                message = "Missing action params"
            },
            arg2.appPage
        )
        return
    end

    local communityId = actionParams.communityId
    if communityId == nil or typeof(communityId) ~= "string" then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.JoinCommunity,
                message = "Missing actionParam: communityId",
                propName = "communityId"
            },
            arg2.appPage
        )
        return
    end

    local var1 = DataHydration.CommunityUserMembership.getCommunityUserMembershipStore(false).joinCommunity(communityId)

    local dispatch = arg2.dependencies.dispatch
    local tbl1 = {}
    tbl1.dispose = Signals.createEffect(function(arg3)
        local var2 = var1(arg3)
        if var2 == nil then
            return
        end

        if var2.type == "error" then
            dispatch(SetCurrentToastMessage({ toastMessage = "Feature.Toast.NetworkingError.SomethingIsWrong" }))
        end

        local dispose = tbl1.dispose
        if dispose then
            dispose()
            tbl1.dispose = nil
        end
    end)
end

return SduiJoinCommunityAction
