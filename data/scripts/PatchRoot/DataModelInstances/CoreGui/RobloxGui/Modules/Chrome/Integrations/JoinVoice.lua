-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local Signals = require(CorePackages.Packages.Signals)
local Foundation = require(CorePackages.Packages.Foundation)
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local Constants = require(RobloxGui.Modules.VoiceChat.Constants)
local CommonIcon = require(Chrome.Integrations.CommonIcon)
local CommonFtuxTooltip = require(Chrome.Integrations.CommonFtuxTooltip)
local Constants2 = require(Chrome.ChromeShared.Unibar.Constants)
local isVoiceChatSupported = require(Chrome.Integrations.isVoiceChatSupported)
local VOICE_JOIN_PROGRESS = Constants.VOICE_JOIN_PROGRESS
local PromptType = require(RobloxGui.Modules.VoiceChatPrompt.PromptType)
local observeCurrentContextId = require(CorePackages.Workspace.Packages.CrossExperience).Utils.observeCurrentContextId
local GetIcon = require(CorePackages.Workspace.Packages.VoiceChat).Utils.GetIcon

local CONTEXT_ID = require(CorePackages.Workspace.Packages.CrossExperience).Constants.AUDIO_FOCUS_MANAGEMENT.CEV.CONTEXT_ID

local GetFFlagIntegratePhoneUpsellJoinVoice = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagIntegratePhoneUpsellJoinVoice

local GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice

local FFlagProactiveVoiceRestrictionsUFR = require(CorePackages.Workspace.Packages.SharedFlags).FFlagProactiveVoiceRestrictionsUFR

local FFlagTokenizeUnibarConstantsWithStyleProvider = require(Chrome.ChromeShared.Flags).FFlagTokenizeUnibarConstantsWithStyleProvider
local bool1 = game:DefineFastFlag("CheckShouldShowJoinVoiceInEvent", false)

local bool2 = game:DefineFastFlag("ReplaceJoinVoiceIconToMuted", false)
local showDelay = game:DefineFastInt("JoinVoiceFtuxShowDelayMs", 1000)
local dismissDelay = game:DefineFastInt("JoinVoiceFtuxDismissDelayMs", 5000)
local priority = game:DefineFastInt("UnibarJoinVoiceTooltipPriority", 1000)
local bool3 = game:DefineFastFlag("EnableChromeJoinVoiceTooltip", false)

local Service = require(Chrome.Service)
local UnibarStyle = require(CorePackages.Workspace.Packages.Chrome).UnibarStyle

local SideSheetPlacement = require(CorePackages.Workspace.Packages.Chrome).Enums.SideSheetPlacement

local bool4 = false
local bool5 = false
local Unavailable = Service.AvailabilitySignal.Unavailable

function getShouldShowJoinVoiceTooltip()
    local ageVerificationOverlayResult = default:FetchAgeVerificationOverlay()
    local showJoinVoiceUpsellTooltip = not bool5 and ageVerificationOverlayResult and ageVerificationOverlayResult.showJoinVoiceUpsellTooltip
    bool5 = true
    return showJoinVoiceUpsellTooltip
end

local var1 = Service:register({
    initialAvailability = Service.AvailabilitySignal.Unavailable,
    id = "join_voice",
    label = "CoreScripts.TopBar.JoinVoice",
    sideSheetPlacement = SideSheetPlacement.Unibar,
    activated = function()
        if FFlagProactiveVoiceRestrictionsUFR and default:GetVoiceRestrictionState(false) ~= "normal" then
            return
        end

        local settingsHub = if GetFFlagIntegratePhoneUpsellJoinVoice() then require(RobloxGui.Modules.Settings.SettingsHub) else nil
        default.pendingConnectionSource = Constants.VOICE_CONNECTION_SOURCE.IN_EXPERIENCE
        default:JoinVoice(settingsHub)
    end,
    components = {
        Icon = function()
            local iconSize = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().ICON_SIZE else Constants2.ICON_SIZE
            local var1 = if bool2 then GetIcon("Muted", "MicLight") else "icons/controls/publicAudioJoin"

            if not bool3 then
                return (CommonIcon(var1))
            end

            local isIconVisible = getShouldShowJoinVoiceTooltip()
            return React.createElement(Foundation.View, {
                Size = UDim2.new(0, iconSize, 0, iconSize)
            }, {
                Icon = CommonIcon(var1),
                Tooltip = CommonFtuxTooltip({
                    id = "JOIN_VOICE",
                    priority = priority,
                    isIconVisible = isIconVisible,
                    dismissOnOutsideInput = true,
                    headerKey = "CoreScripts.FTUX.Heading.JoinVoice",
                    bodyKey = "CoreScripts.FTUX.Label.JoinVoiceDescription",
                    showDelay = showDelay,
                    dismissDelay = dismissDelay,
                    onDismissed = function()
                        pcall(function()
                            default:RecordUserSeenModal(Constants.MODAL_IDS.IN_EXP_JOIN_VOICE_UPSELL)
                        end)
                    end
                })
            })
        end
    }
})

if GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice() then
    return var1
end

local function setAvailability(num4: number)
    if FFlagProactiveVoiceRestrictionsUFR and default:GetVoiceRestrictionState(false) ~= "normal" then
        var1.availability:unavailable()
        return
    end
    Unavailable = num4
    if bool4 then
        return
    end

    if num4 == Service.AvailabilitySignal.Available then
        var1.availability:available()
        return
    end

    if num4 == Service.AvailabilitySignal.Unavailable then
        var1.availability:unavailable()
    end
end

local function HideOrShowJoinVoiceButton(arg1)
    if FFlagProactiveVoiceRestrictionsUFR and default:GetVoiceRestrictionState(false) ~= "normal" then
        var1.availability:unavailable()
        return
    end

    if arg1 == VOICE_JOIN_PROGRESS.Suspended and (not bool1 or default:ShouldShowJoinVoice()) then
        setAvailability(Service.AvailabilitySignal.Available)
        return
    end

    if arg1 ~= VOICE_JOIN_PROGRESS.Joined then
        return
    end

    setAvailability(Service.AvailabilitySignal.Unavailable)

    if default.inExpUpsellEntrypoint == Constants.IN_EXP_UPSELL_ENTRYPOINTS.JOIN_VOICE then
        default:ToggleMic()
        default:showPrompt(PromptType.VoiceConsentAcceptedToast)
    end
end

if FFlagProactiveVoiceRestrictionsUFR then
    local effect = Signals.createEffect(function(arg1)
        if default:GetVoiceRestrictionState(arg1) ~= "normal" then
            var1.availability:unavailable()
        end
    end)
    script.Destroying:Once(effect)
end

observeCurrentContextId(function(arg1)
    local bool6 = arg1 == CONTEXT_ID
    if bool4 == bool6 then
        return
    end

    bool4 = bool6
    if bool4 then
        Unavailable = var1.availability:get()
        var1.availability:unavailable()
        return
    end
    setAvailability(Unavailable)
end)

if isVoiceChatSupported() then
    if GetFFlagIntegratePhoneUpsellJoinVoice() then
        task.spawn(function()
            if default:ShouldShowJoinVoice() then
                setAvailability(Service.AvailabilitySignal.Available)
            end
            default.VoiceJoinProgressChanged.Event:Connect(HideOrShowJoinVoiceButton)
        end)
    else
        if default:ShouldShowJoinVoice() then
            setAvailability(Service.AvailabilitySignal.Available)
        end
        default.VoiceJoinProgressChanged.Event:Connect(HideOrShowJoinVoiceButton)
    end
end

return var1
