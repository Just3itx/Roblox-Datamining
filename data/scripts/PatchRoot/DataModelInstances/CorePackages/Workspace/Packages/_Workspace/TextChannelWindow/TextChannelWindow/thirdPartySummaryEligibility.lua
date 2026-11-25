-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Signals = require(scriptParentParent.Signals)
local SharedFlags = require(scriptParentParent.SharedFlags)

local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local FFlagChatSummariesSettingEnabled = SharedFlags.FFlagChatSummariesSettingEnabled
local FFlagEnableClientSummarySystemMessageOnLua = SharedFlags.FFlagEnableClientSummarySystemMessageOnLua

local FFlagExpChatTextChannelWindowWelcomeAndSummary = require(script.Parent.Flags.FFlagExpChatTextChannelWindowWelcomeAndSummary)

local function resolveEligible(str1: string, str2: string, bool1: boolean, bool2: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    if bool1 then
        if str1 == "AllowThirdPartySummary" then
            return str2 == "Enabled"
        end
    elseif bool2 and str1 == "EligibleForThirdPartySummary" then
        return str2 == "true"
    end

    return nil
end

return {
    create = function(str1: string) -- name: createThirdPartySummaryEligibility
        local getIsEligible, var2 = Signals.createSignal(false)

        if FFlagExpChatTextChannelWindowWelcomeAndSummary then
            coroutine.wrap(function()
                local expChatFeatureValueChanged = RobloxReplicatedStorage:WaitForChild("ExpChatFeatureValueChanged", 10)

                if not expChatFeatureValueChanged then
                    return
                end
                expChatFeatureValueChanged.OnClientEvent:Connect(function(num1: number, str2: string, str3: string)
                    if tostring(num1) ~= str1 then
                        return
                    end

                    local var3 = resolveEligible(str2, str3, FFlagChatSummariesSettingEnabled, FFlagEnableClientSummarySystemMessageOnLua)

                    if var3 ~= nil then
                        var2(var3)
                    end
                end)
            end)()
        end

        return { getIsEligible = getIsEligible }
    end,
    resolveEligible = resolveEligible
}
