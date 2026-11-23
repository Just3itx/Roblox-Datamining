-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local LibraryGridView = require(script.Parent.LibraryGridView)
local _LibraryTypes = require(script.Parent.Parent.LibraryTypes)

local FoundationText = Foundation.Text
local View = Foundation.View

local function LibraryCategoryView(tbl1)
    local element

    if tbl1.status == "Loading" or tbl1.status == "NotReady" then
        element = React.createElement(View, {
            tag = "size-full",
            testId = "Library.Category.Skeleton"
        }, {
            Grid = React.createElement(LibraryGridView, {
                items = {},
                hasMore = false,
                isLoading = true,
                onLoadMore = function() end
            })
        })
    elseif #tbl1.items == 0 then
        element = React.createElement(FoundationText, {
            Text = tbl1.strings.empty,
            tag = "size-full-0 auto-y padding-large text-body-medium text-align-x-center content-muted"
        })
    else
        element = React.createElement(View, { tag = "col gap-medium size-full" }, {
            GridContainer = React.createElement(View, { LayoutOrder = 1, tag = "fill size-full-0" }, {
                Grid = React.createElement(LibraryGridView, { items = tbl1.items, hasMore = tbl1.hasMore, onLoadMore = tbl1.onLoadMore })
            })
        })
    end

    local body = React.createElement(
        View,
        { tag = "col size-full padding-x-medium" },
        {
            Body = React.createElement(View, { tag = "fill size-full-0" }, { Content = element })
        }
    )

    return React.createElement(
        View,
        { tag = "col size-full", testId = "Library.CategoryPage" },
        {
            Content = React.createElement(View, { tag = "fill size-full-0" }, { Body = body })
        }
    )
end

return LibraryCategoryView
