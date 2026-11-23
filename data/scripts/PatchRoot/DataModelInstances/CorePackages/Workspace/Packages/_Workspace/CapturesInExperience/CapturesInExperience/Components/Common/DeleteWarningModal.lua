-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Localization = require(scriptParentParentParentParent.Localization)
local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local RobloxAppHooks = require(scriptParentParentParentParent.RobloxAppHooks)
local UIBlox = require(scriptParentParentParentParent.UIBlox)
local Checkbox = require(scriptParentParentParentParent.Foundation).Checkbox

local DeleteWarningModalClosed = require(scriptParentParentParent.Actions.DeleteWarningModalClosed)
local recordDeleteWarningModalOptOut = require(scriptParentParentParent.Utils.recordDeleteWarningModalOptOut)

local useCallback = React.useCallback
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useLocalization = Localization.Hooks.useLocalization
local useScreenSize = RobloxAppHooks.useScreenSize
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useState = React.useState
local useStyle = UIBlox.Core.Style.useStyle

local Constants = require(scriptParentParentParent.Constants)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)

local ButtonType = UIBlox.App.Button.Enum.ButtonType

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert

return function(tbl1)
    local screenSize = useScreenSize()
    local var2 = useStyle()

    local var3 = useAnalytics()
    local var4 = useDispatch()

    local var5 = useLocalization({
        alertBody = "Feature.Captures.Label.DeleteCaptureInfo",
        alertBodyPlural = "Feature.Captures.Label.DeleteCapturesWarning",
        alertTitle = "Feature.Captures.Title.DeleteCaptureWarning",
        alertTitlePlural = "Feature.Captures.Title.DeleteMultipleCapturesWarning",
        cancelCTA = "Feature.Captures.Action.DeleteCaptureWarningCancel",
        deleteCTA = "Feature.Captures.Action.DeleteCaptureWarningConfirm",
        optOutText = "Feature.Captures.Label.DeleteCaptureWarningOptOut"
    })

    local theme = var2.Theme

    local var6 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Carousel.IsDeleteWarningModalOpen
    end)

    local var7 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].CaptureManager.SelectedCaptures
    end)

    local isChecked, var9 = useState(false)

    useEffect(function()
        if var6 then
            var9(false)
        end
    end, { var6, var9 })

    local onActivated = useCallback(function()
        var4(DeleteWarningModalClosed())
        var3.fireEvent(EventNames.CapturesDeleteWarningModalCancelPressed)
    end, {})

    local var1 = useCallback(function()
        tbl1.deleteItem()

        if isChecked then
            recordDeleteWarningModalOptOut(var3)
        end

        var3.fireEvent(EventNames.CapturesDeleteWarningModalDeletePressed)
        var4(DeleteWarningModalClosed())
    end, { var3, isChecked, tbl1.deleteItem })

    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl2 = {
        Active = true,
        AutoButtonColor = false,
        BackgroundColor3 = theme.Overlay.Color,
        BackgroundTransparency = theme.Overlay.Transparency,
        Size = UDim2.fromScale(1, 1),
        Visible = var6,
        ZIndex = tbl1.zIndex
    }
    local tbl3 = { Alert = 0 }
    local createElement2 = React.createElement
    local var12 = InteractiveAlert
    local tbl4 = {
        bodyText = if #var7 > 1 then var5.alertBodyPlural else var5.alertBody,
        buttonStackInfo = {
            buttons = {
                {
                    buttonType = ButtonType.Secondary,
                    props = {
                        onActivated = onActivated,
                        text = var5.cancelCTA
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = var1,
                        text = var5.deleteCTA
                    }
                }
            }
        },
        isMiddleContentFocusable = false,
        middleContent = 0,
        position = 0,
        screenSize = 0,
        title = 0
    }

    function tbl4.middleContent()
        return React.createElement(Checkbox, {
            label = var5.optOutText,
            isChecked = isChecked,
            isDisabled = false,
            onActivated = function()
                var9(not isChecked)
            end
        })
    end
    tbl4.position = UDim2.fromScale(0.5, 0.5)
    tbl4.screenSize = screenSize
    tbl4.title = if #var7 > 1 then var5.alertTitlePlural else var5.alertTitle
    tbl3.Alert = createElement2(var12, tbl4)
    return createElement(str1, tbl2, tbl3)
end
