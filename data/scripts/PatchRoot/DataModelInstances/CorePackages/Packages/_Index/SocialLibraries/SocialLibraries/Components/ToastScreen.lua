-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local t = dependencies.t

local Images = UIBlox.App.ImageSet.Images
local IconSize = UIBlox.App.Constant.IconSize
local Toast = UIBlox.App.Dialog.Toast
local validateColorInfo = UIBlox.Style.Validator.validateColorInfo

local var1 = Roact.PureComponent:extend("ToastScreen")

var1.defaultProps = { navigation = nil }

local var2 = t.strictInterface({
    toastTitle = t.optional(t.string),
    toastSubtitle = t.optional(t.string),
    iconColorStyle = t.optional(validateColorInfo),
    iconImage = t.optional(t.union(t.table, t.string)),
    iconSize = t.optional(t.Vector2),
    swipeUpDismiss = t.optional(t.boolean),
    onAppeared = t.optional(t.callback),
    onActivated = t.optional(t.callback),
    onDismissed = t.optional(t.callback),
    hideIcon = t.optional(t.boolean)
})

local var3 = t.strictInterface({
    toastContent = t.optional(t.table),
    anchorPoint = t.optional(t.Vector2),
    duration = t.optional(t.integer),
    layoutOrder = t.optional(t.integer),
    position = t.optional(t.UDim2),
    size = t.optional(t.UDim2),
    show = t.optional(t.boolean)
})

function var1.init(arg1)
    arg1.hasToastChanged = false

    function arg1.getToastProps(arg2)
        local toastContent = arg2.toastContent or {}

        assert(var3(arg2))
        assert(var2(toastContent))

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
            toastTitle = toastContent.toastTitle or "",
            toastSubtitle = toastContent.toastSubtitle,
            iconColorStyle = toastContent.iconColorStyle,
            iconImage = if toastContent.hideIcon then nil else toastContent.iconImage or Images["icons/status/alert"],
            iconSize = if toastContent.hideIcon then nil else toastContent.iconSize or Vector2.new(IconSize.Regular, IconSize.Regular),
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

return var1
