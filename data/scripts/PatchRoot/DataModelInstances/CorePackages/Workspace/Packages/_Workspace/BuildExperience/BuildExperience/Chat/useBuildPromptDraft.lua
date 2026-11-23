-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)
local FFlagBuildExperienceDeveloperProductContext = require(BuildExperience.Flags.FFlagBuildExperienceDeveloperProductContext)

local GetBuildPromptDraftStore = require(BuildExperience.Stores.GetBuildPromptDraftStore)
local chatTypes = require(script.Parent.chatTypes)

local function useBuildPromptDraft(universeId: number?, sessionId: string?, callback: (...any) -> (...any), func1: ((...any) -> (...any))?, bool1: boolean?, current)
    local buildPromptDraftStore = GetBuildPromptDraftStore()
    local var1 = SignalsReact.useSignalState(buildPromptDraftStore.getPendingDraft)
    local var2 = nil
    if FFlagBuildExperienceDeveloperProductContext then
        local var3 = React.useRef(current)
        var3.current = current
        var2 = var3
    end

    React.useEffect(function()
        if FFlagBuildExperienceMonetizationNativeUI and (bool1 == false or buildPromptDraftStore.getPendingDraft() ~= var1)
            or var1 == nil
            or var1.universeId ~= universeId
            or var1.sessionId ~= nil and var1.sessionId ~= sessionId
            or not FFlagBuildExperienceDeveloperProductContext and var1.resourceAttachments ~= nil
        then
            return
        end

        if FFlagBuildExperienceDeveloperProductContext and var1.resourceAttachments ~= nil then
            local current2 = if var2 == nil then nil else var2.current

            if current2 == nil then
                return
            end
            current2.clearComposerResourceAttachments()
            for _, resourceAttachment in var1.resourceAttachments do
                if current2.findComposerResourceAttachmentIndexByUri(chatTypes.getResourceAttachmentUri(resourceAttachment)) == nil then
                    current2.addComposerResourceAttachment(resourceAttachment)
                end
            end
        end
        callback(var1.text)
        if var1.autoSend == true and (func1 == nil or not func1()) then
            return
        end
        buildPromptDraftStore.consumeDraft(universeId, sessionId)
    end, FFlagBuildExperienceMonetizationNativeUI
        and {
            var1 or false,
            buildPromptDraftStore,
            universeId or false,
            sessionId or false,
            callback,
            func1 or false,
            bool1 ~= false
        }
        or {
            var1,
            buildPromptDraftStore,
            universeId,
            sessionId,
            callback,
            func1
        })
end

return useBuildPromptDraft
