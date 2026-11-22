-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)

local getCommentsSheetStore = require(Moments.Components.Comments.Sheet.getCommentsSheetStore)
local GetMomentsPreferencesStore = require(Moments.Stores.GetMomentsPreferencesStore)
local MomentContext = require(script.Parent.Parent.MomentContext)
local computeVideoLiftLayout = require(script.Parent.computeVideoLiftLayout)

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local usePreferences = Foundation.Hooks.usePreferences
local useTokens = Foundation.Hooks.useTokens
local getSmartFillScaleType = MomentsCommon.Utils.getSmartFillScaleType

local FFlagMomentsSmartVideoFill = MomentsCommon.Flags.FFlagMomentsSmartVideoFill

local uDim2 = UDim2.fromScale(1, 1)
local uDim2_2 = UDim2.fromScale(0.5, 0.5)

local function scaleLayout(arg1, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        scale = 1 + (arg1.scale - 1) * num1,
        offsetY = arg1.offsetY * num1,
        cornerRadius = arg1.cornerRadius * num1
    }
end

local function useSettlingLayout(arg1, num1: number): number
    local var1, var2 = React.useBinding(arg1(false))

    React.useLayoutEffect(function()
        local connection = nil
        local function stopSettling() -- Luacid: Inlined by compiler; 3 call sites recovered
            if connection ~= nil then
                connection:Disconnect()
                connection = nil
            end
        end

        local function settle()
            local value = var1:getValue()
            if value == nil or connection ~= nil then
                return
            end

            if num1 <= 0 then
                var2(nil)
                return
            end

            local num2 = 0
            connection = RunService.Heartbeat:Connect(function(deltaTime: number)
                num2 += deltaTime
                local alpha = num2 / num1
                if alpha >= 1 then
                    stopSettling()
                    var2(nil)
                    return
                end
                local value2 = TweenService:GetValue(alpha, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                var2((scaleLayout(value, 1 - value2)))
            end)
        end

        local effect = Signals.createEffect(function(arg2)
            local var3 = arg1(arg2)
            if var3 == nil then
                settle()
                return
            end

            stopSettling()
            var2(var3)
        end)

        return function()
            stopSettling()
            effect()
        end
    end, {
        arg1,
        num1,
        var1,
        var2
    })
    return var1
end

local function useVideoLiftViewModel(str1: string?)
    local var1 = useTokens()
    local small = var1.Padding.Small
    local medium = var1.Radius.Medium
    local var2 = if usePreferences().reducedMotion then 0 else var1.Time.Time_200
    local controller = MomentContext.useMoment().controller

    local var3 = React.useMemo(function()
        local getTop, var4 = Signals.createSignal(0)
        local getSize, var6 = Signals.createSignal(Vector2.zero)
        return {
            getTop = getTop,
            getSize = getSize,
            onChanged = function(arg1)
                var4(arg1.AbsolutePosition.Y)
                var6(arg1.AbsoluteSize)
            end
        }
    end, {})

    local var4 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local commentsSheetStore = getCommentsSheetStore(false)
            if str1 == nil or commentsSheetStore.getFeedItemId(arg1) ~= str1 then
                return nil
            end
            local lift = commentsSheetStore.getVideoLift(arg1)
            if lift == nil then
                return nil
            end
            local var4 = computeVideoLiftLayout
            local tbl1 = {
                lift = lift,
                itemTop = var3.getTop(arg1),
                itemSize = var3.getSize(arg1),
                resolution = if controller == nil then nil else controller.getState(arg1).resolution,
                scaleType = if FFlagMomentsSmartVideoFill then getSmartFillScaleType(
                    GetMomentsPreferencesStore(false).getMediaScaleType(arg1),
                    var3.getSize(arg1),
                    if controller == nil then nil else controller.getState(arg1).resolution
                ) else GetMomentsPreferencesStore(false).getMediaScaleType(arg1),
                padding = small,
                cornerRadius = medium
            }
            return var4(tbl1)
        end)
    end, {
        str1 or false,
        controller or false,
        var3,
        small,
        medium
    })
    local var5 = useSettlingLayout(var4, var2)

    return React.useMemo(function()
        return {
            size = var5:map(function(arg1)
                if arg1 ~= nil then
                    return UDim2.fromScale(arg1.scale, arg1.scale)
                end

                return uDim2
            end),
            position = var5:map(function(arg1)
                if arg1 ~= nil then
                    return UDim2.new(0.5, 0, 0.5, arg1.offsetY)
                end

                return uDim2_2
            end),
            mediaSurface = {
                cornerRadius = var5:map(function(arg1): UDim
                    return UDim.new(0, if arg1 == nil then 0 else arg1.cornerRadius)
                end)
            },
            onItemRectChanged = var3.onChanged
        }
    end, { var5, var3 })
end

return useVideoLiftViewModel
