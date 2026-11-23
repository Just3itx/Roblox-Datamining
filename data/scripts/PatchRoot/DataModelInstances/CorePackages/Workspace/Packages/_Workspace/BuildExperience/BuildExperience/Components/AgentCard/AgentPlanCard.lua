-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local Markdown = require(BuildExperienceParent.Markdown)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local AgentCard = require(script.Parent.AgentCard)
local AgentCardActions = require(script.Parent.AgentCardActions)
local getMarkdownRendererProps = require(BuildExperience.utils.getMarkdownRendererProps)
local ChatCardPriority = require(BuildExperience.Components.Chat.ChatCardEmphasis.ChatCardPriority)
local useChatCardEmphasis = require(BuildExperience.Components.Chat.ChatCardEmphasis.useChatCardEmphasis)
local FFlagBuildExperienceChatCardEmphasis = require(BuildExperience.Flags.FFlagBuildExperienceChatCardEmphasis)

local Button = Foundation.Button
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local MarkdownViewer = Markdown.Components.MarkdownViewer

local function AgentPlanSheet(tbl1)
    local var1 = useLocalization({ overview = LocalizationStrings.AGENT_PLAN_OVERVIEW })

    local var2 = Foundation.Hooks.useTokens()
    local default = var2.Color.Content.Default
    local markdownRendererProps = React.useMemo(function()
        return getMarkdownRendererProps(var2, default)
    end, { var2, default })

    return React.createElement(Sheet.Root, {
        isOpen = tbl1.isOpen,
        onClose = tbl1.onClose,
        snapPoints = { 0.5, 1 },
        defaultSnapPointIndex = 1,
        testId = tbl1.testId
    }, {
        Header = React.createElement(Sheet.Header, nil, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl1.title,
                tag = "size-full-0 auto-y margin-x-small padding-y-small text-heading-small text-wrap text-align-x-left content-emphasis"
            })
        }),
        Content = React.createElement(Sheet.Content, nil, {
            OverviewAndBody = React.createElement(
                View,
                { tag = "col gap-xsmall size-full-0 auto-y margin-x-small padding-bottom-large" },
                {
                    Overview = React.createElement(FoundationText, {
                        LayoutOrder = 1,
                        Text = var1.overview,
                        tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-default"
                    }),
                    Body = React.createElement(MarkdownViewer, {
                        Markdown = tbl1.textContent,
                        WrapperProps = {
                            LayoutOrder = 2,
                            tag = "size-full-0 auto-y text-body-medium content-emphasis",
                            testId = `{tbl1.testId}-text-content`
                        },
                        MarkdownRendererProps = markdownRendererProps
                    })
                }
            )
        })
    })
end

local function AgentPlanCard(tbl1)
    local var1 = useLocalization({ build = LocalizationStrings.AGENT_PLAN_BUILD, view = LocalizationStrings.AGENT_PLAN_VIEW })

    local testId = tbl1.testId or "agent-plan-card"
    local isOpen, var3 = React.useState(false)
    local var4 = if FFlagBuildExperienceChatCardEmphasis then useChatCardEmphasis(if tbl1.isBuildDisabled == true then nil else ChatCardPriority.AgentProposal) else nil

    local onActivated = React.useCallback(function()
        if tbl1.isBuildDisabled == true then
            return
        end
        tbl1.onBuild()
    end, { tbl1.isBuildDisabled, tbl1.onBuild })

    local var2 = React.useCallback(function()
        var3(true)
    end, {})

    local onClose = React.useCallback(function()
        var3(false)
    end, {})

    local createElement = React.createElement
    local fragment = React.Fragment
    local var8 = nil
    local tbl2 = { Card = 0, Sheet = 0 }
    local createElement2 = React.createElement
    local var9 = AgentCard
    local tbl3 = {
        title = tbl1.title,
        textContent = tbl1.summary or tbl1.textContent,
        layoutOrder = tbl1.layoutOrder,
        testId = testId
    }
    local tbl4 = { Actions = 0 }
    local createElement3 = React.createElement
    local var10 = AgentCardActions
    local var11 = nil
    local tbl5 = {
        Build = React.createElement(Button, {
            LayoutOrder = 1,
            text = var1.build,
            size = InputSize.Small,
            variant = if var4 == false then ButtonVariant.SoftEmphasis else ButtonVariant.Emphasis,
            fillBehavior = FillBehavior.Fill,
            isDisabled = tbl1.isBuildDisabled == true,
            onActivated = onActivated,
            testId = `{testId}-build-button`
        }),
        View = React.createElement(Button, {
            LayoutOrder = 2,
            text = var1.view,
            size = InputSize.Small,
            variant = ButtonVariant.Standard,
            fillBehavior = FillBehavior.Fill,
            onActivated = var2,
            testId = `{testId}-view-button`
        })
    }
    tbl4.Actions = createElement3(var10, var11, tbl5)
    tbl2.Card = createElement2(var9, tbl3, tbl4)

    tbl2.Sheet = React.createElement(AgentPlanSheet, {
        title = tbl1.title,
        textContent = tbl1.textContent,
        isOpen = isOpen,
        onClose = onClose,
        testId = `{testId}-sheet`
    })
    return createElement(fragment, var8, tbl2)
end

return AgentPlanCard
