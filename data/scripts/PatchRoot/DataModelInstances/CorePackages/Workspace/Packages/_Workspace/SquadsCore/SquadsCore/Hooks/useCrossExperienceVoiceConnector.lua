-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local ThirdPartyUserService = game:GetService("ThirdPartyUserService")
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local useCurrentSquadMember = require(script.Parent.useCurrentSquadMember)
local useIsLocalPlayerPartyVoiceEligible = require(script.Parent.useIsLocalPlayerPartyVoiceEligible)
local useIsCurrentSquadPartyVoiceEligible = require(script.Parent.useIsCurrentSquadPartyVoiceEligible)

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local SquadPromptType = require(SquadsCore.Enums.SquadPromptType)
local displayEuConsentPrompt = require(SquadsCore.Utils.displayEuConsentPrompt)
local getTableAppStorageKey = require(SquadsCore.Utils.appStorageAccess).getTableAppStorageKey
local useCurrentSquadId = require(SquadsCore.Hooks.useCurrentSquadId)

local CrossExperienceVoice = require(SquadsCoreParent.CrossExperienceVoice)
local LuauPolyfill = require(SquadsCoreParent.LuauPolyfill)
local React = require(SquadsCoreParent.React)
local useDispatch = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useStore = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useStore
local SharedFlags = require(SquadsCoreParent.SharedFlags)
local getFFlagEnableCrossExpVoiceMemoryCheck = SharedFlags.getFFlagEnableCrossExpVoiceMemoryCheck
local FFlagEnableVoiceEuConsentPrompt = SharedFlags.FFlagEnableVoiceEuConsentPrompt

local clearInterval = LuauPolyfill.clearInterval
local setInterval = LuauPolyfill.setInterval

local default = CrossExperienceVoice.CrossExperienceVoiceManager.default
local useIsBackgroundDMActive = CrossExperienceVoice.Hooks.useIsBackgroundDMActive
local useIsVoiceRetriableError = CrossExperienceVoice.Hooks.useIsVoiceRetriableError

local SQUAD_VOICE_EU_MODAL_CONSENT_GIVEN_KEY = require(SquadsCore.Common.Constants).SQUAD_VOICE_EU_MODAL_CONSENT_GIVEN_KEY
local SQUAD_VOICE_EU_MODAL_SEEN_KEY = require(SquadsCore.Common.Constants).SQUAD_VOICE_EU_MODAL_SEEN_KEY

local bool1 = game:DefineFastFlag("EnableDisconnectPartyVoiceIfNeeded", false)
local bool2 = game:DefineFastFlag("EnablePartyVoiceRestrictionStatus", false)
local num1 = game:DefineFastInt("PartyVoiceRestrictionStatusMaxAttempts", 10)

function useCrossExperienceVoiceConnector()
    local userId = Players and Players.LocalPlayer and Players.LocalPlayer.UserId or 0
    local var1 = useCurrentSquadId() or ""
    local var2 = useCurrentSquadMember(userId)
    local var3 = useDispatch()
    local var4 = React.useContext(SquadExternalContractContext)
    local var5 = useStore()
    local var6 = React.useRef(nil)

    local var7 = useIsCurrentSquadPartyVoiceEligible()
    local var8 = useIsBackgroundDMActive()

    local var9, var10 = useIsLocalPlayerPartyVoiceEligible()

    local var11 = useIsVoiceRetriableError()
    local var12 = nil
    local var13 = nil
    if bool2 then
        local useState = React.useState
        local chatRestrictionStatus = if ThirdPartyUserService and ThirdPartyUserService:IsChatRestrictionSupported() then ThirdPartyUserService:GetVoiceChatRestrictionStatus() else Enum.ChatRestrictionStatus.NotRestricted
        var12, var13 = useState(chatRestrictionStatus)
    end

    local var14, var15 = React.useState(false)
    local bool3

    if var1 then
        if var1 == "" then
            bool3 = false
        else
            bool3 = var2 and not var8 and var7 and var9 and not var11

            if bool3 then
                if bool2 then
                    local notRestricted = Enum.ChatRestrictionStatus.NotRestricted
                    bool3 = var12 == notRestricted
                else
                    bool3 = true
                end
            end
        end
    else
        bool3 = var1
    end

    local var16 = if bool1 then if var1 and var1 ~= "" and var2 and var7 ~= false and (var10 or var9) then var11 and var8 else var8 else false

    if bool2 then
        React.useEffect(function()
            if var12 ~= Enum.ChatRestrictionStatus.Unknown then
                return
            end

            if not (ThirdPartyUserService and ThirdPartyUserService:IsChatRestrictionSupported()) then
                var13(Enum.ChatRestrictionStatus.NotRestricted)
                return
            end

            local num2 = 0
            local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
                num2 += 1
                local chatRestrictionStatus = ThirdPartyUserService:GetVoiceChatRestrictionStatus()

                if chatRestrictionStatus == Enum.ChatRestrictionStatus.NotRestricted
                    or chatRestrictionStatus == Enum.ChatRestrictionStatus.Restricted
                then
                    var13(chatRestrictionStatus)
                elseif num1 <= num2 then
                    var13(Enum.ChatRestrictionStatus.Restricted)
                end
            end

            local var17 = setInterval(func1, 4000)
            func1()

            return function()
                clearInterval(var17)
            end
        end, { var12 })
    end

    React.useEffect(function()
        if FFlagEnableVoiceEuConsentPrompt
            and bool3
            and getTableAppStorageKey(SQUAD_VOICE_EU_MODAL_CONSENT_GIVEN_KEY)[tostring(userId)]
        then
            var15(true)
        end
    end, { userId, bool3 })

    React.useEffect(function()
        if not FFlagEnableVoiceEuConsentPrompt or not bool3 then
            return
        end

        local str1 = tostring(userId)
        local tableAppStorageKey = getTableAppStorageKey(SQUAD_VOICE_EU_MODAL_SEEN_KEY)
        if not tableAppStorageKey[str1] then
            local tableAppStorageKey2 = getTableAppStorageKey(SQUAD_VOICE_EU_MODAL_CONSENT_GIVEN_KEY)
            var3(displayEuConsentPrompt(var4.setSquadPrompt, str1, tableAppStorageKey, tableAppStorageKey2))
        end
    end, {
        userId,
        displayEuConsentPrompt,
        bool3,
        var4.setSquadPrompt
    })

    React.useEffect(function()
        if not FFlagEnableVoiceEuConsentPrompt then
            return function() end
        end

        local connection = default.VoiceEuModalConsented.Event:Connect(function()
            var15(true)
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    React.useEffect(function()
        if var8 then
            default:setAsConnected()
            return
        end
        default:setAsDisconnected()
    end, { var8 })

    local var17 = React.useCallback(function(partyId: string, force: boolean?, shouldIgnoreMemoryWarning: boolean?)
        default:join({ partyId = partyId, force = force, shouldIgnoreMemoryWarning = shouldIgnoreMemoryWarning })
    end, {})

    local useEffect = React.useEffect
    local function func1()
        if not bool3 or FFlagEnableVoiceEuConsentPrompt and not var14 then
            return
        end

        if default:performJoinFeasibilityCheck() then
            var17(var1)
            return
        end
        var4.setSquadPrompt(var5, {
            hideCancelButton = false,
            promptType = SquadPromptType.JoinWithLowMemory,
            onConfirm = function() end,
            onCancel = function()
                var17(var1, true, true)
            end
        })
    end

    local var18 = if FFlagEnableVoiceEuConsentPrompt then var14 else nil
    useEffect(func1, { bool3, var18 })

    local var19 = React.useCallback(function()
        default:leave()
    end, {})

    React.useEffect(function()
        if bool1 and var16 then
            var19()
        end
    end, { var16, var19 })

    React.useEffect(function()
        if not getFFlagEnableCrossExpVoiceMemoryCheck() then
            return function() end
        end

        local function func2() -- Luacid: Inlined by compiler; 2 call sites recovered
            if var6.current then
                var6.current:Disconnect()
                var6.current = nil
            end
        end

        var6.current = default.MemoryLow.Event:Connect(function()
            func2()

            var4.setSquadPrompt(var5, {
                hideCancelButton = false,
                promptType = SquadPromptType.DisconnectVoiceDueToLowMemory,
                onConfirm = function()
                    var19()
                end
            })
        end)
        return function()
            func2()
        end
    end)

    return var19
end

return useCrossExperienceVoiceConnector
