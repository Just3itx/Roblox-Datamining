-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local Signals = require(BuildExperienceParent.Signals)

local _chatTypes = require(BuildExperience.Chat.chatTypes)
local PROMPT_CHIPS_STATUS = require(script.Parent.promptChipsStatus).PROMPT_CHIPS_STATUS

local function createBuildPromptChipsStore(tbl1)
    local var1 = if tbl1 ~= nil and tbl1.requestSuggestions ~= nil then tbl1.requestSuggestions else CreatorAgentChat.requestBuildSuggestions
    local getChips, var3 = Signals.createSignal({})

    local getStatus, var5 = Signals.createSignal(PROMPT_CHIPS_STATUS.Idle)

    local var6 = nil
    local num1 = 0

    local function cancel() -- Luacid: Inlined by compiler; 2 call sites recovered
        num1 += 1
        if var6 ~= nil then
            var6()
            var6 = nil
        end
    end

    return {
        getChips = getChips,
        getStatus = getStatus,
        requestChips = function(tbl2, callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?)
            cancel()
            local num2 = num1
            var5(PROMPT_CHIPS_STATUS.Loading)

            local var7 = var1({ prompt = tbl2.prompt, selectedChip = if tbl2.selectedChip == nil then nil else tbl2.selectedChip.value })

            local bool1 = false
            local effect = Signals.createEffect(function(arg1)
                local var8 = var7.state(arg1)
                if bool1 or var8.status == "pending" then
                    return
                end
                bool1 = true

                local result = var8.result
                if var8.status == "succeeded" and result ~= nil then
                    var3(result.chips)
                    var5(PROMPT_CHIPS_STATUS.Succeeded)
                    if result.prompt ~= nil and callback ~= nil then
                        callback(result.prompt)
                    end
                    if callback2 ~= nil then
                        callback2(true)
                    end
                else
                    var3({})
                    var5(PROMPT_CHIPS_STATUS.Failed)
                    if callback2 ~= nil then
                        callback2(false)
                    end
                end
            end)

            if num2 ~= num1 then
                effect()
                var7.dispose()
                return
            end
            var6 = function()
                effect()
                var7.dispose()
            end
        end,
        reset = function()
            cancel()
            var3({})
            var5(PROMPT_CHIPS_STATUS.Idle)
        end
    }
end
return createBuildPromptChipsStore
