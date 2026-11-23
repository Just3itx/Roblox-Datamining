-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local TweenService = game:GetService("TweenService")
local AppBlox = script:FindFirstAncestor("AppBlox")
local AppBloxParent = AppBlox.Parent
local React = require(AppBloxParent.React)
local GamepadService = game:GetService("GamepadService")

local SharedFlags = require(AppBloxParent.SharedFlags)
local FFlagUseAnimateScrollViewToSelectionHelper = SharedFlags.FFlagUseAnimateScrollViewToSelectionHelper
local FFlagLuaAppMediaGalleryGamepadSupport = SharedFlags.FFlagLuaAppMediaGalleryGamepadSupport
local AnimateScrollViewToSelectionHelper = require(AppBlox.AnimateScrollViewToSelectionHelper)

local function useAnimateScrollViewToSelection(tbl1, time: number, bool1: boolean?)
    if FFlagUseAnimateScrollViewToSelectionHelper then
        local useEffect = React.useEffect
        local function func1()
            local var1 = nil
            local tbl2 = {}
            if tbl1 then
                local var2 = AnimateScrollViewToSelectionHelper
                local current = tbl1.current
                tbl2, var1 = var2(current, time, nil, if FFlagLuaAppMediaGalleryGamepadSupport then bool1 else nil)
            end

            return function()
                for _, value in tbl2 do
                    value:Disconnect()
                end
                if var1 then
                    var1:Cancel()
                end
            end
        end

        local var1 = if FFlagLuaAppMediaGalleryGamepadSupport then bool1 else nil
        useEffect(func1, { tbl1, time, var1 })
        return
    end

    React.useEffect(function()
        local tbl2 = {}
        local var1 = nil

        local absolutePositionY = 0
        local absoluteWindowSizeY = 0
        if tbl1 and tbl1.current ~= nil then
            local current = tbl1.current
            absolutePositionY = current.AbsolutePosition.Y
            absoluteWindowSizeY = current.AbsoluteWindowSize.Y

            local absolutePositionChanged = current:GetPropertyChangedSignal("AbsolutePosition")

            table.insert(tbl2, absolutePositionChanged:Connect(function()
                absolutePositionY = current.AbsolutePosition.Y
            end))

            local absoluteWindowSizeChanged = current:GetPropertyChangedSignal("AbsoluteWindowSize")

            table.insert(tbl2, absoluteWindowSizeChanged:Connect(function()
                absoluteWindowSizeY = current.AbsoluteWindowSize.Y
            end))

            local selectionChanged = current.SelectionChanged

            table.insert(tbl2, selectionChanged:Connect(function(_, _, arg1)
                if arg1 == nil or not arg1:IsDescendantOf(current) or GamepadService.GamepadCursorEnabled then
                    return
                end

                if var1 then
                    var1:Cancel()
                    var1 = nil
                end

                local absoluteSizeY = arg1.AbsoluteSize.Y
                local var2 = arg1.AbsolutePosition.Y - (absoluteWindowSizeY * 0.5 - absoluteSizeY * 0.5 + absolutePositionY)
                local canvasPosition = current.CanvasPosition
                local vector2 = Vector2.new(canvasPosition.X, canvasPosition.Y + var2)

                if UserGameSettings.ReducedMotion then
                    current.CanvasPosition = vector2
                    return
                end

                var1 = TweenService:Create(
                    current,
                    TweenInfo.new(time, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
                    { CanvasPosition = vector2 }
                )
                if var1 then
                    var1:Play()
                end
            end))
        end

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
            if var1 then
                var1:Cancel()
            end
        end
    end, { tbl1, time })
end

return useAnimateScrollViewToSelection
