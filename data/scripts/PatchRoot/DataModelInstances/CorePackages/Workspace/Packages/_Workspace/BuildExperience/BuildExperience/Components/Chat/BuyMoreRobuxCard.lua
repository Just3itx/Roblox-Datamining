-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local ChatCardPriority = require(script.Parent.ChatCardEmphasis.ChatCardPriority)
local useChatCardEmphasis = require(script.Parent.ChatCardEmphasis.useChatCardEmphasis)

local FFlagBuildExperienceBuyMoreRobuxCardLayout = require(BuildExperience.Flags.FFlagBuildExperienceBuyMoreRobuxCardLayout)
local FFlagBuildExperienceChatCardEmphasis = require(BuildExperience.Flags.FFlagBuildExperienceChatCardEmphasis)

local Button = Foundation.Button
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local function BuyMoreRobuxCard(tbl1)
    local var1 = if FFlagBuildExperienceChatCardEmphasis then useChatCardEmphasis(ChatCardPriority.BuyMoreRobux) else nil
    local element = React.createElement(FoundationText, {
        LayoutOrder = 1,
        Text = tbl1.title,
        tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
    })

    local element2 = React.createElement(FoundationText, {
        LayoutOrder = 2,
        Text = tbl1.description,
        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-emphasis"
    })

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = {
            ["col size-full-0 auto-y padding-large stroke-standard stroke-default radius-large"] = true,
            ["gap-large"] = FFlagBuildExperienceBuyMoreRobuxCardLayout,
            ["gap-medium"] = not FFlagBuildExperienceBuyMoreRobuxCardLayout
        },
        testId = "BuyMoreRobuxCard"
    }

    local tbl3 = {
        Copy = if FFlagBuildExperienceBuyMoreRobuxCardLayout then React.createElement(
            View,
            { LayoutOrder = 1, tag = "col gap-xxsmall size-full-0 auto-y" },
            { Title = element, Description = element2 }
        ) else nil,
        Title = 0,
        Description = 0,
        Actions = 0
    }

    if FFlagBuildExperienceBuyMoreRobuxCardLayout then
        element = nil
    end

    tbl3.Title = element
    if FFlagBuildExperienceBuyMoreRobuxCardLayout then
        element2 = nil
    end

    tbl3.Description = element2
    local createElement2 = React.createElement
    local var3 = View
    local tbl4 = {
        LayoutOrder = if FFlagBuildExperienceBuyMoreRobuxCardLayout then 2 else 3,
        tag = "row gap-small size-full-0 auto-y"
    }
    local tbl5 = {
        PrimaryAction = React.createElement(Button, {
            LayoutOrder = 1,
            text = tbl1.primaryActionText,
            size = InputSize.Small,
            variant = if var1 == false then ButtonVariant.SoftEmphasis else ButtonVariant.Emphasis,
            fillBehavior = FillBehavior.Fill,
            onActivated = tbl1.onPrimaryAction,
            testId = "BuyMoreRobuxCard.PrimaryAction"
        }),
        SecondaryAction = React.createElement(Button, {
            LayoutOrder = 2,
            text = tbl1.secondaryActionText,
            size = InputSize.Small,
            variant = ButtonVariant.Standard,
            fillBehavior = FillBehavior.Fill,
            onActivated = tbl1.onSecondaryAction,
            testId = "BuyMoreRobuxCard.SecondaryAction"
        })
    }
    tbl3.Actions = createElement2(var3, tbl4, tbl5)
    return createElement(var2, tbl2, tbl3)
end

return BuyMoreRobuxCard
