-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text

local _AnalyticsMetric = require(BuildExperience.Analytics.AnalyticsMetric)
local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local _CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)
local FFlagBuildAnalyticsGoals = require(BuildExperience.Flags.FFlagBuildAnalyticsGoals)
local MetricDetailSheet = require(BuildExperience.Components.Analytics.MetricDetailSheet.MetricDetailSheet)
local _StatsCard = require(BuildExperience.Components.Analytics.StatsCard.StatsCard)
local StatsCardContainer = require(BuildExperience.Components.Analytics.StatsCardContainer)
local GoalsSection = require(BuildExperience.Components.Analytics.Goals.GoalsSection)
local _InstantStatCard = require(script.Parent.InstantStatCard)
local InstantStatsRow = require(script.Parent.InstantStatsRow)
local WindowSegmentedControl = require(script.Parent.WindowSegmentedControl)

local function sectionHeading(text: string, testId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return React.createElement(FoundationText, {
        LayoutOrder = 1,
        Text = text,
        tag = "size-full-0 auto-y text-heading-small text-align-x-left content-emphasis",
        testId = testId
    })
end

local function AnalyticsOverviewView(tbl1)
    local testId = tbl1.testId or "AnalyticsOverviewView"
    local overview = React.createElement(
        View,
        {
            LayoutOrder = 1,
            tag = "col gap-xlarge size-full-0 auto-y",
            testId = `{testId}.Overview`
        },
        {
            Heading = sectionHeading(tbl1.overviewTitle, `{testId}.OverviewHeading`),
            InstantStats = React.createElement(InstantStatsRow, { layoutOrder = 2, stats = tbl1.instantStats })
        }
    )

    local keyStats = React.createElement(
        View,
        {
            LayoutOrder = 2,
            tag = "col gap-large size-full-0 auto-y",
            testId = `{testId}.KeyStats`
        },
        {
            Heading = if FFlagBuildAnalyticsGoals then nil else sectionHeading(tbl1.keyStatsTitle, `{testId}.KeyStatsHeading`),
            WindowToggle = React.createElement(WindowSegmentedControl, {
                layoutOrder = 2,
                windows = tbl1.windows,
                selectedWindowId = tbl1.selectedWindowId,
                onWindowSelected = tbl1.onWindowSelected
            }),
            Cards = if FFlagBuildAnalyticsGoals then nil else React.createElement(StatsCardContainer, { layoutOrder = 3, cards = tbl1.statsCards }),
            Goals = if FFlagBuildAnalyticsGoals then React.createElement(GoalsSection, {
                onOpenChat = tbl1.onOpenChat,
                universeId = tbl1.universeId,
                window = tbl1.window,
                layoutOrder = 4,
                testId = `{testId}.Goals`
            }) else nil
        }
    )

    local sheet = tbl1.sheet
    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = {
            ["col gap-xxlarge size-full-0 auto-y"] = true,
            ["padding-bottom-xlarge"] = FFlagBuildAnalyticsGoals
        },
        testId = testId
    }, {
        Overview = overview,
        KeyStats = keyStats,
        Sheet = if sheet == nil then nil else React.createElement(MetricDetailSheet, {
            metricId = sheet.metricId,
            universeId = sheet.universeId,
            window = sheet.window,
            latestAvailableTime = sheet.latestAvailableTime,
            metadataStatus = sheet.metadataStatus,
            onClose = tbl1.onSheetClose,
            onOpenChat = tbl1.onOpenChat
        })
    })
end

return AnalyticsOverviewView
