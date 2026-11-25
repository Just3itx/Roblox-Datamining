-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local Constants = require(SquadsCore.Common.Constants)

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local useCurrentSquadParentChannelId = require(SquadsCore.Hooks.useCurrentSquadParentChannelId)

local React = require(SquadsCoreParent.React)
local RealtimeDelivery = require(SquadsCoreParent.RealtimeDelivery)
local SharedFlags = require(SquadsCoreParent.SharedFlags)
local useDispatch = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useDispatch

local FFlagSquadAppChatRTNFix = SharedFlags.FFlagSquadAppChatRTNFix

local function SquadAppChatEventReceiver(tbl1)
    local var1 = useDispatch()
    local var2 = React.useContext(SquadExternalContractContext)
    local var3 = if FFlagSquadAppChatRTNFix then useCurrentSquadParentChannelId() else tbl1.conversationId

    RealtimeDelivery.useRealtimeNamespace(Constants.COMMUNICATION_CHANNEL_RTN_NAMESPACE, function(arg1)
        local var4 = not FFlagSquadAppChatRTNFix and tbl1.conversationId and tbl1.conversationId == arg1.ChannelId

        if arg1.ChannelType ~= Constants.SQUAD_CHANNEL_TYPE then
            return
        end

        if FFlagSquadAppChatRTNFix then
            var4 = var3 and var3 == arg1.ParentChannelId
        end

        if arg1.Type == Constants.CHANNEL_CREATED_DETAIL_TYPE and not var4 or arg1.Type == Constants.CHANNEL_DELETED_DETAIL_TYPE then
            var2.fetchParentChannelDetails(var1, arg1.ParentChannelId)
        end

        if arg1.Type == Constants.CHANNEL_UPDATED_DETAIL_TYPE
            and arg1.PreviousChannelStatus
            and arg1.PreviousChannelStatus.ParentChannelId
        then
            var2.fetchParentChannelDetails(var1, arg1.PreviousChannelStatus.ParentChannelId)
        end
    end, { var1, var3, var2.fetchParentChannelDetails })

    return nil
end

return SquadAppChatEventReceiver
