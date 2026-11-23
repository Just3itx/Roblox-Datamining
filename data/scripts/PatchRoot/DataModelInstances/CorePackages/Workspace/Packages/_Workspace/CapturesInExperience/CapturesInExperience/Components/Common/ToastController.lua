-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)
local ReactOtter = require(scriptParentParentParentParent.ReactOtter)
local Foundation = require(scriptParentParentParentParent.Foundation)

local Toast = Foundation.Toast
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant

local ToastWithIconAction = require(script.Parent.ToastWithIconAction)

local tbl1 = { dampingRatio = 1, frequency = 3 }

local uDim = UDim.new(0, 296)

local function ToastController(tbl2)
    local var1, var2 = React.useState(false)

    local var3 = React.useCallback(function()
        if not var1 then
            tbl2.onDismissed()
        end
    end, { var1, tbl2.onDismissed })

    local var4, var5 = ReactOtter.useAnimatedBinding(-200, var3)

    local var6 = React.useCallback(function()
        var2(false)
        var5(ReactOtter.spring(-200, tbl1))
    end, { var5 })

    React.useEffect(function()
        if tbl2.show then
            var2(true)
            var5(ReactOtter.spring(20, tbl1))
            return
        end
        var6()
    end, { tbl2.show, var5, var6 })

    React.useEffect(function()
        if not (tbl2.show and tbl2.duration > 0) then
            return nil
        end

        local var7 = task.delay(tbl2.duration, function()
            var6()
        end)
        return function()
            task.cancel(var7)
        end
    end, { tbl2.show, tbl2.duration, var6 })

    local onAction = tbl2.onAction
    local actions = React.useMemo(function(): {{onActivated: () -> (), text: any, variant: any}}?
        return if tbl2.actionText then {{
            text = tbl2.actionText,
            onActivated = function()
                if onAction then
                    onAction()
                end
                var6()
            end,
            variant = ButtonVariant.Emphasis
        }} else nil
    end, { tbl2.actionText, onAction, var6 })

    local iconAction = tbl2.iconAction

    local var8 = var4:map(function(yOffset: number?): UDim2
        return UDim2.new(0.5, 0, 0, yOffset)
    end)

    local createElement = React.createElement
    local var9 = View
    local tbl3 = {
        tag = "size-full-0 auto-y col align-x-center anchor-top-center",
        Position = var8
    }
    local tbl4 = { Toast = 0 }
    local element

    if iconAction and actions then
        element = React.createElement(ToastWithIconAction, {
            title = tbl2.title,
            text = tbl2.text,
            icon = tbl2.icon,
            actionText = actions[1].text,
            onAction = actions[1].onActivated,
            iconActionIcon = iconAction.icon,
            onIconAction = function()
                iconAction.onActivated()
                var6()
            end,
            width = uDim
        })
    else
        element = React.createElement(Toast, { title = tbl2.title, text = tbl2.text, icon = tbl2.icon, actions = actions, width = uDim })
    end

    tbl4.Toast = element
    return createElement(var9, tbl3, tbl4)
end

return ToastController
