-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)

local function WindowSegmentedControl(tbl1)
    local testId = tbl1.testId or "WindowSegmentedControl"

    local tbl2 = ({})
    for layoutOrder, window in tbl1.windows do
        local bool1 = window.id == tbl1.selectedWindowId
        local str1 = `Tab_{window.id}`
        local createElement = React.createElement
        local var1 = View
        local tbl3 = {
            LayoutOrder = layoutOrder,
            tag = {
                ["row align-x-center align-y-center fill auto-y padding-x-medium padding-y-small radius-circle"] = true,
                ["bg-shift-300"] = bool1
            },
            stateLayer = {
                affordance = StateLayerAffordance.Background
            },
            onActivated = 0,
            testId = 0
        }

        function tbl3.onActivated()
            tbl1.onWindowSelected(window.id)
        end
        tbl3.testId = `{testId}-segment-{window.id}`
        local tbl4 = {
            Label = React.createElement(FoundationText, {
                Text = window.label,
                tag = {
                    ["size-full-0 auto-y text-label-medium text-align-x-center text-truncate-end"] = true,
                    ["content-emphasis"] = bool1,
                    ["content-default"] = not bool1
                }
            })
        }
        tbl2[str1] = createElement(var1, tbl3, tbl4)
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = "row align-y-center gap-xxsmall size-full-0 auto-y padding-xsmall stroke-standard stroke-emphasis radius-circle",
        testId = testId
    }, tbl2)
end

return WindowSegmentedControl
