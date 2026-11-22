-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialToastParent = script:FindFirstAncestor("SocialToast").Parent
local React = require(SocialToastParent.React)
local UIBlox = require(SocialToastParent.UIBlox)
local useNavigation = require(SocialToastParent.Navigation).useNavigation
local useNavigationProps = require(SocialToastParent.RobloxAppNavigation).useNavigationProps

local Images = UIBlox.App.ImageSet.Images
local IconSize = UIBlox.App.Constant.IconSize
local Toast = UIBlox.App.Dialog.Toast

return function()
    local var1 = React.useRef(false)
    local var2 = useNavigation()
    local var3 = useNavigationProps(function(_, arg1)
        return {
            toastContent = arg1.toastContent,
            anchorPoint = arg1.anchorPoint,
            duration = arg1.duration,
            layoutOrder = arg1.layoutOrder,
            position = arg1.position,
            size = arg1.size,
            show = arg1.show
        }
    end)

    local toastContent = React.useMemo(function()
        local module = {
            toastTitle = var3.toastContent.toastTitle or "",
            toastSubtitle = var3.toastContent.toastSubtitle,
            iconColorStyle = var3.toastContent.iconColorStyle,
            iconImage = if var3.toastContent.shouldHideIcon then nil else var3.toastContent.iconImage or Images["icons/status/alert"],
            iconSize = if var3.toastContent.shouldHideIcon then nil else var3.toastContent.iconSize or Vector2.new(IconSize.Regular, IconSize.Regular),
            swipeUpDismiss = var3.toastContent.swipeUpDismiss,
            onAppeared = 0,
            onActivated = 0,
            onDismissed = 0
        }

        function module.onAppeared()
            if var3.toastContent.onAppeared then
                var3.toastContent.onAppeared()
            end
            var1.current = false
        end
        module.onActivated = var3.toastContent.onActivated
        function module.onDismissed()
            if var3.toastContent.onDismissed then
                var3.toastContent.onDismissed()
            end
            if not var1.current then
                var2.goBack()
            end
        end

        return module
    end, { var3.toastContent })

    React.useEffect(function()
        var1.current = true
    end)

    return React.createElement(Toast, {
        toastContent = toastContent,
        anchorPoint = var3.anchorPoint,
        duration = var3.duration or 2,
        layoutOrder = var3.layoutOrder,
        position = var3.position,
        size = var3.size,
        show = var3.show
    })
end
