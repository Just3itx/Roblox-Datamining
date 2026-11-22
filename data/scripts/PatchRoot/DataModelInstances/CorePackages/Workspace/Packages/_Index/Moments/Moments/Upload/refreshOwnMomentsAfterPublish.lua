-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:40:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Players = game:GetService("Players")

local _MomentsStoreTypes = require(MomentsParent.DataHydration.MomentsStoreTypes)
local MomentsGetMomentsUserStore = require(MomentsParent.DataHydration.MomentsGetMomentsUserStore)

local function findByAssetId(moments, assetId: number) -- Luacid: Inlined by compiler; 1 call site recovered
    if moments == nil then
        return nil
    end
    for _, moment in moments do
        if moment.assetId == assetId then
            return moment
        end
    end
    return nil
end

local function refreshOwnMomentsAfterPublish(assetId: number, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = if tbl2.userStore ~= nil then tbl2.userStore else MomentsGetMomentsUserStore(false)

    local var2 = tbl2.wait or function(num1: number)
        task.wait(num1)
    end

    local var3

    if tbl2.getLocalUserId ~= nil then
        var3 = tbl2.getLocalUserId()
    else
        local localPlayer = Players.LocalPlayer
        if localPlayer == nil then
            var3 = nil
        else
            var3 = localPlayer.UserId
        end
    end

    if var3 == nil then
        return nil
    end

    for i = 1, 6 do
        if i > 1 then
            var2(2)
        end

        var1.invalidateUser(var3)

        local var4, var5 = var1.getUserMoments(var3, nil):await()
        if not var4 then
            continue
        end
        local byAssetId = findByAssetId(var5.moments, assetId)
        if byAssetId ~= nil then
            return byAssetId
        end
    end

    return nil
end

return refreshOwnMomentsAfterPublish
