-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local Logger = require(AppChat.Logger)
local UIBlox = require(AppChatParent.UIBlox)
local RobloxAppUIBloxConfig = require(AppChatParent.Dev.RobloxAppUIBloxConfig)

UIBlox.init(RobloxAppUIBloxConfig)

local Roact = require(AppChatParent.Roact)
local Cryo = require(AppChatParent.Cryo)

local MockProviders = require(AppChat.Components.MockProviders)

local tbl1 = {
    Default = { themeName = "Light", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

local Logger2 = require(AppChatParent.Loggers).Logger
Logger2:addSink({
    maxLevel = Logger2.Levels.fromString("trace"),
    log = function(_, arg1, _)
        print(arg1)
    end
})

Logger:setParent(Logger2)

return {
    roact = Roact,
    mapStory = function(arg1)
        return function(arg2)
            local var1 = not (arg2 and arg2.definition) and {} or arg2.definition.props or {}
            local var2 = arg2 and tbl1[arg2.theme] or tbl1.Default

            return Roact.createElement(
                MockProviders,
                {
                    rodux = var1.rodux,
                    themeName = var2.themeName
                },
                {
                    story = Roact.createElement(arg1, Cryo.Dictionary.union(var1, arg2))
                }
            )
        end
    end
}
