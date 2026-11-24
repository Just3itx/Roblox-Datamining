-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RBXConsoleCommand = require(script.RBXConsoleCommand)
local RBXHelpCommand = require(script.RBXHelpCommand)
local RBXMuteCommand = require(script.RBXMuteCommand)
local RBXUnmuteCommand = require(script.RBXUnmuteCommand)
local RBXVersionCommand = require(script.RBXVersionCommand)
local RBXEmoteCommand = require(script.RBXEmoteCommand)
local RBXTeamCommand = require(script.RBXTeamCommand)
local RBXWhisperCommand = require(script.Whisper).RBXWhisperCommand
local RBXClearCommand = require(script.RBXClearCommand)
local RBXOnlineCommand = require(script.RBXOnlineCommand)

local engineFeature = game:GetEngineFeature("ExpChatLocalUserCountEnabled")
local bool1 = game:DefineFastFlag("ExpChatEnableVirtualLocalOnlineCommand", false)

local _types = require(script.types)

return {
    enabledCommands = {
        RBXConsoleCommand,
        RBXHelpCommand,
        RBXMuteCommand,
        RBXUnmuteCommand,
        RBXVersionCommand,
        RBXEmoteCommand,
        RBXTeamCommand,
        RBXWhisperCommand,
        RBXClearCommand
    },
    getVirtualLocalEnabledCommands = function()
        local virtualLocalEnabledCommands = {}
        if engineFeature and bool1 then
            table.insert(virtualLocalEnabledCommands, RBXOnlineCommand)
        end
        return virtualLocalEnabledCommands
    end,
    autoCastCommand = require(script.autoCastCommand),
    RBXClearCommand = RBXClearCommand,
    RBXConsoleCommand = RBXConsoleCommand,
    RBXEmoteCommand = RBXEmoteCommand,
    RBXHelpCommand = RBXHelpCommand,
    RBXMuteCommand = RBXMuteCommand,
    RBXTeamCommand = RBXTeamCommand,
    RBXUnmuteCommand = RBXUnmuteCommand,
    RBXVersionCommand = RBXVersionCommand,
    Whisper = require(script.Whisper)
}
