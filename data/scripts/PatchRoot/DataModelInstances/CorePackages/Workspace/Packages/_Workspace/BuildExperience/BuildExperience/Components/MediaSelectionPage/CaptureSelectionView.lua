-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)
local MomentsCommon = require(BuildExperienceParent.MomentsCommon)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local View = Foundation.View

local FFlagBuildExperienceLocalizeCaptureShowMore = require(BuildExperience.Flags.FFlagBuildExperienceLocalizeCaptureShowMore)
local MediaPreview = require(script.Parent.MediaPreview)
local CaptureGridItem = require(script.Parent.CaptureGridItem)
local useCaptureSelectionViewModel = require(script.Parent.useCaptureSelectionViewModel)

local ScrollingGridView = MomentsCommon.ScrollingGridView

local function renderEmptyState()
    return React.createElement(View, { tag = "align-x-center align-y-center size-full" })
end

local function CaptureSelectionView(arg1)
    local renderItem = React.useCallback(function(capture, _: number)
        return React.createElement(
            CaptureGridItem,
            {
                capture = capture,
                isSelected = arg1.selectedCapture == capture,
                onActivated = arg1.onCaptureSelected
            }
        )
    end, { arg1.selectedCapture, arg1.onCaptureSelected })

    return React.createElement(View, { tag = "col gap-medium size-full padding-large" }, {
        Preview = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "align-x-center align-y-center size-full-0 padding-x-xlarge",
                Size = UDim2.new(1, 0, 0.4, 0)
            },
            {
                PreviewContent = React.createElement(MediaPreview, { mediaType = "image", imageContent = arg1.previewContent, isIcon = false })
            }
        ),
        CaptureGrid = React.createElement(View, { LayoutOrder = 2, tag = "fill size-full" }, {
            Grid = React.createElement(ScrollingGridView, {
                aspectRatio = 1,
                itemConfig = {
                    padding = 2,
                    maxItemsPerRow = 4,
                    minItemsPerPage = 8,
                    minItemWidth = 80
                },
                items = arg1.captures,
                layoutOrder = 1,
                onShowMoreCallback = arg1.onShowMore,
                renderEmptyState = renderEmptyState,
                renderItem = renderItem,
                shouldShowShowMoreButton = not arg1.isFinished,
                showMoreButtonText = if FFlagBuildExperienceLocalizeCaptureShowMore then arg1.showMoreText else "Show More"
            })
        }),
        ConfirmButton = React.createElement(View, { LayoutOrder = 3, tag = "size-full-0 auto-y" }, {
            Button = React.createElement(Button, {
                fillBehavior = Foundation.Enums.FillBehavior.Fill,
                isDisabled = arg1.selectedCapture == nil,
                onActivated = arg1.onConfirm,
                size = InputSize.Medium,
                text = "Continue",
                variant = ButtonVariant.Emphasis
            })
        })
    })
end

local function CaptureSelectionContainer(tbl1)
    local var1 = useCaptureSelectionViewModel({ captureSource = tbl1.captureSource, onCaptureConfirmed = tbl1.onCaptureConfirmed })

    return React.createElement(CaptureSelectionView, var1)
end

return CaptureSelectionContainer
