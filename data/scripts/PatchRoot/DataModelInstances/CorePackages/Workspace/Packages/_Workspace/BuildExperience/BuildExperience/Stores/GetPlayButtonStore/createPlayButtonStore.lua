-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local _chatTypes = require(BuildExperience.Chat.chatTypes)

local function createPlayButtonStore()
    local getIsActive, setIsActive = Signals.createSignal(false)
    local getResumeTarget, setResumeTarget = Signals.createSignal(nil)

    local getPendingResourceAttachment, setPendingResourceAttachment = Signals.createSignal(nil)

    return {
        getIsActive = getIsActive,
        useIsActive = function()
            return SignalsReact.useSignalState(getIsActive)
        end,
        setIsActive = setIsActive,
        getResumeTarget = getResumeTarget,
        useResumeTarget = function()
            return SignalsReact.useSignalState(getResumeTarget)
        end,
        setResumeTarget = setResumeTarget,
        getPendingResourceAttachment = getPendingResourceAttachment,
        setPendingResourceAttachment = setPendingResourceAttachment
    }
end

return createPlayButtonStore
