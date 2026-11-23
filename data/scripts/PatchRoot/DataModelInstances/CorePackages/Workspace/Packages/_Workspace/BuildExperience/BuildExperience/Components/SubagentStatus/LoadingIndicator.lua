-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local Icon = Foundation.Icon
local Progress = Foundation.Progress
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local ProgressShape = Foundation.Enums.ProgressShape
local ProgressSize = Foundation.Enums.ProgressSize

local SubagentTaskStatus = CreatorAgentChat.SubagentTaskStatus

return React.memo(function(tbl1) -- name: LoadingIndicator
    local groupTransparency = React.useBinding(0)
    local testId = tbl1.testId or "subagent-status-loading-indicator"
    local layoutOrder = tbl1.layoutOrder

    if tbl1.status == SubagentTaskStatus.InProgress then
        return React.createElement(
            View,
            {
                LayoutOrder = layoutOrder,
                GroupTransparency = groupTransparency,
                tag = "auto-xy clip"
            },
            {
                Progress = React.createElement(
                    Progress,
                    {
                        shape = ProgressShape.Circle,
                        size = ProgressSize.Small,
                        testId = `{testId}-loading`
                    }
                )
            }
        )
    elseif tbl1.status == SubagentTaskStatus.Done then
        return React.createElement(Icon, {
            LayoutOrder = layoutOrder,
            name = IconName.CircleCheck,
            size = IconSize.Small,
            tag = "auto-xy content-system-success",
            testId = `{testId}-check-icon`
        })
    elseif tbl1.status == SubagentTaskStatus.Deleted then
        return React.createElement(Icon, {
            LayoutOrder = layoutOrder,
            name = IconName.CircleSlash,
            size = IconSize.Small,
            tag = "auto-xy content-emphasis",
            testId = `{testId}-deleted-icon`
        })
    elseif tbl1.status == SubagentTaskStatus.Error then
        return React.createElement(Icon, {
            LayoutOrder = layoutOrder,
            name = IconName.TriangleExclamation,
            size = IconSize.Small,
            tag = "auto-xy content-system-alert",
            testId = `{testId}-error-icon`
        })
    end

    return nil
end)
