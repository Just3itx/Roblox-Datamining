-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local GameOptions = settings():FindFirstChild("Game Options")
local UserInputService = game:GetService("UserInputService")
local PlatformService = nil
pcall(function()
    PlatformService = game:GetService("PlatformService")
end)

local Modules = game:GetService("CoreGui").RobloxGui.Modules

local React = require(CorePackages.Packages.React)
local Utility = require(Modules.Shell.Utility)

local ContextActionEvent = require(Modules.Shell.Components.ContextActionEvent)
local ExternalEventConnection = require(CorePackages.Workspace.Packages.RoactUtils).ExternalEventConnection
local RenderStep = require(Modules.Shell.Components.RenderStep)

local engineFeature = game:GetEngineFeature("MigrateOverscanToGameBasicSettings")

local vector2 = Vector2.new(0.85, 0.85)
local vector2_2 = Vector2.new(0.9, 0.9)

local vector2_3 = Vector2.new(1920, 1080)
local vector2_4 = Vector2.new(0, 0)

local function EdgeImage(arg1)
    return React.createElement("ImageLabel", {
        Size = UDim2.new(0, 95, 0, 95),
        Position = arg1.Position,
        AnchorPoint = arg1.AnchorPoint,
        BackgroundTransparency = 1,
        Rotation = arg1.Rotation,
        Image = "rbxasset://textures/ui/Shell/ScreenAdjustment/ScreenAdjustmentArrow.png"
    })
end

local var1 = React.Component:extend("Edges")

function var1.init(arg1)
    local function getCurrentEdgePercent(vector2_5: Vector2) -- Luacid: Inlined by compiler; 4 call sites recovered
        return Utility.ClampVector2(vector2, Vector2.new(1, 1), vector2_5)
    end

    local function getCurrentEdgeSize(arg2) -- Luacid: Inlined by compiler; 3 call sites recovered
        local var2 = arg2 * vector2_3
        local var3 = Vector2.new(Utility.Round(var2.X / 2), Utility.Round(var2.Y / 2)) * 2
        return Utility.ClampVector2(vector2_4, vector2_3, var3)
    end

    function arg1.onAdjustThumbstick(_, _, arg2)
        arg1._stickPosition = Utility.GamepadLinearToCurve(Vector2.new(arg2.Position.X, -arg2.Position.Y), 0.2)
    end

    function arg1.onAccept()
        local _success, _result = pcall(function()
            if engineFeature then
                local var2 = UserGameSettings
                var2.Overscan = Vector2.new(math.min(1, arg1._edgePercent.X), math.min(1, arg1._edgePercent.Y))
                return
            end

            local var2 = GameOptions
            var2.OverscanPX = math.min(1, arg1._edgePercent.X)
            local var3 = GameOptions
            var3.OverscanPY = math.min(1, arg1._edgePercent.Y)
        end)

        if arg1.props.onSetEdges then
            arg1.props.onSetEdges()
        end
    end

    function arg1.onRenderStep()
        local _lastUpdate = tick()
        if arg1._lastUpdate then
            if arg1._stickPosition ~= vector2_4 then
                local var2 = _lastUpdate - arg1._lastUpdate
                local var3 = arg1._stickPosition * arg1._acceleration * var2 * 0.05
                arg1._edgePercent = getCurrentEdgePercent(var3 + arg1._edgePercent)
                local var4 = arg1
                var4._acceleration = math.min(arg1._acceleration + var2 * 1, 3)

                arg1:setState({ currentSize = getCurrentEdgeSize(arg1._edgePercent) })
            else
                arg1._acceleration = 1
            end
        end
        arg1._lastUpdate = _lastUpdate
    end

    function arg1.onSuspended()
        pcall(function()
            if engineFeature then
                UserGameSettings.Overscan = Vector2.new(arg1._lastSavedOverscan.X, arg1._lastSavedOverscan.Y)
                return
            end
            GameOptions.OverscanPX = arg1._lastSavedOverscan.X
            GameOptions.OverscanPY = arg1._lastSavedOverscan.Y
        end)
    end

    local currentEdgePercent = getCurrentEdgePercent(vector2_2)
    local var2 = currentEdgePercent * vector2_3
    local var3 = Vector2.new(Utility.Round(var2.X / 2), Utility.Round(var2.Y / 2)) * 2
    local var4 = Utility.ClampVector2(vector2_4, vector2_3, var3)

    if UserInputService:GetPlatform() == Enum.Platform.XBoxOne then
        pcall(function()
            if engineFeature then
                if UserGameSettings.Overscan.x > 0 and UserGameSettings.Overscan.y > 0 then
                    currentEdgePercent = Vector2.new(UserGameSettings.Overscan.x, UserGameSettings.Overscan.y)
                    currentEdgePercent = getCurrentEdgePercent(currentEdgePercent)
                    var4 = getCurrentEdgeSize(currentEdgePercent)

                    arg1._lastSavedOverscan = Vector2.new(UserGameSettings.Overscan.x, UserGameSettings.Overscan.y)
                    UserGameSettings.Overscan = Vector2.new(1, 1)
                end
            elseif GameOptions.OverscanPX > 0 and GameOptions.OverscanPY > 0 then
                currentEdgePercent = Vector2.new(GameOptions.OverscanPX, GameOptions.OverscanPY)
                currentEdgePercent = getCurrentEdgePercent(currentEdgePercent)
                var4 = getCurrentEdgeSize(currentEdgePercent)

                arg1._lastSavedOverscan = Vector2.new(GameOptions.OverscanPX, GameOptions.OverscanPY)
                GameOptions.OverscanPX = 1
                GameOptions.OverscanPY = 1
            end
        end)
    end

    arg1._stickPosition = vector2_4
    arg1._edgePercent = currentEdgePercent
    arg1._lastUpdate = nil
    arg1._acceleration = 1
    arg1._seenAPressed = false

    arg1.state = { currentSize = var4 }
end

function var1.render(arg1)
    return React.createElement("Frame", {
        Size = UDim2.new(0, arg1.state.currentSize.X, 0, arg1.state.currentSize.Y),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1
    }, {
        SelectionImage = React.createElement("ImageLabel", {
            Size = UDim2.new(1, 2, 1, 2),
            Position = UDim2.new(0, -1, 0, -1),
            BackgroundTransparency = 1,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(21, 21, 41, 41),
            Image = "rbxasset://textures/ui/Shell/ScreenAdjustment/ScreenRangeOverlay.png"
        }),
        TopLeft = React.createElement(EdgeImage, { Rotation = 0, Position = UDim2.new(0, 0, 0, 0), AnchorPoint = Vector2.new(0, 0) }),
        TopRight = React.createElement(EdgeImage, { Rotation = 90, Position = UDim2.new(1, 0, 0, 0), AnchorPoint = Vector2.new(1, 0) }),
        BottomRight = React.createElement(EdgeImage, { Rotation = 180, Position = UDim2.new(1, 0, 1, 0), AnchorPoint = Vector2.new(1, 1) }),
        BottomLeft = React.createElement(EdgeImage, { Rotation = 270, Position = UDim2.new(0, 0, 1, 0), AnchorPoint = Vector2.new(0, 1) }),
        Render = React.createElement(
            RenderStep,
            {
                name = "UpdateAdjustmentScreen",
                priority = Enum.RenderPriority.Input.Value,
                callback = arg1.onRenderStep
            }
        ),
        AdjustConnectorThumbstick = React.createElement(
            ContextActionEvent,
            {
                name = "ThumbstickAdjustmentScreen",
                callback = arg1.onAdjustThumbstick,
                binds = { Enum.KeyCode.Thumbstick2 }
            }
        ),
        SuspendedCn = PlatformService
            and React.createElement(ExternalEventConnection, { event = PlatformService.Suspended, callback = arg1.onSuspended })
    })
end

return var1
