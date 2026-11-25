-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChat = script:FindFirstAncestor("VoiceChat")

local dependencies = require(VoiceChat.dependencies)

local Promise = dependencies.Promise
local default = dependencies.LinkingProtocol.LinkingProtocol.default
local SettingsRoute = dependencies.LinkingProtocol.Enums.SettingsRoute

return function()
    return Promise.new(function(callback, callback2)
        default:switchToSettingsApp(SettingsRoute.Microphone):andThen(function()
            callback()
        end):catch(function()
            callback2()
        end)
    end)
end
