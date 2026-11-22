-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local observeGuiOnScreen = require(script.Parent.observeGuiOnScreen)

local cFrame = CFrame.new(0, 2000, 0)

local function saveCamera(camera: Camera) -- Luacid: Inlined by compiler; 3 call sites recovered
    return {
        instance = camera,
        cframe = camera.CFrame,
        focus = camera.Focus,
        fieldOfView = camera.FieldOfView,
        fieldOfViewMode = camera.FieldOfViewMode,
        cameraType = camera.CameraType
    }
end

local function guiToViewportY(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return num1 + GuiService:GetGuiInset().Y
end

local function getStudsPerPixel(arg1, num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    return 2 * (arg1.Focus.Position - arg1.CFrame.Position).Magnitude * math.tan(math.rad(arg1.FieldOfView) / 2) / num1
end

local function getCoverage(tbl1): number -- Luacid: Inlined by compiler; 1 call site recovered
    local absolutePositionY = tbl1.pager.AbsolutePosition.Y
    local absoluteSizeY = tbl1.pager.AbsoluteSize.Y
    if absoluteSizeY <= 0 then
        return 0
    end
    local absolutePositionY2 = tbl1.page.AbsolutePosition.Y
    return math.clamp(
        (math.min(absolutePositionY2 + tbl1.page.AbsoluteSize.Y, absolutePositionY + absoluteSizeY) - math.max(absolutePositionY2, absolutePositionY)) / absoluteSizeY,
        0,
        1
    )
end

local function createAvatarSceneStage()
    local tbl1 = {}
    local tbl2 = ({})
    local tbl3 = ({})
    local num1 = 0
    local var1 = nil
    local var2 = nil
    local var3 = nil
    local var4 = nil
    local cFrame2 = nil
    local bool1 = false
    local connection = nil
    local tbl4 = {}

    local function acquireCamera() -- Luacid: Inlined by compiler; 2 call sites recovered
        local avatarMomentCamera = Workspace.CurrentCamera
        if avatarMomentCamera == nil then
            avatarMomentCamera = Instance.new("Camera")
            avatarMomentCamera.Name = "AvatarMomentCamera"
            avatarMomentCamera.Parent = Workspace
            Workspace.CurrentCamera = avatarMomentCamera
            var3 = avatarMomentCamera
        end

        var2 = avatarMomentCamera
        var4 = saveCamera(avatarMomentCamera)
        cFrame2 = nil
    end

    local function releaseCamera()
        local var5 = var4
        local var6 = var2
        var4 = nil
        var2 = nil

        if var5 ~= nil
            and var6 ~= nil
            and var5.instance.Parent ~= nil
            and Workspace.CurrentCamera == var5.instance
            and (cFrame2 == nil or var6.CFrame == cFrame2)
        then
            var6.CFrame = var5.cframe
            var6.Focus = var5.focus
            var6.FieldOfView = var5.fieldOfView
            var6.FieldOfViewMode = var5.fieldOfViewMode
            var6.CameraType = var5.cameraType
        end
        cFrame2 = nil
        local var7 = var3
        var3 = nil
        if var7 == nil then
            return
        end

        if Workspace.CurrentCamera == var7 then
            Workspace.CurrentCamera = nil
        end
        var7:Destroy()
    end

    local function moveToViewportFrame(tbl5) -- Luacid: Inlined by compiler; 3 call sites recovered
        if tbl5.worldModel.Parent == nil then
            return
        end
        local root = tbl5.scene.root
        root:PivotTo(CFrame.identity)
        root.Parent = tbl5.worldModel
    end

    local function moveToWorkspace(tbl5) -- Luacid: Inlined by compiler; 2 call sites recovered
        local root = tbl5.scene.root
        root.Parent = Workspace
        root:PivotTo(cFrame)
    end

    local function setOwner(tbl5) -- Luacid: unused: defined but never referenced
        if tbl5 == var1 then
            return
        end
        local var5 = var1
        var1 = tbl5

        if tbl5 == nil then
            releaseCamera()
        end
        if var5 ~= nil then
            moveToViewportFrame(var5)
        end

        if tbl5 == nil then
            return
        end

        if var5 == nil then
            acquireCamera()
        end

        moveToWorkspace(tbl5)
    end
    local function updateWorkspaceCamera(tbl5, num2: number)
        local var5 = var2
        if var5 == nil or Workspace.CurrentCamera ~= var5 then
            return
        end
        local camera = tbl5.scene.camera
        local y

        if num2 > 0 then
            y = (tbl5.page.AbsolutePosition.Y - tbl5.pager.AbsolutePosition.Y) * getStudsPerPixel(camera, num2)
        else
            y = 0
        end

        var5.CameraType = Enum.CameraType.Scriptable

        var5.FieldOfViewMode = Enum.FieldOfViewMode.Vertical
        var5.FieldOfView = camera.FieldOfView
        var5.CFrame = cFrame * camera.CFrame * CFrame.new(0, y, 0)
        var5.Focus = cFrame * camera.Focus
        cFrame2 = var5.CFrame
    end

    local function updateViewportCamera(tbl5, num2: number)
        local camera = tbl5.scene.camera
        local viewportCamera = tbl5.viewportCamera
        local absoluteSizeY = tbl5.viewportFrame.AbsoluteSize.Y
        viewportCamera.FieldOfViewMode = Enum.FieldOfViewMode.Vertical
        if num2 <= 0 or absoluteSizeY <= 0 then
            viewportCamera.FieldOfView = camera.FieldOfView
            viewportCamera.CFrame = camera.CFrame
            return
        end
        viewportCamera.FieldOfView = math.deg(math.atan(math.tan(math.rad(camera.FieldOfView) / 2) * absoluteSizeY / num2) * 2)

        local var5 = tbl5.viewportFrame.AbsolutePosition.Y - tbl5.page.AbsolutePosition.Y
        local var6 = guiToViewportY(tbl5.pager.AbsolutePosition.Y) + var5 + absoluteSizeY / 2 - num2 / 2
        viewportCamera.CFrame = camera.CFrame * CFrame.new(0, -var6 * getStudsPerPixel(camera, num2), 0)
    end

    local function setViewportFrameVisible(tbl5, viewportFrameVisible: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
        if tbl5.viewportFrameVisible ~= viewportFrameVisible then
            tbl5.viewportFrameVisible = viewportFrameVisible
            tbl5.viewportFrame.Visible = viewportFrameVisible
        end
    end

    local function isCameraTakenOver(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        local var5 = var2

        return not (var5 == nil or cFrame2 == nil) and (Workspace.CurrentCamera ~= var5 or var5.CFrame ~= cFrame2)
    end

    local function step(): boolean
        if isCameraTakenOver() then
            bool1 = true
            var4 = nil
        end

        local pager = nil
        local num2 = -1
        for _, value in tbl2 do
            local var5 = if value.isOnScreen then tbl3[value.pager] else nil

            if var5 ~= nil and num2 < var5 then
                pager = value.pager
                num2 = var5
            end
        end

        local var5 = nil
        local num3 = 0
        local num4 = 0
        for _, value in tbl1 do
            value.coverage = if value.presence.isOnScreen then if value.pager ~= pager then 0 else getCoverage(value) else 0
            if value == var1 then
                num4 = value.coverage
            end
            if num3 < value.coverage then
                num3 = value.coverage
                var5 = value
            end
        end

        local var6 = var1
        if var6 ~= nil and not (num4 <= 0) and not (num4 + 0.1 < num3) then
            var5 = var6
        end

        if bool1 then
            var5 = nil
        end

        if var5 ~= var1 then
            local var7 = var1
            var1 = var5

            if var5 == nil then
                releaseCamera()
            end
            if var7 ~= nil then
                moveToViewportFrame(var7)
            end

            if var5 ~= nil then
                if var7 == nil then
                    acquireCamera()
                end

                moveToWorkspace(var5)
            end
        end

        if num3 <= 0 then
            bool1 = false
        end

        local currentCamera = Workspace.CurrentCamera
        local num5 = if currentCamera == nil then 0 else currentCamera.ViewportSize.Y
        for _, value in tbl1 do
            setViewportFrameVisible(value, value.coverage > 0)
            if value ~= var1 and value.coverage > 0 then
                updateViewportCamera(value, num5)
            end
        end
        if var1 ~= nil then
            updateWorkspaceCamera(var1, num5)
        end
        return num3 > 0
    end

    local function stopRendering() -- Luacid: Inlined by compiler; 2 call sites recovered
        if connection ~= nil then
            connection:Disconnect()
            connection = nil
        end
    end

    local function stopWatchingForMovement() -- Luacid: Inlined by compiler; 3 call sites recovered
        for _, value in tbl4 do
            value:Disconnect()
        end
        table.clear(tbl4)
    end

    local refresh = nil

    local function watchForMovement()
        stopRendering()
        stopWatchingForMovement()

        for _, value in tbl1 do
            if value.presence.isOnScreen then
                table.insert(tbl4, value.page:GetPropertyChangedSignal("AbsolutePosition"):Connect(refresh))

                table.insert(tbl4, value.page:GetPropertyChangedSignal("AbsoluteSize"):Connect(refresh))
                table.insert(tbl4, value.pager:GetPropertyChangedSignal("AbsoluteSize"):Connect(refresh))
            end
        end
    end

    local function onRenderStepped()
        if not step() then
            watchForMovement()
        end
    end

    refresh = function()
        local bool2 = false
        for _, value in tbl1 do
            if value.presence.isOnScreen then
                bool2 = true
                break
            end
        end

        if bool2 then
            if not step() then
                watchForMovement()
                return
            end

            stopWatchingForMovement()

            if connection == nil then
                connection = RunService.RenderStepped:Connect(onRenderStepped)
            end

            return
        end

        stopRendering()
        stopWatchingForMovement()
        bool1 = false

        if var1 ~= nil then
            local var5 = var1
            var1 = nil

            releaseCamera()

            if var5 ~= nil then
                moveToViewportFrame(var5)
            end
        end

        for _, value in tbl1 do
            setViewportFrameVisible(value, false)
        end
    end

    local function updatePagerOrder(pager)
        local num2 = 0
        for _, value in tbl2 do
            if value.pager == pager and value.isOnScreen then
                num2 += 1
            end
        end
        if num2 == 0 then
            tbl3[pager] = nil
        elseif tbl3[pager] == nil then
            num1 += 1
            tbl3[pager] = num1
        end
    end

    local function retainPage(page)
        local var5 = tbl2[page]
        if var5 ~= nil then
            var5.refCount += 1
            return var5
        end
        local scrollingFrame = page:FindFirstAncestorWhichIsA("ScrollingFrame")
        local module = {
            page = page,
            pager = 0,
            isOnScreen = false,
            refCount = 1,
            disconnectOnScreen = 0
        }

        if scrollingFrame == nil then
            scrollingFrame = page
        end

        module.pager = scrollingFrame

        function module.disconnectOnScreen() end

        tbl2[page] = module
        module.disconnectOnScreen = observeGuiOnScreen(page, function(isOnScreen: boolean)
            module.isOnScreen = isOnScreen
            updatePagerOrder(module.pager)
            refresh()
        end)
        return module
    end

    local function releasePage(tbl5) -- Luacid: Inlined by compiler; 2 call sites recovered
        tbl5.refCount -= 1
        if tbl5.refCount > 0 then
            return
        end
        tbl5.disconnectOnScreen()
        tbl2[tbl5.page] = nil
        updatePagerOrder(tbl5.pager)
        refresh()
    end

    return {
        trackPage = function(page)
            local var5 = retainPage(page)
            local bool2 = true
            return function()
                if bool2 then
                    bool2 = false
                    releasePage(var5)
                end
            end
        end,
        register = function(tbl5)
            local avatarMomentViewportCamera = Instance.new("Camera")
            avatarMomentViewportCamera.Name = "AvatarMomentViewportCamera"
            avatarMomentViewportCamera.Parent = tbl5.viewportFrame
            tbl5.viewportFrame.CurrentCamera = avatarMomentViewportCamera
            avatarMomentViewportCamera.CFrame = tbl5.scene.camera.CFrame
            avatarMomentViewportCamera.FieldOfView = tbl5.scene.camera.FieldOfView
            tbl5.scene.root.Parent = tbl5.worldModel

            local presence = retainPage(tbl5.page)
            local tbl6 = {
                scene = tbl5.scene,
                page = tbl5.page,
                viewportFrame = tbl5.viewportFrame,
                worldModel = tbl5.worldModel,
                pager = presence.pager,
                presence = presence,
                viewportCamera = avatarMomentViewportCamera,
                coverage = 0,
                viewportFrameVisible = nil
            }

            table.insert(tbl1, tbl6)
            refresh()

            local bool2 = true
            return function()
                if not bool2 then
                    return
                end
                bool2 = false

                if var1 == tbl6 then
                    var1 = nil
                    releaseCamera()
                end
                local var6 = table.find(tbl1, tbl6)
                if var6 ~= nil then
                    table.remove(tbl1, var6)
                end
                if tbl6.viewportFrame.CurrentCamera == avatarMomentViewportCamera then
                    tbl6.viewportFrame.CurrentCamera = nil
                end
                avatarMomentViewportCamera:Destroy()
                releasePage(presence)
                refresh()
            end
        end,
        getOwnerScene = function()
            return if var1 == nil then nil else var1.scene
        end
    }
end
return createAvatarSceneStage
