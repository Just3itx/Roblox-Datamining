-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local React = require(CrossExperienceVoice.dependencies).React
local default = require(CrossExperienceVoice.CrossExperienceVoiceManager).default
local audioFocusService = default:getAudioFocusService()

return function()
    local var1, var2 = React.useState(-1)

    if audioFocusService then
        React.useEffect(function()
            var2(default:getCurrentAudioContext())

            audioFocusService.OnContextRegistered:Connect(function()
                var2(default:getCurrentAudioContext())
            end)

            audioFocusService.OnContextUnregistered:Connect(function()
                var2(default:getCurrentAudioContext())
            end)

            audioFocusService.OnDeafenVoiceAudio:Connect(function(_: number)
                var2(default:getCurrentAudioContext())
            end)

            audioFocusService.OnUndeafenVoiceAudio:Connect(function(_: number)
                var2(default:getCurrentAudioContext())
            end)
        end, {})
    end

    return var1
end
