-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local React = require(ServerDrivenUiParent.React)
local Foundation = require(ServerDrivenUiParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local Dialog = Foundation.Dialog
local EnumsOrientation = Foundation.Enums.Orientation

local bool1 = game:DefineFastFlag("SduiDialogHeroMediaProps2", false)

return React.memo(function(tbl1) -- name: SduiDialog
    local var1 = tbl1.bodyText or tbl1.bodyComponent

    local onActivated = React.useCallback(function()
        if not tbl1.primaryButtonAction then
            return
        end

        tbl1.primaryButtonAction()
        if tbl1.primaryButtonSideEffectAction then
            tbl1.primaryButtonSideEffectAction()
        end
    end, { tbl1.primaryButtonAction, tbl1.primaryButtonSideEffectAction })

    local var2 = React.useCallback(function()
        if not tbl1.secondaryButtonAction then
            return
        end

        tbl1.secondaryButtonAction()
        if tbl1.secondaryButtonSideEffectAction then
            tbl1.secondaryButtonSideEffectAction()
        end
    end, { tbl1.secondaryButtonAction, tbl1.secondaryButtonSideEffectAction })

    local var4 = nil
    if tbl1.primaryButtonAction or tbl1.primaryButtonText or tbl1.primaryButtonIcon then
        var4 = var4 or {}
        table.insert(var4, {
            testId = "--sdui-dialog-primary-button",
            variant = ButtonVariant.Emphasis,
            text = tbl1.primaryButtonText,
            icon = tbl1.primaryButtonIcon,
            onActivated = onActivated,
            inputDelay = tbl1.primaryButtonInputDelay
        })
    end
    if tbl1.secondaryButtonAction or tbl1.secondaryButtonText or tbl1.secondaryButtonIcon then
        var4 = var4 or {}
        table.insert(var4, {
            testId = "--sdui-dialog-secondary-button",
            variant = ButtonVariant.Standard,
            text = tbl1.secondaryButtonText,
            icon = tbl1.secondaryButtonIcon,
            onActivated = var2,
            inputDelay = tbl1.secondaryButtonInputDelay
        })
    end

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl2 = {
        size = tbl1.size,
        onClose = tbl1.onClose,
        disablePortal = tbl1.disablePortal == nil or tbl1.disablePortal,
        hasBackdrop = tbl1.hasBackdrop == nil or tbl1.hasBackdrop
    }
    local tbl3 = {
        DialogTitle = if tbl1.titleText then React.createElement(Dialog.Title, { text = tbl1.titleText }) or nil else nil,
        DialogMedia = 0,
        DialogContent = 0,
        DialogActions = 0
    }
    local element

    if tbl1.image then
        element = React.createElement(Dialog.HeroMedia, {
            media = tbl1.image,
            aspectRatio = if bool1 and tbl1.imageHeight ~= nil then tbl1.imageAspectRatio else tbl1.imageAspectRatio or 16 / 9,
            mediaStyle = if bool1 then tbl1.imageStyle else nil,
            height = if bool1 then tbl1.imageHeight else nil,
            scaleType = if bool1 then tbl1.imageScaleType else nil
        })
            or nil
    else
        element = nil
    end

    tbl3.DialogMedia = element
    local element2 = if var1 then React.createElement(Dialog.Content, { LayoutOrder = 2 }, {
        BodyContent = if tbl1.bodyComponent then tbl1.bodyComponent elseif tbl1.bodyText then React.createElement(Dialog.Text, { Text = tbl1.bodyText }) else nil
    })
        or nil else nil
    tbl3.DialogContent = element2

    tbl3.DialogActions = if var4 then React.createElement(Dialog.Actions, {
        LayoutOrder = 3,
        actions = var4,
        label = tbl1.actionsLabel,
        orientation = tbl1.actionsOrientation or EnumsOrientation.Horizontal
    })
        or nil else nil
    return createElement(root, tbl2, tbl3)
end)
