-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local PickedUserList = require(BuildExperience.Components.UserPicker.PickedUserList)

local Badge = Foundation.Badge
local List = Foundation.List
local FoundationText = Foundation.Text
local View = Foundation.View

local function PrivateInvitesManagementView(tbl1)
    local testId = tbl1.testId or "private-invites-management"
    local isInviteDisabled = tbl1.isInviteDisabled

    local element = React.createElement(List.Item, {
        LayoutOrder = 1,
        title = tbl1.inviteButtonText,
        onActivated = if isInviteDisabled then nil else tbl1.onOpenInvitePicker,
        testId = `{testId}-invite-button`
    })
    if isInviteDisabled then
        element = React.createElement("CanvasGroup", {
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            GroupTransparency = 0.5
        }, { Item = element })
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "col gap-medium size-full-0 auto-y",
            testId = testId
        },
        {
            Header = React.createElement(View, {
                LayoutOrder = 1,
                tag = "row align-y-center gap-small size-full-0 auto-y"
            }, {
                Title = React.createElement(
                    FoundationText,
                    {
                        LayoutOrder = 1,
                        Text = tbl1.title,
                        tag = "fill auto-y text-title-large text-align-x-left content-default"
                    }
                ),
                Count = React.createElement(Badge, { LayoutOrder = 2, text = tbl1.countText, testId = `{testId}-count` })
            }),
            Body = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl1.subtitle,
                tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-muted"
            }),
            Table = React.createElement(PickedUserList, {
                layoutOrder = 4,
                userIds = tbl1.userIds,
                onRemove = tbl1.onRemove,
                removingUserIds = tbl1.removingUserIds,
                header = element,
                testId = `{testId}-list`
            })
        }
    )
end
return PrivateInvitesManagementView
