-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local View = Foundation.View

local function renderPanel(str1: string, hole, color3: Color3, func1: (...any) -> (...any), func2: (...any) -> (...any))
    local uDim2 = if str1 == "Top" then UDim2.fromScale(1, 1) else UDim2.new()

    return React.createElement(View, {
        Position = if hole == nil then nil else hole:map(function(rect: Rect?)
            if rect ~= nil then
                return (func1(rect))
            end

            return UDim2.new()
        end),
        Size = if hole == nil then uDim2 else hole:map(function(rect: Rect?)
            if rect ~= nil then
                return (func2(rect))
            end

            return uDim2
        end),
        backgroundStyle = { Color3 = color3, Transparency = 0 },
        testId = `Library.WorldBackdrop.{str1}`
    })
end

local function LibraryWorldBackdropView(tbl1)
    local hole = tbl1.hole
    local thickness = tbl1.progress:map(function(num1: number)
        return tbl1.cornerRadius * (1 - math.clamp(num1, 0, 1))
    end)
    return React.createElement(View, {
        Visible = tbl1.Visible,
        ZIndex = tbl1.ZIndex,
        GroupTransparency = tbl1.transparency,
        tag = "size-full clip",
        testId = "Library.WorldBackdrop"
    }, {
        Top = renderPanel("Top", hole, tbl1.color, function(): UDim2
            return UDim2.new()
        end, function(arg1)
            return UDim2.new(1, 0, 0, math.max(0, arg1.Min.Y))
        end),
        Bottom = renderPanel("Bottom", hole, tbl1.color, function(arg1): UDim2
            return UDim2.fromOffset(0, arg1.Max.Y)
        end, function(arg1)
            return UDim2.new(1, 0, 1, math.max(0, -arg1.Max.Y))
        end),
        Left = renderPanel("Left", hole, tbl1.color, function(arg1): UDim2
            return UDim2.fromOffset(0, arg1.Min.Y)
        end, function(arg1)
            return UDim2.fromOffset(math.max(0, arg1.Min.X), math.max(0, arg1.Height))
        end),
        Right = renderPanel("Right", hole, tbl1.color, function(arg1): UDim2
            return UDim2.fromOffset(arg1.Max.X, arg1.Min.Y)
        end, function(arg1)
            return UDim2.new(1, math.max(0, -arg1.Max.X), 0, math.max(0, arg1.Height))
        end),
        Corners = if hole == nil then nil else React.createElement(View, {
            Visible = hole:map(function(rect: Rect?): boolean
                return rect ~= nil
            end),
            Position = hole:map(function(rect: Rect?): UDim2
                if rect ~= nil then
                    return UDim2.fromOffset(rect.Min.X, rect.Min.Y)
                end

                return UDim2.new()
            end),
            Size = hole:map(function(rect: Rect?): UDim2
                if rect ~= nil then
                    return UDim2.fromOffset(rect.Width, rect.Height)
                end

                return UDim2.new()
            end),
            backgroundStyle = { Transparency = 1 },
            cornerRadius = thickness:map(function(offset: number): UDim
                return UDim.new(0, offset)
            end),
            stroke = {
                Color = tbl1.color,
                Thickness = thickness,
                Transparency = 0,
                BorderStrokePosition = Enum.BorderStrokePosition.Outer
            },
            testId = "Library.WorldBackdrop.Corners"
        })
    })
end

return LibraryWorldBackdropView
