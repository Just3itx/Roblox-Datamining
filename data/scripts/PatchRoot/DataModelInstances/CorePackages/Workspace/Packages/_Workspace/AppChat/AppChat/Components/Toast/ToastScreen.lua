-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)
local UIBlox = require(AppChatParent.UIBlox)

local Images = UIBlox.App.ImageSet.Images
local IconSize = UIBlox.App.Constant.IconSize
local Toast = UIBlox.App.Dialog.Toast
local Logger = require(script.Parent.Logger)

local var1 = Roact.PureComponent:extend("ToastScreen")
var1.defaultProps = { navigation = nil }

function var1.init(arg1)
    arg1.hasToastChanged = false

    function arg1.getToastProps(arg2)
        local toastContent = arg2.toastContent

        local tbl1 = {
            toastContent = 0,
            anchorPoint = 0,
            duration = 0,
            layoutOrder = 0,
            position = 0,
            size = 0,
            show = 0
        }
        local tbl2 = {
            toastTitle = toastContent.toastTitle,
            toastSubtitle = toastContent.toastSubtitle,
            iconColorStyle = toastContent.iconColorStyle,
            iconImage = if arg2.shouldHideIcon then nil else toastContent.iconImage or Images["icons/status/alert"],
            iconSize = toastContent.iconSize or Vector2.new(IconSize.Regular, IconSize.Regular),
            swipeUpDismiss = toastContent.swipeUpDismiss,
            onAppeared = 0,
            onActivated = 0,
            onDismissed = 0
        }

        function tbl2.onAppeared()
            if toastContent.onAppeared then
                toastContent.onAppeared()
            end
            arg1.hasToastChanged = false
        end
        tbl2.onActivated = toastContent.onActivated
        function tbl2.onDismissed()
            if toastContent.onDismissed then
                toastContent.onDismissed()
            end
            if not arg1.hasToastChanged then
                arg1.props.navigation.goBack()
            end
        end

        tbl1.toastContent = tbl2

        tbl1.anchorPoint = arg2.anchorPoint
        tbl1.duration = arg2.duration or 2
        tbl1.layoutOrder = arg2.layoutOrder
        tbl1.position = arg2.position
        tbl1.size = arg2.size
        tbl1.show = arg2.show

        return tbl1
    end
end

function var1.render(arg1)
    assert(type(arg1.props.navigation) ~= "nil", "ToastScreen should be wrapped with Roact Navigation")

    local toastProps = arg1.getToastProps(arg1.props.navigation.getParam("toastProps", {}))
    return Roact.createElement(Toast, toastProps)
end

function var1.didUpdate(arg1, _, _)
    arg1.hasToastChanged = true
end

function var1.didMount(_)
    Logger:info("{screen} mounted")
end

return var1
