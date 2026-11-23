-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local DataHydration = require(AppChatParent.DataHydration)
local MomentsTypes = require(AppChatParent.MomentsTypes)
local React = require(AppChatParent.React)
local SignalsReact = require(AppChatParent.SignalsReact)

local GetMomentDetailsStore = require(AppChat.Stores.GetMomentDetailsStore)
local MomentDetailsStatus = require(script.Parent.MomentDetailsStatus)

local FFlagAppChatMomentShareCardEdgeCases = require(AppChat.Flags.FFlagAppChatMomentShareCardEdgeCases)

local MomentStatus = MomentsTypes.Enums.MomentStatus

local tbl1 = {
    metadata = {}
}

local function useMomentDetails(str1: string, str2: string)
    local momentDetailsStore = GetMomentDetailsStore(false)
    local var1 = React.useMemo(function()
        return momentDetailsStore.getAndFetchMomentDetails(str1, str2)
    end, { momentDetailsStore, str1, str2 })
    local var2 = SignalsReact.useSignalState(var1.data)
    local var3 = SignalsReact.useSignalState(var1.status)

    local var4 = var2 or tbl1
    local metadata = var4.metadata
    local creatorId = var4.creatorId
    local description = metadata.description
    local universeId = metadata.universeId
    local experienceName = metadata.experienceName
    local likeCount = metadata.likeCount
    local assetId = var4.assetId
    local captureType = metadata.captureType
    local assetAccessContext = metadata.assetAccessContext
    local isModerated = var4.isModerated
    local status = var4.status

    return React.useMemo(function()
        if var2 == nil then
            if var3 == DataHydration.DataStatus.Failed then
                return {
                    status = MomentDetailsStatus.Error
                }
            end

            return {
                status = MomentDetailsStatus.Loading
            }
        end

        if FFlagAppChatMomentShareCardEdgeCases and (isModerated == true or status == MomentStatus.Deleted) then
            return {
                status = MomentDetailsStatus.Unavailable
            }
        end

        return {
            status = MomentDetailsStatus.Ready,
            creatorId = creatorId,
            description = description,
            universeId = universeId,
            experienceName = experienceName,
            likeCount = likeCount,
            assetId = assetId,
            captureType = captureType,
            assetAccessContext = assetAccessContext
        }
    end, {
        var3,
        var2 ~= nil,
        creatorId,
        description,
        universeId,
        experienceName,
        likeCount,
        assetId,
        captureType,
        assetAccessContext,
        isModerated,
        status
    })
end

return useMomentDetails
