-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")

local tbl1 = ({})
local tbl2 = ({})
local screenGui = nil
local frame = nil

local tbl3 = {
    UDim2.new(0, 123, 0, 70),
    UDim2.new(0, 30, 0, 60),
    UDim2.new(0, 180, 0, 160),
    UDim2.new(0, 85, 0, -25),
    UDim2.new(0, 185, 0, -25),
    UDim2.new(0, 185, 0, 260),
    UDim2.new(0, 216, 0, 65)
}
local num1 = #tbl3

game:GetService("ContentProvider"):Preload("https://www.roblox.com/asset/?id=97166756")
game:GetService("ContentProvider"):Preload("https://www.roblox.com/asset/?id=97166444")

local CoreGui = game:GetService("CoreGui")
local _CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui.RobloxGui
local CoreUtility = require(RobloxGui.Modules.CoreUtility)

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players.ChildAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

local var1 = CoreUtility.waitForChildOfClass(LocalPlayer, "PlayerGui")

function createContextActionGui()
    if screenGui then
        return
    end

    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ContextActionGui"
    screenGui.ResetOnSpawn = false

    frame = Instance.new("Frame")
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(0.3, 0, 0.5, 0)
    frame.Position = UDim2.new(0.7, 0, 0.5, 0)
    frame.Name = "ContextButtonFrame"
    frame.Parent = screenGui
    local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
        local frame2 = frame
        frame2.Visible = UserInputService.PreferredInput == Enum.PreferredInput.Touch and GuiService.TouchControlsEnabled
    end

    GuiService:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(func1)
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(func1)
    func1()
end

function setButtonSizeAndPosition(arg1)
    local num2 = if game:GetService("CoreGui").RobloxGui.AbsoluteSize.X < 600 then 55 else 85

    arg1.Size = UDim2.new(0, num2, 0, num2)
end

function contextActionButtonDown(imageButton, inputObject: Instance, actionName: string)
    imageButton.Image = "https://www.roblox.com/asset/?id=97166756"
    ContextActionService:CallFunction(actionName, Enum.UserInputState.Begin, inputObject)
end

function contextActionButtonMoved(imageButton, inputObject: Instance, actionName: string)
    imageButton.Image = "https://www.roblox.com/asset/?id=97166756"
    ContextActionService:CallFunction(actionName, Enum.UserInputState.Change, inputObject)
end

function contextActionButtonUp(imageButton, inputObject: Instance, actionName: string)
    imageButton.Image = "https://www.roblox.com/asset/?id=97166444"
    ContextActionService:CallFunction(actionName, Enum.UserInputState.End, inputObject)
end

function contextActionButtonCancel(imageButton, inputObject: Instance, actionName: string)
    imageButton.Image = "https://www.roblox.com/asset/?id=97166444"
    ContextActionService:CallFunction(actionName, Enum.UserInputState.Cancel, inputObject)
end

function isSmallScreenDevice(): boolean
    return game:GetService("GuiService"):GetScreenResolution().Y <= 320
end

function createNewButton(arg1, arg2): ImageButton
    local contextActionButton = Instance.new("ImageButton")
    contextActionButton.Name = "ContextActionButton"
    contextActionButton.BackgroundTransparency = 1
    contextActionButton.Size = UDim2.new(0, 45, 0, 45)
    contextActionButton.Active = true
    if isSmallScreenDevice() then
        contextActionButton.Size = UDim2.new(0, 35, 0, 35)
    end
    contextActionButton.Image = "https://www.roblox.com/asset/?id=97166444"
    contextActionButton.Parent = frame

    local currentInput = nil
    local bool1 = false

    UserInputService.InputEnded:connect(function(input: InputObject)
        if input.UserInputType ~= Enum.UserInputType.Touch or currentInput ~= input then
            return
        end

        if input.UserInputState == Enum.UserInputState.End and bool1 then
            contextActionButtonCancel(contextActionButton, input, arg1)
        end
        currentInput = nil
        bool1 = false
    end)

    contextActionButton.InputBegan:connect(function(input: InputObject)
        if input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        if input.UserInputState == Enum.UserInputState.Begin then
            currentInput = input
            bool1 = false
            contextActionButtonDown(contextActionButton, input, arg1)
            return
        end

        if input.UserInputState ~= Enum.UserInputState.Change then
            return
        end

        if currentInput ~= input then
            return
        end

        bool1 = false
    end)

    contextActionButton.InputEnded:connect(function(input: InputObject)
        if input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        if currentInput ~= input then
            return
        end

        if input.UserInputState == Enum.UserInputState.End then
            currentInput = nil
            bool1 = false
            contextActionButtonUp(contextActionButton, input, arg1)
        elseif input.UserInputState == Enum.UserInputState.Change then
            bool1 = true
        end
    end)

    contextActionButton.InputChanged:connect(function(input: InputObject)
        if input.UserInputType == Enum.UserInputType.Touch and currentInput == input then
            contextActionButtonMoved(contextActionButton, input, arg1)
        end
    end)
    local actionIcon = Instance.new("ImageLabel")
    actionIcon.Name = "ActionIcon"
    actionIcon.Position = UDim2.new(0.175, 0, 0.175, 0)
    actionIcon.Size = UDim2.new(0.65, 0, 0.65, 0)
    actionIcon.BackgroundTransparency = 1
    if arg2.image and type(arg2.image) == "string" then
        actionIcon.Image = arg2.image
    end
    actionIcon.Parent = contextActionButton

    local actionTitle = Instance.new("TextLabel")
    actionTitle.Name = "ActionTitle"
    actionTitle.Size = UDim2.new(1, 0, 1, 0)
    actionTitle.BackgroundTransparency = 1
    actionTitle.Font = Enum.Font.SourceSansBold
    actionTitle.TextColor3 = Color3.new(1, 1, 1)
    actionTitle.TextStrokeTransparency = 0
    actionTitle.FontSize = Enum.FontSize.Size18
    actionTitle.TextWrapped = true
    actionTitle.Text = ""
    if arg2.title and type(arg2.title) == "string" then
        actionTitle.Text = arg2.title
    end
    actionTitle.Parent = contextActionButton

    return contextActionButton
end

function createButton(arg1, arg2)
    local var2 = nil
    for i = 1, #tbl2 do
        if tbl2[i] == "empty" then
            var2 = i
            break
        end
    end

    local var3 = var2 or #tbl2 + 1

    if num1 < var3 then
        warn("Maximum of 7 allowed touch buttons, new touch button not created for " .. arg1 .. ".")
        return
    end

    local button = createNewButton(arg1, arg2)

    tbl2[var3] = button
    tbl1[arg1].button = button

    button.Position = tbl3[var3]
    button.Parent = frame

    if not screenGui or screenGui.Parent ~= nil then
        return
    end

    screenGui.Parent = var1
    if not frame.Parent then
        frame.Parent = screenGui
    end
end

function removeAction(arg1)
    if not tbl1[arg1] then
        return
    end
    local button = tbl1[arg1].button

    if button then
        button.Parent = nil

        for i = 1, #tbl2 do
            if tbl2[i] == button then
                tbl2[i] = "empty"
                break
            end
        end

        button:Destroy()
    end

    tbl1[arg1] = nil
end

function addAction(arg1, createTouchButton, arg2)
    if tbl1[arg1] then
        removeAction(arg1)
    end
    tbl1[arg1] = { arg2 }
    if createTouchButton then
        createContextActionGui()
        createButton(arg1, arg2)
    end
end

ContextActionService.BoundActionChanged:connect(function(actionChanged: string, changeName: string, changeTable)
    if not tbl1[actionChanged] or not changeTable then
        return
    end

    local button = tbl1[actionChanged].button
    local var2 = changeTable[changeName]
    local var3 = if not var2 and (changeName == "image" or changeName == "title" or changeName == "description") then "" else var2

    if not button then
        return
    end

    if changeName == "image" then
        button.ActionIcon.Image = var3
        return
    elseif changeName == "title" then
        button.ActionTitle.Text = var3
        return
    elseif changeName == "description" then
        return
    end
    if changeName == "position" then
        button.Position = var3
    end
end)

ContextActionService.BoundActionAdded:connect(function(actionAdded: string, createTouchButton: boolean, functionInfoTable)
    addAction(actionAdded, createTouchButton, functionInfoTable)
end)

ContextActionService.BoundActionRemoved:connect(function(actionRemoved: string, _)
    removeAction(actionRemoved)
end)

ContextActionService.GetActionButtonEvent:connect(function(actionName: string)
    if tbl1[actionName] then
        ContextActionService:FireActionButtonFoundSignal(actionName, tbl1[actionName].button)
    end
end)

local allBoundActionInfo = ContextActionService:GetAllBoundActionInfo()
for k, value in pairs(allBoundActionInfo) do
    addAction(k, value.createTouchButton, value)

    if tbl1[k] and tbl1[k].button then
        ContextActionService:FireActionButtonFoundSignal(k, tbl1[k].button)
    end
end
