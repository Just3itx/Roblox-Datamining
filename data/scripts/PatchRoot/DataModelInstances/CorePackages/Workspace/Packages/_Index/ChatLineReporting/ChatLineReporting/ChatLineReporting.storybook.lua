-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")
local ChatLineReportingParent = ChatLineReporting.Parent
local Cryo = require(ChatLineReportingParent.Cryo)
local React = require(ChatLineReportingParent.React)
local ReactRoblox = require(ChatLineReportingParent.Dev.ReactRoblox)

local MockProviders = require(script.Parent.MockProviders)

local Dictionary = Cryo.Dictionary

return {
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local var1 = Dictionary.union(arg2, arg2.definition and arg2.definition.props or {})
            return React.createElement(MockProviders, {}, { story = React.createElement(arg1, var1) })
        end
    end,
    storyRoots = { ChatLineReporting }
}
