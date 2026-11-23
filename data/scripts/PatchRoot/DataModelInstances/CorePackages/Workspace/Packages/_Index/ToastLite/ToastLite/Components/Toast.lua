-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ToastLiteParent = script:FindFirstAncestor("ToastLite").Parent

local Cryo = require(ToastLiteParent.Cryo)
local React = require(ToastLiteParent.React)
local RoactUtils = require(ToastLiteParent.RoactUtils)
local ToastRodux = require(ToastLiteParent.ToastRodux)
local UIBlox = require(ToastLiteParent.UIBlox)

local Toast = UIBlox.App.Dialog.Toast
local Images = UIBlox.App.ImageSet.Images
local ToastType = ToastRodux.Enums.ToastType
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useStyle = UIBlox.Core.Style.useStyle

local tbl1 = {
    Info = Images["icons/logo/block"],
    Warning = Images["icons/status/alert"],
    Success = Images["icons/actions/accept"]
}
local tbl2 = {
    [ToastType.InformationMessage] = tbl1.Info,
    [ToastType.SuccessConfirmation] = tbl1.Success,
    [ToastType.NetworkingError] = tbl1.Warning
}
local tbl3 = {
    duration = 3,
    springOptions = { frequency = 4, damping = 1 }
}

local function selectCurrentMessage(arg1)
    return arg1.currentToastMessages[1]
end

local function Toast2(tbl4)
    local var1 = Cryo.Dictionary.join(tbl3, tbl4)

    local var2 = useDispatch()
    local var3 = useSelector(selectCurrentMessage)
    local tokens = useStyle().Tokens

    local onDismissed = React.useCallback(function()
        var2(ToastRodux.Actions.RemoveCurrentToastMessage())
    end, { var2 })

    local function func1()
        if var3 then
            onDismissed()
        end
    end

    React.useEffect(function()
        if var3 and not (next(var3) and var3.toastTitle) then
            onDismissed()
        end
    end, { var3, onDismissed })

    if var3 == nil then
        return nil
    end

    local toastType = var3.toastType
    if toastType ~= ToastType.QuickLaunchError then
        func1 = nil
    end

    local iconImage = if toastType == nil then nil else tbl2[toastType]
    local uDim2 = UDim2.new(0.5, 0, 0, tokens.Size.Size_500)

    return React.createElement(Toast, {
        duration = var1.duration,
        position = uDim2,
        show = true,
        springOptions = var1.springOptions,
        toastContent = {
            iconImage = iconImage,
            onActivated = func1,
            onDismissed = onDismissed,
            sequenceNumber = var3.sequenceNumber,
            toastSubtitle = var3.toastSubtitle,
            toastTitle = var3.toastTitle
        }
    })
end

return Toast2
