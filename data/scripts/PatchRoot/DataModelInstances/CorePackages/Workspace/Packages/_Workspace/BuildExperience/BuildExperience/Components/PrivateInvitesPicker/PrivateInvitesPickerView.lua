-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local UserPickerList = require(BuildExperience.Components.UserPicker.UserPickerList)
local PrivateInviteAddErrorDialog = require(script.Parent.PrivateInviteAddErrorDialog)
local PrivateInviteAddRejectedDialog = require(script.Parent.PrivateInviteAddRejectedDialog)
local Sheet = Foundation.Sheet
local Button = Foundation.Button
local IconButton = Foundation.IconButton
local SearchInput = Foundation.SearchInput
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize

local function PrivateInvitesPickerView(tbl1)
    local testId = tbl1.testId or "private-invites-picker"

    local footer = React.createElement(
        View,
        {
            tag = "col gap-small size-full-0 auto-y",
            testId = `{testId}-submit`
        },
        {
            Send = React.createElement(Button, {
                LayoutOrder = 1,
                text = tbl1.sendButtonText,
                onActivated = tbl1.submit,
                isLoading = tbl1.isSubmitting,
                isDisabled = not tbl1.hasSelection,
                variant = ButtonVariant.Emphasis,
                size = InputSize.Medium,
                width = UDim.new(1, 0),
                testId = `{testId}-send`
            })
        }
    )
    return React.createElement(React.Fragment, nil, {
        Sheet = React.createElement(
            Sheet.Root,
            {
                isOpen = tbl1.isOpen,
                snapPoints = { 1 },
                defaultSnapPointIndex = 1,
                onClose = tbl1.onClose,
                testId = testId
            },
            {
                Header = React.createElement(Sheet.Header, { hasCloseAffordance = false }, {
                    Back = React.createElement(IconButton, {
                        LayoutOrder = 1,
                        icon = IconName.ChevronLargeLeft,
                        isCircular = true,
                        onActivated = tbl1.onRequestClose,
                        size = InputSize.Medium,
                        testId = `{testId}-back`,
                        variant = ButtonVariant.Utility
                    }),
                    Search = React.createElement(View, { LayoutOrder = 2, tag = "fill auto-y" }, {
                        Input = React.createElement(SearchInput, {
                            text = tbl1.searchText,
                            onChanged = tbl1.setSearchText,
                            placeholder = tbl1.searchPlaceholder,
                            width = UDim.new(1, 0),
                            testId = `{testId}-search`
                        })
                    })
                }),
                Content = React.createElement(Sheet.Content, {
                    scrollingFrameRef = tbl1.scrollingFrameRef
                }, {
                    List = React.createElement(UserPickerList, {
                        userIds = tbl1.userIds,
                        isLoading = tbl1.isLoading,
                        searchText = tbl1.searchText,
                        emptyText = tbl1.emptyText,
                        isSelected = tbl1.isSelected,
                        canSelect = tbl1.canSelect,
                        toggleSelected = tbl1.toggleSelected,
                        testId = testId
                    })
                }),
                Actions = React.createElement(Sheet.Actions, nil, { Footer = footer })
            }
        ),
        AddErrorDialog = if tbl1.hasAddError then React.createElement(PrivateInviteAddErrorDialog, { onDismiss = tbl1.onDismissAddError }) else nil,
        AddRejectedDialog = if #tbl1.rejectedInviteUserIds > 0 then React.createElement(
            PrivateInviteAddRejectedDialog,
            {
                rejectedUserIds = tbl1.rejectedInviteUserIds,
                onDismiss = tbl1.onDismissRejectedInvite
            }
        ) else nil
    })
end

return PrivateInvitesPickerView
