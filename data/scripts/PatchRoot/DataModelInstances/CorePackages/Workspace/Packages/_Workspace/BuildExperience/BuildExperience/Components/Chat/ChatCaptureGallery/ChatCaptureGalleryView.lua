-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent
local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)

local ChatCaptureEmptyState = require(script.Parent.ChatCaptureEmptyState)
local ChatCaptureGrid = require(script.Parent.ChatCaptureGrid)
local _ChatCaptureToolbarIllustration = require(script.Parent.ChatCaptureToolbarIllustration)

local FFlagBuildExperienceChatCaptureGalleryEmptyEducationEnabled = require(BuildExperience.Flags.FFlagBuildExperienceChatCaptureGalleryEmptyEducationEnabled)

local Button = Foundation.Button
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local function ChatCaptureGalleryView(tbl1)
    local education = if FFlagBuildExperienceChatCaptureGalleryEmptyEducationEnabled and tbl1.education ~= nil and tbl1.education.isShown then tbl1.education else nil
    local createElement = React.createElement
    local root = Sheet.Root
    local tbl2 = {
        defaultSnapPointIndex = if education == nil then 1 else 2,
        isOpen = tbl1.isOpen,
        onClose = tbl1.onClose,
        snapPoints = { 0.5, 1 },
        testId = "ChatCaptureGalleryView"
    }
    local tbl3 = {
        Header = React.createElement(Sheet.Header, { hasCloseAffordance = true }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl1.titleText,
                TextXAlignment = Enum.TextXAlignment.Left,
                tag = "fill auto-y padding-y-small text-heading-small text-align-x-left content-emphasis"
            }),
            SelectionCount = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl1.selectionCountText,
                Visible = education == nil,
                tag = "auto-xy text-caption-small content-muted"
            })
        }),
        Content = 0,
        Actions = 0
    }

    local createElement2 = React.createElement
    local content = Sheet.Content
    local var1 = nil
    local tbl4 = {
        EmptyState = if education == nil then nil else React.createElement(ChatCaptureEmptyState, {
            descriptionText = education.descriptionText,
            emptyText = tbl1.emptyText,
            howToSteps = education.howToSteps,
            toolbarLayout = education.toolbarLayout
        }),
        Grid = 0
    }
    local element

    if education == nil then
        element = React.createElement(ChatCaptureGrid, {
            captures = tbl1.captures,
            isFinished = tbl1.isFinished,
            isLoading = tbl1.isLoading,
            isSelected = tbl1.isSelected,
            emptyText = tbl1.emptyText,
            onCaptureToggled = tbl1.onCaptureToggled,
            onShowMore = tbl1.onShowMore,
            shouldProgressivelyLoad = tbl1.shouldProgressivelyLoad,
            showMoreText = tbl1.showMoreText
        })
    else
        element = nil
    end

    tbl4.Grid = element
    tbl3.Content = createElement2(content, var1, tbl4)

    local createElement3 = React.createElement
    local actions = Sheet.Actions
    local var2 = nil
    local tbl5 = {
        Confirm = React.createElement(Button, {
            fillBehavior = FillBehavior.Fill,
            onActivated = tbl1.onConfirm,
            size = InputSize.Medium,
            text = if education ~= nil then education.dismissText else tbl1.addText,
            variant = ButtonVariant.Emphasis,
            testId = "ChatCaptureGalleryView.Confirm"
        })
    }
    tbl3.Actions = createElement3(actions, var2, tbl5)
    return createElement(root, tbl2, tbl3)
end

return ChatCaptureGalleryView
