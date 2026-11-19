-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local ObservableValue = require(ChromeShared.Service.ChromeUtils).ObservableValue

local observableValue = ObservableValue.new(Vector2.new(0, 0))
local observableValue2 = ObservableValue.new(false)
local connection = nil

function createViewportInfo(vector2: Vector2)
    local portraitOrientation = vector2.Y > vector2.X
    local platform = UserInputService:GetPlatform()
    local isMobileDevice = platform == Enum.Platform.IOS or platform == Enum.Platform.Android
    return {
        size = vector2,
        portraitOrientation = portraitOrientation,
        tinyPortrait = isMobileDevice and portraitOrientation and vector2.X < 360,
        isMobileDevice = isMobileDevice
    }
end

local observableValue3 = ObservableValue.new(createViewportInfo(Vector2.zero))

function updateViewportSize(vector2: Vector2)
    local vector2_2 = Vector2.new(vector2.X, vector2.Y)
    observableValue:set(vector2_2)
    observableValue3:set(createViewportInfo(vector2_2))
end

function setCurrentCamera(currentCamera)
    if connection then
        pcall(function()
            connection:Disconnect()
        end)
        connection = nil
    end

    if not currentCamera then
        return
    end

    local platform = UserInputService:GetPlatform()
    observableValue2:set(platform == Enum.Platform.IOS or platform == Enum.Platform.Android)
    connection = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        updateViewportSize(currentCamera.ViewportSize)
    end)
    updateViewportSize(currentCamera.ViewportSize)
end

Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    setCurrentCamera(Workspace.CurrentCamera)
end)
setCurrentCamera(Workspace.CurrentCamera)

return {
    screenSize = observableValue,
    mobileDevice = observableValue2,
    viewport = observableValue3,
    isSmallTouchScreen = function(): boolean
        local var1 = observableValue:get()
        return UserInputService.TouchEnabled and (var1.Y < 500 or var1.X < 700)
    end
}
