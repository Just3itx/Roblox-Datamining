-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local _createPlaytestLoadingStore = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.createPlaytestLoadingStore)

local Icon = Foundation.Icon
local Progress = Foundation.Progress
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant
local ProgressShape = Foundation.Enums.ProgressShape
local ProgressSize = Foundation.Enums.ProgressSize
local useTokens = Foundation.Hooks.useTokens

local function PlaytestStatusIndicator(tbl1)
    local size400 = useTokens().Size.Size_400

    if tbl1.status == "Loading" then
        return React.createElement(
            View,
            {
                LayoutOrder = tbl1.LayoutOrder,
                Size = UDim2.fromOffset(size400, size400),
                tag = "row align-x-center align-y-center",
                testId = "MyCreationsTab.StatusIndicator.Loading"
            },
            {
                Progress = React.createElement(Progress, { shape = ProgressShape.Circle, size = ProgressSize.Small })
            }
        )
    elseif tbl1.status == "Completed" then
        return React.createElement(Icon, {
            LayoutOrder = tbl1.LayoutOrder,
            name = IconName.CircleCheck,
            size = size400,
            variant = IconVariant.Filled,
            tag = "auto-xy content-system-success",
            testId = "MyCreationsTab.StatusIndicator.Completed"
        })
    end

    return nil
end

return PlaytestStatusIndicator
