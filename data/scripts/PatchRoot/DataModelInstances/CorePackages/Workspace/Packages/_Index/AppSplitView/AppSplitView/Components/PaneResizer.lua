-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:21:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local AppSplitViewParent = script:FindFirstAncestor("AppSplitView").Parent

local React = require(AppSplitViewParent.React)
local useTokens = require(AppSplitViewParent.Foundation).Hooks.useTokens

local function VisualPaneResizer(tbl1)
    local var1 = useTokens()
    local name = tbl1.Name or "PaneResizer"
    local lineTopInset = tbl1.lineTopInset or 0

    return React.createElement("Frame", {
        Name = name,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = false,
        Position = tbl1.position,
        Size = UDim2.new(0, tbl1.hitWidth, 1, 0),
        ZIndex = tbl1.ZIndex
    }, {
        Line = React.createElement("Frame", {
            Name = "Line",
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, lineTopInset),
            Size = UDim2.new(0, 1, 1, -lineTopInset),
            BackgroundColor3 = var1.Color.Stroke.Emphasis.Color3,
            BackgroundTransparency = var1.Color.Stroke.Emphasis.Transparency,
            BorderSizePixel = 0,
            Active = false
        })
    })
end

local function InteractivePaneResizer(tbl1)
    local var1 = useTokens()
    local name = tbl1.Name or "PaneResizer"
    local lineTopInset = tbl1.lineTopInset or 0

    local var2, var3 = React.useBinding(false)

    local var4 = React.useRef(tbl1.onDrag)
    local var5 = React.useRef(tbl1.onDragStart)
    local var6 = React.useRef(tbl1.onDragEnd)
    var4.current = tbl1.onDrag
    var5.current = tbl1.onDragStart
    var6.current = tbl1.onDragEnd

    local var7 = React.useRef(false)
    local var8 = React.useRef(false)
    local var9 = React.useCallback(function()
        var3(var7.current or var8.current)
    end, {})

    local var10 = React.useCallback(function(_, arg1)
        if arg1.UserInputType ~= Enum.UserInputType.MouseButton1 and arg1.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local position = arg1.Position
        var7.current = true
        var9()
        if var5.current then
            var5.current()
        end

        local connection = nil

        local connection2 = UserInputService.InputChanged:Connect(function(input: InputObject)
            if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
                return
            end
            if var4.current then
                local var10 = input.Position - position
                position = input.Position
                var4.current(Vector2.new(var10.X, var10.Y))
            end
        end)

        connection = arg1.Changed:Connect(function(str1: string)
            if str1 ~= "UserInputState" or arg1.UserInputState ~= Enum.UserInputState.End then
                return
            end

            if connection2 then
                connection2:Disconnect()
            end
            if connection then
                connection:Disconnect()
            end
            var7.current = false
            var9()
            if var6.current then
                var6.current()
            end
        end)
    end, { var9 })

    local var11 = React.useCallback(function(_, _)
        var8.current = true
        var9()
    end, { var9 })
    local var12 = React.useCallback(function(_, _)
        var8.current = false
        var9()
    end, { var9 })

    local backgroundColor3 = var2:map(function(arg1)
        if arg1 then
            return var1.Color.System.Emphasis.Color3
        end

        return var1.Color.Stroke.Emphasis.Color3
    end)

    local backgroundTransparency = var2:map(function(arg1)
        if arg1 then
            return var1.Color.System.Emphasis.Transparency
        end

        return var1.Color.Stroke.Emphasis.Transparency
    end)

    return React.createElement("TextButton", {
        Name = name,
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = true,
        Position = tbl1.position,
        Size = UDim2.new(0, tbl1.hitWidth, 1, 0),
        ZIndex = tbl1.ZIndex,
        [React.Event.InputBegan] = var10,
        [React.Event.MouseEnter] = var11,
        [React.Event.MouseLeave] = var12
    }, {
        Line = React.createElement("Frame", {
            Name = "Line",
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, lineTopInset),
            Size = UDim2.new(0, 1, 1, -lineTopInset),
            BackgroundColor3 = backgroundColor3,
            BackgroundTransparency = backgroundTransparency,
            BorderSizePixel = 0,
            Active = false
        })
    })
end

return React.memo(function(tbl1) -- name: PaneResizer
    if tbl1.interactive == false then
        return React.createElement(VisualPaneResizer, tbl1)
    end
    return React.createElement(InteractivePaneResizer, tbl1)
end)
