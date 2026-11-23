-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local DataHydration = require(BuildExperienceParent.DataHydration)
local Foundation = require(BuildExperienceParent.Foundation)
local LuaSocialLibrariesDeps = require(BuildExperienceParent.LuaSocialLibrariesDeps)
local React = require(BuildExperienceParent.React)

local BuildEmptyState = require(BuildExperience.Components.BuildEmptyState.BuildEmptyState)
local ExperienceResultsLoadingSkeleton = require(BuildExperience.Components.MyCreationsTab.ExperienceResultsLoadingSkeleton)

local List = Foundation.List
local View = Foundation.View
local RefreshScrollingFrame = LuaSocialLibrariesDeps.SocialLibraries.config({}).Components.RefreshScrollingFrame

local DataStatus = DataHydration.DataStatus
local InputSize = Foundation.Enums.InputSize

local function PreviewsTabView(tbl1)
    local bool1 = #tbl1.rows == 0 and tbl1.listStatus == DataStatus.Ready
    local tbl2 = {}
    if #tbl1.rows > 0 then
        for layoutOrder, row in tbl1.rows do
            local str1 = `U{row.universeId}`
            tbl2[str1] = React.createElement(List.Item, {
                LayoutOrder = layoutOrder,
                leading = {
                    iconName = row.gameIcon
                },
                title = row.title,
                description = row.description,
                testId = `PreviewsTab.PreviewRow.{row.universeId}`,
                onActivated = row.onActivated
            })
        end
    elseif tbl1.listStatus == DataStatus.NotReady then
        for i = 1, 2 do
            tbl2[`Loading{i}`] = React.createElement(ExperienceResultsLoadingSkeleton, { LayoutOrder = i, index = i, testIdPrefix = "PreviewsTab" })
        end
    end

    if tbl1.listStatus == DataStatus.Failed then
        tbl2.Error = React.createElement(
            List.Item,
            {
                LayoutOrder = #tbl1.rows + 1,
                title = tbl1.loadError,
                testId = "PreviewsTab.LoadError"
            }
        )
    end

    if tbl1.failedLoadMore then
        tbl2.LoadMoreError = React.createElement(List.Item, {
            LayoutOrder = #tbl1.rows + 2,
            title = tbl1.loadError,
            testId = "PreviewsTab.LoadMoreError",
            onActivated = tbl1.retryLoadMore
        })
    end

    local isLoadingMore = tbl1.isLoadingMore
    local createFooter = React.useCallback(function()
        if not isLoadingMore then
            return nil
        end

        return React.createElement(ExperienceResultsLoadingSkeleton, { LayoutOrder = 1, index = 1, testIdPrefix = "PreviewsTab" })
    end, { isLoadingMore })

    local results = React.createElement(RefreshScrollingFrame, {
        refresh = tbl1.refresh,
        onCanvasPositionChangedCallback = tbl1.loadMoreIfNeeded,
        onCanvasSizeChangedCallback = tbl1.loadMoreIfNeeded,
        createFooter = createFooter,
        usesBuilderIcon = true,
        scrollingElementProps = {
            LayoutOrder = 1,
            ZIndex = 1,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ScrollBarThickness = 0,
            CanvasSize = UDim2.new(1, 0, 1, 1),
            AutomaticCanvasSize = Enum.AutomaticSize.XY,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            [React.Tag] = "fill"
        }
    }, {
        ContentLayout = React.createElement(
            View,
            {
                tag = "composition-layout-detail size-full-0 auto-y",
                testId = "PreviewsTab.ContentLayout"
            },
            {
                ContentBody = React.createElement(
                    View,
                    { tag = "composition-content-body col size-full-0 auto-y" },
                    bool1
                        and {
                            EmptyContent = React.createElement(View, { tag = "col size-full" }, {
                                EmptyState = React.createElement(
                                    View,
                                    {
                                        tag = "col align-x-center align-y-center fill size-full-0 padding-large",
                                        testId = "PreviewsTab.Empty"
                                    },
                                    {
                                        Content = React.createElement(BuildEmptyState, { message = tbl1.emptyText })
                                    }
                                )
                            })
                        }
                        or {
                            List = React.createElement(
                                List.Root,
                                {
                                    hasDivider = false,
                                    isContained = { isContained = false, hasMargin = false },
                                    size = InputSize.Large
                                },
                                tbl2
                            )
                        }
                )
            }
        )
    })
    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "col fill size-full"
        },
        {
            Filter = tbl1.filterHeader,
            Results = results
        }
    )
end
return PreviewsTabView
