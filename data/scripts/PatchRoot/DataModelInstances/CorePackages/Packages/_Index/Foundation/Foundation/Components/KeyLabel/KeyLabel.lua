-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:20:35Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local UserInputService = require(Foundation.Utility.Wrappers).Services.UserInputService

local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)
local ReactUtils = require(FoundationParent.ReactUtils)

local getVisualForKey = require(script.Parent.getVisualForKey)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local CircularProgressBar = require(Foundation.Components.CircularProgressBar)
local Image = require(Foundation.Components.Image)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local EventConnection = ReactUtils.EventConnection

local tbl1 = { holdTime = 1, resetTime = 0.5 }

local tbl2 = { testId = "--foundation-key-label" }

local rect = Rect.new(Vector2.new(10, 9), Vector2.new(25, 25))

return React.memo(React.forwardRef(function(arg1, ref) -- name: KeyLabel
    local var1 = withDefaults(arg1, tbl2)
    local var2 = if var1.holdBehavior then withDefaults(var1.holdBehavior, tbl1) else nil
    local var3 = useTokens()

    local var4, var5 = React.useState(nil)
    local var6 = nil
    local var7, var8 = ReactOtter.useAnimatedBinding(0, function(num1: number)
        if not var2 or num1 ~= 1 or not var4 then
            return
        end

        var6(ReactOtter.ease(0, { duration = var2.resetTime, easingStyle = Enum.EasingStyle.Linear }))

        var5(nil)
        var2.onEndHold(true)
    end)

    local progress = var7
    var6 = var8

    local visualForKey = getVisualForKey(var1.keyCode)

    local bool1 = visualForKey.keyVisualType == "Image"
    local createElement = React.createElement
    local var10 = View
    local var11 = withCommonProps(var1, { Size = var1.Size, ref = ref })

    local tbl3 = { Image = 0, Indicator = 0, InputBeganConnection = 0, InputEndedConnection = 0 }

    local createElement2 = React.createElement
    local var12 = Image
    local tbl4 = {
        Image = if bool1 then visualForKey.key else "icons/controls/keys/key_single",
        Size = visualForKey.size,
        ScaleType = if bool1 then nil else Enum.ScaleType.Slice,
        imageStyle = if var4 then var3.Color.Content.Emphasis else var3.Color.Content.Muted,
        slice = not bool1 and { center = rect } or nil,
        tag = "position-center-center anchor-center-center"
    }

    local tbl5 = {
        CustomPadding = if bool1 then nil else React.createElement("UIPadding", { PaddingBottom = UDim.new(0, 3) }),
        Text = if bool1 then nil else React.createElement(Text, {
            Text = visualForKey.key,
            textStyle = if var4 then var3.Color.Content.Emphasis else var3.Color.Content.Muted,
            tag = "size-full-full auto-xy text-body-medium text-align-x-center"
        })
    }
    tbl3.Image = createElement2(var12, tbl4, tbl5)

    tbl3.Indicator = if var2 and var2.holdTime > 0 then React.createElement(
        CircularProgressBar,
        {
            progress = progress,
            tag = "size-full-full",
            testId = `{var1.testId}--indicator`
        },
        {}
    ) else nil

    tbl3.InputBeganConnection = if var2 then React.createElement(EventConnection, {
        event = UserInputService.InputBegan,
        callback = function(arg2)
            if var4 then
                return
            end

            if arg2.KeyCode ~= var1.keyCode then
                return
            end

            if var2.onBeginHold then
                var2.onBeginHold()
            end
            if var2.holdTime == 0 then
                var2.onEndHold(true)
                return
            end
            var5(arg2)
            var6(
                ReactOtter.ease(1, { duration = (1 - progress:getValue()) * var2.holdTime, easingStyle = Enum.EasingStyle.Linear })
            )
        end
    }) else nil

    tbl3.InputEndedConnection = if var2 then React.createElement(EventConnection, {
        event = UserInputService.InputEnded,
        callback = function(arg2)
            if arg2 ~= var4 then
                return
            end

            if var2.onEndHold then
                var2.onEndHold(false)
            end
            var5(nil)
            var6(ReactOtter.ease(0, { duration = progress:getValue() * var2.resetTime, easingStyle = Enum.EasingStyle.Linear }))
        end
    }) else nil

    return createElement(var10, var11, tbl3)
end))
