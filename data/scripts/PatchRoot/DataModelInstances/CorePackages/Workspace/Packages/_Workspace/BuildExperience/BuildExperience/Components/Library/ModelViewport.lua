-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local Motion = require(BuildExperienceParent.Motion)

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local tbl1 = {
    [Enum.KeyCode.Left] = Vector2.new(-1, 0),
    [Enum.KeyCode.Right] = Vector2.new(1, 0),
    [Enum.KeyCode.Up] = Vector2.new(0, -1),
    [Enum.KeyCode.Down] = Vector2.new(0, 1)
}

local function getCameraDistance(fieldOfView: number, vec1: vector, vector2: Vector2): number -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = if vector2.X > 0 and vector2.Y > 0 then vector2.X / vector2.Y else 1
    local num1 = math.atan(math.tan(math.rad(fieldOfView) / 2) * math.min(1, var1))
    return math.max(vec1.Magnitude / 2, 0.01) / math.sin(num1)
end

return React.memo(function(tbl2) -- name: ModelViewport
    local var1 = useTokens()
    local reducedMotion = Foundation.Hooks.usePreferences().reducedMotion
    local ref = React.useRef(nil)
    local var3, current = Motion.useMotion({ size = UDim2.fromScale(1, 1) })
    local var5 = React.useRef(current)
    var5.current = current
    local var6, var7 = React.useState(nil)
    local var8, var9 = React.useState(0)
    local model = tbl2.model
    local fieldOfView = tbl2.fieldOfView or 30
    local cameraDistanceScale = tbl2.cameraDistanceScale or 1
    local active = tbl2.isInteractive == true

    local var10 = React.useRef({
        yaw = math.rad(20),
        pitch = -math.rad(15),
        zoom = 1,
        center = Vector3.new(0, 0, 0),
        baseDistance = 0,
        camera = nil,
        sourceModel = nil,
        dragInput = nil,
        lastDragPosition = nil
    })

    local var11 = React.useCallback(function()
        local current = var10.current
        local camera = current.camera
        if camera == nil then
            return
        end
        local var11 = CFrame.fromEulerAnglesYXZ(current.pitch, current.yaw, 0) * Vector3.new(0, 0, current.baseDistance * current.zoom)
        camera.CFrame = CFrame.lookAt(current.center + var11, current.center)
    end, {})

    React.useEffect(function()
        local current = ref.current
        if current == nil or model == nil then
            return nil
        end

        local modelClone = model:Clone()
        if modelClone == nil then
            var7(model)
            local connection = model:GetPropertyChangedSignal("Archivable"):Connect(function()
                var9(function(arg1): number
                    return arg1 + 1
                end)
            end)
            return function()
                connection:Disconnect()
            end
        end

        var7(nil)
        local worldModel = Instance.new("WorldModel")
        worldModel.Parent = current
        modelClone.Parent = worldModel

        local camera = Instance.new("Camera")
        camera.CameraType = Enum.CameraType.Scriptable
        camera.FieldOfView = fieldOfView
        camera.Parent = worldModel
        current.CurrentCamera = camera

        local current2 = var10.current
        current2.camera = camera
        if current2.sourceModel ~= model then
            current2.yaw = math.rad(20)
            current2.pitch = -math.rad(15)
            current2.zoom = 1
            current2.sourceModel = model
        end

        local var12, var13 = modelClone:GetBoundingBox()
        local var14 = -var12.Position
        modelClone:TranslateBy(var14)
        current2.center = Vector3.new(0, 0, 0)

        local function updateFit()
            current2.baseDistance = getCameraDistance(fieldOfView, var13, current.AbsoluteSize) * cameraDistanceScale
            var11()
        end
        local connection = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateFit)
        current2.baseDistance = getCameraDistance(fieldOfView, var13, current.AbsoluteSize) * cameraDistanceScale
        var11()

        local bool2 = false
        local var15 = nil
        local tbl3 = ({})
        local function refreshPreview()
            var15 = nil
            if bool2 then
                return
            end
            local modelClone2 = model:Clone()
            if modelClone2 == nil then
                return
            end
            local var16, var17 = modelClone2:GetBoundingBox()
            modelClone2:TranslateBy(-var16.Position)
            modelClone:Destroy()
            modelClone = modelClone2
            modelClone.Parent = worldModel
            var13 = var17
            current2.baseDistance = getCameraDistance(fieldOfView, var13, current.AbsoluteSize) * cameraDistanceScale
            var11()
        end

        local function scheduleRefresh() -- Luacid: Inlined by compiler; 2 call sites recovered
            if bool2 or var15 ~= nil then
                return
            end
            var15 = task.defer(refreshPreview)
        end
        local function observe(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
            if tbl3[arg1] == nil then
                tbl3[arg1] = arg1.Changed:Connect(scheduleRefresh)
            end
        end
        local connection2 = nil
        local connection3 = nil
        if active then
            observe(model)
            for _, descendant in model:GetDescendants() do
                observe(descendant)
            end

            connection2 = model.DescendantAdded:Connect(function(descendant: Instance)
                observe(descendant)
                scheduleRefresh()
            end)

            connection3 = model.DescendantRemoving:Connect(function(descendant: Instance)
                local var16 = tbl3[descendant]
                if var16 ~= nil then
                    var16:Disconnect()
                    tbl3[descendant] = nil
                end

                scheduleRefresh()
            end)
        end

        return function()
            bool2 = true
            if var15 ~= nil then
                task.cancel(var15)
            end
            if connection2 then
                connection2:Disconnect()
            end
            if connection3 then
                connection3:Disconnect()
            end
            for _, value in tbl3 do
                value:Disconnect()
            end
            connection:Disconnect()
            current2.camera = nil
            current2.dragInput = nil
            current2.lastDragPosition = nil
            worldModel:Destroy()
        end
    end, {
        model or false,
        fieldOfView,
        cameraDistanceScale,
        active,
        var11,
        var8
    })
    React.useEffect(function()
        local current = ref.current
        if current == nil or not active then
            return nil
        end
        local currentParent = current.Parent
        local bool2 = false
        local function resizeViewport()
            local absoluteSize = currentParent.AbsoluteSize
            if absoluteSize.X <= 0 or absoluteSize.Y <= 0 then
                return
            end
            var5.current(
                Motion.createState({
                    size = UDim2.fromOffset(absoluteSize.X, absoluteSize.Y)
                }, {
                    default = Motion.transition({ duration = if bool2 and not reducedMotion then 0.25 else 0, easingStyle = Enum.EasingStyle.Quad })
                })
            )
            bool2 = true
        end
        resizeViewport()
        local connection = currentParent:GetPropertyChangedSignal("AbsoluteSize"):Connect(resizeViewport)
        return function()
            connection:Disconnect()
        end
    end, { active, reducedMotion })

    local var12 = React.useCallback(function(_, dragInput)
        local current = var10.current
        if not active or current.dragInput ~= nil then
            return
        end

        if dragInput.UserInputType == Enum.UserInputType.MouseButton1 or dragInput.UserInputType == Enum.UserInputType.Touch then
            current.dragInput = dragInput
            current.lastDragPosition = dragInput.Position
        end
    end, { active })

    React.useEffect(function()
        if not active then
            return nil
        end
        local UserInputService = game:GetService("UserInputService")
        local connection = UserInputService.InputChanged:Connect(function(input: InputObject)
            local current = var10.current
            local dragInput = current.dragInput
            if dragInput == nil or current.lastDragPosition == nil then
                return
            end

            local bool2 = dragInput.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement

            if not bool2 and input ~= dragInput then
                return
            end
            local var13 = input.Position - current.lastDragPosition
            current.lastDragPosition = input.Position
            current.yaw -= var13.X * 0.01
            current.pitch = math.clamp(current.pitch - var13.Y * 0.01, -math.rad(85), math.rad(85))
            var11()
        end)
        local function clearDrag() -- Luacid: Inlined by compiler; 2 call sites recovered
            var10.current.dragInput = nil
            var10.current.lastDragPosition = nil
        end
        local connection2 = UserInputService.InputEnded:Connect(function(input: InputObject)
            if var10.current.dragInput == input then
                clearDrag()
            end
        end)

        local connection3 = UserInputService.WindowFocusReleased:Connect(clearDrag)
        local connection4 = UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean)
            local var13 = tbl1[input.KeyCode]
            if gameProcessedEvent or var13 == nil then
                return
            end
            local current = var10.current
            current.yaw -= var13.X * math.rad(15)
            current.pitch = math.clamp(current.pitch - var13.Y * math.rad(15), -math.rad(85), math.rad(85))
            var11()
        end)
        return function()
            connection4:Disconnect()
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
            clearDrag()
        end
    end, { active, var11 })

    local var13 = React.useCallback(function(_, arg1)
        local current = var10.current
        if active and current.dragInput == nil and arg1.UserInputType == Enum.UserInputType.MouseWheel then
            current.zoom = math.clamp(current.zoom - arg1.Position.Z * 0.12, 0.4, 2.5)
            var11()
        end
    end, { active, var11 })

    local createElement = React.createElement
    local var14 = View
    local tbl3 = {
        Size = tbl2.size or UDim2.fromScale(1, 1),
        backgroundStyle = tbl2.backgroundTransparency ~= nil
            and {
                Color3 = var1.Color.Surface.Surface_200.Color3,
                Transparency = tbl2.backgroundTransparency
            }
            or nil,
        LayoutOrder = tbl2.LayoutOrder,
        testId = tbl2.testId
    }
    local tbl4 = {
        Unavailable = if model == nil or var6 ~= model then nil else React.createElement(Foundation.Text, {
            Text = tbl2.unavailableText,
            tag = "size-full padding-small text-body-small text-wrap text-align-x-center content-default",
            testId = if tbl2.testId == nil then nil else `{tbl2.testId}.Unavailable`
        }),
        Viewport = React.createElement("ViewportFrame", {
            Visible = model == nil or var6 ~= model,
            Size = if active then var3.size else UDim2.fromScale(1, 1),
            BackgroundColor3 = var1.Color.Surface.Surface_200.Color3,
            BackgroundTransparency = tbl2.backgroundTransparency or var1.Color.Surface.Surface_200.Transparency,
            BorderSizePixel = 0,
            Active = active,
            ref = ref,
            [React.Tag] = if tbl2.testId == nil then nil else `data-testid={tbl2.testId}.Viewport`,
            [React.Event.InputBegan] = var12,
            [React.Event.InputChanged] = var13
        })
    }
    return createElement(var14, tbl3, tbl4)
end)
