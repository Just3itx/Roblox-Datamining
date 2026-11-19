-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local engineFeature = game:GetEngineFeature("AudioFocusManagement")

local CrossExperienceVoice = require(CorePackages.Workspace.Packages.CrossExperienceVoice)
local Service = if require(CorePackages.Workspace.Packages.Chrome).Enabled() then require(Chrome.Service) else nil
local Constants = require(Chrome.Integrations.Party.Constants)
local useIsVoiceFocused = CrossExperienceVoice.Hooks.useIsVoiceFocused
local useIsVoiceConnected = CrossExperienceVoice.Hooks.useIsVoiceConnected

local function PartyMicBinder()
    local var1 = useIsVoiceFocused()
    local var2 = useIsVoiceConnected()
    local var3 = React.useMemo(function()
        if Service then
            return Service:integrations()[Constants.TOGGLE_MIC_INTEGRATION_ID]
        end

        return nil
    end, {})

    React.useEffect(function()
        if not var3 then
            return
        end

        if var2 and (var1 or not engineFeature) then
            var3.availability:available()
            return
        end
        var3.availability:unavailable()
    end, { var2, var1, var3 })

    return nil
end

return PartyMicBinder
