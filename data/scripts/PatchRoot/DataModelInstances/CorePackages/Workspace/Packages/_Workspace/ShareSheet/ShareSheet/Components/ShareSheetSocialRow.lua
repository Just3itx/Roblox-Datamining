-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local Array = require(ShareSheetParent.LuauPolyfill).Array
local Foundation = require(ShareSheetParent.Foundation)
local React = require(ShareSheetParent.React)
local Signals = require(ShareSheetParent.Signals)
local SignalsReact = require(ShareSheetParent.SignalsReact)
local useLocalization = require(ShareSheetParent.Localization).Hooks.useLocalization

local Skeleton = Foundation.Skeleton
local View = Foundation.View
local IconName = Foundation.Enums.IconName
local Radius = Foundation.Enums.Radius

local FFlagShareSheetDesktopReadiness = require(ShareSheet.Flags.FFlagShareSheetDesktopReadiness)
local Recipient = require(ShareSheet.Recipients.Recipient)
local ShareSheetConstants = require(ShareSheet.ShareSheetConstants)
local ShareSheetRow = require(script.Parent.ShareSheetRow)
local ShareSheetItemContainer = require(script.Parent.ShareSheetItemContainer)
local _getShareSheetRowLayout = require(script.Parent.getShareSheetRowLayout)

local Players = game:GetService("Players")

local function createSkeletonItems(tbl1)
    local skeletonItems = ({})
    local var1 = if FFlagShareSheetDesktopReadiness then tbl1.rowLayout.visibleTileCount else ShareSheetConstants.FIntShareSheetNumAvatarSkeletons

    for layoutOrder = 1, var1 do
        local tileWidth = if FFlagShareSheetDesktopReadiness then tbl1.rowLayout.getTileWidth(layoutOrder) else nil
        local str1 = `Skeleton{layoutOrder}`
        local createElement = React.createElement
        local var2 = View
        local tbl2 = {
            LayoutOrder = layoutOrder,
            tag = {
                ["col align-x-center gap-small auto-y"] = true,
                ["size-1700-0"] = not FFlagShareSheetDesktopReadiness
            },
            Size = if FFlagShareSheetDesktopReadiness then UDim2.fromOffset(tileWidth, 0) else nil
        }
        local tbl3 = { Avatar = 0, Text = 0 }
        local createElement2 = React.createElement
        local var3 = View
        local tbl4 = {
            LayoutOrder = 1,
            tag = {
                ["size-full-1700"] = not FFlagShareSheetDesktopReadiness
            },
            Size = if FFlagShareSheetDesktopReadiness then UDim2.fromOffset(tileWidth, tileWidth) else nil,
            testId = "share-sheet-avatar-skeleton-container"
        }
        local tbl5 = {
            Skeleton = React.createElement(Skeleton, { radius = Radius.Circle, testId = "share-sheet-avatar-skeleton" })
        }
        tbl3.Avatar = createElement2(var3, tbl4, tbl5)

        local createElement3 = React.createElement
        local var4 = View

        local tbl6 = {
            Skeleton = React.createElement(Skeleton, { radius = Radius.Medium, testId = "share-sheet-text-skeleton" })
        }
        tbl3.Text = createElement3(var4, { LayoutOrder = 2, tag = "size-full-400", testId = "share-sheet-text-skeleton-container" }, tbl6)
        skeletonItems[str1] = createElement(var2, tbl2, tbl3)
    end

    return skeletonItems
end

local function getRecipientsToShow(tbl1)
    local recipients = tbl1.socialRowRecipients.recipients
    local function isSelected(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        return tbl1.selectedConversationIds[arg1.id] == true
    end
    local var1 = tbl1.rowLayout.maxTileCount - 1 - #Array.filter(recipients, isSelected)

    return Array.filter(recipients, function(arg1): boolean
        if isSelected(arg1) then
            return true
        end
        var1 -= 1
        return var1 >= 0
    end)
end

local function ShareSheetRecipientItem(tbl1)
    local id = tbl1.recipient.id
    local onActivated = React.useCallback(function()
        tbl1.onConversationActivated(id)
    end, { id, tbl1.onConversationActivated })
    local participantIds = Recipient.getParticipantIds(tbl1.recipient, tbl1.localUserId)
    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            return Recipient.getName(tbl1.recipient, arg1)
        end)
    end, { tbl1.recipient })
    local label = SignalsReact.useSignalState(var2)

    return React.createElement(ShareSheetItemContainer, {
        primaryUserId = participantIds[1] or tbl1.localUserId,
        secondUserId = participantIds[2],
        isSelected = tbl1.isSelected,
        label = label,
        onActivated = onActivated,
        width = if FFlagShareSheetDesktopReadiness then tbl1.width else nil,
        LayoutOrder = tbl1.LayoutOrder
    })
end

local function ShareSheetSocialRow(tbl1)
    local localUserId = tostring(Players.LocalPlayer and Players.LocalPlayer.UserId or 0)
    local var1 = useLocalization({ more = "CommonUI.Features.Label.More" })

    local tbl2 = {}
    local visibleTileCount

    if tbl1.isLoading or tbl1.socialRowRecipients.isLoading then
        tbl2 = createSkeletonItems(if FFlagShareSheetDesktopReadiness then tbl1 else nil)
        if FFlagShareSheetDesktopReadiness then
            visibleTileCount = tbl1.rowLayout.visibleTileCount
        else
            visibleTileCount = nil
        end
    else
        local var2 = if FFlagShareSheetDesktopReadiness then getRecipientsToShow(tbl1) else tbl1.socialRowRecipients.recipients

        for layoutOrder, recipient in var2 do
            local id = recipient.id
            local createElement = React.createElement
            local func1 = ShareSheetRecipientItem
            local tbl3 = {
                recipient = recipient,
                isSelected = tbl1.selectedConversationIds[recipient.id] == true,
                localUserId = localUserId,
                onConversationActivated = tbl1.onConversationActivated,
                width = if FFlagShareSheetDesktopReadiness then tbl1.rowLayout.getTileWidth(layoutOrder) else nil,
                LayoutOrder = layoutOrder
            }
            tbl2[id] = createElement(func1, tbl3)
        end

        if FFlagShareSheetDesktopReadiness then
            visibleTileCount = #var2 + 1
        else
            visibleTileCount = nil
        end

        local createElement = React.createElement
        local var3 = ShareSheetItemContainer
        local tbl3 = {
            icon = IconName.ThreeDotsHorizontal,
            label = var1.more,
            onActivated = tbl1.onMoreActivated,
            width = if FFlagShareSheetDesktopReadiness then tbl1.rowLayout.getTileWidth(visibleTileCount) else nil,
            LayoutOrder = #var2 + 1
        }
        tbl2.More = createElement(var3, tbl3)
    end

    return React.createElement(ShareSheetRow, {
        LayoutOrder = tbl1.LayoutOrder,
        margin = if FFlagShareSheetDesktopReadiness then tbl1.rowLayout.margin else nil,
        gap = if FFlagShareSheetDesktopReadiness then tbl1.rowLayout.gap else nil,
        isScrollingEnabled = if FFlagShareSheetDesktopReadiness then tbl1.rowLayout.isScrollingEnabled(visibleTileCount) else nil
    }, tbl2)
end

return ShareSheetSocialRow
