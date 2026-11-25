-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local default = require(SquadsCoreParent.CrossExperienceVoice).CrossExperienceVoiceManager.default

local SQUAD_VOICE_EU_MODAL_CONSENT_GIVEN_KEY = require(SquadsCore.Common.Constants).SQUAD_VOICE_EU_MODAL_CONSENT_GIVEN_KEY
local SQUAD_VOICE_EU_MODAL_SEEN_KEY = require(SquadsCore.Common.Constants).SQUAD_VOICE_EU_MODAL_SEEN_KEY
local SquadPromptType = require(SquadsCore.Enums.SquadPromptType)
local setTableAppStorageKey = require(SquadsCore.Utils.appStorageAccess).setTableAppStorageKey

return function(callback: (...any) -> (...any), str1: string, input, input2)
    return function(arg1)
        callback(arg1, {
            promptType = SquadPromptType.EuVoiceConsentPrompt,
            onConfirm = function()
                input[str1] = true
                input2[str1] = true
                setTableAppStorageKey(SQUAD_VOICE_EU_MODAL_SEEN_KEY, HttpService:JSONEncode(input))
                setTableAppStorageKey(SQUAD_VOICE_EU_MODAL_CONSENT_GIVEN_KEY, HttpService:JSONEncode(input2))

                default.default.VoiceEuModalConsented:Fire()
            end,
            onCancel = function()
                input[str1] = true
                setTableAppStorageKey(SQUAD_VOICE_EU_MODAL_SEEN_KEY, HttpService:JSONEncode(input))
                default.default.VoiceEuModalRefused:Fire()
            end
        })
    end
end
