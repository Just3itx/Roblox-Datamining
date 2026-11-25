-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local FFlagDebugExpChatTextChannelWindowStaticExpressions = require(script.Parent.FFlagDebugExpChatTextChannelWindowStaticExpressions)
local bool1 = game:DefineFastFlag("ExpChatPresetChatVREnabled", false)
local bool2 = game:DefineFastFlag("ExpChatTextChannelWindowExpressionTray", false)

local function isSupportedPlatform(): boolean -- Luacid: unused: defined but never referenced
    return not UserInputService.VREnabled or bool1
end

if bool2 then
    if game:GetEngineFeature("TextChatPresetsEnabled") or FFlagDebugExpChatTextChannelWindowStaticExpressions then
        if UserInputService.VREnabled then
            return bool1
        end

        FFlagDebugExpChatTextChannelWindowStaticExpressions = true
    end
else
    FFlagDebugExpChatTextChannelWindowStaticExpressions = bool2
end

return FFlagDebugExpChatTextChannelWindowStaticExpressions
