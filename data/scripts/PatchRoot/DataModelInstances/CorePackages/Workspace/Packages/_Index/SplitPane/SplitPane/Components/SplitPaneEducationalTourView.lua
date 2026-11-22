-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)
local ReactRoblox = require(SplitPaneParent.ReactRoblox)
local Foundation = require(SplitPaneParent.Foundation)

local SplitPaneEducationalTourChrome = require(script.Parent.SplitPaneEducationalTourChrome)
local SplitPaneEducationalTourScrim = require(script.Parent.SplitPaneEducationalTourScrim)
local SplitPaneEducationalTourVideo = require(script.Parent.SplitPaneEducationalTourVideo)
local _getSplitPaneEducationalTourPresentation = require(script.Parent.getSplitPaneEducationalTourPresentation)
local _getSplitPaneEducationalTourTooltipModel = require(script.Parent.getSplitPaneEducationalTourTooltipModel)

local ButtonVariant = Foundation.Enums.ButtonVariant
local EducationalTooltip = Foundation.EducationalTooltip

local function toOverlayLocalRect(rect: Rect, vector2: Vector2): Rect -- Luacid: Inlined by compiler; 2 call sites recovered
    return Rect.new(rect.Min - vector2, rect.Max - vector2)
end

local frame = Instance.new("Frame")
frame.BackgroundTransparency = 1

local function SplitPaneEducationalTourView(tbl1)
    local actions = {}
    if tbl1.tooltipModel ~= nil then
        if tbl1.tooltipModel.isFinal then
            table.insert(actions, {
                text = tbl1.tooltipModel.primaryActionText,
                variant = ButtonVariant.Emphasis,
                onActivated = tbl1.onEnd,
                ref = tbl1.setPrimaryActionRef,
                testId = "split-pane-educational-tour--action-finish-tour"
            })
        else
            table.insert(actions, {
                text = tbl1.tooltipModel.primaryActionText,
                variant = ButtonVariant.Emphasis,
                onActivated = tbl1.onNext,
                ref = tbl1.setPrimaryActionRef,
                testId = "split-pane-educational-tour--action-next"
            })

            table.insert(actions, {
                text = tbl1.tooltipModel.skipActionText or "",
                variant = ButtonVariant.Standard,
                onActivated = tbl1.onEnd,
                testId = "split-pane-educational-tour--action-skip"
            })
        end
    end

    local tooltipModel = tbl1.tooltipModel
    local element

    if tbl1.presentation.isAnchorReady and tooltipModel ~= nil and tbl1.presentation.anchorRef ~= nil then
        element = React.createElement(EducationalTooltip, {
            ref = tbl1.setTooltipContentRef,
            isOpen = true,
            anchorRef = tbl1.presentation.anchorRef,
            side = tooltipModel.side,
            align = tooltipModel.align,
            hasArrow = false,
            title = tooltipModel.title,
            text = tooltipModel.text,
            media = React.createElement(SplitPaneEducationalTourVideo, {
                videoAssetId = tooltipModel.videoAssetId,
                mediaWidth = tbl1.mediaWidth,
                videoAspectRatio = tbl1.videoAspectRatio,
                topRadius = tbl1.tokens.Radius.Medium
            }),
            steps = {
                current = tooltipModel.stepIndex,
                total = tooltipModel.totalSteps
            },
            actions = actions,
            selectionGroup = {
                SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
                SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
                SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
                SelectionBehaviorUp = Enum.SelectionBehavior.Stop
            },
            testId = "split-pane-educational-tour"
        })
    else
        element = nil
    end

    local supportPaneRect = if tbl1.supportPaneRect == nil then nil else toOverlayLocalRect(tbl1.supportPaneRect, tbl1.overlayOrigin)
    local var2 = if tbl1.presentation.spotlightRect == nil then nil else toOverlayLocalRect(tbl1.presentation.spotlightRect, tbl1.overlayOrigin)
    local var3 = if tbl1.presentation.dimEndX == nil then nil else tbl1.presentation.dimEndX - tbl1.overlayOrigin.X
    local isTooltipContentVisible = tbl1.presentation.isAnchorReady and tbl1.isTooltipContentVisible
    local tbl3 = { OverlayPortal = 0 }
    local var4

    if tbl1.overlayInstance == nil then
        var4 = nil
    else
        local createPortal = ReactRoblox.createPortal
        local createElement = React.createElement
        local fragment = React.Fragment
        local var5 = nil
        local tbl4 = { GamepadCollapsedTooltipAnchor = 0, Scrim = 0, FocusHold = 0, Chrome = 0 }
        local element2

        if tbl1.presentation.isGamepadCollapsedStepOne then
            element2 = React.createElement("Frame", {
                Name = "GamepadCollapsedTooltipAnchor",
                ref = tbl1.setGamepadCollapsedTooltipAnchorInstance,
                Position = UDim2.new(0.5, tbl1.mediaWidth / 2 + tbl1.tokens.Padding.Small, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.fromOffset(1, 1),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            })
        else
            element2 = nil
        end

        tbl4.GamepadCollapsedTooltipAnchor = element2
        local var6

        if tbl1.hasPresentedTooltip or tbl1.holdsInputBeforeTooltip then
            local createElement2 = React.createElement
            local var7 = SplitPaneEducationalTourScrim
            local tbl5 = { targetRect = 0, dimEndX = 0, isTransparent = 0 }
            if not isTooltipContentVisible then
                var2 = nil
            end

            tbl5.targetRect = var2
            if not isTooltipContentVisible then
                var3 = nil
            end

            tbl5.dimEndX = var3
            tbl5.isTransparent = not tbl1.hasPresentedTooltip
            var6 = createElement2(var7, tbl5)
        else
            var6 = nil
        end

        tbl4.Scrim = var6
        local element3

        if tbl1.holdsInputBeforeTooltip and tbl1.tooltipModel == nil then
            element3 = React.createElement("Frame", {
                Name = "SplitPaneEducationalTourFocusHold",
                ref = tbl1.setFocusSurfaceRef,
                Size = UDim2.fromOffset(1, 1),
                BackgroundTransparency = 1,
                SelectionGroup = true,
                SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
                SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
                SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
                SelectionBehaviorUp = Enum.SelectionBehavior.Stop
            }, {
                FocusTarget = React.createElement("TextButton", {
                    Name = "FocusTarget",
                    ref = tbl1.setPrimaryActionRef,
                    Size = UDim2.fromScale(1, 1),
                    BackgroundTransparency = 1,
                    AutoButtonColor = false,
                    Selectable = true,
                    SelectionImageObject = frame,
                    Text = ""
                })
            })
        else
            element3 = nil
        end

        tbl4.FocusHold = element3
        local element4

        if supportPaneRect == nil or tbl1.supportOverlayTopInset == nil or tbl1.presentation.isCollapsedStepOne then
            element4 = nil
        else
            element4 = React.createElement(SplitPaneEducationalTourChrome, {
                supportPaneRect = supportPaneRect,
                topInset = tbl1.supportOverlayTopInset,
                onBottomPaneTooltipAnchorInstanceChanged = tbl1.setBottomPaneTooltipAnchorInstance,
                onGamepadStepTwoTooltipAnchorInstanceChanged = tbl1.setGamepadStepTwoTooltipAnchorInstance,
                onGamepadFinalTooltipAnchorInstanceChanged = tbl1.setGamepadFinalTooltipAnchorInstance,
                onTopRightControlInstanceChanged = tbl1.setTopRightControlInstance
            })
        end

        tbl4.Chrome = element4
        var4 = createPortal(createElement(fragment, var5, tbl4), tbl1.overlayInstance)
    end

    tbl3.OverlayPortal = var4

    if element ~= nil and tooltipModel ~= nil then
        tbl3[`Tooltip-{tooltipModel.stepIndex}`] = element
    end
    return React.createElement(React.Fragment, nil, tbl3)
end

return SplitPaneEducationalTourView
