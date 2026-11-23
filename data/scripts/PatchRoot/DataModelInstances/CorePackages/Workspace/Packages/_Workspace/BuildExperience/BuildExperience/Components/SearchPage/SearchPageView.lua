-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local LuaSocialLibrariesDeps = require(BuildExperienceParent.LuaSocialLibrariesDeps)
local React = require(BuildExperienceParent.React)

local SearchBarContainer = require(BuildExperience.Components.SearchBar.SearchBarContainer)
local SearchEmptyState = require(BuildExperience.Components.SearchEmptyState.SearchEmptyState)

local RefreshScrollingFrame = LuaSocialLibrariesDeps.SocialLibraries.config({}).Components.RefreshScrollingFrame

local HeaderBar = Foundation.HeaderBar
local IconButton = Foundation.IconButton
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize

local function SearchPageView(tbl1)
    local var1 = tbl1.showEmptyState and {
        EmptyState = React.createElement(SearchEmptyState, { testId = "SearchPage.EmptyState" })
    }
        or {
            Content = React.createElement(View, { tag = "col size-full-0 auto-y", testId = "SearchPage.Content" }, tbl1.children)
        }
    local contentBody = React.createElement(
        View,
        {
            tag = "composition-content-body col size-full-0 auto-y",
            testId = "SearchPage.ContentBody"
        },
        var1
    )

    local tbl2 = {
        ContentLayout = React.createElement(
            View,
            {
                tag = "composition-layout-detail size-full-0 auto-y",
                testId = "SearchPage.ContentLayout"
            },
            { ContentBody = contentBody }
        )
    }
    local element = React.createElement(
        View,
        {
            tag = "composition-content-body row align-y-center gap-small size-full",
            testId = "SearchPage.SearchBarContentBody"
        },
        {
            Back = React.createElement(IconButton, {
                LayoutOrder = 1,
                icon = IconName.ChevronLargeLeft,
                isCircular = true,
                onActivated = tbl1.onBack,
                size = InputSize.Large,
                testId = "SearchPage.Back",
                variant = ButtonVariant.Utility
            }),
            Search = React.createElement(
                View,
                { LayoutOrder = 2, tag = "fill auto-y" },
                {
                    SearchBar = React.createElement(SearchBarContainer, tbl1.searchBarProps)
                }
            )
        }
    )
    local layout = React.createElement(
        View,
        { tag = "composition-layout-detail size-full", testId = "SearchPage.SearchBarLayout" },
        { ContentBody = element }
    )

    return React.createElement(View, { tag = "col size-full", testId = "SearchPage" }, {
        Header = React.createElement(
            HeaderBar.Root,
            { LayoutOrder = 1, testId = "SearchPage.Header" },
            {
                Content = React.createElement(HeaderBar.Content, nil, { Layout = layout })
            }
        ),
        Results = React.createElement(RefreshScrollingFrame, {
            createFooter = tbl1.createFooter,
            onCanvasPositionChangedCallback = tbl1.onCanvasPositionChangedCallback,
            onCanvasSizeChangedCallback = tbl1.onCanvasSizeChangedCallback,
            ref = tbl1.scrollingFrameRef,
            refresh = tbl1.refresh,
            scrollingElementProps = tbl1.scrollingElementProps,
            usesBuilderIcon = true
        }, tbl2)
    })
end

return SearchPageView
