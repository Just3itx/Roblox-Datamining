-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local FFlagBuildAdsUiPolish = require(BuildExperience.Flags.FFlagBuildAdsUiPolish)
local useScrollPerformanceTracker = require(BuildExperience.Telemetry.useScrollPerformanceTracker)

local IconButton = Foundation.IconButton
local Divider = Foundation.Divider
local ScrollView = Foundation.ScrollView
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize

local function OverflowMenuPageShell(tbl1)
    local testId = tbl1.testId or "overflow-menu-page"
    local scrollingFrameRef = React.useRef(nil)
    useScrollPerformanceTracker(tbl1.scrollPerformanceIntervalName or "BuildOverflowMenuPageShell", scrollingFrameRef)
    local contentBody = React.createElement(View, {
        tag = {
            ["composition-content-body"] = true,
            ["col size-full"] = tbl1.disableScrolling == true,
            ["col size-full-0 auto-y"] = tbl1.disableScrolling ~= true
        },
        testId = `{testId}-content-body`
    }, {
        Content = tbl1.content
    })

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = {
            ["composition-layout-detail"] = true,
            ["col align-x-center size-full bg-surface-0"] = true
        },
        testId = testId
    }
    local tbl3 = {
        Header = React.createElement(View, {
            LayoutOrder = 1,
            tag = {
                ["composition-content-header"] = true,
                ["row align-y-center gap-small size-full-0 auto-y padding-y-small"] = true
            },
            testId = `{testId}-header`
        }, {
            Close = React.createElement(IconButton, {
                LayoutOrder = 1,
                icon = tbl1.closeIcon or IconName.ChevronLargeLeft,
                isCircular = true,
                onActivated = tbl1.onClose,
                size = InputSize.Large,
                testId = `{testId}-close`,
                variant = ButtonVariant.Utility
            }),
            Title = if tbl1.headerContent ~= nil then React.createElement(
                View,
                {
                    LayoutOrder = 2,
                    tag = "grow auto-y",
                    testId = `{testId}-header-content`
                },
                {
                    Content = tbl1.headerContent
                }
            ) else React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl1.title,
                tag = "fill text-heading-medium text-align-x-left text-truncate-end content-emphasis"
            }),
            Trailing = if tbl1.headerTrailing == nil then nil else React.createElement(
                View,
                {
                    LayoutOrder = 3,
                    tag = "auto-xy",
                    testId = `{testId}-header-trailing`
                },
                {
                    Content = tbl1.headerTrailing
                }
            )
        }),
        Body = 0,
        FooterDivider = 0,
        Footer = 0
    }
    local element2

    if tbl1.disableScrolling then
        element2 = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "fill size-full-0 bg-surface-0",
                testId = `{testId}-body`
            },
            { ContentBody = contentBody }
        )
    else
        element2 = React.createElement(ScrollView, {
            LayoutOrder = 2,
            scrollingFrameRef = scrollingFrameRef,
            tag = "fill size-full-0 bg-surface-0",
            testId = `{testId}-scroll-view`,
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.new(1, 0, 0, 0),
                ScrollingDirection = Enum.ScrollingDirection.Y
            }
        }, { ContentBody = contentBody })
    end

    tbl3.Body = element2

    tbl3.FooterDivider = if tbl1.footer == nil or tbl1.footerDivider == false then nil else React.createElement(Divider, { LayoutOrder = 3, testId = `{testId}-footer-divider` })

    tbl3.Footer = if tbl1.footer == nil then nil else React.createElement(View, {
        LayoutOrder = 4,
        ZIndex = if FFlagBuildAdsUiPolish then 2 else nil,
        tag = { ["composition-content-body"] = true, ["size-full-0 auto-y"] = true },
        testId = `{testId}-footer-body`
    }, {
        Footer = tbl1.footer
    })
    return createElement(var2, tbl2, tbl3)
end

return OverflowMenuPageShell
