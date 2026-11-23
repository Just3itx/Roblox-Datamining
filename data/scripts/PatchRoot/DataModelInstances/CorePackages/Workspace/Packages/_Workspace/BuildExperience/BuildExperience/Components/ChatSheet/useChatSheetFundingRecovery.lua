-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local _useChatSessionCore = require(BuildExperience.Chat.useChatSessionCore)
local _ModelPickerTypes = require(BuildExperience.Components.ModelPicker.ModelPickerTypes)
local useCreatorCreditChatUpsellViewModel = require(BuildExperience.Components.BuildChatPage.useCreatorCreditChatUpsellViewModel)
local _BuildPillMenuPageHost = require(BuildExperience.Components.BuildPillMenu.BuildPillMenuPageHost)

local function useChatSheetFundingRecovery(arg1, arg2, universeId: number?, placeId: number?, sessionId: string?)
    local var1, var2 = React.useState(false)
    local var3 = React.useCallback(function()
        local current = arg1.textBoxRef.current
        if current ~= nil then
            current.releaseFocus()
        end
        var2(true)
    end, { arg1.textBoxRef })
    local onClose = React.useCallback(function()
        var2(false)
    end, {})
    React.useEffect(function()
        var2(false)
    end, { universeId, sessionId })
    local fundingFailure = arg1.fundingFailure
    local var5 = useCreatorCreditChatUpsellViewModel
    local tbl1 = {
        namedTier = if arg2 then if arg2.selectedId ~= "advanced" then "default" else arg2.internalTesting and arg2.internalTesting.isSelected and "default" or "advanced" else "default",
        isAssistantResponding = arg1.isAssistantResponding,
        outOfCreditsPromptFailureCount = if fundingFailure then fundingFailure.count else nil,
        outOfCreditsPromptFailureReason = if fundingFailure then fundingFailure.reason else nil,
        onOpenCreatorCreditPage = 0
    }

    if universeId == nil then
        var3 = nil
    end

    tbl1.onOpenCreatorCreditPage = var3
    return {
        card = var5(tbl1),
        page = if var1 then universeId ~= nil
            and {
                activePage = { type = "creator-credit" },
                target = {
                    universeId = universeId,
                    placeId = placeId,
                    sessionId = sessionId,
                    isNewGameTarget = false
                },
                onClose = onClose
            }
            or nil else nil
    }
end

return useChatSheetFundingRecovery
