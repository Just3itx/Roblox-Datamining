-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Signals = require(MomentsCreationParent.Signals)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)

local CreationFlowState = require(MomentsCreation.Enums.CreationFlowState)
local createNavigationMachine = require(MomentsCreation.Stores.createNavigationMachine)
local createSelectionStore = require(MomentsCreation.Stores.createSelectionStore)
local createDescriptionStore = require(MomentsCreation.Stores.createDescriptionStore)
local createEditsStore = require(MomentsCreation.Stores.createEditsStore)
local FFlagMomentsTTSDraftRestore = require(MomentsCreation.Flags.FFlagMomentsTTSDraftRestore)

local createComputed = Signals.createComputed
local createSignal = Signals.createSignal
local FFlagMomentTextGenerationFilteredSignal = MomentsCommon.Flags.FFlagMomentTextGenerationFilteredSignal
local GetFFlagEnableMomentTextGeneration = MomentsCommon.Flags.GetFFlagEnableMomentTextGeneration

local function createCreationFlowStore()
    local navigationMachine = createNavigationMachine(CreationFlowState.Gallery)
    local selectionStore = createSelectionStore()
    local descriptionStore = createDescriptionStore()
    local editsStore = createEditsStore()

    local getActive, var2 = createSignal(false)

    local getMusicList, var4 = createSignal({})

    local getActiveSession, setActiveSession = createSignal(nil)

    local getIsGenerating, setIsGenerating = createSignal(false)

    local getActiveGeneration, setActiveGeneration = createSignal(nil)

    local getTtsAudio, setTtsAudio = createSignal(nil)
    local getPendingRestoredVoice, var14 = createSignal(nil)

    local getTrimEdit = createComputed(function(arg1)
        return editsStore.getMap(arg1).trim
    end)
    local getMusicEdit = createComputed(function(arg1)
        return editsStore.getMap(arg1).music
    end)
    local getTextOverlayEdits = createComputed(function(arg1)
        return editsStore.getMap(arg1).text
    end)

    local function setPendingRestoredVoice(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        var14(arg1)
    end

    return {
        getStep = navigationMachine.getStep,
        getCurrentState = navigationMachine.getStep,
        canNavigate = navigationMachine.canNavigate,
        navigate = navigationMachine.navigate,
        getActive = getActive,
        getSelectedCapture = selectionStore.getSelectedCapture,
        getDescription = descriptionStore.getDescription,
        getGeneratedDescription = descriptionStore.getGeneratedDescription,
        getGenerationToken = descriptionStore.getGenerationToken,
        getGeneratedTextFeedback = descriptionStore.getGeneratedTextFeedback,
        getGeneratedSummary = descriptionStore.getGeneratedSummary,
        getCommentsEnabled = descriptionStore.getCommentsEnabled,
        getMusicList = getMusicList,
        getMusicEdit = getMusicEdit,
        getTextOverlayEdits = getTextOverlayEdits,
        getTrimEdit = getTrimEdit,
        getEditsMap = editsStore.getMap,
        getActiveSession = getActiveSession,
        getIsGenerating = getIsGenerating,
        getActiveGeneration = getActiveGeneration,
        getTTSAudio = getTtsAudio,
        getPendingRestoredVoice = getPendingRestoredVoice,
        updateCurrentState = function(arg1)
            navigationMachine.reset(arg1)
        end,
        onSelectedCaptureUpdated = function(arg1)
            selectionStore.setSelectedCapture(arg1)
        end,
        updateDescription = function(str1: string)
            descriptionStore.setDescription(str1)
        end,
        setGeneratedDescription = function(str1: string?)
            descriptionStore.setGeneratedDescription(str1)
        end,
        setGenerationToken = function(str1: string?)
            descriptionStore.setGenerationToken(str1)
        end,
        setGeneratedTextFeedback = function(str1: string?)
            descriptionStore.setGeneratedTextFeedback(str1)
        end,
        setGeneratedSummary = function(str1: string?)
            descriptionStore.setGeneratedSummary(str1)
        end,
        updateCommentsEnabled = function(bool1: boolean)
            descriptionStore.setCommentsEnabled(bool1)
        end,
        updateTrimEdit = function(arg1)
            editsStore.setCommitted("trim", arg1)
        end,
        updateMusicEdit = function(arg1)
            editsStore.setCommitted("music", arg1)
        end,
        updateTextOverlayEdits = function(tbl1)
            editsStore.setCommitted("text", tbl1)
        end,
        setCommittedEdit = editsStore.setCommitted,
        setActiveSession = setActiveSession,
        setIsGenerating = setIsGenerating,
        setActiveGeneration = setActiveGeneration,
        setTTSAudio = setTtsAudio,
        setPendingRestoredVoice = setPendingRestoredVoice,
        onMusicSearchRetrieved = function(tbl1)
            var4(tbl1)
        end,
        clearEdits = function(arg1)
            var2(true)
            selectionStore.setSelectedCapture(nil)
            navigationMachine.reset(arg1)
            descriptionStore.setDescription("")
            descriptionStore.setCommentsEnabled(true)
            if FFlagMomentTextGenerationFilteredSignal or GetFFlagEnableMomentTextGeneration() then
                descriptionStore.setGeneratedDescription(nil)
                descriptionStore.setGenerationToken(nil)
                descriptionStore.setGeneratedTextFeedback(nil)
                descriptionStore.setGeneratedSummary(nil)
            end
            var4({})
            editsStore.clear()

            setActiveSession(nil)
            if FFlagMomentsTTSDraftRestore then
                setPendingRestoredVoice(nil)
            end
        end
    }
end

return createCreationFlowStore
