-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local ContextActionService = game:GetService("ContextActionService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local GameSettings = UserSettings().GameSettings

local SendNotificationInfo = CoreGui:WaitForChild("RobloxGui"):WaitForChild("SendNotificationInfo")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local selectionParent = nil

local function LocalizedGetString(arg1, arg2) -- Luacid: unused: defined but never referenced
    pcall(function()
        arg2 = RobloxTranslator:FormatByKey(arg1)
    end)
    return arg2
end

local function ScrollSelectedElement(_: string, userInputState: Enum.UserInputState, inputObject: InputObject)
    if userInputState ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass
    end

    local selectedObject = GuiService.SelectedObject

    if selectedObject == nil then
        return Enum.ContextActionResult.Pass
    end

    local var1 = nil
    if selectedObject.ClassName ~= "ScrollingFrame" then
        selectedObject = selectedObject:FindFirstAncestorOfClass("ScrollingFrame")
        if selectedObject == nil then
            selectedObject = var1
        end
    end

    if selectedObject == nil then
        return Enum.ContextActionResult.Pass
    end

    local num1 = 0
    if inputObject.KeyCode == Enum.KeyCode.PageUp or inputObject.KeyCode == Enum.KeyCode.Home then
        num1 = -100
    elseif inputObject.KeyCode == Enum.KeyCode.PageDown or inputObject.KeyCode == Enum.KeyCode.End then
        num1 = 100
    end

    local canvasPositionX = selectedObject.CanvasPosition.X
    local canvasPositionY = selectedObject.CanvasPosition.Y
    if inputObject.KeyCode == Enum.KeyCode.PageUp or inputObject.KeyCode == Enum.KeyCode.PageDown then
        canvasPositionY = math.max(0, math.min(canvasPositionY + num1, selectedObject.AbsoluteCanvasSize.Y))
    elseif inputObject.KeyCode == Enum.KeyCode.Home or inputObject.KeyCode == Enum.KeyCode.End then
        canvasPositionX = math.max(0, math.min(canvasPositionX + num1, selectedObject.AbsoluteCanvasSize.X))
    end
    selectedObject.CanvasPosition = Vector2.new(canvasPositionX, canvasPositionY)

    return Enum.ContextActionResult.Pass
end

local function EnableKeyboardNavigation(_: string, userInputState: Enum.UserInputState, _inputObject: InputObject)
    if not GameSettings.UiNavigationKeyBindEnabled then
        return Enum.ContextActionResult.Pass
    end

    if userInputState ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass
    end

    if not GuiService.AutoSelectGuiEnabled then
        return Enum.ContextActionResult.Pass
    end

    if GuiService.SelectedObject then
        GuiService.SelectedObject = nil
        return Enum.ContextActionResult.Sink
    end

    if selectionParent == nil then
        selectionParent = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
    end
    GuiService:Select(selectionParent)

    if GuiService.SelectedObject then
        local var1 = nil
        local str1 = "InGame.NotificationScript2.UINavigation.Title"

        pcall(function()
            var1 = RobloxTranslator:FormatByKey(str1)
        end)
        local title = var1

        local var3 = nil
        local str2 = "InGame.NotificationScript2.UINavigation.Text"

        pcall(function()
            var3 = RobloxTranslator:FormatByKey(str2)
        end)
        SendNotificationInfo:Fire({ Title = title, Text = var3, Duration = 3 })
    end

    return Enum.ContextActionResult.Sink
end

local tbl1 = {}
tbl1.__index = tbl1
function tbl1.new()
    local self = setmetatable({}, tbl1)
    ContextActionService:BindAction("EnableKeyboardUINavigation", EnableKeyboardNavigation, false, Enum.KeyCode.BackSlash)
    ContextActionService:BindAction(
        "ScrollSelectedElement",
        ScrollSelectedElement,
        false,
        Enum.KeyCode.PageUp,
        Enum.KeyCode.PageDown,
        Enum.KeyCode.Home,
        Enum.KeyCode.End
    )
    GameSettings:GetPropertyChangedSignal("UiNavigationKeyBindEnabled"):Connect(function()
        if not GameSettings.UiNavigationKeyBindEnabled then
            GuiService.SelectedObject = nil
        end
    end)
    return self
end
return tbl1.new()
