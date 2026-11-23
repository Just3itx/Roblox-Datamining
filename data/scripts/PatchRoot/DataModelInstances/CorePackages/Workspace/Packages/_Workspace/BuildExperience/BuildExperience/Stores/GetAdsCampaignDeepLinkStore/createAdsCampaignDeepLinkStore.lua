-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Signals = require(BuildExperienceParent.Signals)
local createSessionScopedSignal = require(BuildExperienceParent.SignalsUtils).createSessionScopedSignal
local _AdCampaignEligibility = require(BuildExperienceParent.DataHydration.AdCampaignEligibility)
local canCreateCampaign = require(BuildExperience.Components.Ads.adCampaignEligibilityUtils).canCreateCampaign
local _sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local FFlagBuildAdsNotificationRouting = require(BuildExperienceParent.SharedFlags).FFlagBuildAdsNotificationRouting

local function createAdsCampaignDeepLinkStore()
    local tbl1 = ({})

    local getRequest, var2 = createSessionScopedSignal(nil)

    local getStatus, var4 = createSessionScopedSignal("idle")
    local var5, var6 = createSessionScopedSignal(function()
        return {}
    end)

    local var7, var8 = createSessionScopedSignal(nil)

    local function claim(id: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        local var9 = getRequest(false)
        if var9 == nil or var9.id ~= id or var7(false) == id then
            return false
        end
        var8(id)
        return true
    end

    local function finish(id: string) -- Luacid: Inlined by compiler; 1 call site recovered
        local var9 = getRequest(false)
        if var9 == nil or var9.id ~= id then
            return
        end

        local var10 = getStatus(false)
        if var10 == "pending" or var10 == "refreshing" then
            var4("cancelled")
        end
        var2(nil)
    end

    return {
        getRequest = getRequest,
        getStatus = getStatus,
        hasVisibleChat = function(universeId)
            for value in tbl1 do
                local var9 = value(false)
                if var9 ~= nil and var9.isPageVisible and var9.universeId == universeId then
                    return true
                end
            end
            return false
        end,
        begin = function(id, universeId): boolean
            local var9 = var5(false)
            if var9[id] then
                return false
            end
            local var10 = table.clone(var9)
            var10[id] = true
            var6(var10)
            var4(if universeId == nil then "idle" else "pending")

            var2(universeId ~= nil and { id = id, universeId = universeId, expiresAt = os.clock() + 10 } or nil)

            return true
        end,
        claim = claim,
        finish = finish,
        createChat = function()
            local var9, var10 = createSessionScopedSignal(nil)
            local getScopeRevision, var12 = Signals.createSignal(0)

            local var13, var14 = createSessionScopedSignal(nil)

            local var15, var16 = createSessionScopedSignal(nil)

            return {
                getScopeRevision = getScopeRevision,
                updateScope = function(universeId: number?, sessionId: string?, isPageVisible: boolean, canPresent: boolean?)
                    local var17 = var9(false)
                    local tbl2 = {
                        universeId = universeId,
                        sessionId = sessionId,
                        isPageVisible = isPageVisible,
                        canPresent = canPresent
                    }
                    if var17 ~= nil then
                        local bool1 = var17.universeId ~= universeId or var17.sessionId ~= sessionId
                        if not bool1 and var17.isPageVisible == isPageVisible and var17.canPresent == canPresent then
                            return
                        end
                        if bool1 then
                            if var17.universeId == universeId
                                and (var17.sessionId == nil or var17.sessionId == "")
                                and sessionId ~= nil
                                and sessionId ~= ""
                                and var13(false) ~= nil
                            then
                                local var18 = var15(false)
                                if var18 ~= nil and var18.universeId == universeId and var18.sessionId == var17.sessionId then
                                    var16(tbl2)
                                end
                            else
                                var14(nil)
                                var12(function(arg1): number
                                    return arg1 + 1
                                end)
                            end
                        end
                    end
                    var10(tbl2)
                end,
                connect = function(arg1, callback, func1: (...any) -> (...any))
                    if FFlagBuildAdsNotificationRouting then
                        tbl1[var9] = true
                    end
                    local var17 = nil
                    local var18 = nil
                    local var19 = nil
                    local bool1 = false
                    local var20 = nil
                    local var21 = nil

                    local function complete(str1: string): boolean
                        local var22 = var17
                        if var22 == nil then
                            return false
                        end
                        var17 = nil
                        if var21 ~= nil then
                            task.cancel(var21)
                            var21 = nil
                        end
                        if var20 ~= nil then
                            task.cancel(var20)
                            var20 = nil
                        end
                        local var23 = getRequest(false)
                        if var23 == nil or var23.id ~= var22.id then
                            str1 = "cancelled"
                        elseif str1 == "eligible" then
                            str1 = if os.clock() >= var22.expiresAt then "timeout" else str1
                        end

                        if var23 ~= nil and var23.id == var22.id then
                            var4(str1)
                            finish(var22.id)
                        end
                        callback(
                            "AD_CAMPAIGN_DEEP_LINK_ELIGIBILITY",
                            {
                                universeId = var22.universeId
                            },
                            {
                                requestId = var22.id,
                                outcome = str1
                            }
                        )
                        return str1 == "eligible"
                    end

                    local effect = Signals.createEffect(function(arg2)
                        local var22 = getRequest(arg2)
                        local var23 = var9(arg2)
                        local isPageVisible

                        if var23 == nil then
                            isPageVisible = false
                        else
                            isPageVisible = var23.isPageVisible

                            if isPageVisible then
                                if var22 == nil then
                                    isPageVisible = false
                                else
                                    isPageVisible = var23.universeId == var22.universeId
                                end
                            end
                        end

                        if var17 ~= nil and (not isPageVisible or var22 == nil or var22.id ~= var17.id) then
                            complete("cancelled")
                        end
                        if not isPageVisible or var22 == nil then
                            return
                        end

                        local eligibility = arg1.getEligibility(var22.universeId)
                        local var24 = eligibility.data(arg2)
                        local var25 = eligibility.status(arg2)
                        if var17 ~= nil then
                            if var25 == "NotReady" then
                                bool1 = true
                            elseif var25 == "Ready" then
                                if var19 == "Ready" and var24 == var18 then
                                    return
                                end

                                if FFlagBuildAdsNotificationRouting and var23 ~= nil and var23.canPresent == false and canCreateCampaign(var24) then
                                    return
                                end
                                if complete(if canCreateCampaign(var24) then "eligible" else "ineligible") and func1(var24) then
                                    var14(var22.id)
                                    callback("AD_CAMPAIGN_DEEP_LINK_PRESENTED", { universeId = var22.universeId }, { requestId = var22.id })
                                end
                            elseif var25 == "Failed" and (var19 ~= "Failed" or bool1) then
                                complete("failed")
                            end

                            return
                        end

                        if not claim(var22.id) then
                            return
                        end
                        var17 = var22
                        var18 = var24
                        var19 = var25
                        bool1 = var25 == "NotReady"
                        local var26 = var22.expiresAt - os.clock()
                        if var26 <= 0 then
                            complete("timeout")
                            return
                        end
                        var4("refreshing")
                        var20 = task.delay(var26, function()
                            var20 = nil
                            complete("timeout")
                        end)
                        if not FFlagBuildAdsNotificationRouting then
                            local var27 = arg1.fetchEligibility(var22.universeId)
                            bool1 = bool1 or var27.status(false) == "NotReady"
                            return
                        end

                        var21 = task.defer(function()
                            var21 = nil
                            if var17 == nil or var17.id ~= var22.id then
                                return
                            end
                            local var27 = arg1.fetchEligibility(var22.universeId)
                            bool1 = bool1 or var27.status(false) == "NotReady"
                        end)
                    end)

                    return function()
                        tbl1[var9] = nil
                        effect()
                        complete("cancelled")
                    end
                end,
                clearPresentedRequest = function()
                    var14(nil)
                end,
                getPresentedRequestId = function()
                    return var13(false)
                end,
                startCreate = function()
                    var16(var9(false))
                end,
                finishCreate = function(): boolean
                    local var17 = var15(false)
                    local var18 = var9(false)
                    var16(nil)

                    return not (var17 == nil or var18 == nil or var17.universeId ~= var18.universeId) and var17.sessionId == var18.sessionId
                end
            }
        end,
        reset = function()
            var2(nil)
            var4("idle")
            var6({})
            var8(nil)
        end
    }
end

return createAdsCampaignDeepLinkStore
