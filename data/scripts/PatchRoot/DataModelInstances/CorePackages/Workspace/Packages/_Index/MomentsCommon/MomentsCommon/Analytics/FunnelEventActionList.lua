-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")

local EventNames = require(MomentsCommon.Analytics.EventNames)
local FunnelEventNames = require(MomentsCommon.Analytics.FunnelEventNames)
local GetFFlagMomentsCreationSaveDraft = require(MomentsCommon.Flags.GetFFlagMomentsCreationSaveDraft)

local FunnelTypes = FunnelEventNames.FunnelTypes
local CreationFlowSteps = FunnelEventNames.CreationFlowSteps
local MusicEnhancementSteps = FunnelEventNames.MusicEnhancementSteps
local TrimEnhancementSteps = FunnelEventNames.TrimEnhancementSteps
local TextOverlayEnhancementSteps = FunnelEventNames.TextOverlayEnhancementSteps
local StickerOverlayEnhancementSteps = FunnelEventNames.StickerOverlayEnhancementSteps
local VoiceEnhancementSteps = FunnelEventNames.VoiceEnhancementSteps
local DraftRecoverySteps = FunnelEventNames.DraftRecoverySteps

return {
    [EventNames.EditingFlowGalleryItemSelected] = {{
        funnelType = FunnelTypes.CreationFlow,
        stepKey = CreationFlowSteps.GalleryItemSelected
    }},
    [EventNames.MomentsEditingFlowContinueToEditButtonPressed] = {{
        funnelType = FunnelTypes.CreationFlow,
        stepKey = CreationFlowSteps.GalleryItemSelectedContinuePressed
    }},
    [EventNames.MomentsEditingFlowContinueToDescriptionButtonPressed] = {{
        funnelType = FunnelTypes.CreationFlow,
        stepKey = CreationFlowSteps.EditingScreenContinuePressed
    }},
    [EventNames.MomentsEditingFlowPublished] = GetFFlagMomentsCreationSaveDraft()
        and {
            {
                funnelType = FunnelTypes.CreationFlow,
                stepKey = CreationFlowSteps.Published,
                endSession = true
            },
            {
                funnelType = FunnelTypes.DraftRecovery,
                stepKey = DraftRecoverySteps.DraftPublished,
                endSession = true,
                onlyIfSessionOpen = true
            }
        }
        or {{
            funnelType = FunnelTypes.CreationFlow,
            stepKey = CreationFlowSteps.Published,
            endSession = true
        }},
    [EventNames.EditingFlowMusicButtonPressed] = {{
        funnelType = FunnelTypes.MusicEnhancement,
        stepKey = MusicEnhancementSteps.MusicButtonPressed
    }},
    [EventNames.EditingFlowMusicSelected] = {{
        funnelType = FunnelTypes.MusicEnhancement,
        stepKey = MusicEnhancementSteps.MusicSelected
    }},
    [EventNames.EditingFlowMusicDoneButtonPressed] = {{
        funnelType = FunnelTypes.MusicEnhancement,
        stepKey = MusicEnhancementSteps.MusicApplied,
        endSession = true
    }},
    [EventNames.EditingFlowMusicBackButtonPressed] = {{
        funnelType = FunnelTypes.MusicEnhancement,
        endSession = true
    }},
    [EventNames.EditingFlowTextOverlayButtonPressed] = {{
        funnelType = FunnelTypes.TextOverlayEnhancement,
        stepKey = TextOverlayEnhancementSteps.TextOverlayButtonPressed
    }},
    [EventNames.EditingFlowTextOverlayDoneButtonPressed] = {{
        funnelType = FunnelTypes.TextOverlayEnhancement,
        stepKey = TextOverlayEnhancementSteps.TextOverlayCompleted,
        endSession = true
    }},
    [EventNames.EditingFlowTextOverlayBackButtonPressed] = {{
        funnelType = FunnelTypes.TextOverlayEnhancement,
        endSession = true
    }},
    [EventNames.EditingFlowStickerOverlayButtonPressed] = {{
        funnelType = FunnelTypes.StickerOverlayEnhancement,
        stepKey = StickerOverlayEnhancementSteps.StickerOverlayButtonPressed
    }},
    [EventNames.EditingFlowStickerSelected] = {{
        funnelType = FunnelTypes.StickerOverlayEnhancement,
        stepKey = StickerOverlayEnhancementSteps.StickerOverlaySelected
    }},
    [EventNames.EditingFlowStickerOverlayDoneButtonPressed] = {{
        funnelType = FunnelTypes.StickerOverlayEnhancement,
        stepKey = StickerOverlayEnhancementSteps.StickerOverlayCompleted,
        endSession = true
    }},
    [EventNames.EditingFlowStickerOverlayBackButtonPressed] = {{
        funnelType = FunnelTypes.StickerOverlayEnhancement,
        endSession = true
    }},
    [EventNames.EditingFlowTrimButtonPressed] = {{
        funnelType = FunnelTypes.TrimEnhancement,
        stepKey = TrimEnhancementSteps.TrimButtonPressed
    }},
    [EventNames.EditingFlowTrimDoneButtonPressed] = {{
        funnelType = FunnelTypes.TrimEnhancement,
        stepKey = TrimEnhancementSteps.TrimCompleted,
        endSession = true
    }},
    [EventNames.EditingFlowTrimBackButtonPressed] = {{
        funnelType = FunnelTypes.TrimEnhancement,
        endSession = true
    }},
    [EventNames.EditingFlowVoiceButtonPressed] = {{
        funnelType = FunnelTypes.VoiceEnhancement,
        stepKey = VoiceEnhancementSteps.VoiceButtonPressed
    }},
    [EventNames.EditingFlowVoiceTextEntered] = {{
        funnelType = FunnelTypes.VoiceEnhancement,
        stepKey = VoiceEnhancementSteps.VoiceTextEntered
    }},
    [EventNames.EditingFlowVoiceGeneratePressed] = {{
        funnelType = FunnelTypes.VoiceEnhancement,
        stepKey = VoiceEnhancementSteps.VoiceGeneratePressed
    }},
    [EventNames.EditingFlowVoiceGenerateSucceeded] = {{
        funnelType = FunnelTypes.VoiceEnhancement,
        stepKey = VoiceEnhancementSteps.VoiceGenerateSucceeded
    }},
    [EventNames.EditingFlowVoiceDoneButtonPressed] = {{
        funnelType = FunnelTypes.VoiceEnhancement,
        stepKey = VoiceEnhancementSteps.VoiceApplied,
        endSession = true
    }},
    [EventNames.EditingFlowVoiceDeleteChangePressed] = {{
        funnelType = FunnelTypes.VoiceEnhancement,
        endSession = true
    }},
    [EventNames.MomentsEditingFlowExited] = GetFFlagMomentsCreationSaveDraft()
        and {
            {
                funnelType = FunnelTypes.CreationFlow,
                endSession = true
            },
            {
                funnelType = FunnelTypes.MusicEnhancement,
                endSession = true
            },
            {
                funnelType = FunnelTypes.TextOverlayEnhancement,
                endSession = true
            },
            {
                funnelType = FunnelTypes.StickerOverlayEnhancement,
                endSession = true
            },
            {
                funnelType = FunnelTypes.TrimEnhancement,
                endSession = true
            },
            {
                funnelType = FunnelTypes.VoiceEnhancement,
                endSession = true
            },
            {
                funnelType = FunnelTypes.DraftRecovery,
                endSession = true,
                onlyIfSessionOpen = true
            }
        }
        or {
            {
                funnelType = FunnelTypes.CreationFlow,
                endSession = true
            },
            {
                funnelType = FunnelTypes.MusicEnhancement,
                endSession = true
            },
            {
                funnelType = FunnelTypes.TextOverlayEnhancement,
                endSession = true
            },
            {
                funnelType = FunnelTypes.StickerOverlayEnhancement,
                endSession = true
            },
            {
                funnelType = FunnelTypes.TrimEnhancement,
                endSession = true
            },
            {
                funnelType = FunnelTypes.VoiceEnhancement,
                endSession = true
            }
        },
    [EventNames.DraftRestoreSucceededEvent] = {{
        funnelType = FunnelTypes.DraftRecovery,
        stepKey = DraftRecoverySteps.DraftRestored
    }},
    [EventNames.MomentsReturnToGallery] = GetFFlagMomentsCreationSaveDraft()
        and {{
            funnelType = FunnelTypes.DraftRecovery,
            endSession = true,
            onlyIfSessionOpen = true
        }}
        or {}
}
