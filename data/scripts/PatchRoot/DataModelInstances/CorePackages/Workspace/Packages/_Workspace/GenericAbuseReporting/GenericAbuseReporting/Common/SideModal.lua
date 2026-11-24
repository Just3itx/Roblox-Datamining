-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)
local ReactOtter = require(GenericAbuseReportingParent.ReactOtter)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local View = Foundation.View
local IconSize = Foundation.Enums.IconSize
local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local Button = Foundation.Button
local ButtonSize = Foundation.Enums.ButtonSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local useTokens = Foundation.Hooks.useTokens

local tbl1 = {
    stiffness = 400,
    damping = 40,
    mass = 1,
    restingPositionLimit = 0.5,
    restingVelocityLimit = 0.1
}

local function isFullWidth(num1: number): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return num1 < 540
end

local function getAnchorPoint(vector2: Vector2): Vector2
    if isFullWidth(vector2.X) then
        return Vector2.new(0.5, 1)
    end
    return Vector2.new(0, 0)
end

local function getSize(vector2: Vector2, xOffset: number, yOffset: number): UDim2
    if isFullWidth(vector2.X) then
        return UDim2.new(0, vector2.X, 0, yOffset)
    end
    return UDim2.new(0, xOffset, 0, vector2.Y)
end

local function getPosition(vector2: Vector2, width: number): UDim2
    if isFullWidth(vector2.X) then
        return UDim2.new(0.5, 0, 1, 0)
    end
    return UDim2.new(1, -width, 0, 0)
end

local function SideModal(tbl2)
    local var1 = useTokens()
    local anchorPoint, var3 = React.useState(getAnchorPoint(tbl2.screenSize))
    local var4, var5 = React.useState(getSize(tbl2.screenSize, tbl2.width, tbl2.height))
    local var6, var7 = React.useState(getPosition(tbl2.screenSize, tbl2.width))
    local var8, var9 = React.useState(true)
    local var10, var11 = React.useState(false)

    local footerContent = React.useMemo(function()
        if tbl2.footerContent then
            return (tbl2.footerContent())
        end

        return nil
    end, { tbl2.footerContent })
    local num1 = if footerContent then 35 else 0

    local var13, var14 = ReactOtter.useAnimatedBinding(1, function()
        if var8 then
            return
        end

        if var10 then
            if tbl2.buttonProps then
                tbl2.buttonProps.onActivated()
            end
        elseif tbl2.onAbandon then
            tbl2.onAbandon()
        end
    end)

    local var15 = React.useMemo(function(): number
        return if var8 then 0 else 1
    end, { var8 })

    React.useEffect(function()
        if tbl2.closeWithAnimation then
            var9(false)
        end
    end, { tbl2.closeWithAnimation })

    React.useEffect(function()
        var14(ReactOtter.spring(var15, tbl1))
    end, { var15 })

    React.useEffect(function()
        var3(getAnchorPoint(tbl2.screenSize))
        var5(getSize(tbl2.screenSize, tbl2.width, tbl2.height))
        var7(getPosition(tbl2.screenSize, tbl2.width))
    end, { tbl2.screenSize })

    local onActivated = React.useCallback(function()
        var9(false)
    end, { var9 })

    local var2 = React.useCallback(function()
        if tbl2.buttonProps and tbl2.buttonProps.validateState and not tbl2.buttonProps.validateState() then
            return
        end

        var11(true)
        var9(false)
    end, { var9, var11, tbl2.buttonProps })

    local createElement = React.createElement
    local str1 = "TextButton"

    local tbl3 = {
        AutoButtonColor = false,
        BorderSizePixel = 0,
        BackgroundTransparency = var13:map(function(num2: number): number
            return num2 + 0.3
        end),
        BackgroundColor3 = Color3.fromHex("#000000"),
        Text = "",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        [React.Event.Activated] = onActivated
    }

    local tbl4 = { SideModalContainer = 0 }
    local createElement2 = React.createElement
    local var18 = View

    local tbl5 = {
        AnchorPoint = Vector2.new(1, 0),
        Position = var13:map(function(num2: number): UDim2
            if isFullWidth(tbl2.screenSize.X) then
                return UDim2.new(1, 0, 0, tbl2.height * num2)
            end

            return UDim2.new(1, tbl2.width * num2, 0, 0)
        end),
        tag = "size-full"
    }

    local tbl6 = { SideModal = 0 }
    local createElement3 = React.createElement
    local var19 = View
    local tbl7 = {
        AnchorPoint = anchorPoint,
        Position = var6,
        Size = var4,
        tag = "bg-surface-300 radius-medium col"
    }
    local tbl8 = {
        IconRow = React.createElement(View, {
            Size = UDim2.new(1, 0, 0, 32),
            tag = "padding-left-medium",
            LayoutOrder = 0
        }, {
            IconButton = React.createElement(IconButton, {
                icon = "icons/navigation/pushBack",
                size = IconSize.Medium,
                tag = "anchor-center-left position-center-left",
                onActivated = onActivated
            })
        }),
        TitleRow = React.createElement(View, {
            Size = UDim2.new(1, 0, 0, 32),
            tag = "auto-xy",
            LayoutOrder = 1
        }, {
            Title = React.createElement(FoundationText, {
                fontStyle = var1.Typography.TitleLarge,
                textStyle = var1.Color.Content.Emphasis,
                Text = tbl2.title,
                TextWrapped = true,
                Size = UDim2.new(1, 0, 0, 32),
                tag = "auto-xy"
            })
        }),
        Content = React.createElement(
            View,
            {
                ClipsDescendants = true,
                Size = if tbl2.buttonProps then UDim2.new(1, 0, 1, -116 - num1) else UDim2.new(1, 0, 1, -84 - num1),
                tag = "padding-x-medium",
                LayoutOrder = 2
            },
            {
                MiddleContent = React.createElement(View, { tag = "size-full" }, tbl2.children)
            }
        ),
        ButtonRow = tbl2.buttonProps
            and React.createElement(
                View,
                {
                    Size = UDim2.new(1, 0, 0, 32),
                    tag = "padding-x-medium padding-bottom-medium",
                    LayoutOrder = 3
                },
                {
                    Button = React.createElement(Button, {
                        text = tbl2.buttonProps.text,
                        variant = ButtonVariant.Emphasis,
                        onActivated = var2,
                        isDisabled = false,
                        size = ButtonSize.Small,
                        fillBehavior = FillBehavior.Fill
                    })
                }
            ),
        BottomFrame = if tbl2.footerContent then React.createElement(View, {
            Size = UDim2.new(1, 0, 0, 32),
            tag = "padding-x-medium padding-bottom-medium",
            LayoutOrder = 4,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y
        }, { FooterContent = footerContent }) else nil
    }
    tbl6.SideModal = createElement3(var19, tbl7, tbl8)
    tbl4.SideModalContainer = createElement2(var18, tbl5, tbl6)
    return createElement(str1, tbl3, tbl4)
end

return SideModal
