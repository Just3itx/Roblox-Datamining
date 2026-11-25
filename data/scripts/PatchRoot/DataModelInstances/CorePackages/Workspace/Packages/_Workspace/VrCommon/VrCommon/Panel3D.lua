-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrCommon = script:FindFirstAncestor("VrCommon")
local VrCommonParent = VrCommon.Parent

local VRService = game:GetService("VRService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local VRUtil = require(VrCommon.VRUtil)
local Create = require(VrCommonParent.AppCommonLib).Create

local name = "Panel3DRenderStep-" .. game:GetService("HttpService"):GenerateGUID()

local vector2 = Vector2.new(0, 0)

local cFrame = CFrame.new(0, -0.5, -5.5)
local cFrame2 = CFrame.new(0, 0, -3)

local var1 = CFrame.new(0, 0, -0.1) * CFrame.Angles(0, math.pi, 0)

local var2 = nil
local var3 = nil
local huge = math.huge
local var4 = nil
local vector2_2 = vector2
local tbl1 = ({})
local var5 = Create("ImageLabel")({
    Image = "rbxasset://textures/Cursors/Gamepad/Pointer.png",
    ImageColor3 = Color3.new(0, 1, 0),
    BackgroundTransparency = 1,
    ZIndex = 1000000000
})

local CoreGuiFolder = Create("Folder")({ Name = "VRCorePanelParts", Archivable = false })

local CoreEffectFolder = Create("Folder")({ Name = "VRCoreEffectParts", Archivable = false })

pcall(function()
    GuiService.CoreGuiFolder = CoreGuiFolder
    GuiService.CoreEffectFolder = CoreEffectFolder
end)

local module = {
    Type = {
        None = 0,
        Standard = 1,
        Fixed = 2,
        HorizontalFollow = 3,
        FixedToHead = 4,
        NewStandard = 5,
        WristView = 6,
        PositionLocked = 7,
        UIManagerManaged = 8
    },
    OnPanelClosed = Create("BindableEvent")({ Name = "OnPanelClosed" })
}

function module.GetHeadLookXZ(arg1)
    local cFrame3 = VRService:GetUserCFrame(Enum.UserCFrame.Head)
    local lookVector = cFrame3.lookVector
    local ry = math.atan2(-lookVector.Z, lookVector.X) - math.pi / 2
    local cFrame4 = CFrame.Angles(0, ry, 0)

    if arg1 then
        cFrame4 += cFrame3.p
    end
    return cFrame4
end

function module.FindContainerOf(arg1)
    for _, value in pairs(tbl1) do
        if value.gui and value.gui:IsAncestorOf(arg1) then
            return value
        end
        for _, subpanel in pairs(value.subpanels) do
            if subpanel.gui and subpanel.gui:IsAncestorOf(arg1) then
                return value
            end
        end
    end
    return nil
end

function module.SetModalPanel(arg1)
    if var2 == arg1 then
        return
    end
    if var2 then
        var2:OnModalChanged(false)
    end
    if arg1 then
        arg1:OnModalChanged(true)
    end
    var3 = var2
    var2 = arg1
end

function module.RaycastOntoPanel(arg1, arg2, arg3, arg4)
    local size = arg1.Size
    local sizeZ = size.Z
    local sizeX = size.X
    local sizeY = size.Y

    local renderCFrame = arg1:GetRenderCFrame()
    local lookVector = renderCFrame.lookVector
    local var8 = renderCFrame.p + lookVector * sizeZ * 0.5

    local var9 = VRUtil.RayPlaneIntersection(arg4, lookVector, var8)
    if not var9 then
        return nil, nil, nil, false
    end

    local absoluteSizeX = arg2.AbsoluteSize.X
    local absoluteSizeY = arg2.AbsoluteSize.Y

    local var10 = renderCFrame:pointToObjectSpace(var9) * Vector3.new(-1, 1, 1) + Vector3.new(sizeX / 2, -sizeY / 2, 0)

    local vector2_3 = Vector2.new(var10.X / sizeX * absoluteSizeX, var10.Y / sizeY * -absoluteSizeY)

    local vector23X = vector2_3.X
    local vector23Y = vector2_3.Y
    local absolutePositionX = arg3.AbsolutePosition.X
    local absolutePositionY = arg3.AbsolutePosition.Y
    local absoluteSizeX2 = arg3.AbsoluteSize.X
    local absoluteSizeY2 = arg3.AbsoluteSize.Y

    return var9, var10, vector2_3, not not (arg2.Enabled
        and absolutePositionX <= vector23X
        and vector23X <= absolutePositionX + absoluteSizeX2
        and absolutePositionY <= vector23Y
        and vector23Y <= absolutePositionY + absoluteSizeY2)
end

local tbl2 = {}
tbl2.__index = tbl2
function tbl2.new(arg1)
    local tbl3 = {
        name = arg1,
        part = false,
        gui = false,
        width = 1,
        height = 1,
        isVisible = false,
        isEnabled = false,
        panelType = module.Type.None,
        pixelScale = 1,
        showCursor = true,
        canFade = true,
        shouldFindLookAtGuiElement = false,
        ignoreModal = false,
        needsPositionUpdate = false,
        alwaysUpdatePosition = false,
        linkedTo = false,
        subpanels = {},
        transparency = 0,
        forceShowUntilLookedAt = false,
        forceShowUntilTick = 0,
        isLookedAt = false,
        isWristHeldUp = false,
        isOffscreen = true,
        lookAtPixel = Vector2.new(-1, -1),
        cursorPos = Vector2.new(-1, -1),
        lookAtDistance = math.huge,
        lookAtGuiElement = false,
        isClosest = true,
        localCF = CFrame.new(),
        originCF = CFrame.new(),
        angleFromHorizon = false,
        angleFromForward = false,
        distance = 0,
        lerpTime = 0,
        lerpInitialCF = nil,
        lerpScaleSize = Vector2.new(0, 0),
        lerpInitialSize = Vector2.new(0, 0),
        FollowView = true,
        LastFollowCF = nil,
        LastCameraPos = Vector3.new(0, 0, 0),
        wristTargetPosition = Vector3.new()
    }
    if tbl1[arg1] then
        error("A panel by the name of " .. arg1 .. " already exists.")
    end
    tbl1[arg1] = tbl3

    return (setmetatable(tbl3, tbl2))
end

function tbl2:GetPart()
    if not self.part then
        self.part = Create("Part")({
            Name = self.name,
            Parent = CoreGuiFolder,
            Transparency = 1,
            CanCollide = false,
            CanTouch = false,
            Anchored = true,
            Size = Vector3.new(1, 1, 0.2)
        })
    end

    return self.part
end

function tbl2:GetGUI()
    if not self.gui then
        local adornee = self:GetPart()
        self.gui = Create("SurfaceGui")({
            Parent = CoreGui,
            Name = self.name,
            Archivable = false,
            Adornee = adornee,
            Active = true,
            ToolPunchThroughDistance = 1000,
            CanvasSize = self.CanvasSize or Vector2.new(1000, 1000),
            Enabled = self.isEnabled,
            AlwaysOnTop = true
        })
    end

    return self.gui
end

function tbl2:FindHoveredGuiElement(arg1)
    local lookAtPixelX = self.lookAtPixel.X
    local lookAtPixelY = self.lookAtPixel.Y
    for k, value in pairs(arg1) do
        local absolutePosition = value.AbsolutePosition
        local var8 = value.AbsolutePosition + value.AbsoluteSize
        if absolutePosition.X <= lookAtPixelX
            and lookAtPixelX <= var8.X
            and absolutePosition.Y <= lookAtPixelY
            and lookAtPixelY <= var8.Y
        then
            return value, k
        end
    end
end

function tbl2:SetPartCFrame(arg1)
    self:GetPart().CFrame = arg1 * var1
end

function tbl2:SetEnabled(isEnabled)
    if self.isEnabled == isEnabled then
        return
    end

    self.isEnabled = isEnabled
    if isEnabled then
        self:GetPart().Parent = CoreGuiFolder
        self:GetGUI().Enabled = true
        for _, subpanel in pairs(self.subpanels) do
            subpanel:SetEnabled(subpanel:GetEnabled())
        end
    else
        self:GetPart().Parent = nil
        self:GetGUI().Enabled = false
        for _, subpanel in pairs(self.subpanels) do
            subpanel:SetEnabled(subpanel:GetEnabled())
        end
    end

    self:OnEnabled(isEnabled)
end

function tbl2:StartLerp(arg1)
    if self.panelType == module.Type.UIManagerManaged then
        return
    end

    self.lerpInitialCF = self:GetPart().CFrame * CFrame.new(0, -1.5, 0)
    self.lerpTime = 1
    self.lerpInitialSize = Vector2.new(self.width, self.height)
    self.lerpScaleSize = arg1 and arg1 or Vector2.new(0, 0)
end

function tbl2:EvaluatePositioning(arg1, arg2, arg3, arg4)
    if self.panelType == module.Type.UIManagerManaged then
        return
    end
    if self.panelType == module.Type.Fixed then
        self:SetPartCFrame(arg1 * (self.localCF - self.localCF.p + self.localCF.p * workspace.CurrentCamera.HeadScale))
    elseif self.panelType == module.Type.HorizontalFollow then
        local lookVector = arg3.lookVector
        self:SetPartCFrame(
            arg1 * (CFrame.new(arg3.p, arg3.p + lookVector * Vector3.new(1, 0, 1)) * self.angleFromForward * self.angleFromHorizon * CFrame.new(0, 0, workspace.CurrentCamera.HeadScale * -self.distance))
        )
    elseif self.panelType == module.Type.FixedToHead then
        self:SetPartCFrame(arg2 * (self.localCF - self.localCF.p + self.localCF.p * workspace.CurrentCamera.HeadScale))
    elseif self.panelType == module.Type.Standard then
        if self.needsPositionUpdate or self.alwaysUpdatePosition then
            self.needsPositionUpdate = false
            local headLookXz = module.GetHeadLookXZ(true)
            local pos = cFrame.Position * workspace.CurrentCamera.HeadScale
            self.originCF = headLookXz * CFrame.new(pos)
        end

        self:SetPartCFrame(arg1 * self.originCF * self.localCF)
    elseif self.panelType == module.Type.NewStandard then
        if self.needsPositionUpdate or self.alwaysUpdatePosition then
            self.needsPositionUpdate = false
            local cFrame3 = VRService:GetUserCFrame(Enum.UserCFrame.Head)
            local pos = cFrame2.Position * workspace.CurrentCamera.HeadScale
            self.originCF = cFrame3 * CFrame.new(pos)
        end

        self:SetPartCFrame(arg1 * self.originCF * self.localCF)
    elseif self.panelType == module.Type.WristView then
        if VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
            if self.needsPositionUpdate or self.alwaysUpdatePosition then
                self.needsPositionUpdate = false
                local pos = VRService:GetUserCFrame(Enum.UserCFrame.LeftHand).Position * workspace.CurrentCamera.HeadScale
                self.originCF = CFrame.new(pos)
            end

            local var8 = arg1 * VRService:GetUserCFrame(Enum.UserCFrame.Head)

            local position = (arg1 * self.originCF).Position
            if self.distance > 0 then
                local vec3 = Vector3.new(position.x, var8.Position.y - 0.33, position.z)

                local num1 = math.clamp((vec3 - var8.Position).Magnitude, self.distance - 0.5, self.distance + 0.5)

                local var9 = (vec3 - var8.Position).Unit * num1
                position = var8.Position + var9
            end

            local vec3 = Vector3.new(var8.Position.x, position.y, var8.Position.z)

            local cFrame3 = CFrame.new(position, vec3)

            self:GetPart().CFrame = cFrame3
        else
            self:SetPartCFrame(arg1 * (self.localCF - self.localCF.p + self.localCF.p * workspace.CurrentCamera.HeadScale))
        end
    elseif self.panelType == module.Type.PositionLocked then
        local lastFollowCf = VRUtil.GetUserCFrameWorldSpace(Enum.UserCFrame.Head)

        if not self.LastFollowCF then
            self.LastFollowCF = lastFollowCf
        end

        if (self.LastCameraPos - arg1.Position).Magnitude > 0.1 then
            self.LastFollowCF = lastFollowCf
        end
        self.LastCameraPos = arg1.Position

        if self.LastFollowCF.LookVector:Dot(lastFollowCf.LookVector) < 0.85 then
            self.FollowView = true
        elseif self.LastFollowCF.LookVector:Dot(lastFollowCf.LookVector) > 0.99 then
            self.FollowView = false
        end

        if self.FollowView then
            self.LastFollowCF = self.LastFollowCF:Lerp(lastFollowCf, 0.1)
        end

        local var8 = lastFollowCf.Position + self.LastFollowCF.LookVector * (self.distance * workspace.CurrentCamera.HeadScale + 0.1)
        local vec3 = Vector3.new(var8.X, lastFollowCf.Position.Y - 0.5 * workspace.CurrentCamera.HeadScale, var8.Z)

        local vec3_2 = Vector3.new(lastFollowCf.Position.x, vec3.y, lastFollowCf.Position.z)

        local cFrame3 = CFrame.new(vec3, vec3_2)

        self:GetPart().CFrame = cFrame3
    end

    if not self.lerpInitialCF or not (self.lerpTime > 0) then
        return
    end

    local partCFrame = self:GetPart().CFrame

    self.lerpTime -= arg4 * 4
    local num1 = math.clamp(1 - self.lerpTime, 0, 1)
    local var8 = self.lerpInitialCF:Lerp(partCFrame, num1)

    self:GetPart().CFrame = var8

    if self.lerpScaleSize.x > 0 or self.lerpScaleSize.y > 0 then
        local var9 = self.lerpInitialSize:Lerp(self.lerpScaleSize, num1)
        self:ResizeStuds(var9.x, var9.y, self.pixelsPerStud)
    end
end

function tbl2:SetLookedAt(arg1)
    if not self.isLookedAt and arg1 then
        self.isLookedAt = true
        self:OnMouseEnter(self.lookAtPixel.X, self.lookAtPixel.Y)
        if self.forceShowUntilLookedAt then
            self.forceShowUntilLookedAt = false
        end
    elseif self.isLookedAt and not arg1 then
        self.isLookedAt = false
        self:OnMouseLeave(self.lookAtPixel.X, self.lookAtPixel.Y)
    end
end

function tbl2:EvaluateGaze(arg1, arg2, _, _, arg3)
    self.isClosest = false
    self.lookAtPixel = vector2
    self.lookAtDistance = math.huge

    local var8 = nil
    local num1 = 0
    for _, subpanel in pairs(self.subpanels) do
        if not (subpanel.part and subpanel.guiElement) then
            continue
        end

        local var9, _, var10, var11 = module.RaycastOntoPanel(subpanel.part, subpanel.gui, subpanel.guiElement, arg3)
        if not var9 then
            continue
        end

        subpanel.lookAtPixel = var10
        subpanel.cursorPos = var10

        if var11 and num1 < subpanel.depthOffset then
            num1 = subpanel.depthOffset
            var8 = subpanel
        end
    end

    if var8 and var8.depthOffset > 0 then
        vector2_2 = var8.cursorPos
        var4 = var8

        for _, subpanel in pairs(self.subpanels) do
            if subpanel ~= var8 then
                subpanel:SetLookedAt(false)
            end
        end
        var8:SetLookedAt(true)
    end

    if self.panelType == module.Type.WristView then
        self.isWristHeldUp = false
        local cFrame3 = VRService:GetUserCFrame(Enum.UserCFrame.LeftHand)
        local pos = cFrame3.Position * workspace.CurrentCamera.HeadScale
        local var9 = arg1 * CFrame.new(pos)

        if self.distance == 0 then
            local var10 = arg1 * VRService:GetUserCFrame(Enum.UserCFrame.Head)
            local position = var9.Position
            local vec3 = Vector3.new(position.x, var10.Position.y - 0.33, position.z)

            local num2 = math.clamp((vec3 - var10.Position).Magnitude, 0.5, 1)
            local var11 = (vec3 - var10.Position).Unit * num2
            self.isWristHeldUp = (var10.Position + var11 - var9.Position).Magnitude < 0.25
        else
            local cFrame4 = VRService:GetUserCFrame(Enum.UserCFrame.RightHand)
            local other = cFrame3.Position - cFrame4.Position
            local num2 = cFrame4.LookVector:Dot(other)
            local var10 = cFrame4.Position + cFrame4.LookVector * num2
            if (cFrame3.Position - var10).Magnitude < 0.5 then
                self.isWristHeldUp = true
            end
        end
    end

    local gUi = self:GetGUI()

    local var9, _, var10, var11 = module.RaycastOntoPanel(self:GetPart(), gUi, gUi, arg3)

    if not var9 then
        self.isOffscreen = true

        if self.lookedAt then
            self.lookedAt = false
            self:OnMouseLeave(self.lookAtPixel.X, self.lookAtPixel.Y)
        end

        return
    end

    self.isOffscreen = false

    self.lookAtPixel = var10
    self.cursorPos = var10

    self:SetLookedAt(var11)

    self.lookAtDistance = (var9 - arg2.p).magnitude
    if not self.isLookedAt or not (self.lookAtDistance < huge) or not self.showCursor then
        return
    end

    huge = self.lookAtDistance
    var4 = self
    if not var8 then
        vector2_2 = self.cursorPos
    end
end

function tbl2:EvaluateTransparency()
    if self.panelType == module.Type.UIManagerManaged then
        self.transparency = 1
        return
    end

    if self.forceShowUntilLookedAt or not self.canFade or self.forceShowUntilTick > tick() or self.isLookedAt then
        self.transparency = 0
        return
    end

    if self.isOffscreen then
        self.transparency = 1
    else
        self.transparency = self:CalculateTransparency()
    end
end

function tbl2:Update(arg1, arg2, arg3, arg4, arg5, arg6)
    if (self.forceShowUntilLookedAt or self.forceShowUntilTick > tick()) and not self.part then
        self:GetPart()
        self:GetGUI()
    end
    if not self.part then
        return
    end

    local bool1 = var2 == self
    if not bool1 and self.linkedTo and self.linkedTo == var2 then
        bool1 = true
    end

    if var2 and not bool1 then
        self:SetEnabled(false)
        return
    end

    self:PreUpdate(arg1, arg2, arg3, arg4, arg6)
    if not self.isVisible then
        if self.alwaysUpdatePosition then
            self:EvaluatePositioning(arg1, arg2, arg3, arg6)
        end

        return
    end

    self:EvaluatePositioning(arg1, arg2, arg3, arg6)
    for _, subpanel in pairs(self.subpanels) do
        subpanel:Update()
    end

    self:EvaluateGaze(arg1, arg2, arg3, arg4, arg5)

    self:EvaluateTransparency(arg1, arg2)
end

function tbl2:PreUpdate(_, _, _, _, _) end

function tbl2.OnUpdate(_, _) end

function tbl2:OnMouseEnter(_, _) end

function tbl2:OnMouseLeave(_, _) end

function tbl2:OnEnabled(_) end

function tbl2.OnModalChanged(_, _) end

function tbl2:OnVisibilityChanged(_) end

function tbl2:CalculateTransparency(): number
    if not self.canFade then
        return 0
    end

    local absoluteSizeX = self.gui.AbsoluteSize.X
    local absoluteSizeY = self.gui.AbsoluteSize.Y
    local lookAtPixelX = self.lookAtPixel.X
    local lookAtPixelY = self.lookAtPixel.Y

    local var8 = lookAtPixelX < 0 and -lookAtPixelX or lookAtPixelX - absoluteSizeX
    local var9 = lookAtPixelY < 0 and -lookAtPixelY or lookAtPixelY - absoluteSizeY
    local var10 = if lookAtPixelX > 0 and lookAtPixelX < absoluteSizeX then 0 else var8

    local var11 = if lookAtPixelY > 0 and lookAtPixelY < absoluteSizeY then 0 else var9

    return math.max(0, math.min(1, (math.sqrt(var10 ^ 2 + var11 ^ 2) - 10) / 20))
end

function tbl2:ResizeStuds(width, height, arg1)
    if self.panelType == module.Type.UIManagerManaged then
        return
    end
    arg1 = arg1 or 64

    self.width = width
    self.height = height

    self.pixelScale = arg1 / 64

    local part = self:GetPart()
    part.Size = Vector3.new(self.width * workspace.CurrentCamera.HeadScale, self.height * workspace.CurrentCamera.HeadScale, 0.2)

    local gUi = self:GetGUI()
    gUi.CanvasSize = Vector2.new(arg1 * self.width, arg1 * self.height)

    for _, subpanel in pairs(self.subpanels) do
        if subpanel.part then
            subpanel.part.Size = part.Size
        end
        if subpanel.gui then
            subpanel.gui.CanvasSize = gUi.CanvasSize
        end
    end
end

function tbl2.ResizePixels(arg1, arg2, arg3, arg4)
    arg4 = arg4 or 64

    arg1:ResizeStuds(arg2 / arg4, arg3 / arg4, arg4)
end

function tbl2:OnHeadScaleChanged()
    local var8 = self.pixelScale * 64
    self:ResizeStuds(self.width, self.height, var8)
end

function tbl2:SetType(panelType, arg1)
    self.panelType = panelType

    self.localCF = CFrame.new()

    self.angleFromHorizon = false
    self.angleFromForward = false
    self.distance = 0

    arg1 = arg1 or {}

    if panelType == module.Type.None then
        return
    end

    if panelType == module.Type.Standard or panelType == module.Type.Fixed then
        self.localCF = arg1.CFrame or CFrame.new()
    elseif panelType == module.Type.HorizontalFollow then
        self.angleFromHorizon = CFrame.Angles(arg1.angleFromHorizon or 0, 0, 0)
        self.angleFromForward = CFrame.Angles(0, arg1.angleFromForward or 0, 0)
        self.distance = arg1.distance or 5
    elseif panelType == module.Type.FixedToHead or panelType == module.Type.NewStandard then
        self.localCF = arg1.CFrame or CFrame.new()
    elseif panelType == module.Type.WristView then
        self.localCF = arg1.CFrame or CFrame.new()
        self.distance = 0
    elseif panelType == module.Type.PositionLocked then
        self.localCF = arg1.CFrame or CFrame.new()
    elseif panelType == module.Type.UIManagerManaged then
        self.part = arg1.uiManagerPanelPart
    else
        error("Invalid Panel type")
    end
end

function tbl2:IsUIManagerManagedType(): boolean
    return self.panelType == module.Type.UIManagerManaged
end

function tbl2:IsPositionLockedType(): boolean
    return self.panelType == module.Type.PositionLocked
end

function tbl2:SetVisible(isVisible, arg1)
    if isVisible ~= self.isVisible then
        self:OnVisibilityChanged(isVisible)
        if not isVisible then
            module.OnPanelClosed:Fire(self.name)
        else
            self.needsPositionUpdate = true
            if self.panelType == module.Type.WristView then
                self.originCF = VRService:GetUserCFrame(Enum.UserCFrame.Head) * cFrame2
            end
        end
    end

    self.isVisible = isVisible
    self:SetEnabled(isVisible)
    if isVisible and arg1 then
        module.SetModalPanel(self)
    end
    if not isVisible and var2 == self then
        if arg1 then
            module.SetModalPanel(var3)
        else
            module.SetModalPanel(nil)

            if var3 == self then
                var3 = nil
            end
        end
    end

    if not isVisible and self.forceShowUntilLookedAt then
        self.forceShowUntilLookedAt = false
    end
end

function tbl2:IsVisible()
    return self.isVisible
end

function tbl2:LinkTo(linkedTo)
    if type(linkedTo) == "string" then
        self.linkedTo = module.Get(linkedTo)
        return
    end
    self.linkedTo = linkedTo
end

function tbl2:ForceShowUntilLookedAt(arg1)
    self:GetPart()
    self:GetGUI()

    self:SetVisible(true, arg1)
    self:RequestPositionUpdate()
    self.forceShowUntilLookedAt = true
end

function tbl2:ForceShowForSeconds(arg1)
    self:GetPart()
    self:GetGUI()

    self:SetVisible(true)
    if self.forceShowUntilTick < tick() then
        self:RequestPositionUpdate()
    end
    self.forceShowUntilTick = tick() + arg1
end

function tbl2:SetCanFade(canFade)
    self.canFade = canFade
end

function tbl2:RequestPositionUpdate()
    self.needsPositionUpdate = true
end

function tbl2:ForcePositionUpdate(alwaysUpdatePosition)
    self.alwaysUpdatePosition = alwaysUpdatePosition
end

function tbl2:GetGuiPositionInPanelSpace(arg1): Vector3
    local vector2_3 = Vector2.new(self.part.Size.X, self.part.Size.Y)
    local absoluteSize = self.gui.AbsoluteSize
    local var8 = (arg1 - absoluteSize / 2) / absoluteSize * vector2_3

    return Vector3.new(var8.X, var8.Y, 0.1)
end

function tbl2:GetCFrameInCameraSpace()
    if self.panelType == module.Type.Standard or self.panelType == module.Type.NewStandard then
        return self.originCF * self.localCF
    end

    return self.localCF or CFrame.new()
end

local tbl3 = {}
tbl3.__index = tbl3
function tbl3.new(parentPanel, guiElement)
    local tbl4 = {
        parentPanel = parentPanel,
        guiElement = guiElement,
        lastParent = guiElement.Parent,
        ancestryConn = nil,
        changedConn = nil,
        lookAtPixel = Vector2.new(-1, -1),
        cursorPos = Vector2.new(-1, -1),
        lookedAt = false,
        isEnabled = true,
        part = nil,
        gui = nil,
        guiSurrogate = nil,
        depthOffset = 0
    }
    setmetatable(tbl4, tbl3)

    tbl4:GetGUI()
    tbl4:UpdateSurrogate()
    tbl4:WatchParent(tbl4.lastParent)

    guiElement.Parent = tbl4.guiSurrogate

    local function ancestryCallback(_: Instance, parent: Instance)
        tbl4:GetGUI().Enabled = tbl4.parentPanel:GetGUI():IsAncestorOf(tbl4.lastParent)
        if not tbl4:GetGUI().Enabled then
            tbl4:GetPart().Parent = nil
        else
            tbl4:GetPart().Parent = workspace.CurrentCamera
        end
        if parent ~= guiElement then
            return
        end
        tbl4.ancestryConn:disconnect()

        tbl4.lastParent = guiElement.Parent
        guiElement.Parent = tbl4.guiSurrogate
        tbl4:WatchParent(tbl4.lastParent)

        tbl4.ancestryConn = guiElement.AncestryChanged:connect(ancestryCallback)
    end

    tbl4.ancestryConn = guiElement.AncestryChanged:connect(ancestryCallback)

    return tbl4
end

function tbl3:Cleanup()
    self.guiElement.Parent = self.lastParent
    if self.part then
        self.part:Destroy()
        self.part = nil
    end
    spawn(function()
        wait()
        if self.gui then
            self.gui:Destroy()
            self.gui = nil
        end
    end)
    if self.ancestryConn then
        self.ancestryConn:disconnect()
        self.ancestryConn = nil
    end
    if self.changedConn then
        self.changedConn:disconnect()
        self.changedConn = nil
    end
    self.lastParent = nil
    self.parentPanel = nil
    self.guiElement = nil
    self.guiSurrogate = nil
end

function tbl3:OnMouseEnter(_, _) end

function tbl3:OnMouseLeave(_, _) end

function tbl3:SetLookedAt(lookedAt)
    if lookedAt and not self.lookedAt then
        self:OnMouseEnter(self.lookAtPixel.X, self.lookAtPixel.Y)
    elseif not lookedAt and self.lookedAt then
        self:OnMouseLeave(self.lookAtPixel.X, self.lookAtPixel.Y)
    end
    self.lookedAt = lookedAt
end

function tbl3:WatchParent(arg1)
    if self.changedConn then
        self.changedConn:disconnect()
    end
    self.changedConn = arg1.Changed:connect(function(arg2)
        if arg2 == "AbsolutePosition" or arg2 == "AbsoluteSize" or arg2 == "Parent" then
            self:UpdateSurrogate()
        end
    end)
end

function tbl3:UpdateSurrogate()
    local lastParent = self.lastParent
    self.guiSurrogate.Position = UDim2.new(0, lastParent.AbsolutePosition.X, 0, lastParent.AbsolutePosition.Y)
    self.guiSurrogate.Size = UDim2.new(0, lastParent.AbsoluteSize.X, 0, lastParent.AbsoluteSize.Y)
end

function tbl3:GetPart()
    if not self.part then
        self.part = self.parentPanel:GetPart():Clone()
        self.part.Parent = CoreGuiFolder
    end

    return self.part
end

function tbl3:GetGUI()
    if not self.gui then
        self.gui = Create("SurfaceGui")({
            Parent = CoreGui,
            Adornee = self:GetPart(),
            Active = true,
            ToolPunchThroughDistance = 1000,
            CanvasSize = self.parentPanel:GetGUI().CanvasSize,
            Enabled = self.parentPanel.isEnabled,
            AlwaysOnTop = true
        })

        self.guiSurrogate = Create("Frame")({
            Parent = self.gui,
            Active = false,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        })
    end

    return self.gui
end

function tbl3:SetDepthOffset(depthOffset)
    self.depthOffset = depthOffset
end

function tbl3:Update()
    local part = self:GetPart()
    local part2 = self.parentPanel:GetPart()

    if part and part2 then
        part.CFrame = part2.CFrame * CFrame.new(0, 0, -self.depthOffset)
    end
end

function tbl3:SetEnabled(isEnabled)
    self.isEnabled = isEnabled
    if isEnabled and self.parentPanel.isEnabled then
        self:GetPart().Parent = CoreGuiFolder
        self:GetGUI().Enabled = true
        return
    end
    self:GetPart().Parent = nil
    self:GetGUI().Enabled = false
end

function tbl3:GetEnabled()
    return self.isEnabled
end

function tbl3:GetPixelScale()
    return self.parentPanel:GetPixelScale()
end

function tbl2:GetPixelScale()
    return self.pixelScale
end

function tbl2:AddSubpanel(arg1)
    local var8 = tbl3.new(self, arg1)
    self.subpanels[arg1] = var8
    return var8
end

function tbl2:RemoveSubpanel(arg1)
    local subpanel = self.subpanels[arg1]
    if subpanel then
        subpanel:Cleanup()
    end
    self.subpanels[arg1] = nil
end

function tbl2:SetSubpanelDepth(arg1, arg2)
    local subpanel = self.subpanels[arg1]

    if arg2 == 0 then
        if subpanel then
            self:RemoveSubpanel(arg1)
        end
        return nil
    end

    local var8 = subpanel or self:AddSubpanel(arg1)

    var8:SetDepthOffset(arg2)

    return var8
end

function module.Get(linkedTo)
    local var8 = tbl1[linkedTo]
    if not tbl1[linkedTo] then
        tbl1[linkedTo] = tbl2.new(linkedTo)
        var8 = tbl1[linkedTo]
    end
    return var8
end

local var8 = tick()
local function onRenderStep()
    if not VRService.VREnabled then
        return
    end

    local now = tick()
    local var9 = now - var8
    var8 = now

    var4 = nil
    huge = math.huge

    local currentCamera = workspace.CurrentCamera
    local currentCameraCFrame = currentCamera.CFrame
    local cFrame3 = currentCamera:GetRenderCFrame()
    local cFrame4 = VRService:GetUserCFrame(Enum.UserCFrame.Head)
    local ray = Ray.new(cFrame3.p, cFrame3.lookVector)

    local guiInputUserCFrame = VRService.GuiInputUserCFrame
    local var10 = currentCameraCFrame * VRService:GetUserCFrame(guiInputUserCFrame)
    local ray2 = Ray.new(var10.p, var10.lookVector)

    for _, value in pairs(tbl1) do
        value:Update(currentCameraCFrame, cFrame3, cFrame4, ray, ray2, var9)
    end

    local tbl4 = ({})
    for _, value in pairs(tbl1) do
        if tbl4[value] or not (value.linkedTo and value.isVisible and value.linkedTo.isVisible) then
            continue
        end

        tbl4[value] = true
        tbl4[value.linkedTo] = true

        local transparency = math.min(value.transparency, value.linkedTo.transparency)
        value.transparency = transparency
        value.linkedTo.transparency = transparency
    end

    for _, value in pairs(tbl1) do
        if value.part and value.gui then
            local bool1 = var2 == value

            if not bool1 and value.linkedTo and value.linkedTo == var2 then
                bool1 = true
            end

            local isVisible = value.isVisible
            if not bool1 and var2 then
                isVisible = false
            end

            if value.transparency >= 1 then
                isVisible = false
            end

            if value.forceShowUntilLookedAt then
                isVisible = true
            end

            if not value.canFade and value.isVisible then
                isVisible = true
            end

            value:SetEnabled(isVisible)
        end

        value:OnUpdate(var9)
    end

    if not var4 then
        var5.Parent = nil

        return
    end

    local vector22X = vector2_2.X
    local vector22Y = vector2_2.Y
    local pixelScale = var4:GetPixelScale()
    var5.Size = UDim2.new(0, 3 * pixelScale, 0, 3 * pixelScale)
    var5.Position = UDim2.new(0, vector22X - var5.AbsoluteSize.x * 0.5, 0, vector22Y - var5.AbsoluteSize.y * 0.5)
end
local bool1 = true
local function putFoldersIn(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    CoreGuiFolder.Parent = arg1
    CoreEffectFolder.Parent = arg1
end

local connection = nil
local function onHeadScaleChanged() -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in pairs(tbl1) do
        value:OnHeadScaleChanged()
    end
end

local connection2 = nil
local function onCameraCFrameChanged()
    local currentCamera = workspace.CurrentCamera
    local currentCameraCFrame = currentCamera.CFrame
    local cFrame3 = currentCamera:GetRenderCFrame()
    local cFrame4 = VRService:GetUserCFrame(Enum.UserCFrame.Head)
    local ray = Ray.new(cFrame3.p, cFrame3.lookVector)

    local guiInputUserCFrame = VRService.GuiInputUserCFrame
    local var9 = currentCameraCFrame * VRService:GetUserCFrame(guiInputUserCFrame)
    local ray2 = Ray.new(var9.p, var9.lookVector)

    for _, value in pairs(tbl1) do
        value:Update(currentCameraCFrame, cFrame3, cFrame4, ray, ray2, 0)
    end
end

local function onCurrentCameraChanged()
    onHeadScaleChanged()

    if connection then
        connection:disconnect()
    end
    connection = workspace.CurrentCamera:GetPropertyChangedSignal("HeadScale"):Connect(onHeadScaleChanged)

    if connection2 then
        connection2:disconnect()
    end
    connection2 = workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Connect(onCameraCFrameChanged)

    if VRService.VREnabled and bool1 then
        putFoldersIn(workspace.CurrentCamera)
    end
end

local connection3 = nil
local bool2 = false
local function onVREnabledChanged()
    if VRService.VREnabled then
        while not bool1 do
            wait()
        end

        if workspace.CurrentCamera then
            onCurrentCameraChanged()
        end
        connection3 = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCurrentCameraChanged)

        putFoldersIn(workspace.CurrentCamera)

        if not bool2 then
            RunService:BindToRenderStep(name, Enum.RenderPriority.Last.Value, onRenderStep)
            bool2 = true
        end
    else
        if connection3 then
            connection3:disconnect()
            connection3 = nil
        end

        putFoldersIn(nil)

        if bool2 then
            RunService:UnbindFromRenderStep(name)
            bool2 = false
        end
    end
end
VRService:GetPropertyChangedSignal("VREnabled"):connect(onVREnabledChanged)
spawn(onVREnabledChanged)

coroutine.wrap(function()
    while true do
        while workspace.CurrentCamera do
            if workspace.CurrentCamera.CameraSubject ~= nil or workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                bool1 = true
                return
            end

            workspace.CurrentCamera.Changed:Wait()
        end

        wait()
    end
end)()

return module
