-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")

local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)

local _ModelTypes = require(Squads.Common.ModelTypes)
local SquadVoiceAbuseReport = require(script.Parent.SquadVoiceAbuseReport)
local dependencies = require(Squads.dependencies)

local React = dependencies.React
local Foundation = dependencies.Foundation

local function SquadVoiceAbuseReportScreen(arg1)
    local navigation = arg1.navigation
    local reportData = navigation.getParam("reportData", nil)
    assert(reportData ~= nil, "SquadVoiceAbuseReportScreen requires reportData to be passed in")

    return React.createElement(Foundation.View, {
        Size = UDim2.new(1, 0, 1, 0),
        padding = UDim.new(0, 12),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        sizeConstraint = {
            MaxSize = Vector2.new(800, 450)
        },
        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-voice-abuse-report-screen" else nil
    }, {
        abuseReportFlow = React.createElement(
            SquadVoiceAbuseReport,
            {
                reportData = reportData,
                onAbandon = navigation.pop,
                onComplete = navigation.pop
            }
        )
    })
end
return SquadVoiceAbuseReportScreen
