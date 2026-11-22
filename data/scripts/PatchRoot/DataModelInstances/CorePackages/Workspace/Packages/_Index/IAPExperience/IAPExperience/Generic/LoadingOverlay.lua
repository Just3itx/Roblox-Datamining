-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)
local _React = require(scriptParentParentParent.React)
local Otter = require(scriptParentParentParent.Otter)

local UIBlox = require(scriptParentParentParent.UIBlox)
local Foundation = require(scriptParentParentParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local withStyle = UIBlox.Core.Style.withStyle

local MultiTextLocalizer = require(scriptParentParent.Locale.MultiTextLocalizer)

local LoadingOverlayState = require(scriptParent.LoadingOverlayState)

local var1 = Roact.Component:extend(script.Name)

local tbl1 = { dampingRatio = 1, frequency = 1 }

function var1.init(arg1)
    local animationProgress, var3 = Roact.createBinding(0)

    arg1.motor = Otter.createSingleMotor(0)
    arg1.motor:start()

    arg1.motor:onStep(var3)
    arg1.animationProgress = animationProgress

    arg1.motor:setGoal(Otter.spring(if arg1.props.loadingState == nil then 0 else 1, tbl1))
end

function var1.getLoadingMessage(_, tbl2, arg1)
    if arg1 == LoadingOverlayState.PurchasingItem then
        return tbl2.PurchasingItem
    end

    if arg1 == LoadingOverlayState.PurchasingRobux then
        return tbl2.PurchasingRobux
    end

    if arg1 == LoadingOverlayState.WaitingForPurchase then
        return tbl2.WaitingForPurchase
    end

    if arg1 == LoadingOverlayState.WaitingForRobux then
        return tbl2.WaitingForRobux
    end

    return nil
end

function var1.didUpdate(tbl2, tbl3, _)
    local props = tbl2.props

    if tbl3.loadingState ~= props.loadingState then
        tbl2.motor:setGoal(Otter.spring(if props.loadingState == nil then 0 else 1, tbl1))
    end
end

function var1.willUnmount(arg1)
    arg1.motor:destroy()
end

function var1.render(arg1)
    return Roact.createElement(MultiTextLocalizer, {
        keys = {
            PurchasingItem = { key = "IAPExperience.Loading.Text.PurchasingItem" },
            PurchasingRobux = { key = "IAPExperience.Loading.Text.PurchasingRobux" },
            WaitingForPurchase = { key = "IAPExperience.Loading.Text.WaitingForPurchase" },
            WaitingForRobux = { key = "IAPExperience.Loading.Text.WaitingForRobux" }
        },
        render = function(tbl2)
            return arg1:renderAlert(tbl2)
        end
    })
end

function var1.renderAlert(tbl2, tbl3)
    local props = tbl2.props
    local bool1 = not (props.loadingState == LoadingOverlayState.None) and props.loadingState ~= nil
    local loadingMessage = tbl2:getLoadingMessage(tbl3, props.loadingState)

    return withStyle(function(arg1)
        local theme = arg1.Theme
        local font = arg1.Font
        local createElement = Roact.createElement

        local tbl4 = {
            BackgroundColor3 = theme.BackgroundUIContrast.Color,
            BackgroundTransparency = tbl2.animationProgress:map(function(arg2)
                if props.showOverlay then
                    if props.shouldAnimate then
                        return 1 - (1 - theme.BackgroundUIContrast.Transparency) * arg2
                    end

                    return theme.BackgroundUIContrast.Transparency
                end

                return 1
            end),
            Size = UDim2.new(1, 0, 1, 0),
            Visible = props.showOverlay
        }

        local tbl5 = {
            StopPropagationOverlay = Roact.createElement("TextButton", {
                Active = false,
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                Selectable = false,
                Size = UDim2.new(1, 0, 1, 0),
                Text = "",
                ZIndex = 0
            }),
            MiddleContent = 0,
            Children = 0
        }

        local createElement2 = Roact.createElement
        local tbl6 = {
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ZIndex = 1
        }

        local tbl7 = {
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 20),
                [Roact.Change.AbsoluteContentSize] = tbl2.onListLayoutAbsoluteContentSizeChanged
            }),
            Spinner = bool1
                and Roact.createElement(
                    Loading,
                    {
                        size = IconSize.Large,
                        Position = UDim2.fromScale(0.5, 0.5),
                        AnchorPoint = Vector2.new(0.5, 0.5)
                    }
                )
                or nil,
            PreText = loadingMessage
                and Roact.createElement("TextLabel", {
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextWrapped = true,
                    FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                    Text = loadingMessage,
                    TextSize = font.BaseSize * font.Body.RelativeSize,
                    TextColor3 = theme.TextDefault.Color,
                    TextTransparency = theme.TextDefault.Transparency
                })
                or nil
        }
        tbl5.MiddleContent = createElement2("Frame", tbl6, tbl7)

        tbl5.Children = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundTransparency = 1
            },
            tbl2.props[Roact.Children]
        )
        return createElement("Frame", tbl4, tbl5)
    end)
end

return var1
