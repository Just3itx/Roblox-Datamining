-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local Foundation = require(ShareSheetParent.Foundation)
local React = require(ShareSheetParent.React)
local ReactRoblox = require(ShareSheetParent.ReactRoblox)
local ShareSheetView = require(script.Parent.Parent.ShareSheetView)
local useShareSheetViewModel = require(script.Parent.Parent.useShareSheetViewModel)
local useUniversalShareSheetViewModel = require(script.Parent.useUniversalShareSheetViewModel)

local num1 = game:DefineFastInt("ShareSheetSnackbarAutoDismissSeconds", 5)

local useOverlay = Foundation.Hooks.useOverlay
local useTokens = Foundation.Hooks.useTokens

local function UniversalShareSheetContent(arg1)
    local var1 = useShareSheetViewModel(arg1)
    return React.createElement(ShareSheetView, var1)
end

return React.memo(function() -- name: UniversalShareSheetHost
    local var1, onShareSendResultSnackbar = React.useState(nil)
    local var3 = useOverlay()
    local var4 = useTokens()
    local var5 = useUniversalShareSheetViewModel()
    local var6 = React.useCallback(function()
        onShareSendResultSnackbar(nil)
    end, {})
    React.useEffect(function()
        if var1 ~= nil then
            local var7 = task.delay(num1, var6)
            return function()
                task.cancel(var7)
            end
        end
    end, { var1, var6 })

    local action = if var1 then var1.action else nil

    local var2 = action and {
        onActivated = function()
            var6()
            action.onActivated()
            return nil
        end,
        text = action.text
    } or nil

    local createElement = React.createElement
    local fragment = React.Fragment
    local var8 = nil
    local tbl1 = { ShareSheet = 0, ShareSendResultSnackbar = 0 }
    local element

    if var5 then
        element = React.createElement(UniversalShareSheetContent, {
            context = var5.context,
            formatSuccessSnackbarText = var5.formatSuccessSnackbarText,
            isOpen = var5.isOpen,
            messagePlaceholder = var5.messagePlaceholder,
            onCloseWithReason = var5.onCloseWithReason,
            onShareSendResultSnackbar = onShareSendResultSnackbar,
            recipientSource = var5.recipientSource,
            telemetryId = var5.telemetryId,
            url = var5.url
        })
    else
        element = nil
    end

    tbl1.ShareSheet = element

    tbl1.ShareSendResultSnackbar = if var1 and var3 then ReactRoblox.createPortal(
        React.createElement(Foundation.Snackbar, {
            action = var2,
            AnchorPoint = Vector2.new(0.5, 1),
            Position = UDim2.new(0.5, 0, 1, -var4.Padding.XLarge),
            testId = "share-sheet-snackbar",
            title = var1.title,
            ZIndex = 999
        }),
        var3
    ) else nil
    return createElement(fragment, var8, tbl1)
end)
