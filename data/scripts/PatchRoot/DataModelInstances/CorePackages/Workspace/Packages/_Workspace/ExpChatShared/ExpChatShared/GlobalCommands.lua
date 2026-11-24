-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GlobalHelpCommand = require(script.GlobalHelpCommand)
local GlobalClearCommand = require(script.GlobalClearCommand)
local GlobalMuteCommand = require(script.GlobalMuteCommand)
local GlobalUnmuteCommand = require(script.GlobalUnmuteCommand)
local GlobalOnlineCommand = require(script.GlobalOnlineCommand)

local engineFeature = game:GetEngineFeature("ExpChatGlobalUserCountEnabled")
local bool1 = game:DefineFastFlag("ExpChatEnableGlobalOnlineCommand", false)

local _types = require(script.types)

return {
    getGlobalEnabledCommands = function()
        local globalEnabledCommands = {}

        table.insert(globalEnabledCommands, GlobalClearCommand)
        table.insert(globalEnabledCommands, GlobalHelpCommand)
        table.insert(globalEnabledCommands, GlobalMuteCommand)
        table.insert(globalEnabledCommands, GlobalUnmuteCommand)

        if engineFeature and bool1 then
            table.insert(globalEnabledCommands, GlobalOnlineCommand)
        end

        return globalEnabledCommands
    end,
    GlobalHelpCommand = GlobalHelpCommand,
    GlobalClearCommand = GlobalClearCommand,
    GlobalMuteCommand = GlobalMuteCommand,
    GlobalUnmuteCommand = GlobalUnmuteCommand,
    GlobalOnlineCommand = GlobalOnlineCommand
}
