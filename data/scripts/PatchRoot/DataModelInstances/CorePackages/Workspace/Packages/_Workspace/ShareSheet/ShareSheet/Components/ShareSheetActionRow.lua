-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local Foundation = require(ShareSheetParent.Foundation)
local React = require(ShareSheetParent.React)
local createNextOrder = require(ShareSheetParent.ReactUtils).createNextOrder
local useLocalization = require(ShareSheetParent.Localization).Hooks.useLocalization
local ShareSheetItemContainer = require(script.Parent.ShareSheetItemContainer)
local ShareSheetRow = require(script.Parent.ShareSheetRow)
local _getShareSheetRowLayout = require(script.Parent.getShareSheetRowLayout)

local FFlagShareSheetDesktopReadiness = require(ShareSheet.Flags.FFlagShareSheetDesktopReadiness)

local _RecipientSource = require(ShareSheet.Recipients.RecipientSource)
local ShareSheetTelemetry = require(ShareSheet.telemetry.ShareSheetTelemetry)
local copyLink = require(ShareSheet.copyLink)
local shareLink = require(ShareSheet.shareLink)

local IconName = Foundation.Enums.IconName
local View = Foundation.View

local function ShareSheetActionRow(tbl1)
    local shouldAnimate, var2 = React.useState(false)
    local var3 = React.useRef(nil)
    local var4 = useLocalization({
        copied = "Feature.UniversalShareSheet.Action.CopiedLink",
        copyLink = "Feature.SocialShare.Action.CopyLink",
        share = "Feature.SocialShare.Action.Share"
    })

    local var5 = React.useCallback(function()
        var2(true)
        if var3.current then
            task.cancel(var3.current)
        end
        var3.current = task.delay(2, function()
            var3.current = nil
            var2(false)
        end)
    end, {})
    local onActivated = React.useCallback(function()
        copyLink({ context = tbl1.context, url = tbl1.url })

        var5()
        ShareSheetTelemetry.logInteraction({
            context = tbl1.context,
            recipientSource = tbl1.recipientSource,
            telemetryId = tbl1.telemetryId or "",
            interactionType = ShareSheetTelemetry.InteractionType.CopyLink
        })
    end, {
        tbl1.context,
        tbl1.recipientSource,
        tbl1.telemetryId,
        tbl1.url,
        var5
    })

    local var1 = React.useCallback(function()
        shareLink({ context = tbl1.context, url = tbl1.url })

        ShareSheetTelemetry.logInteraction({
            context = tbl1.context,
            recipientSource = tbl1.recipientSource,
            telemetryId = tbl1.telemetryId or "",
            interactionType = ShareSheetTelemetry.InteractionType.NativeShare
        })
    end, {
        tbl1.context,
        tbl1.recipientSource,
        tbl1.telemetryId,
        tbl1.url
    })

    React.useEffect(function()
        return function()
            if var3.current then
                task.cancel(var3.current)
            end
        end
    end, {})

    local nextOrder = if FFlagShareSheetDesktopReadiness then createNextOrder() else nil
    local var8 = if FFlagShareSheetDesktopReadiness then nextOrder() else nil
    local var9 = if FFlagShareSheetDesktopReadiness then nextOrder() else nil
    local tbl2 = {
        CopyLink = React.createElement(ShareSheetItemContainer, {
            icon = if shouldAnimate then IconName.Check else IconName.ChainLink,
            label = if shouldAnimate then var4.copied else var4.copyLink,
            onActivated = onActivated,
            shouldAnimate = shouldAnimate,
            width = if FFlagShareSheetDesktopReadiness then tbl1.rowLayout.getTileWidth(var8) else nil,
            LayoutOrder = if FFlagShareSheetDesktopReadiness then var8 else 1
        }),
        Share = if tbl1.canShare then React.createElement(ShareSheetItemContainer, {
            icon = IconName.ArrowUpFromLandscapeRectangle,
            label = var4.share,
            onActivated = var1,
            width = if FFlagShareSheetDesktopReadiness then tbl1.rowLayout.getTileWidth(var9) else nil,
            LayoutOrder = if FFlagShareSheetDesktopReadiness then var9 else 2
        }) else nil
    }

    if not FFlagShareSheetDesktopReadiness then
        return (React.createElement(View, { tag = "row gap-medium size-full-0 auto-y" }, tbl2))
    end

    return (React.createElement(
        ShareSheetRow,
        {
            LayoutOrder = tbl1.LayoutOrder,
            margin = tbl1.rowLayout.margin,
            gap = tbl1.rowLayout.gap,
            isScrollingEnabled = false
        },
        tbl2
    ))
end

return ShareSheetActionRow
