-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorCredit = require(BuildExperienceParent.DataHydration.CreatorCredit)
local LocalUserIdStore = require(BuildExperienceParent.LocalUserIdStore).LocalUserIdStore
local Signals = require(BuildExperienceParent.Signals)
local CreatorCreditConfig = require(BuildExperience.CreatorCreditConfig)

local function createBuildCreatorCreditRefreshStore(tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.getCreditStore or function()
        return CreatorCredit.getCreatorCreditStore(false)
    end
    local var2 = tbl2.getUserId or LocalUserIdStore.getCurrentUserId
    local var3 = tbl2.onUnhide or game:GetService("AppLifecycleObserverService").OnUnhide
    local var4 = tbl2.now or function(): number
        return DateTime.now().UnixTimestamp
    end
    local num1 = 0
    local var5 = nil
    local var6 = nil
    local var7 = nil
    local var8 = nil
    local tbl3 = ({})

    local function cancelTimers() -- Luacid: Inlined by compiler; 2 call sites recovered
        if var6 then
            task.cancel(var6)
            var6 = nil
        end
        if var7 then
            task.cancel(var7)
            var7 = nil
        end
        if var8 then
            task.cancel(var8)
            var8 = nil
        end
    end

    local function refresh() -- Luacid: Inlined by compiler; 2 call sites recovered
        if var6 then
            return
        end
        local var9 = var2(false)
        local var10 = var1()
        var6 = task.defer(function()
            var6 = nil
            if var9 ~= var2(false) or var10 ~= var1() then
                return
            end
            var10.refreshQuotaSummary():catch(function() end)
            local var11 = assert(var10.refreshTierQuotaSummary, "Model picker requires tier quotas")
            var11("PRODUCT_BUILD", "default")
            var11("PRODUCT_BUILD", "advanced")
        end)
    end

    return {
        acquire = function()
            num1 += 1
            if num1 == 1 then
                local var9 = var1()
                local var10 = nil
                local effect = Signals.createEffect(function(arg1)
                    local var11 = var2(arg1)
                    if var11 ~= var10 then
                        cancelTimers()
                        tbl3 = {}
                        var10 = var11
                    end
                    if var8 then
                        task.cancel(var8)
                        var8 = nil
                    end
                    local tbl4 = ({})
                    for _, value in { "default", "advanced" } do
                        local var12 = assert(var9.getTierQuotaSummarySignals, "Model picker requires tier quotas")("PRODUCT_BUILD", value).data(arg1)
                        local nextResetEligibleTime = if var12 then var12.nextResetEligibleTime else nil

                        if typeof(nextResetEligibleTime) ~= "string" or nextResetEligibleTime == "" then
                            continue
                        end

                        local dateTime = DateTime.fromIsoDate(nextResetEligibleTime)
                        if dateTime then
                            tbl4[nextResetEligibleTime] = dateTime.UnixTimestamp
                        end
                    end

                    local function scheduleReset()
                        local var12 = nil
                        local var13 = nil
                        for value, value2 in tbl4 do
                            if not tbl3[value] and (var12 == nil or value2 < var12) then
                                var13 = value
                                var12 = value2
                            end
                        end

                        if not var12 or not var13 then
                            return
                        end
                        var8 = task.delay(math.max(1, var12 - var4() + CreatorCreditConfig.FIntResetRefreshBufferSeconds), function()
                            var8 = nil
                            tbl3[var13] = true
                            scheduleReset()
                            refresh()
                        end)
                    end

                    scheduleReset()
                end)
                local connection = var3:Connect(refresh)
                var5 = function()
                    connection:Disconnect()
                    effect()
                    cancelTimers()
                end
            end

            local bool1 = false
            return function()
                if bool1 then
                    return
                end
                bool1 = true
                num1 -= 1
                if num1 == 0 and var5 then
                    var5()
                    var5 = nil
                end
            end
        end,
        refresh = refresh,
        settled = function()
            if var7 then
                task.cancel(var7)
            end
            local var9 = var2(false)
            var7 = task.delay(CreatorCreditConfig.FIntPostTurnRefreshDelaySeconds, function()
                var7 = nil
                if var9 == var2(false) then
                    refresh()
                end
            end)
        end
    }
end

return createBuildCreatorCreditRefreshStore
