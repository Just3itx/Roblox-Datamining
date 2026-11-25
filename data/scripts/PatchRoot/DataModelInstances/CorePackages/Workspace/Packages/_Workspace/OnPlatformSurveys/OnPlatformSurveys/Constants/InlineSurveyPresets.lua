-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")

local _InlineSurveyPreset = require(OnPlatformSurveys.Enums.InlineSurveyPreset)
local Surface = require(OnPlatformSurveys.Enums.Surface)

local tbl1 = {
    NoInviteInContent = {
        hasInvite = false,
        inviteSurface = nil,
        surveySurface = Surface.InContent
    },
    NoInviteModal = {
        hasInvite = false,
        inviteSurface = nil,
        surveySurface = Surface.Modal
    },
    ModalInviteToModalSurvey = {
        hasInvite = true,
        inviteSurface = Surface.Modal,
        surveySurface = Surface.Modal
    },
    InContentInviteToModalSurvey = {
        hasInvite = true,
        inviteSurface = Surface.InContent,
        surveySurface = Surface.Modal
    }
}

return {
    getPresentationConfig = function(arg1)
        return tbl1[arg1 or "NoInviteModal"] or tbl1.NoInviteModal
    end,
    DEFAULT_PRESET = "NoInviteModal"
}
