-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)

local CommentsSheetView = require(script.Parent.CommentsSheetView)
local useCommentsSheetViewModel = require(script.Parent.useCommentsSheetViewModel)
local useHideTabBarWhileOpen = require(Moments.ExperienceDetailsSheet.Sheet.useHideTabBarWhileOpen)
local FFlagMomentsTabsBehindModalScrim = require(Moments.Flags.FFlagMomentsTabsBehindModalScrim)

local function TabBarVisibilityController()
    useHideTabBarWhileOpen(true)
    return nil
end

return React.memo(function() -- name: CommentsSheetContainer
    local var1 = useCommentsSheetViewModel()
    return React.createElement(React.Fragment, nil, {
        Sheet = React.createElement(CommentsSheetView, var1),
        TabBarVisibilityController = if FFlagMomentsTabsBehindModalScrim or not var1.isOpen then nil else React.createElement(TabBarVisibilityController)
    })
end)
