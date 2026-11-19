-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local CrossExperienceVoice = require(CorePackages.Workspace.Packages.CrossExperienceVoice)
local GetFFlagEnableCrossExpVoice = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableCrossExpVoice

local SideSheetPlacement = require(CorePackages.Workspace.Packages.Chrome).Enums.SideSheetPlacement

local Service = require(Chrome.Service)
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local PartyMicIcon = require(Chrome.Integrations.Party.PartyMicIcon)
local Constants = require(Chrome.Integrations.Party.Constants)
local Signal = require(CorePackages.Workspace.Packages.AppCommonLib).Signal
local MappedSignal = ChromeUtils.MappedSignal

local default = CrossExperienceVoice.CrossExperienceVoiceManager.default

local var1 = nil
local bool1 = false

local signal = Signal.new()
local signal2 = Signal.new()

signal:connect(function(arg1)
    var1 = arg1
end)

signal2:connect(function(arg1)
    bool1 = arg1
end)

local mappedSignal = MappedSignal.new(signal, function()
    return bool1 and var1 == false
end)

local FFlagChangeToggleMicText = require(Chrome.Flags.FFlagChangeToggleMicText)

return if GetFFlagEnableCrossExpVoice() then Service:register({
    id = Constants.TOGGLE_MIC_INTEGRATION_ID,
    label = if FFlagChangeToggleMicText then "CoreScripts.TopBar.Mic" else "CoreScripts.TopBar.ToggleMic",
    sideSheetPlacement = SideSheetPlacement.Unibar,
    isActivated = mappedSignal,
    activated = function()
        local userId = Players and Players.LocalPlayer and Players.LocalPlayer.UserId or -1
        if userId == -1 or not bool1 or var1 == nil then
            return
        end

        if var1 then
            default:unmuteVoiceParticipant(userId)
            return
        end
        default:muteVoiceParticipant(userId)
    end,
    components = {
        Icon = function()
            return PartyMicIcon({ isLocalPlayerMutedSignal = signal, isVoiceConnectedSignal = signal2 })
        end
    },
    initialAvailability = Service.AvailabilitySignal.Unavailable
}) else nil
