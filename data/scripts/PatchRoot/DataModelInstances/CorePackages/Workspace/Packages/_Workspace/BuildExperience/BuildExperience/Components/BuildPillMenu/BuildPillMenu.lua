-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local View = Foundation.View

local IconName = Foundation.Enums.IconName

local BuildOverflowMenuButton = require(script.Parent.BuildOverflowMenuButton)
local StopPlaytestButton = require(script.Parent.StopPlaytestButton)
local GetBuildOverflowMenuStore = require(BuildExperience.Stores.GetBuildOverflowMenuStore)
local _createBuildOverflowMenuStore = require(BuildExperience.Stores.GetBuildOverflowMenuStore.createBuildOverflowMenuStore)
local PublishStatus = require(BuildExperience.Chat.PublishStatus)
local leaveExperience = require(BuildExperience.utils.leaveExperience)
local FFlagBuildExperienceMenuImprovements = require(BuildExperience.Flags.FFlagBuildExperienceMenuImprovements)

local function BuildPillMenu(tbl1)
    local store = tbl1.store or GetBuildOverflowMenuStore()
    local var2 = PublishStatus.usePublishStatus(tbl1.target)

    local onAction = React.useCallback(function(arg1)
        if arg1.type == "openPage" then
            if tbl1.onOpenPage then
                tbl1.onOpenPage(arg1.page)
            end
        elseif arg1.type == "openInvitePicker" then
            if tbl1.onOpenInvitePicker then
                tbl1.onOpenInvitePicker()
            end
        elseif arg1.type == "openInviteManagement" then
            if tbl1.onOpenPlaytestManagement then
                tbl1.onOpenPlaytestManagement()
            end
        elseif tbl1.onAction then
            tbl1.onAction(arg1)
        end
    end, {
        tbl1.onAction,
        tbl1.onOpenPage,
        tbl1.onOpenInvitePicker,
        tbl1.onOpenPlaytestManagement
    })

    local createElement = React.createElement
    local fragment = React.Fragment
    local var4 = nil

    local tbl2 = {
        Pill = React.createElement(View, {
            Position = tbl1.position,
            AnchorPoint = tbl1.anchorPoint,
            LayoutOrder = tbl1.layoutOrder,
            tag = "row align-y-center gap-xsmall size-0-1100 auto-x padding-x-xsmall radius-circle clip bg-over-media-0",
            testId = tbl1.testId
        }, {
            StopPlaytest = if FFlagBuildExperienceMenuImprovements then React.createElement(StopPlaytestButton, {
                layoutOrder = 0,
                onActivated = function()
                    leaveExperience()
                end
            }) else nil,
            Overflow = React.createElement(BuildOverflowMenuButton, {
                layoutOrder = 3,
                icon = IconName.ThreeDotsHorizontal,
                store = store,
                target = tbl1.target,
                hasPublishedTurn = var2.hasPublishedTurn,
                hasPublishedVersion = var2.hasPublishedVersion,
                onAction = onAction,
                onOpenCreatorCreditPage = tbl1.onOpenCreatorCreditPage
            })
        })
    }

    return createElement(fragment, var4, tbl2)
end

return BuildPillMenu
