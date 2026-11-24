-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local scriptParent = script.Parent
local CreateTemporaryOverlay = require(scriptParent.CreateTemporaryOverlay)

local DisplayName = nil

local var1 = nil

local num1 = 0
local tbl1 = {}
local num2 = 1
local var2 = nil

local num3 = 50

local vec3 = Vector3.new(0, 0, 0)
local var3 = nil

local module = {}

function module.createSpectatorCamera(arg1)
    local inputFrame = Instance.new("Frame")
    inputFrame.Name = "InputFrame"

    inputFrame.Size = UDim2.new(0.4, 0, 0.15, 0)
    inputFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    inputFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    inputFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    inputFrame.BackgroundTransparency = 0.4
    inputFrame.BorderSizePixel = 0
    inputFrame.Visible = false
    inputFrame.Parent = arg1.screenGui

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Padding = UDim.new(0, 5)
    uiListLayout.Parent = inputFrame

    local speedLabel = Instance.new("TextLabel")
    speedLabel.Name = "SpeedLabel"

    speedLabel.Size = UDim2.new(0.9, 0, 0.3, 0)

    speedLabel.BackgroundTransparency = 1
    speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedLabel.Font = Enum.Font.SourceSans
    speedLabel.TextScaled = true

    speedLabel.Text = "Free Cam Speed (Current: " .. math.floor(num3) .. ") Between 10 And 20000"
    speedLabel.Parent = inputFrame

    local speedTextBox = Instance.new("TextBox")
    speedTextBox.Name = "SpeedTextBox"

    speedTextBox.Size = UDim2.new(0.9, 0, 0.25, 0)

    speedTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    speedTextBox.BackgroundTransparency = 0
    local num4 = math.floor(num3)
    speedTextBox.Text = tostring(num4)
    speedTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedTextBox.TextScaled = true

    speedTextBox.Font = Enum.Font.SourceSans
    speedTextBox.ClearTextOnFocus = true
    speedTextBox.TextXAlignment = Enum.TextXAlignment.Center
    speedTextBox.Parent = inputFrame

    local applyButton = Instance.new("TextButton")
    applyButton.Name = "ApplyButton"

    applyButton.Size = UDim2.new(0.9, 0, 0.25, 0)

    applyButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    applyButton.Text = "Apply Speed"
    applyButton.Font = Enum.Font.SourceSansBold
    applyButton.TextScaled = true

    applyButton.Parent = inputFrame

    applyButton.MouseButton1Click:Connect(function()
        local success, result = pcall(tonumber, speedTextBox.Text)
        if success and type(result) == "number" and result >= 10 and result <= 20000 then
            num3 = result
            speedLabel.Text = "Free Cam Speed (Current: " .. math.floor(num3) .. ") Between 10 And 20000"
            return
        end

        warn("Invalid speed input: " .. speedTextBox.Text .. ". Please enter a number between 10 and 20000.")
        local textBox = speedTextBox
        textBox.Text = tostring(math.floor(num3))
    end)

    local bool1 = false

    local function updateHumanoidList()
        tbl1 = {}

        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA("Humanoid") then
                table.insert(tbl1, descendant)
            end
        end
    end

    local function getCurrentHumanoid() -- Luacid: Inlined by compiler; 1 call site recovered
        updateHumanoidList()
        return if #tbl1 == 0 then nil else tbl1[num2]
    end

    local function getNextHumanoid() -- Luacid: Inlined by compiler; 1 call site recovered
        updateHumanoidList()
        if #tbl1 == 0 then
            return nil
        end

        num2 = num2 % #tbl1 + 1
        return tbl1[num2]
    end

    local function getHumanoidWithName(displayName) -- Luacid: Inlined by compiler; 1 call site recovered
        updateHumanoidList()
        if #tbl1 == 0 then
            return nil
        end

        for _, value in ipairs(tbl1) do
            if value.DisplayName == displayName then
                return value
            end
        end

        return nil
    end

    local function StepFreecam(num5: number)
        local num6 = num3
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            num6 = num3 * 3
        end

        local vec3_2 = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            vec3_2 += var1.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            vec3_2 -= var1.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            vec3_2 += var1.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            vec3_2 -= var1.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.E) then
            vec3_2 += Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
            vec3_2 -= Vector3.new(0, 1, 0)
        end

        if vec3_2.Magnitude > 0 then
            vec3_2 = vec3_2.Unit
        end

        local goal = vec3_2 * num6

        local alpha = 1 - math.exp(-10 * num5)
        vec3 = vec3:Lerp(goal, alpha)

        if goal.Magnitude == 0 and vec3.Magnitude < 0.1 then
            vec3 = Vector3.new(0, 0, 0)
        end

        var1 += vec3 * num5

        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter

            local vector2 = UserInputService:GetMouseDelta()
            local bool2 = var3 == nil and (vector2.X > 700 or vector2.Y > 300)
            local bool3 = not (var3 == nil) and (math.abs(vector2.X - var3.X) > 300 or math.abs(vector2.Y - var3.Y) > 150)
            var3 = vector2
            if not (bool2 or bool3) then
                local var4 = CFrame.Angles(0, math.rad(-vector2.X * 0.4), 0)
                local var5 = CFrame.Angles(math.rad(-vector2.Y * 0.4), 0, 0)

                local position = var1.Position

                local var6 = var4 * var1.Rotation * var5

                var1 = CFrame.new(position) * var6
            end
        else
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        end
        Workspace.CurrentCamera.CFrame = var1
    end

    local function setCameraMode(arg2)
        RunService:UnbindFromRenderStep("Freecam")

        UserInputService.MouseBehavior = Enum.MouseBehavior.Default

        inputFrame.Visible = false

        if DisplayName == nil then
            if Workspace.CurrentCamera.CameraSubject ~= nil then
                DisplayName = Workspace.CurrentCamera.CameraSubject.DisplayName
            else
                arg2 = math.max(1, arg2)
            end
        end

        if arg2 == 0 then
            Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
            local cameraSubject = getHumanoidWithName(DisplayName)
            if cameraSubject == nil then
                warn("Default humanoid not found: " .. tostring(DisplayName))
                setCameraMode(1)
                return
            end
            Workspace.CurrentCamera.CameraSubject = cameraSubject
            CreateTemporaryOverlay.showOverlay("Default Camera", 2, arg1.screenGui)
            return
        end

        if arg2 == 1 then
            Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
            Workspace.CurrentCamera.CameraSubject = nil
            var1 = Workspace.CurrentCamera.CFrame

            RunService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, StepFreecam)

            inputFrame.Visible = bool1
            local textBox = speedTextBox
            textBox.Text = tostring(math.floor(num3))
            speedLabel.Text = "Free Cam Speed (Current: " .. math.floor(num3) .. ") Between 10 And 20000"
            CreateTemporaryOverlay.showOverlay("Free Camera", 2, arg1.screenGui)
        elseif arg2 == 2 then
            var2 = getCurrentHumanoid()

            if var2 then
                Workspace.CurrentCamera.CameraType = Enum.CameraType.Follow
                Workspace.CurrentCamera.CameraSubject = var2
                CreateTemporaryOverlay.showOverlay("Follow " .. var2.DisplayName, 2, arg1.screenGui)
                return
            end

            num1 = 0
            setCameraMode(0)
        end
    end

    local function cycleCameraMode() -- Luacid: Inlined by compiler; 1 call site recovered
        num1 = (num1 + 1) % 3
        setCameraMode(num1)
    end

    local function onInputBegan(input: InputObject, gameProcessedEvent: boolean)
        if gameProcessedEvent then
            return
        end

        if input.KeyCode == Enum.KeyCode.C then
            cycleCameraMode()
        end

        if input.KeyCode == Enum.KeyCode.N and num1 == 2 then
            getNextHumanoid()
            setCameraMode(2)
        end

        if input.KeyCode ~= Enum.KeyCode.V or num1 ~= 1 then
            return
        end

        bool1 = not bool1
        inputFrame.Visible = bool1

        if bool1 then
            speedTextBox:CaptureFocus()
            return
        end
        speedTextBox:ReleaseFocus()
    end

    updateHumanoidList()

    UserInputService.InputBegan:Connect(onInputBegan)
end

return module
