-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local Constants = require(SquadsCore.Common.Constants)
local Logger = require(SquadsCore.Logger)
local RoduxSquads = require(SquadsCore.RoduxSquads)

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local fetchActiveSquad = require(SquadsCore.Thunks.fetchActiveSquad)
local serializeTable = require(SquadsCore.Utils.serializeTable)

local React = require(SquadsCoreParent.React)
local RealtimeDelivery = require(SquadsCoreParent.RealtimeDelivery)
local useDispatch = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useDispatch

return function(tbl1)
    local var1 = useDispatch()
    local var2 = React.useContext(SquadExternalContractContext)

    RealtimeDelivery.useRealtimeNamespace(Constants.COMMUNICATION_CHANNEL_RTN_NAMESPACE, function(arg1)
        if not table.find(Constants.PARENT_CHANNEL_TYPES, arg1.ChannelType)
            or not tbl1.currentParentChannelId
            or tbl1.currentParentChannelId ~= arg1.ChannelId
        then
            return
        end

        Logger:debug(
            "Parent squad channel RTN received. Detail: {}, CurrentParentChannelId: {}",
            serializeTable(arg1),
            tbl1.currentParentChannelId
        )

        if arg1.Type == Constants.CHANNEL_DELETED_DETAIL_TYPE
            or arg1.Type == Constants.CHANNEL_ARCHIVED_DETAIL_TYPE
            or arg1.Type == Constants.CHANNEL_LOCAL_USER_REMOVED_DETAIL_TYPE
        then
            var1(RoduxSquads.Actions.CurrentSquadUpdated(nil))
        elseif arg1.Type == Constants.CHANNEL_PARTICIPANT_REMOVED_DETAIL_TYPE then
            var1(fetchActiveSquad())
        end
    end, { var1, tbl1.currentParentChannelId, var2.fetchParentChannelDetails })

    React.useEffect(function()
        if tbl1.currentParentChannelId and tbl1.currentParentChannelId ~= "" then
            var2.fetchParentChannelDetails(var1, tbl1.currentParentChannelId)
        end
    end, { var1, tbl1.currentParentChannelId, var2.fetchParentChannelDetails })

    return nil
end
