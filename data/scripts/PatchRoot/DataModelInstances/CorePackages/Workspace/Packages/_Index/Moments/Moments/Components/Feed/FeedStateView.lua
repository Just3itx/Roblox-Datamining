-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)
local FocusNavigationUtils = require(MomentsParent.FocusNavigationUtils)

local useLocalization = Localization.Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens

local _FeedTypes = require(script.Parent.FeedTypes)
local FeedMessageView = require(script.Parent.FeedMessageView)
local FFlagMomentsFeedErrorStateRedesign = require(Moments.Flags.FFlagMomentsFeedErrorStateRedesign)
local FFlagMomentsParentTimeLimit = MomentsCommon.Flags.FFlagMomentsParentTimeLimit

local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local Button = Foundation.Button
local FoundationText = Foundation.Text
local View = Foundation.View
local IconName = Foundation.Enums.IconName

local tbl1 = {
    failedTitle = "Feature.Moments.Label.FeedFailedToLoad",
    failedMessage = "Feature.Moments.Label.Error",
    retryLabel = "Feature.Moments.Action.Retry"
}

if FFlagMomentsFeedErrorStateRedesign then
    tbl1.couldNotLoadTitle = "Feature.Moments.Label.FeedCouldNotLoad"
    tbl1.somethingWentWrong = "CommonUI.Messages.Response.SomethingWentWrong"
end

local function resolveLocalized(couldNotLoadTitle: string?, str1: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if couldNotLoadTitle == nil or couldNotLoadTitle == "" then str1 else couldNotLoadTitle
end

local function CenteredOverlay(tbl2)
    return React.createElement(FocusRoot, {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
        isAutoFocusRoot = true,
        frameProps = tbl2.zIndex ~= nil and {
            ZIndex = tbl2.zIndex
        } or nil
    }, {
        Content = React.createElement(
            View,
            {
                tag = "col align-x-center align-y-center gap-medium size-full padding-xlarge bg-surface-0"
            },
            tbl2.children
        )
    })
end

local function FeedErrorMessage(tbl2)
    local var1 = useTokens()
    local localized = tbl2.localized

    return React.createElement(FeedMessageView, {
        iconName = IconName.TriangleExclamation,
        iconSize = var1.Size.Size_1600,
        tilted = false,
        title = resolveLocalized(localized.couldNotLoadTitle, "Moments couldn't load"),
        description = localized.somethingWentWrong,
        primaryAction = {
            text = localized.retryLabel,
            onActivated = tbl2.onRetry,
            testId = "--moments-feed-error--retry"
        },
        testId = "--moments-feed-error"
    })
end

local function FeedStateView(tbl2)
    local localized = useLocalization(tbl1)
    local status = tbl2.status

    if FFlagMomentsFeedErrorStateRedesign and status == "Failed" then
        return React.createElement(
            CenteredOverlay,
            {
                zIndex = tbl2.zIndex
            },
            {
                Message = React.createElement(FeedErrorMessage, { localized = localized, onRetry = tbl2.onRetry })
            }
        )
    elseif status == "Failed" then
        return React.createElement(CenteredOverlay, {
            zIndex = tbl2.zIndex
        }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                tag = "size-full-0 auto-y text-heading-medium text-wrap text-align-x-center content-emphasis",
                Text = localized.failedTitle
            }),
            Description = React.createElement(FoundationText, {
                LayoutOrder = 2,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-default",
                Text = localized.failedMessage
            })
        })
    elseif status == "Empty" and tbl2.emptyState ~= nil then
        return React.createElement(CenteredOverlay, { zIndex = tbl2.zIndex }, { EmptyState = tbl2.emptyState })
    elseif status == "Empty" then
        return React.createElement(CenteredOverlay, {
            zIndex = tbl2.zIndex
        }, {
            Message = React.createElement(FoundationText, {
                LayoutOrder = 1,
                tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-center content-emphasis",
                Text = "No moments yet"
            }),
            Cta = tbl2.emptyContent
        })
    elseif FFlagMomentsParentTimeLimit and status == "LimitReached" then
        return React.createElement(
            View,
            {
                tag = "col align-x-center align-y-center gap-medium size-full padding-xlarge bg-surface-0",
                ZIndex = tbl2.zIndex
            },
            {
                TimeLimit = React.createElement(require(script.Parent.Items.TimeLimit.MomentsTimeLimitContainer))
            }
        )
    elseif tbl2.loadMoreFailed then
        return React.createElement(
            View,
            {
                tag = "col align-x-center align-y-bottom size-full padding-large",
                ZIndex = tbl2.zIndex
            },
            {
                RetryButton = React.createElement(Button, {
                    onActivated = tbl2.onRetry,
                    size = Foundation.Enums.InputSize.Small,
                    text = localized.retryLabel,
                    variant = Foundation.Enums.ButtonVariant.Standard
                })
            }
        )
    end
    return nil
end

return FeedStateView
