-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local LocalUserIdStore = require(ServerTriggeredModalsParent.LocalUserIdStore).LocalUserIdStore
local Logger = require(ServerTriggeredModals.Logger)
local reportPromptImpression = require(ServerTriggeredModals.reportPromptImpression)
local sendModalImpressionEvent = require(ServerTriggeredModalsParent.ServerTriggeredModalImpressions).sendModalImpressionEvent

return {
    handlePromptsResponse = function(arg1)
        if type(arg1) ~= "table" or type(arg1.custom_prompts) ~= "table" then
            return
        end

        local currentUserId = LocalUserIdStore.getCurrentUserId(false)
        if currentUserId == "" or arg1.custom_prompts.SplitPaneEducationalTour == nil then
            return
        end

        local var1 = require(ServerTriggeredModalsParent.SplitPane).getSplitPaneEducationalTourStore(false)
        if var1.hasHandledCustomPromptForUser(currentUserId) then
            return
        end

        var1.setHasHandledCustomPromptForUser(currentUserId, true)
        var1.setPendingUserId(currentUserId)
        var1.setOnTourVisible(function()
            reportPromptImpression("SplitPaneEducationalTour", "SplitPaneEducationalTour"):catch(function()
                Logger:warning("Failed to report split-pane educational prompt impression")
            end)
            sendModalImpressionEvent("SplitPaneEducationalTour", "SplitPaneEducationalTour")
        end)
        var1.setIsOpen(true)
    end
}
