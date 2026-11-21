-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)

local render = require(ChatUIPrimitivesParent.Dev.ReactTestingLibrary).render

local BenchmarkUtils = require(ChatUIPrimitivesParent.Dev.BenchmarkUtils)
local benchFile = BenchmarkUtils.benchFile
local benchmarkWarm = BenchmarkUtils.benchmarkWarm
local benchmarkInstanceCount = BenchmarkUtils.benchmarkInstanceCount

local ChatInputBarView = require(ChatUIPrimitives.Components.ChatInputBar.ChatInputBarView)

local element = React.createElement(
    Foundation.FoundationProvider,
    nil,
    React.createElement(ChatInputBarView, {
        onSend = function(_: string) end,
        canLocalUserChat = true,
        placeholderText = "Write a message",
        autocomplete = { commands = nil, emojis = true }
    })
)

benchFile(script, function()
    benchmarkWarm("Render ChatInputBarView (emoji autocomplete)", function()
        render(element):unmount()
    end)

    benchmarkInstanceCount("Mount ChatInputBarView (emoji autocomplete)", element)
end)
