-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Signals = require(MomentsCreationParent.Signals)

local CreationFlowState = require(MomentsCreation.Enums.CreationFlowState)

local createSignal = Signals.createSignal

local Gallery = CreationFlowState.Gallery
local Preview = CreationFlowState.Preview
local Music = CreationFlowState.Music
local TextOverlay = CreationFlowState.TextOverlay
local Trimming = CreationFlowState.Trimming
local Description = CreationFlowState.Description
local StickerOverlay = CreationFlowState.StickerOverlay
local Voice = CreationFlowState.Voice

local tbl1 = {
    [Gallery] = {
        [Preview] = true
    },
    [Preview] = {
        [Gallery] = true,
        [Trimming] = true,
        [Music] = true,
        [TextOverlay] = true,
        [Voice] = true,
        [Description] = true,
        [StickerOverlay] = true
    },
    [Trimming] = {
        [Preview] = true
    },
    [Music] = {
        [Preview] = true
    },
    [TextOverlay] = {
        [Preview] = true
    },
    [Voice] = {
        [Preview] = true
    },
    [Description] = {
        [Preview] = true
    },
    [StickerOverlay] = {
        [Preview] = true
    }
}

local function createNavigationMachine(arg1)
    local getStep, var2 = createSignal(arg1 or Gallery)

    local function canNavigate(arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        local var3 = getStep(false)
        if var3 == arg2 then
            return true
        end
        local var4 = tbl1[var3]
        return not (var4 == nil) and var4[arg2] == true
    end

    return {
        getStep = getStep,
        canNavigate = canNavigate,
        navigate = function(arg2): boolean
            if not canNavigate(arg2) then
                return false
            end
            var2(arg2)
            return true
        end,
        reset = function(arg2)
            var2(arg2)
        end
    }
end
return createNavigationMachine
