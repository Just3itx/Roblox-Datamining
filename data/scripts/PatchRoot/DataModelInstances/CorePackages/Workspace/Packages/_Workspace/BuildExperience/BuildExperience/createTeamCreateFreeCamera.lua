-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createInputAction(parent, inputActionName: string, type, tbl1): InputAction
    local inputAction = Instance.new("InputAction")
    inputAction.Name = inputActionName
    inputAction.Type = type
    for _, value in tbl1 do
        local inputBinding = Instance.new("InputBinding")
        inputBinding.KeyCode = value.KeyCode or Enum.KeyCode.None
        inputBinding.PrimaryModifier = value.PrimaryModifier or Enum.KeyCode.None
        inputBinding.Up = value.Up or Enum.KeyCode.None
        inputBinding.Down = value.Down or Enum.KeyCode.None
        inputBinding.Left = value.Left or Enum.KeyCode.None
        inputBinding.Right = value.Right or Enum.KeyCode.None
        inputBinding.Vector2Scale = value.Vector2Scale or Vector2.one
        inputBinding.Parent = inputAction
    end
    inputAction.Parent = parent
    return inputAction
end

local function getFocusCFrame(vec1: vector, num1: number, rect: Rect?, vector2: Vector2, fieldOfView: number, arg1, bool1: boolean)
    local rotation = CFrame.lookAt(Vector3.new(0.5, 0.5, 1), Vector3.new(0, 0, 0)).Rotation
    if rect == nil or vector2.X <= 1 or vector2.Y <= 1 then
        local z = math.max(10, num1 * 2.5)
        return CFrame.lookAt(vec1 + Vector3.new(z * 0.5, z * 0.5, z), vec1)
    end
    local width = rect.Width
    local height = rect.Height
    if width <= 1 or height <= 1 then
        return nil
    end
    local num2 = math.min(32, width / 4, height / 4)
    local var1 = math.tan(math.rad(fieldOfView) / 2) * 2 / vector2.Y
    local var2 = (rect.Min.X + num2 - vector2.X / 2) * var1
    local var3 = (rect.Max.X - num2 - vector2.X / 2) * var1
    local var4 = (vector2.Y / 2 - rect.Max.Y + num2) * var1
    local var5 = (vector2.Y / 2 - rect.Min.Y - num2) * var1
    local var6 = (var2 + var3) / 2
    local var7 = (var4 + var5) / 2
    local num3 = math.max(
        10,
        num1 * math.sqrt(1 + var2 * var2) / (var6 - var2),
        num1 * math.sqrt(1 + var3 * var3) / (var3 - var6),
        num1 * math.sqrt(1 + var4 * var4) / (var7 - var4),
        num1 * math.sqrt(1 + var5 * var5) / (var5 - var7)
    )
    if bool1 and arg1 ~= nil then
        local var8, var9 = arg1:GetBoundingBox()
        local num4 = 10
        for i = -1, 1, 2 do
            for j = -1, 1, 2 do
                for k = -1, 1, 2 do
                    local localVector = rotation:VectorToObjectSpace(var8:PointToWorldSpace(var9 * Vector3.new(i, j, k) / 2) - vec1)
                    num4 = math.max(
                        num4,
                        localVector.Z + 1,
                        (-localVector.X - var2 * localVector.Z) / (var6 - var2),
                        (localVector.X + var3 * localVector.Z) / (var3 - var6),
                        (-localVector.Y - var4 * localVector.Z) / (var7 - var4),
                        (localVector.Y + var5 * localVector.Z) / (var5 - var7)
                    )
                end
            end
        end
        num3 = math.max(num3 / 1.5, num4)
    end
    local x = var6 * num3
    local y = var7 * num3
    local z = -num3
    local worldVector = rotation:VectorToWorldSpace(Vector3.new(x, y, z))
    return CFrame.new(vec1 - worldVector) * rotation
end

local function getRecenteredCFrame(vec1: vector, cFrame: CFrame, rect: Rect, vector2: Vector2, fieldOfView: number)
    local num1 = -cFrame:PointToObjectSpace(vec1).Z
    if num1 <= 0 or rect.Width <= 1 or rect.Height <= 1 or vector2.X <= 1 or vector2.Y <= 1 then
        return nil
    end
    local var1 = math.tan(math.rad(fieldOfView) / 2) * 2 / vector2.Y
    local var2 = (rect.Min + rect.Max) / 2
    local rotation = cFrame.Rotation

    local x = (var2.X - vector2.X / 2) * var1 * num1
    local y = (vector2.Y / 2 - var2.Y) * var1 * num1
    local z = -num1
    local var3 = rotation:VectorToWorldSpace(Vector3.new(x, y, z))

    return CFrame.new(vec1 - var3) * rotation
end

local function createTeamCreateFreeCamera(arg1, arg2, tbl1, arg3, func1: ((...any) -> (...any))?)
    local var1 = arg3 or game:GetService("GuiService")
    local var2 = func1 or createInputAction
    arg1.CameraType = Enum.CameraType.Scriptable
    arg1.CFrame = CFrame.new(0, 150, 300) * CFrame.Angles(-math.rad(15), 0, 0)

    local token = 0
    local rx, ry = arg1.CFrame:ToEulerAnglesYXZ()
    local position = nil
    local radius = 0
    local model = nil
    local bool1 = false
    local bool2 = false
    local var3 = nil
    local var4 = nil
    local viewportSize = arg1.ViewportSize
    local fieldOfView = arg1.FieldOfView
    local num1 = 0
    local bool3 = false
    local var5 = nil
    local currentTotalTranslation = nil
    local tbl2 = ({})
    local bool4 = false

    local function isInputBlocked() -- Luacid: Inlined by compiler; 5 call sites recovered
        return tbl1.getIsOpen() or arg2:GetFocusedTextBox() ~= nil
    end

    local function isChatUsingInput(): boolean
        if not tbl1.getIsChatOpen() then
            return false
        end
        if var1.SelectedObject ~= nil then
            return true
        end
        local worldChatTop = tbl1.getWorldChatTop()
        local worldChatLeft = tbl1.getWorldChatLeft()
        local guiInset = var1:GetGuiInset()
        local mouseLocation = arg2:GetMouseLocation()

        return worldChatTop ~= nil and mouseLocation.Y >= worldChatTop + guiInset.Y
            or not (worldChatLeft == nil) and mouseLocation.X >= worldChatLeft + guiInset.X
    end

    local teamCreateFreeCamera = Instance.new("InputContext")
    teamCreateFreeCamera.Name = "TeamCreateFreeCamera"
    teamCreateFreeCamera.Priority = 1000
    teamCreateFreeCamera.Sink = true
    teamCreateFreeCamera.Enabled = not isInputBlocked()

    teamCreateFreeCamera.Parent = game:GetService("CoreGui")

    local var6 = var2(teamCreateFreeCamera, "Move", Enum.InputActionType.Direction2D, {
        {
            Up = Enum.KeyCode.W,
            Down = Enum.KeyCode.S,
            Left = Enum.KeyCode.A,
            Right = Enum.KeyCode.D
        },
        {
            Up = Enum.KeyCode.Up,
            Down = Enum.KeyCode.Down,
            Left = Enum.KeyCode.Left,
            Right = Enum.KeyCode.Right
        },
        {
            KeyCode = Enum.KeyCode.Thumbstick1
        }
    })

    local var7 = var2(
        teamCreateFreeCamera,
        "Elevate",
        Enum.InputActionType.Direction1D,
        {
            {
                Up = Enum.KeyCode.E,
                Down = Enum.KeyCode.Q
            },
            {
                Up = Enum.KeyCode.ButtonR2,
                Down = Enum.KeyCode.ButtonL2
            }
        }
    )
    local var8 = var2(
        teamCreateFreeCamera,
        "Sprint",
        Enum.InputActionType.Bool,
        {
            {
                KeyCode = Enum.KeyCode.LeftShift
            },
            {
                KeyCode = Enum.KeyCode.RightShift
            }
        }
    )
    local var9 = var2(teamCreateFreeCamera, "Look", Enum.InputActionType.Bool, {{ KeyCode = Enum.KeyCode.MouseRightButton }})

    local var10 = var2(teamCreateFreeCamera, "Pan", Enum.InputActionType.Direction2D, {
        {
            KeyCode = Enum.KeyCode.MouseDelta,
            PrimaryModifier = Enum.KeyCode.MouseRightButton,
            Vector2Scale = Vector2.new(-0.003, -0.003)
        },
        {
            KeyCode = Enum.KeyCode.TrackpadPan,
            Vector2Scale = Vector2.new(-0.042, -0.042)
        },
        {
            KeyCode = Enum.KeyCode.Thumbstick2,
            Vector2Scale = Vector2.new(-2.5, 2.5)
        }
    })

    local function isTouchGestureBlocked(bool5: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
        for _, value in tbl2 do
            if value then
                return true
            end
        end
        return bool5
    end

    local connection = arg2.TouchStarted:Connect(function(touch: InputObject, gameProcessedEvent: boolean)
        if bool4 then
            return
        end
        tbl2[touch] = gameProcessedEvent or isInputBlocked()
        if tbl2[touch] then
            currentTotalTranslation = nil
            var5 = nil
        end
    end)

    local connection2 = arg2.TouchEnded:Connect(function(arg4)
        tbl2[arg4] = nil
    end)

    local connection3 = arg2.TouchPan:Connect(function(touchPositions: {Vector2}, totalTranslation: Vector2, _vector2: Vector2, state: Enum.UserInputState, bool5: boolean)
        if bool4
            or isTouchGestureBlocked(bool5)
            or isInputBlocked()
            or #touchPositions ~= 1
            or var5 ~= nil
            or state == Enum.UserInputState.End
            or state == Enum.UserInputState.Cancel
        then
            currentTotalTranslation = nil
            return
        end

        if state == Enum.UserInputState.Begin then
            currentTotalTranslation = totalTranslation
            return
        end

        if state ~= Enum.UserInputState.Change or currentTotalTranslation == nil then
            return
        end

        local var11 = totalTranslation - currentTotalTranslation
        currentTotalTranslation = totalTranslation
        if var11.Magnitude > 0 then
            bool1 = false
            var3 = nil
        end
        ry -= var11.X * 0.003
        rx = math.clamp(rx - var11.Y * 0.003, -1.5676547341413067, 1.5676547341413067)
        arg1.CFrame = CFrame.new(arg1.CFrame.Position) * CFrame.fromEulerAnglesYXZ(rx, ry, 0)
    end)

    local connection4 = arg2.TouchPinch:Connect(function(_: {Vector2}, scale: number, _: number, state: Enum.UserInputState, bool5: boolean)
        if bool4
            or isTouchGestureBlocked(bool5)
            or isInputBlocked()
            or state == Enum.UserInputState.End
            or state == Enum.UserInputState.Cancel
        then
            var5 = nil
            return
        end

        if not (scale > 0 and scale < math.huge) then
            return
        end

        if state == Enum.UserInputState.Begin then
            currentTotalTranslation = nil
            local tbl3 = {
                cframe = arg1.CFrame,
                distance = if position == nil then 300 else math.max(1, (arg1.CFrame.Position - position).Magnitude),
                scale = scale
            }
            var5 = tbl3
        elseif state == Enum.UserInputState.Change and var5 ~= nil then
            if scale ~= var5.scale then
                bool1 = false
                var3 = nil
            end

            local num2 = math.clamp(var5.distance * (var5.scale / scale) ^ 0.35, 1, 100000)
            local pos = var5.cframe.Position + var5.cframe.LookVector * (var5.distance - num2)
            arg1.CFrame = CFrame.new(pos) * var5.cframe.Rotation
        end
    end)

    return {
        step = function(num2: number)
            if bool4 then
                return
            end
            local worldViewportRect = tbl1.getWorldViewportRect()
            local worldChatTop = tbl1.getWorldChatTop()
            local worldChatLeft = tbl1.getWorldChatLeft()
            local viewportSize2 = arg1.ViewportSize
            local var11

            if worldViewportRect == nil then
                var11 = nil
            else
                local guiInset = var1:GetGuiInset()
                local rect = Rect.new(worldViewportRect.Min + guiInset, worldViewportRect.Max + guiInset)
                if worldChatTop ~= nil then
                    worldChatTop += guiInset.Y
                end
                if worldChatLeft ~= nil then
                    worldChatLeft += guiInset.X
                end
                local var12 = Vector2.new(math.clamp(rect.Min.X, 0, viewportSize2.X), math.clamp(rect.Min.Y, 0, viewportSize2.Y))

                local num3 = math.max(var12.X, math.min(viewportSize2.X, rect.Max.X, worldChatLeft or math.huge))
                local num4 = math.min(viewportSize2.Y, rect.Max.Y)

                worldViewportRect = Rect.new(var12, Vector2.new(num3, math.max(var12.Y, math.min(num4, worldChatTop or math.huge))))

                local var13 = if arg2.OnScreenKeyboardVisible then arg2.OnScreenKeyboardSize.Y else 0

                local num5 = math.min(num4, worldChatTop == nil and math.huge or worldChatTop + var13)
                var11 = Rect.new(var12, Vector2.new(num3, math.max(num5, math.min(num4, var12.Y + (num4 - var12.Y) * 0.3))))
            end

            if worldViewportRect ~= var4 or viewportSize2 ~= viewportSize or arg1.FieldOfView ~= fieldOfView then
                var4 = worldViewportRect
                viewportSize = viewportSize2
                fieldOfView = arg1.FieldOfView
                num1 = 0
                bool3 = true
            else
                num1 += num2
            end
            local focusRequest = tbl1.getFocusRequest()
            if focusRequest == nil then
                position = nil
                model = nil
                bool1 = false
                var3 = nil
            end

            local bool5 = not (focusRequest == nil) and focusRequest.token ~= token

            if bool5 and focusRequest ~= nil then
                token = focusRequest.token
                var3 = nil
                position = focusRequest.position
                radius = focusRequest.radius
                model = focusRequest.model
                bool1 = true
                bool2 = false
                bool3 = true
                var5 = nil
                currentTotalTranslation = nil
                num1 = 0
            end

            local bool6 = not (worldViewportRect == nil) and (not tbl1.getIsChatOpen() or worldChatTop ~= nil or worldChatLeft ~= nil)

            if position ~= nil and bool6 and bool1 and bool3 and num1 >= 0.1 then
                bool3 = false
                var5 = nil
                currentTotalTranslation = nil
                local var12 = if bool2 then getRecenteredCFrame(
                    position,
                    if var3 ~= nil then var3.target else arg1.CFrame,
                    worldViewportRect,
                    viewportSize2,
                    arg1.FieldOfView
                ) else getFocusCFrame(
                    position,
                    radius,
                    var11,
                    viewportSize2,
                    arg1.FieldOfView,
                    model,
                    worldChatTop ~= nil or worldChatLeft ~= nil
                )

                if var12 ~= nil then
                    bool2 = true
                    var3 = {
                        start = arg1.CFrame,
                        target = var12,
                        elapsed = 0
                    }
                end
            end
            if var3 ~= nil then
                local var12 = var3
                var12.elapsed += num2
                local num3 = math.clamp(var3.elapsed / 0.25, 0, 1)
                local num4 = num3 * num3 * (3 - num3 * 2)
                local var13 = arg1
                var13.CFrame = if num3 == 1 then var3.target else var3.start:Lerp(var3.target, num4)

                rx, ry = arg1.CFrame:ToEulerAnglesYXZ()
                if num3 == 1 then
                    var3 = nil
                end
            end

            local var12 = isInputBlocked()
            teamCreateFreeCamera.Enabled = not (var12 or isChatUsingInput())
            if not teamCreateFreeCamera.Enabled then
                if var12 then
                    var5 = nil
                    currentTotalTranslation = nil
                end
                arg2.MouseBehavior = Enum.MouseBehavior.Default
                return
            end

            local state = var9:GetState()
            local var13 = arg2
            var13.MouseBehavior = if state then Enum.MouseBehavior.LockCurrentPosition else Enum.MouseBehavior.Default

            local var14 = var10:GetState() * num2
            if var14.Magnitude > 0 then
                bool1 = false
                var3 = nil
            end
            ry += var14.X
            rx = math.clamp(rx + var14.Y, -1.5676547341413067, 1.5676547341413067)

            local cFrame = CFrame.fromEulerAnglesYXZ(rx, ry, 0)
            local num3 = num2 * 50 * (if var8:GetState() then 5 else 1)
            local state2 = var6:GetState()
            local pos = arg1.CFrame.Position + (cFrame.RightVector * state2.X + cFrame.LookVector * state2.Y + Vector3.new(0, 1, 0) * var7:GetState()) * num3

            if pos ~= arg1.CFrame.Position then
                bool1 = false
                var3 = nil
            end

            arg1.CFrame = CFrame.new(pos) * cFrame
        end,
        destroy = function()
            bool4 = true
            teamCreateFreeCamera:Destroy()
            var3 = nil
            var5 = nil
            currentTotalTranslation = nil
            table.clear(tbl2)
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
            connection4:Disconnect()
            arg2.MouseBehavior = Enum.MouseBehavior.Default
        end
    }
end

return createTeamCreateFreeCamera
