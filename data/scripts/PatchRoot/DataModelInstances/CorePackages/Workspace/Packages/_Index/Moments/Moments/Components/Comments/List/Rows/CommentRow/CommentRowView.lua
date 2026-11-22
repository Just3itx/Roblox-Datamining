-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local ReactUtils = require(MomentsParent.ReactUtils)

local FFlagMomentsCommentRowRedesign = require(Moments.Flags.FFlagMomentsCommentRowRedesign)
local FFlagMomentsCommentRowTrailingReaction = require(Moments.Flags.FFlagMomentsCommentRowTrailingReaction)
local FFlagMomentsCommentsAttachSheetScroller = require(Moments.Flags.FFlagMomentsCommentsAttachSheetScroller)
local ImageWithSkeleton = require(Moments.Components.ImageWithSkeleton)
local CommentActionsMenu = require(script.Parent.CommentActionsMenu)
local CommentDeleteConfirmationDialog = require(script.Parent.CommentDeleteConfirmationDialog)
local CommentReactionButton = require(script.Parent.CommentReactionButton)
local CommentRowHighlight = require(script.Parent.CommentRowHighlight)
local CommentTranslationToggle = require(script.Parent.CommentTranslationToggle)
local getLineHeights = require(script.Parent.Parent.getLineHeights)

local Radius = Foundation.Enums.Radius
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local ThumbnailSize = Foundation.Enums.ThumbnailSize
local ThumbnailType = Foundation.Enums.ThumbnailType
local getRbxThumb = Foundation.Utility.getRbxThumb
local useComposedRef = ReactUtils.useComposedRef
local useTokens = Foundation.Hooks.useTokens

local function noop() end

local function CommentRowView(tbl1)
    local var1 = useTokens()
    local actionsMenu = tbl1.actionsMenu
    local deleteConfirmation = tbl1.deleteConfirmation
    local translationToggle = tbl1.translationToggle
    local element = if translationToggle == nil then nil else React.createElement(CommentTranslationToggle, {
        commentId = tbl1.commentId,
        isShowingTranslation = translationToggle.isShowingTranslation,
        onToggle = translationToggle.onToggle,
        LayoutOrder = if FFlagMomentsCommentRowRedesign then 3 else 5
    })
    local bool1 = not (actionsMenu == nil) and actionsMenu.anchorRef ~= nil
    local bool2 = not (actionsMenu == nil) and not bool1
    local current, var3 = React.useState(nil)
    local ref = useComposedRef(tbl1.gestureRef, var3)
    local anchorRef = React.useMemo(function()
        return { current = current }
    end, { current })

    local image = if tbl1.avatarUserId == nil then nil else getRbxThumb(ThumbnailType.AvatarHeadShot, tbl1.avatarUserId, ThumbnailSize.Medium)
    local lineHeights = getLineHeights(if FFlagMomentsCommentRowRedesign then var1.Typography.TitleMedium else var1.Typography.TitleSmall)

    local var6 = FFlagMomentsCommentRowTrailingReaction and (bool2 or tbl1.showReactionControl == true)
    local var7, var8 = React.useState(0)
    local var9 = React.useCallback(function(arg1)
        var8(arg1.AbsoluteSize.X)
    end, {})

    local var10

    if FFlagMomentsCommentsAttachSheetScroller then
        local var11 = (if FFlagMomentsCommentRowRedesign then var1.Size.Size_800 else var1.Size.Size_700) + var1.Gap.Medium
        if FFlagMomentsCommentRowTrailingReaction then
            if var6 then
                var11 += var7 + var1.Gap.Medium
            end
        elseif actionsMenu ~= nil and not bool1 then
            var11 += var1.Size.Size_600 + var1.Gap.Medium
        end
        var10 = UDim2.new(1, -var11, 0, 0)
    else
        var10 = nil
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder,
        GroupTransparency = tbl1.GroupTransparency,
        testId = `moments-comment-row-{tbl1.commentId}`
    }
    local tbl3 = {
        Highlight = if actionsMenu == nil or not bool1 then nil else React.createElement(CommentRowHighlight, {
            commentId = tbl1.commentId,
            phase = if actionsMenu.isOpen then "Active" elseif tbl1.isLongPressCharging then "Charging" else "Idle"
        }),
        Content = 0,
        RowActionsMenu = 0,
        DeleteConfirmation = 0
    }

    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        tag = {
            ["row gap-medium size-full-0 auto-y padding-x-small padding-top-small"] = true,
            ["padding-bottom-small"] = FFlagMomentsCommentRowRedesign or not tbl1.showReactionControl
        },
        ref = ref,
        onActivated = if tbl1.isGestureSurfaceActive then noop else nil,
        onStateChanged = if tbl1.isGestureSurfaceActive then tbl1.onContentStateChanged else nil,
        stateLayer = tbl1.isGestureSurfaceActive and {
            affordance = StateLayerAffordance.None
        } or nil,
        selection = { Selectable = false },
        testId = `moments-comment-row-content-{tbl1.commentId}`
    }
    local tbl5 = {
        Avatar = React.createElement(Foundation.View, {
            tag = {
                ["size-800-800"] = FFlagMomentsCommentRowRedesign,
                ["size-700-700"] = not FFlagMomentsCommentRowRedesign
            },
            LayoutOrder = 1,
            testId = if tbl1.avatarUserId ~= nil then `moments-comment-avatar-{tbl1.commentId}` else `moments-comment-avatar-fallback-{tbl1.commentId}`
        }, {
            Image = React.createElement(
                ImageWithSkeleton,
                {
                    Image = image,
                    Size = UDim2.fromScale(1, 1),
                    radius = Radius.Circle,
                    backgroundStyle = tbl1.avatarBackgroundStyle
                }
            )
        }),
        TextColumn = 0,
        ActionsMenu = 0,
        Trailing = 0
    }

    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl6 = {
        tag = {
            ["col auto-y"] = true,
            fill = not FFlagMomentsCommentsAttachSheetScroller,
            ["gap-xsmall"] = FFlagMomentsCommentRowRedesign,
            ["gap-small"] = not FFlagMomentsCommentRowRedesign
        },
        Size = var10,
        LayoutOrder = 2,
        testId = `moments-comment-content-{tbl1.commentId}`
    }
    local tbl7 = { MainContent = 0, Reaction = 0, Footer = 0 }
    local createElement4 = React.createElement
    local view4 = Foundation.View
    local tbl8 = {
        tag = {
            ["col size-full-0 auto-y"] = true,
            ["gap-xxsmall"] = FFlagMomentsCommentRowRedesign,
            ["gap-xsmall"] = not FFlagMomentsCommentRowRedesign
        },
        LayoutOrder = 1,
        testId = `moments-comment-main-content-{tbl1.commentId}`
    }
    local tbl9 = { Header = 0, Body = 0, BodyMeasure = 0 }
    local createElement5 = React.createElement
    local view5 = Foundation.View
    local tbl10 = {
        tag = "row align-y-center gap-xsmall size-full-0 auto-y clip",
        LayoutOrder = 1,
        testId = `moments-comment-metadata-{tbl1.commentId}`
    }
    local tbl11 = {
        Author = 0,
        Separator = 0,
        Timestamp = 0,
        HeaderAction = 0,
        TranslationToggle = 0
    }
    local element2

    if tbl1.isAuthorLoading then
        element2 = React.createElement(
            Foundation.View,
            {
                Size = UDim2.fromOffset(var1.Size.Size_2000, lineHeights),
                tag = "row align-y-center",
                LayoutOrder = 1
            },
            {
                Bar = React.createElement(Foundation.Skeleton, {
                    Size = UDim2.new(1, 0, 0, var1.Size.Size_300),
                    radius = Radius.Medium,
                    testId = `moments-comment-author-loading-{tbl1.commentId}`
                })
            }
        )
    else
        element2 = React.createElement(Foundation.Text, {
            tag = {
                ["shrink auto-xy text-truncate-end"] = true,
                ["text-title-medium content-emphasis"] = FFlagMomentsCommentRowRedesign,
                ["text-title-small content-default"] = not FFlagMomentsCommentRowRedesign
            },
            LayoutOrder = 1,
            Text = tbl1.authorLabel,
            testId = `moments-comment-author-{tbl1.commentId}`
        })
    end

    tbl11.Author = element2

    tbl11.Separator = if FFlagMomentsCommentRowRedesign or tbl1.metadataLabel == nil then nil else React.createElement(Foundation.Text, { tag = "auto-xy text-body-small content-muted", LayoutOrder = 2, Text = "·" })

    tbl11.Timestamp = if FFlagMomentsCommentRowRedesign then nil else React.createElement(Foundation.Text, {
        tag = "auto-xy text-body-small text-truncate-end content-muted",
        LayoutOrder = 3,
        Text = tbl1.metadataLabel or "",
        testId = `moments-comment-timestamp-{tbl1.commentId}`
    })

    tbl11.HeaderAction = if FFlagMomentsCommentRowRedesign or tbl1.headerAction == nil then nil else React.createElement(Foundation.View, { tag = "auto-xy", LayoutOrder = 4 }, { Action = tbl1.headerAction })

    tbl11.TranslationToggle = if FFlagMomentsCommentRowRedesign then nil else element
    tbl9.Header = createElement5(view5, tbl10, tbl11)

    local createElement6 = React.createElement
    local foundationText = Foundation.Text
    local tbl12 = {
        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left",
        LayoutOrder = 2,
        Text = tbl1.bodyText or tbl1.text,
        RichText = tbl1.bodyText ~= nil,
        textStyle = 0,
        ref = 0,
        onAbsoluteSizeChanged = 0,
        testId = 0
    }
    local bodyTextStyle = tbl1.bodyTextStyle

    if not bodyTextStyle then
        if FFlagMomentsCommentRowRedesign then
            bodyTextStyle = var1.Color.Content.Default
        else
            bodyTextStyle = var1.Color.Content.Emphasis
        end
    end

    tbl12.textStyle = bodyTextStyle

    tbl12.ref = tbl1.bodyRef
    tbl12.onAbsoluteSizeChanged = tbl1.onBodyAbsoluteSizeChanged
    tbl12.testId = `moments-comment-body-{tbl1.commentId}`
    tbl9.Body = createElement6(foundationText, tbl12)

    tbl9.BodyMeasure = if tbl1.bodyMeasureRef == nil then nil else React.createElement(Foundation.Text, {
        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left",
        LayoutOrder = 3,
        RichText = true,
        Visible = false,
        ref = tbl1.bodyMeasureRef,
        testId = `moments-comment-body-measure-{tbl1.commentId}`
    })
    tbl7.MainContent = createElement4(view4, tbl8, tbl9)
    local element3

    if FFlagMomentsCommentRowRedesign or not tbl1.showReactionControl then
        element3 = nil
    else
        element3 = React.createElement(CommentReactionButton, {
            commentId = tbl1.commentId,
            isReactionSelected = tbl1.isReactionSelected == true,
            isReactionDisabled = tbl1.isReactionDisabled == true,
            reactionCountLabel = tbl1.reactionCountLabel or "0",
            isReactionCountHidden = tbl1.isReactionCountHidden,
            onReactionActivated = tbl1.onReactionActivated or noop,
            LayoutOrder = 2
        })
    end

    tbl7.Reaction = element3
    local var11

    if FFlagMomentsCommentRowRedesign
        and (tbl1.metadataLabel ~= nil or tbl1.headerAction ~= nil or tbl1.showReactionControl or translationToggle ~= nil)
    then
        local createElement7 = React.createElement
        local view6 = Foundation.View
        local tbl13 = {
            tag = {
                ["row align-y-center gap-small"] = true,
                ["size-full-0 auto-y"] = not FFlagMomentsCommentRowTrailingReaction,
                ["size-full-600"] = FFlagMomentsCommentRowTrailingReaction
            },
            LayoutOrder = 2,
            testId = `moments-comment-footer-{tbl1.commentId}`
        }
        local tbl14 = {
            Metadata = React.createElement(Foundation.View, {
                tag = {
                    ["row align-y-center fill gap-small auto-y clip"] = true,
                    wrap = translationToggle ~= nil
                },
                LayoutOrder = 1,
                testId = `moments-comment-footer-metadata-{tbl1.commentId}`
            }, {
                Timestamp = if tbl1.metadataLabel == nil then nil else React.createElement(Foundation.Text, {
                    tag = "auto-xy text-body-small text-truncate-end content-muted",
                    LayoutOrder = 1,
                    Text = tbl1.metadataLabel,
                    testId = `moments-comment-timestamp-{tbl1.commentId}`
                }),
                HeaderAction = if tbl1.headerAction == nil then nil else React.createElement(Foundation.View, { tag = "auto-xy", LayoutOrder = 2 }, { Action = tbl1.headerAction }),
                TranslationToggle = element
            }),
            Reaction = 0
        }
        local element4

        if FFlagMomentsCommentRowTrailingReaction or not tbl1.showReactionControl then
            element4 = nil
        else
            element4 = React.createElement(CommentReactionButton, {
                commentId = tbl1.commentId,
                isReactionSelected = tbl1.isReactionSelected == true,
                isReactionDisabled = tbl1.isReactionDisabled == true,
                reactionCountLabel = tbl1.reactionCountLabel or "0",
                isReactionCountHidden = tbl1.isReactionCountHidden,
                onReactionActivated = tbl1.onReactionActivated or noop,
                LayoutOrder = 2
            })
        end

        tbl14.Reaction = element4
        var11 = createElement7(view6, tbl13, tbl14)
    else
        var11 = nil
    end

    tbl7.Footer = var11
    tbl5.TextColumn = createElement3(view3, tbl6, tbl7)

    tbl5.ActionsMenu = if FFlagMomentsCommentRowTrailingReaction or actionsMenu == nil or bool1 then nil else React.createElement(
        CommentActionsMenu,
        {
            commentId = tbl1.commentId,
            items = actionsMenu.items,
            isOpen = actionsMenu.isOpen,
            onButtonActivated = actionsMenu.onButtonActivated,
            onClose = actionsMenu.onClose,
            LayoutOrder = 3
        }
    )
    local var12

    if var6 then
        local createElement7 = React.createElement
        local view6 = Foundation.View
        local tbl13 = {
            tag = "col align-x-right self-stretch auto-x",
            LayoutOrder = 3,
            onAbsoluteSizeChanged = 0,
            testId = 0
        }

        if not FFlagMomentsCommentsAttachSheetScroller then
            var9 = nil
        end

        tbl13.onAbsoluteSizeChanged = var9

        tbl13.testId = `moments-comment-trailing-{tbl1.commentId}`
        local tbl14 = {
            ActionsMenu = if actionsMenu == nil or bool1 then nil else React.createElement(CommentActionsMenu, {
                commentId = tbl1.commentId,
                items = actionsMenu.items,
                isOpen = actionsMenu.isOpen,
                onButtonActivated = actionsMenu.onButtonActivated,
                onClose = actionsMenu.onClose,
                LayoutOrder = 1
            }),
            ReactionTopSpacer = if tbl1.showReactionControl then React.createElement(
                Foundation.View,
                {
                    tag = "grow",
                    Size = UDim2.fromOffset(0, if bool2 then var1.Gap.XSmall else 0),
                    LayoutOrder = 2
                }
            ) else nil,
            Reaction = 0,
            ReactionBottomSpacer = 0
        }
        local element4

        if tbl1.showReactionControl then
            element4 = React.createElement(CommentReactionButton, {
                commentId = tbl1.commentId,
                isReactionSelected = tbl1.isReactionSelected == true,
                isReactionDisabled = tbl1.isReactionDisabled == true,
                reactionCountLabel = tbl1.reactionCountLabel or "0",
                isReactionCountHidden = tbl1.isReactionCountHidden,
                onReactionActivated = tbl1.onReactionActivated or noop,
                rightInset = (var1.Size.Size_600 - var1.Size.Size_400) / 2,
                LayoutOrder = 3
            })
        else
            element4 = nil
        end

        tbl14.Reaction = element4

        tbl14.ReactionBottomSpacer = if tbl1.showReactionControl then React.createElement(
            Foundation.View,
            {
                tag = "fill",
                Size = UDim2.fromOffset(0, if bool2 then var1.Size.Size_600 + var1.Gap.XSmall else 0),
                LayoutOrder = 4
            }
        ) else nil
        var12 = createElement7(view6, tbl13, tbl14)
    else
        var12 = nil
    end

    tbl5.Trailing = var12
    tbl3.Content = createElement2(view2, tbl4, tbl5)

    tbl3.RowActionsMenu = if actionsMenu == nil or not bool1 or current == nil then nil else React.createElement(
        CommentActionsMenu,
        {
            commentId = tbl1.commentId,
            items = actionsMenu.items,
            isOpen = actionsMenu.isOpen,
            anchorRef = anchorRef,
            onButtonActivated = actionsMenu.onButtonActivated,
            onClose = actionsMenu.onClose
        }
    )

    tbl3.DeleteConfirmation = if deleteConfirmation == nil then nil else React.createElement(
        CommentDeleteConfirmationDialog,
        {
            commentId = tbl1.commentId,
            onConfirm = deleteConfirmation.onConfirm,
            onCancel = deleteConfirmation.onCancel
        }
    )
    return createElement(view, tbl2, tbl3)
end

return CommentRowView
