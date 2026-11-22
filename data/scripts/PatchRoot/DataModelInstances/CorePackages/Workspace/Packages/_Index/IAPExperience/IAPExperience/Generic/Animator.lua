-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Localization = require(scriptParentParentParent.RobloxAppLocales).Localization
local LocaleProvider = require(scriptParentParent.Locale.LocaleProvider)
local LocalizationProvider = require(scriptParentParentParent.Localization).LocalizationProvider

local Roact = require(scriptParentParentParent.Roact)
local Otter = require(scriptParentParentParent.Otter)

local var1 = Roact.Component:extend(script.Name)

local tbl1 = { dampingRatio = 1, frequency = 1.6 }

function var1.init(arg1)
    arg1.state = {
        shouldRenderChildren = arg1.props.shouldShow
    }

    local animationProgress, var3 = Roact.createBinding(1)

    arg1.motor = Otter.createSingleMotor(1)
    arg1.motor:start()

    arg1.motor:onStep(var3)
    arg1.animationProgress = animationProgress

    arg1.motor:onComplete(function()
        local props = arg1.props
        if props.shouldShow then
            if props.onShown ~= nil then
                props.onShown()
            end

            return
        end

        arg1:setState({ shouldRenderChildren = false })

        if props.onHidden ~= nil then
            props.onHidden()
        end
    end)

    local num1 = if arg1.props.shouldShow then 0 else 1
    if arg1.props.skipAnimation then
        arg1.motor:setGoal(Otter.instant(num1))
        return
    end
    arg1.motor:setGoal(Otter.spring(num1, tbl1))
end

function var1.didUpdate(tbl2, tbl3, _)
    local props = tbl2.props

    if tbl3.shouldShow == props.shouldShow then
        return
    end

    if props.shouldShow then
        tbl2:setState({ shouldRenderChildren = props.shouldShow })
    end

    local num1 = if tbl2.props.shouldShow then 0 else 1
    if tbl2.props.skipAnimation then
        tbl2.motor:setGoal(Otter.instant(num1))
        return
    end
    tbl2.motor:setGoal(Otter.spring(num1, tbl1))
end

function var1.willUnmount(arg1)
    arg1.motor:destroy()
end

function var1.renderWithoutLocale(arg1)
    local props = arg1.props

    if not props.shouldAnimate then
        if props.shouldShow then
            return props.renderChildren()
        end
        return nil
    end

    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Position = arg1.animationProgress:map(function(arg2): UDim2
            if props.animateDown then
                return UDim2.new(0, 0, -1 * arg2, 0)
            end
            return UDim2.new(0, 0, 1 * arg2, 0)
        end),
        ZIndex = props.ZIndex
    }, arg1.state.shouldRenderChildren and props.renderChildren() or nil)
end

function var1.render(arg1)
    return Roact.createElement(LocaleProvider, {
        locale = LocalizationService and LocalizationService.RobloxLocaleId
    }, { Roact.createElement(
            LocalizationProvider,
            {
                localization = Localization.new(LocalizationService.RobloxLocaleId)
            },
            { arg1:renderWithoutLocale() }
        ) })
end

return var1
