-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local Cryo = require(GenericAbuseReportingParent.Cryo)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)
local ReactRoblox = require(GenericAbuseReportingParent.Dev.ReactRoblox)

local FoundationProvider = Foundation.FoundationProvider

local MockProviders = require(script.Parent.MockProviders)

local Dictionary = Cryo.Dictionary

local Logger = require(GenericAbuseReporting.Logger)
Logger:addSink({
    maxLevel = Logger.Levels.fromString("trace"),
    log = function(_, arg1, arg2)
        print(`[{arg2.loggerName}] {arg1}`)
    end
})

return {
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local var1 = Dictionary.union(arg2, not arg2.definition and {} or arg2.definition.props or {})
            return React.createElement(MockProviders, {}, {
                FoundationProvider = React.createElement(
                    FoundationProvider,
                    {
                        colorMode = "Dark",
                        preferences = arg2.settings,
                        overlayGui = arg2.focus
                    },
                    {
                        story = React.createElement(arg1, var1)
                    }
                )
            })
        end
    end,
    storyRoots = { GenericAbuseReporting }
}
