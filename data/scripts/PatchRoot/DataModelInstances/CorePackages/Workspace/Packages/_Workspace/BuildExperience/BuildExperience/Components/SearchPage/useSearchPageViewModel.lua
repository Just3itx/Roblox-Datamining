-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Cryo = require(BuildExperienceParent.Cryo)
local _Promise = require(BuildExperienceParent.Promise)
local React = require(BuildExperienceParent.React)

local _SearchBarContainer = require(BuildExperience.Components.SearchBar.SearchBarContainer)
local _SearchPageView = require(script.Parent.SearchPageView)

local tbl1 = {
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    BackgroundTransparency = 1,
    CanvasSize = UDim2.new(1, 0, 1, 1),
    LayoutOrder = 2,
    ScrollBarThickness = 0,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    Size = UDim2.fromScale(1, 1),
    [React.Tag] = "fill"
}

local function useSearchPageViewModel(arg1, scrollingFrameRef)
    local scrollingElementProps = React.useMemo(function()
        return Cryo.Dictionary.join(tbl1, arg1.scrollingElementProps or {})
    end, { arg1.scrollingElementProps })
    return {
        children = arg1.children,
        createFooter = arg1.createFooter,
        onBack = arg1.onBack,
        onCanvasPositionChangedCallback = arg1.onCanvasPositionChangedCallback,
        onCanvasSizeChangedCallback = arg1.onCanvasSizeChangedCallback,
        refresh = arg1.refresh,
        scrollingElementProps = scrollingElementProps,
        scrollingFrameRef = scrollingFrameRef,
        searchBarProps = arg1.searchBarProps,
        showEmptyState = arg1.showEmptyState
    }
end

return useSearchPageViewModel
