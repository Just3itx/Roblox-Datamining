-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local Foundation = require(ShareSheetParent.Foundation)
local React = require(ShareSheetParent.React)

local DialogSize = Foundation.Enums.DialogSize
local Divider = Foundation.Divider
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View

local FFlagShareSheetDesktopReadiness = require(ShareSheet.Flags.FFlagShareSheetDesktopReadiness)
local FFlagShareSheetOmitsEmptyActions = require(ShareSheet.Flags.FFlagShareSheetOmitsEmptyActions)

local FIntShareSheetPeoplePickerEnabledSnapPointHundredthsPercent = require(ShareSheet.ShareSheetConstants).FIntShareSheetPeoplePickerEnabledSnapPointHundredthsPercent
local PeoplePicker = require(ShareSheet.Components.PeoplePicker)
local ShareSheetActionRow = require(script.Parent.ShareSheetActionRow)
local useMeasuredRows = require(script.Parent.useMeasuredRows)
local ShareSheetSocialRow = require(script.Parent.ShareSheetSocialRow)
local ShareSendRow = require(script.Parent.ShareSendRow)
local _Recipient = require(ShareSheet.Recipients.Recipient)
local _RecipientSource = require(ShareSheet.Recipients.RecipientSource)
local ShareSheetTelemetry = require(ShareSheet.telemetry.ShareSheetTelemetry)

local function setDefaultContentScrollingFrameRef(arg1)
    if arg1 then
        arg1.AutomaticSize = Enum.AutomaticSize.Y
        arg1.ScrollBarThickness = 0
    end
end

local function setPeoplePickerContentScrollingFrameRef(arg1)
    if arg1 then
        arg1.AutomaticSize = Enum.AutomaticSize.None
        arg1.ScrollBarThickness = 0
    end
end

local function ShareSheetView(tbl1)
    local bool1 = next(tbl1.selectedConversationIds) ~= nil or tbl1.isSending == true
    local peoplePicker = tbl1.peoplePicker
    local isPeoplePickerDisplayed = tbl1.isPeoplePickerDisplayed
    local var1 = if FFlagShareSheetOmitsEmptyActions then bool1 or not isPeoplePickerDisplayed else nil
    local var2 = if FFlagShareSheetDesktopReadiness then useMeasuredRows() else nil
    local var3 = if FFlagShareSheetDesktopReadiness then var2.isLayoutReady and not (isPeoplePickerDisplayed or bool1) else nil
    local var4, var5

    if isPeoplePickerDisplayed then
        var4 = FIntShareSheetPeoplePickerEnabledSnapPointHundredthsPercent / 10000
        var5 = { var4 }
    else
        var4 = nil
        var5 = nil
    end

    local onClose = React.useCallback(function()
        tbl1.onCloseWithReason(ShareSheetTelemetry.CloseReason.UserDismissed)
    end, { tbl1.onCloseWithReason })

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl2 = {
        centerSheetHeight = var4,
        isOpen = tbl1.isOpen,
        onClose = onClose,
        preferCenterSheet = true,
        size = if FFlagShareSheetDesktopReadiness then DialogSize.Large else nil,
        snapPoints = var5
    }
    local tbl3 = {
        Header = React.createElement(
            Sheet.Header,
            {
                hasCloseAffordance = not isPeoplePickerDisplayed
            },
            isPeoplePickerDisplayed and {
                Picker = React.createElement(PeoplePicker.PeoplePickerHeader, peoplePicker.headerProps)
            }
                or {
                    Title = React.createElement(
                        FoundationText,
                        {
                            LayoutOrder = 1,
                            Text = tbl1.shareLabel,
                            tag = "auto-xy text-heading-small content-emphasis"
                        }
                    )
                }
        ),
        Content = 0,
        Actions = 0
    }

    local createElement2 = React.createElement
    local content = Sheet.Content
    local tbl4 = {
        scrollingFrameRef = if isPeoplePickerDisplayed then setPeoplePickerContentScrollingFrameRef else setDefaultContentScrollingFrameRef,
        isContentFullBleed = not isPeoplePickerDisplayed
    }
    local tbl5 = { ContentLayout = 0 }
    local createElement3 = React.createElement
    local var7 = View
    local tbl6 = {
        tag = {
            ["col size-full"] = isPeoplePickerDisplayed,
            ["col size-full-0 auto-y"] = not isPeoplePickerDisplayed,
            ["gap-xlarge"] = not isPeoplePickerDisplayed
        },
        onAbsoluteSizeChanged = if FFlagShareSheetDesktopReadiness and not isPeoplePickerDisplayed then var2.onAbsoluteSizeChanged else nil
    }
    local tbl7

    if isPeoplePickerDisplayed then
        tbl7 = {
            PeoplePicker = React.createElement(PeoplePicker.PeoplePickerList, peoplePicker.listProps)
        }
    else
        tbl7 = { SocialRow = 0, RowDivider = 0, ActionRow = 0 }
        local element

        if FFlagShareSheetDesktopReadiness and tbl1.shouldShowSocialRow and not var2.isLayoutReady then
            element = React.createElement(
                View,
                {
                    tag = "col gap-small size-full-0 auto-y",
                    LayoutOrder = 1,
                    testId = "share-sheet-rows-loading"
                },
                {
                    Tile = React.createElement(View, { tag = "size-full-1700", LayoutOrder = 1 }),
                    Label = React.createElement(FoundationText, { tag = "size-full-0 auto-y text-body-small", Text = " ", LayoutOrder = 2 })
                }
            )
        elseif tbl1.shouldShowSocialRow then
            element = React.createElement(ShareSheetSocialRow, {
                socialRowRecipients = tbl1.socialRowRecipients,
                isLoading = tbl1.isSocialRowLoading,
                onConversationActivated = tbl1.onConversationActivated,
                onMoreActivated = tbl1.onMoreActivated,
                selectedConversationIds = tbl1.selectedConversationIds,
                rowLayout = if FFlagShareSheetDesktopReadiness then var2.layout else nil,
                LayoutOrder = 1
            })
        else
            element = nil
        end

        tbl7.SocialRow = element
        local rowDivider = if tbl1.shouldShowSocialRow then React.createElement(Divider, { LayoutOrder = 2, testId = "share-sheet-row-divider" }) else nil
        tbl7.RowDivider = rowDivider
        local actionRow = if FFlagShareSheetDesktopReadiness and var3 then React.createElement(ShareSheetActionRow, {
            canShare = tbl1.canShareLink,
            context = tbl1.context,
            recipientSource = tbl1.recipientSource,
            telemetryId = tbl1.telemetryId,
            url = tbl1.url,
            rowLayout = var2.layout,
            LayoutOrder = 3
        }) else nil
        tbl7.ActionRow = actionRow
    end

    tbl5.ContentLayout = createElement3(var7, tbl6, tbl7)
    tbl3.Content = createElement2(content, tbl4, tbl5)
    local var8 = if FFlagShareSheetDesktopReadiness then bool1 else not FFlagShareSheetOmitsEmptyActions or var1
    local var9

    if var8 then
        local createElement4 = React.createElement
        local actions = Sheet.Actions
        local var10 = nil
        local tbl8 = { Footer = 0 }
        local element

        if bool1 then
            element = React.createElement(ShareSendRow, {
                isLoading = tbl1.isSending,
                label = tbl1.sendLabel,
                messagePlaceholder = tbl1.messagePlaceholder,
                onActivated = tbl1.onSendActivated,
                onFocusGained = tbl1.onComposerFocused
            })
        elseif FFlagShareSheetDesktopReadiness or isPeoplePickerDisplayed then
            element = nil
        else
            element = React.createElement(ShareSheetActionRow, {
                canShare = tbl1.canShareLink,
                context = tbl1.context,
                recipientSource = tbl1.recipientSource,
                telemetryId = tbl1.telemetryId,
                url = tbl1.url,
                rowLayout = nil,
                LayoutOrder = nil
            })
        end

        tbl8.Footer = element
        var9 = createElement4(actions, var10, tbl8)
    else
        var9 = nil
    end

    tbl3.Actions = var9
    return createElement(root, tbl2, tbl3)
end

return ShareSheetView
