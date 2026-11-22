-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:40:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local NotificationService = game:GetService("NotificationService")

local MomentsCommon = require(MomentsParent.MomentsCommon)
local RealtimeDelivery = require(MomentsParent.RealtimeDelivery)
local SharedFlags = require(MomentsParent.SharedFlags)
local Signals = require(MomentsParent.Signals)
local MomentsGetMomentsUserStore = require(MomentsParent.DataHydration.MomentsGetMomentsUserStore)
local getLocalUserId = require(Moments.Utils.getLocalUserId)

local bool1 = game:DefineFastFlag("MomentsPostReviewTelemetry", false)

local var1 = require(MomentsParent.Loggers).Logger:new("Moments.Upload")

local var2, var3 = Signals.createSignal({})

local function advanceWakeVersion(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var4 = table.clone(var2(false))
    var4[num1] = (var4[num1] or 0) + 1
    var3(var4)
end

local tbl1 = ({})

local var4 = nil
local connection = nil

local function onPostLifecycleEvent(arg1)
    if SharedFlags.FFlagMomentsPostFeedback and type(arg1) == "table" then
        local var5 = var1

        local str1 = tostring(arg1.type)
        local str2 = tostring(arg1.status)
        local str3 = tostring(arg1.isNewPost)
        local postAssetId = arg1.postAssetId
        var5:debug(
            "event=post_lifecycle_event type={} status={} isNewPost={} postAssetId={}",
            str1,
            str2,
            str3,
            tostring(postAssetId)
        )
    end

    if type(arg1) ~= "table"
        or arg1.type ~= "PostStatusChanged"
        or arg1.status ~= "Published" and arg1.status ~= "Rejected"
        or type(arg1.postAssetId) ~= "string"
        or arg1.postAssetId == ""
    then
        return
    end
    local localUserId = getLocalUserId()
    if localUserId == nil then
        return
    end
    if bool1 and arg1.isNewPost == true then
        local var5 = arg1.postAssetId .. ":" .. arg1.status
        if not tbl1[var5] then
            tbl1[var5] = true
            MomentsCommon.Analytics.reportMomentsCreationStep(
                "post_review",
                if arg1.status == "Published" then "success" else "failed"
            )
        end
    end
    if SharedFlags.FFlagMomentsOptimisticProfilePending then
        advanceWakeVersion(localUserId)
    end

    if SharedFlags.FFlagMomentsRefreshProfileOnPostStatus then
        MomentsGetMomentsUserStore(false).invalidateUser(localUserId)
    end
end

local function onAppResumed()
    local localUserId = getLocalUserId()
    if localUserId ~= nil then
        advanceWakeVersion(localUserId)
    end
end

return {
    subscribe = function(arg1, tbl2)
        if var4 ~= nil then
            return
        end
        var4 = (arg1 or RealtimeDelivery.RobloxEventReceiver.new(NotificationService)):observeEvent(
            "MomentsPostLifecycleV1",
            onPostLifecycleEvent
        )

        if not SharedFlags.FFlagMomentsOptimisticProfilePending then
            return
        end
        if tbl2 == nil then
            local success, result = pcall(function(): AppLifecycleObserverService
                return game:GetService("AppLifecycleObserverService")
            end)
            if success then
                tbl2 = result
            end
        end

        if tbl2 ~= nil then
            connection = tbl2.OnUnhide:Connect(onAppResumed)
        end
    end,
    unsubscribe = function()
        if var4 ~= nil then
            var4:disconnect()
            var4 = nil
        end
        if connection ~= nil then
            connection:Disconnect()
            connection = nil
        end
    end,
    getWakeVersion = function(arg1, num1: number)
        return var2(arg1)[num1] or 0
    end
}
