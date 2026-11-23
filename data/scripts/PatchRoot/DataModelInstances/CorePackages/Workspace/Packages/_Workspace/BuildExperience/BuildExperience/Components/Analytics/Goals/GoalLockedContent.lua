-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local Button = Foundation.Button
local FoundationText = Foundation.Text
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local _GoalLockedActionId = require(BuildExperience.Analytics.Goals.GoalLockedActionId)
local _GoalTypes = require(BuildExperience.Analytics.Goals.GoalTypes)
local useGoalLockedTelemetry = require(script.Parent.useGoalLockedTelemetry)

local function GoalLockedContent(tbl1)
    local testId = tbl1.testId or "GoalLockedContent"
    local locked = tbl1.locked
    local actions = locked.actions
    local goalId = tbl1.goalId
    local universeId = tbl1.universeId

    local function getEligibleHandler(arg1) -- Luacid: unused: defined but never referenced
        if arg1 == nil or tbl1.actionHandlers == nil then
            return nil
        end
        local actionHandler = tbl1.actionHandlers[arg1.id]
        return if actionHandler == nil or not actionHandler.isEligible then nil else actionHandler
    end

    local var1 = nil
    local var2 = nil
    local secondary = nil
    local var3 = nil
    if actions ~= nil then
        var1 = actions.primary
        local primary = actions.primary

        if primary == nil or tbl1.actionHandlers == nil then
            var2 = nil
        else
            local actionHandler = tbl1.actionHandlers[primary.id]
            if actionHandler ~= nil and actionHandler.isEligible then
                var2 = actionHandler
            else
                var2 = nil
            end
        end

        secondary = actions.secondary
        local secondary2 = actions.secondary

        if secondary2 == nil or tbl1.actionHandlers == nil then
            var3 = nil
        else
            local actionHandler = tbl1.actionHandlers[secondary2.id]
            if actionHandler ~= nil and actionHandler.isEligible then
                var3 = actionHandler
            else
                var3 = nil
            end
        end

        if var2 == nil then
            var1 = secondary
            var2 = var3
            secondary = nil
            var3 = nil
        end
    end

    local tbl2 = {
        message = locked.messageKey
    }
    local id = nil
    local id2

    if var1 == nil or var2 == nil then
        id2 = nil
    else
        tbl2.primary = var1.textKey
        id2 = var1.id
    end
    if secondary ~= nil and var3 ~= nil then
        tbl2.secondary = secondary.textKey
        id = secondary.id
    end
    local var4 = useLocalization(tbl2)
    local var5 = useGoalLockedTelemetry(universeId, goalId, id2, id)

    local tbl3 = {}
    if var1 ~= nil and var2 ~= nil then
        tbl3.Primary = React.createElement(Button, {
            LayoutOrder = 1,
            text = var4.primary,
            size = InputSize.Small,
            variant = ButtonVariant.SoftEmphasis,
            fillBehavior = FillBehavior.Fill,
            width = UDim.new(1, 0),
            onActivated = function()
                var5("primary", var1.id)
                var2.onActivate()
            end,
            testId = `{testId}.Primary`
        })

        if secondary ~= nil and var3 ~= nil then
            tbl3.Secondary = React.createElement(Button, {
                LayoutOrder = 2,
                text = var4.secondary,
                size = InputSize.Small,
                variant = ButtonVariant.Standard,
                fillBehavior = FillBehavior.Fill,
                width = UDim.new(1, 0),
                onActivated = function()
                    var5("secondary", secondary.id)
                    var3.onActivate()
                end,
                testId = `{testId}.Secondary`
            })
        end
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "col gap-medium size-full-0 auto-y",
            testId = testId
        },
        {
            Message = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = var4.message,
                tag = "size-full-0 auto-y text-body-medium text-align-x-center content-default",
                testId = `{testId}.Message`
            }),
            Actions = if var2 == nil then nil else React.createElement(
                View,
                {
                    LayoutOrder = 2,
                    tag = "row gap-small size-full-0 auto-y",
                    testId = `{testId}.Actions`
                },
                tbl3
            )
        }
    )
end

return GoalLockedContent
