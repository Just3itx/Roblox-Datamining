-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Players = game:GetService("Players")

local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local AdCampaignToolCallStatus = require(BuildExperienceParent.DataHydration.AdCampaignToolCallStatus)
local _chatTypes = require(BuildExperience.Chat.chatTypes)

local computed = Signals.createComputed(function()
    return {
        cardStates = {},
        pendingToolCallIds = {}
    }
end)

local function toolCallIdsKey(tbl1): string -- Luacid: Inlined by compiler; 1 call site recovered
    return table.concat(tbl1, "\0")
end

local function useAgentAdCampaignToolCallStatusFallback(tbl1, num1: number?)
    local localPlayer = Players.LocalPlayer
    if not num1 then
        if localPlayer == nil or not (localPlayer.UserId > 0) then
            num1 = nil
        else
            num1 = localPlayer.UserId
        end
    end

    local adCampaignToolCallStatusStore = AdCampaignToolCallStatus.getAdCampaignToolCallStatusStore(false)
    local key = toolCallIdsKey(tbl1)

    local var1 = React.useRef({ key = "", value = {} })
    if var1.current.key ~= key then
        var1.current = {
            key = key,
            value = table.clone(tbl1)
        }
    end

    local value = var1.current.value
    local var2 = React.useMemo(function()
        if num1 == nil or #value == 0 then
            return computed
        end
        return Signals.createComputed(function(arg1)
            local cardStates = ({})
            local pendingToolCallIds = ({})
            for _, value2 in value do
                local andFetchToolCallStatus = adCampaignToolCallStatusStore.getAndFetchToolCallStatus(num1, value2)
                local var2 = andFetchToolCallStatus.data(arg1)
                local var3 = andFetchToolCallStatus.status(arg1)
                if var3 == "NotReady" then
                    pendingToolCallIds[value2] = true
                elseif var3 == "Ready" and var2 ~= nil then
                    if var2.campaignId ~= nil then
                        local tbl4 = {
                            campaignId = var2.campaignId,
                            variant = nil,
                            campaignStartDate = nil,
                            campaignEndDate = nil
                        }
                        cardStates[value2] = tbl4
                    elseif var2.status == "processing" or var2.status == "created" then
                        pendingToolCallIds[value2] = true
                    end
                end
            end
            return { cardStates = cardStates, pendingToolCallIds = pendingToolCallIds }
        end)
    end, { adCampaignToolCallStatusStore, num1, value })
    local var3 = SignalsReact.useSignalState(var2)
    local var4 = React.useRef({})
    React.useEffect(function()
        if num1 == nil or next(var3.pendingToolCallIds) == nil then
            return
        end

        local current = var4.current
        for value2 in current do
            if var3.pendingToolCallIds[value2] == nil then
                current[value2] = nil
            end
        end
        local tbl2 = ({})
        for k in var3.pendingToolCallIds do
            local var5 = current[k] or 0
            if var5 >= 3 then
                continue
            end

            local var6 = 5 * 2 ^ var5
            local var7 = nil
            var7 = task.delay(var6, function()
                if var7 ~= nil then
                    tbl2[var7] = nil
                end
                local toolCallStatus = adCampaignToolCallStatusStore.getToolCallStatus(num1, k)
                local var8 = toolCallStatus.data(false)

                if toolCallStatus.status(false) == "Ready"
                    and var8 ~= nil
                    and var8.campaignId == nil
                    and (var8.status == "processing" or var8.status == "created")
                then
                    current[k] = var5 + 1
                    adCampaignToolCallStatusStore.fetchToolCallStatus(num1, k)
                end
            end)
            if var7 ~= nil then
                tbl2[var7] = true
            end
        end
        return function()
            for value2 in tbl2 do
                task.cancel(value2)
            end
        end
    end, { var3, num1, adCampaignToolCallStatusStore })
    return var3
end

return useAgentAdCampaignToolCallStatusFallback
