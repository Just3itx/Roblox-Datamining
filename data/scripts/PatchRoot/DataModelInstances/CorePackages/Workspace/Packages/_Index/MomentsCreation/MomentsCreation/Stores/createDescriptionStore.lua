-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local createSignal = require(MomentsCreationParent.Signals).createSignal

local function createDescriptionStore()
    local getDescription, setDescription = createSignal("")
    local getGeneratedDescription, setGeneratedDescription = createSignal(nil)
    local getGenerationToken, setGenerationToken = createSignal(nil)
    local getGeneratedTextFeedback, setGeneratedTextFeedback = createSignal(nil)
    local getGeneratedSummary, setGeneratedSummary = createSignal(nil)
    local getCommentsEnabled, setCommentsEnabled = createSignal(true)

    return {
        getDescription = getDescription,
        setDescription = setDescription,
        getGeneratedDescription = getGeneratedDescription,
        setGeneratedDescription = setGeneratedDescription,
        getGenerationToken = getGenerationToken,
        setGenerationToken = setGenerationToken,
        getGeneratedTextFeedback = getGeneratedTextFeedback,
        setGeneratedTextFeedback = setGeneratedTextFeedback,
        getGeneratedSummary = getGeneratedSummary,
        setGeneratedSummary = setGeneratedSummary,
        getCommentsEnabled = getCommentsEnabled,
        setCommentsEnabled = setCommentsEnabled
    }
end

return createDescriptionStore
