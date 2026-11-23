-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local GamepadService = game:GetService("GamepadService")
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")

local AppBlox = script:FindFirstAncestor("AppBlox")
local AppBloxParent = AppBlox.Parent
local CenterOnFocusScroll = require(AppBlox.CenterOnFocusScroll)
local FFlagLuaAppMediaGalleryGamepadSupport = require(AppBloxParent.SharedFlags).FFlagLuaAppMediaGalleryGamepadSupport
local bool1 = game:DefineFastFlag("AnimateScrollViewIgnoreStaleSelection", false)

function AnimateScrollViewToSelectionHelper(instance: Instance, time: number, func1: ((...any) -> (...any))?, bool2: boolean?)
    local tbl1 = {}
    local var1 = nil

    if not instance then
        return tbl1
    end

    local absolutePositionY = instance.AbsolutePosition.Y
    local absoluteWindowSizeY = instance.AbsoluteWindowSize.Y

    local absolutePositionChanged = instance:GetPropertyChangedSignal("AbsolutePosition")

    table.insert(tbl1, absolutePositionChanged:Connect(function()
        absolutePositionY = instance.AbsolutePosition.Y
    end))

    local absoluteWindowSizeChanged = instance:GetPropertyChangedSignal("AbsoluteWindowSize")

    table.insert(tbl1, absoluteWindowSizeChanged:Connect(function()
        absoluteWindowSizeY = instance.AbsoluteWindowSize.Y
    end))

    local selectionChanged = instance.SelectionChanged

    table.insert(tbl1, selectionChanged:Connect(function(_, _, arg1)
        if not arg1
            or not arg1:IsDescendantOf(instance)
            or GamepadService.GamepadCursorEnabled
            or bool1 and arg1 ~= GuiService.SelectedCoreObject and arg1 ~= GuiService.SelectedObject
        then
            return
        end

        if var1 then
            var1:Cancel()
            var1 = nil
        end

        local absoluteSizeY = arg1.AbsoluteSize.Y
        local absolutePositionY2 = arg1.AbsolutePosition.Y
        local canvasPosition = instance.CanvasPosition
        local var2

        if FFlagLuaAppMediaGalleryGamepadSupport and bool2 then
            local revealOnlyCanvasY = CenterOnFocusScroll.getRevealOnlyCanvasY(
                absolutePositionY2,
                absoluteSizeY,
                canvasPosition,
                absolutePositionY,
                absoluteWindowSizeY
            )
            if revealOnlyCanvasY == nil then
                return
            end
            var2 = Vector2.new(canvasPosition.X, revealOnlyCanvasY)
        else
            local var3 = absolutePositionY2 - (absoluteWindowSizeY * 0.5 - absoluteSizeY * 0.5 + absolutePositionY)
            var2 = Vector2.new(canvasPosition.X, canvasPosition.Y + var3)
        end

        if UserGameSettings.ReducedMotion or func1 and func1() then
            instance.CanvasPosition = var2
            return
        end

        var1 = TweenService:Create(
            instance,
            TweenInfo.new(time, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
            { CanvasPosition = var2 }
        )
        if var1 then
            var1:Play()
        end
    end))

    return tbl1, var1
end

return AnimateScrollViewToSelectionHelper
