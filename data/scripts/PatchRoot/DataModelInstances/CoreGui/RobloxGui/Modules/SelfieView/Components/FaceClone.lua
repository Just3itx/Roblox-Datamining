-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ModelUtils = require(script.Parent.Parent.Utils.ModelUtils)
local UserInputService = game:GetService("UserInputService")
local var1 = game:FindService("FaceAnimatorService")

local CharacterUtility = require(CorePackages.Packages.Thumbnailing).CharacterUtility
local CFrameUtility = require(CorePackages.Packages.Thumbnailing).CFrameUtility

local engineFeature = game:GetEngineFeature("PlayerViewRemoteEventSupport")

local trackerStreamAnimation = nil
local var2 = nil
local bool1 = game:DefineFastFlag("SelfViewRestorePoseSynchronization", false)
local bool2 = game:DefineFastFlag("DebugSelfViewPerfBenchmark", false)
local GetFFlagSelfViewVisibilityFix = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagSelfViewVisibilityFix

local RunService = game:GetService("RunService")

local Y = 1.31

local num1 = 0

local connection = nil
local connection2 = nil
local tbl1 = ({})

local tbl2 = {}

local animator = nil
local tbl3 = {}
local tbl4 = {}
local var3 = nil
local Size = nil

local viewportFrame = nil
local camera = nil

local vec3 = Vector3.new(1.1721, 1.1811, 1.1578)
local var4 = nil
local clone = nil
local head = nil
local var5 = nil
local neck = nil
local cFrame = nil
local var6 = nil
local var7 = nil
local var8 = nil
local bool3 = false

local num2 = 0

local tbl5 = ({})
local tbl6 = {
    AnimationPlayed = "AnimationPlayed",
    AnimationPlayedCoreScript = "AnimationPlayedCoreScript",
    DescendantAdded = "DescendantAdded",
    DescendantRemoving = "DescendantRemoving",
    HeadSize = "HeadSize",
    Color = "Color",
    CharacterAdded = "CharacterAdded",
    CharacterRemoving = "CharacterRemoving",
    HumanoidStateChanged = "HumanoidStateChanged",
    FaceControlsChanged = "FaceControlsChanged"
}

local Players = game:GetService("Players")
if not Players.LocalPlayer then
    warn("Players.LocalPlayer does not exist")
end
local LocalPlayer = Players.LocalPlayer

local bool4 = false

function setCloneDirty(bool5: boolean)
    if bool5 then
        num1 = 0.35
        return
    end
    num1 = 0
end

function createCloneAnchor()
    if var4 ~= nil then
        var4:Destroy()
        var4 = nil
    end

    local worldModel = Instance.new("WorldModel")
    worldModel.Parent = viewportFrame

    var4 = worldModel
end

local function clearObserver(str1: string) -- Luacid: Inlined by compiler; 19 call sites recovered
    if tbl5[str1] then
        tbl5[str1]:Disconnect()
        tbl5[str1] = nil
    end
end

function clearCloneCharacter()
    if clone then
        clone:Destroy()
        clone = nil
    end

    if not var4 then
        warn("cloneAnchor is nil, this shouldn't be possible")
        return
    end
    assert(var4 ~= nil)
    local selfAvatar = var4:FindFirstChild("SelfAvatar")
    if selfAvatar then
        selfAvatar:Destroy()
    end

    createCloneAnchor()
end

local function clearClone()
    stopRenderStepped()
    clearObserver("AnimationPlayed")
    clearObserver("AnimationPlayedCoreScript")

    for _, value in tbl3 do
        if value then
            value:Stop(0)
        end
    end
    if var2 then
        var2:Stop(0)
        var2 = nil
    end

    animator = nil
    tbl3 = {}

    clearCloneCharacter()
end

local function syncTrack(animator2, arg1)
    if not (animator2 and arg1.Animation) then
        return
    end

    local var9 = nil
    if not (arg1.Animation and arg1.Animation:IsA("Animation")) then
        if arg1.Animation and arg1.Animation:IsA("TrackerStreamAnimation") then
            if var2 then
                var2:Stop(0)
            end
            trackerStreamAnimation = Instance.new("TrackerStreamAnimation")
            assert(trackerStreamAnimation ~= nil)
            if game:GetEngineFeature("UseNewLoadStreamAnimationAPI") then
                var2 = animator2:LoadStreamAnimationV2(trackerStreamAnimation, LocalPlayer, false, false)
            else
                var2 = animator2:LoadStreamAnimationForSelfieView_deprecated(trackerStreamAnimation, LocalPlayer)
            end
            var9 = var2
        else
            warn("No animation to clone in SelfView")
        end
    end

    if not var9 then
        return
    end
    var9:Play()
    local priority = arg1.Priority
    var9.Priority = priority

    tbl1[arg1] = arg1.Stopped:Connect(function()
        var9:Stop(0)
        if tbl1[arg1] then
            tbl1[arg1]:Disconnect()
        end
    end)
end

local function updateClone(arg1)
    clearClone()

    if not arg1 then
        return
    end
    assert(arg1 ~= nil)

    startRenderStepped(arg1)

    local _character = arg1.Character

    if not (arg1 and arg1.Character) then
        return
    end

    local character = arg1.Character

    if not character then
        return
    end

    assert(character ~= nil)

    local animator2 = ModelUtils.getAnimator(character, 10)

    clearCloneCharacter()

    local archivable = character.Archivable
    character.Archivable = true

    local head2 = ModelUtils.getHead(character)

    if not head2 then
        return
    end

    clone = character:Clone()
    if clone == nil then
        return
    end
    assert(clone ~= nil)

    ModelUtils.resetPartOrientation(clone)

    ModelUtils.updateTransparency(clone, tbl2)

    ModelUtils.removeTags(clone)

    clone.Name = "SelfAvatar"

    ModelUtils.removeScripts(clone)

    ModelUtils.sanitizeCharacter(clone)

    character.Archivable = archivable

    clone.Parent = var4

    local humanoidRootPart = clone:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        humanoidRootPart.CFrame = CFrame.new(Vector3.new(0, 0, 0))
        assert(camera ~= nil)

        if head2 then
            local head3 = ModelUtils.getHead(clone)
            if head3 then
                assert(head3 ~= nil)

                local targetCFrame = CFrameUtility.CalculateTargetCFrame(head3.CFrame)
                local var9, var10 = CharacterUtility.CalculateHeadExtents(clone, targetCFrame)

                local vec3_2 = Vector3.new(var9.X, var9.Y, var9.Z)
                vec3 = Vector3.new(var10.X, var10.Y, var10.Z) - vec3_2

                assert(vec3 ~= nil)

                Y = head3.Size.Y
                math.min(vec3.X, vec3.Y)
                local num3 = math.min(vec3.X, vec3.Z)

                local model = Instance.new("Model")
                model.Parent = clone
                local head4 = ModelUtils.getHead(clone)
                character.Archivable = true
                var5 = head4:Clone()

                assert(var5 ~= nil)
                var5.CanCollide = false
                var5.Parent = model

                neck = ModelUtils.getNeck(clone, var5)
                cFrame = var5.CFrame
                var5:Destroy()
                assert(cFrame ~= nil)

                local var11 = cFrame.Position + cFrame.LookVector * (num3 * 2)
                camera.CFrame = CFrame.lookAt(var11 + Vector3.new(0, 0.105, -0.25), cFrame.Position)
                camera.Focus = cFrame

                character.Archivable = archivable
                model:Destroy()
            end
        else
            local var9 = humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * 2.5
            camera.CFrame = CFrame.lookAt(var9 + Vector3.new(0, 1.5, 0), humanoidRootPart.Position)
            camera.CFrame = CFrame.new(camera.CFrame.Position) * CFrame.Angles(-0.0006981317007977319, math.pi, 0)
        end
    end

    if clone == nil then
        return
    end

    local humanoid = clone:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    end
    animator = ModelUtils.getAnimator(clone, 0)

    if not animator then
        return
    end

    if not bool1 then
        local playingAnimationTracks = animator:GetPlayingAnimationTracks()
        local playingAnimationTracksCoreScript = animator:GetPlayingAnimationTracksCoreScript()

        for _, playingAnimationTrack in ipairs(playingAnimationTracks) do
            if playingAnimationTrack ~= nil then
                playingAnimationTrack:Stop(0)
                playingAnimationTrack:Destroy()
            end
        end

        for _, value in ipairs(playingAnimationTracksCoreScript) do
            if value ~= nil then
                value:Stop(0)
                value:Destroy()
            end
        end

        if trackerStreamAnimation then
            trackerStreamAnimation:Destroy()
            trackerStreamAnimation = nil
        end
    end

    if not animator2 then
        return
    end

    if bool1 then
        animator:SynchronizeWith(animator2)
    else
        for _, value in ipairs(animator2:GetPlayingAnimationTracksCoreScript()) do
            syncTrack(animator, value)
        end

        tbl5.AnimationPlayedCoreScript = animator2.AnimationPlayedCoreScript:Connect(function(animationTrack: AnimationTrack)
            syncTrack(animator, animationTrack)
        end)
    end

    setCloneDirty(false)
end

local function hasProperty(arg1, str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    local _ = arg1[str1]
end

function updateCachedHeadColor(arg1)
    if arg1 == nil then
        return
    end
    assert(arg1 ~= nil)

    if not pcall(function()
        hasProperty(arg1, "Color")
    end) then
        return
    end

    var3 = arg1.Color
    if pcall(function()
        hasProperty(arg1, "Size")
    end) then
        Size = arg1.Size
    end
end

local function addHumanoidStateChangedObserver(arg1) -- Luacid: unused: defined but never referenced
    if not arg1 then
        return
    end
    if tbl5.HumanoidStateChanged then
        return
    end

    tbl5.HumanoidStateChanged = arg1.StateChanged:Connect(function(humanoidStateType, humanoidStateType2)
        if humanoidStateType == Enum.HumanoidStateType.PlatformStanding and humanoidStateType2 == Enum.HumanoidStateType.Running then
            setCloneDirty(true)
        end
        if humanoidStateType2 == Enum.HumanoidStateType.GettingUp then
            setCloneDirty(true)
        end
    end)
end

local function addFaceControlsObserver(arg1) -- Luacid: unused: defined but never referenced
    if not tbl5.FaceControlsChanged then
        tbl5.FaceControlsChanged = arg1.InternalFacsOverrideChanged:Connect(function()
            setCloneDirty(true)
        end)
    end
end

local function characterAdded(arg1)
    if viewportFrame == nil or var6 == nil or not arg1 then
        return
    end

    head = ModelUtils.getHead(arg1)
    updateCachedHeadColor(head)
    clearObserver("DescendantAdded")
    clearObserver("DescendantRemoving")
    clearObserver("HeadSize")
    clearObserver("Color")
    local humanoid = arg1:FindFirstChildWhichIsA("Humanoid")

    if humanoid and not tbl5[tbl6.HumanoidStateChanged] then
        tbl5[tbl6.HumanoidStateChanged] = humanoid.StateChanged:Connect(function(old: Enum.HumanoidStateType, new: Enum.HumanoidStateType)
            if old == Enum.HumanoidStateType.PlatformStanding and new == Enum.HumanoidStateType.Running then
                setCloneDirty(true)
            end
            if new == Enum.HumanoidStateType.GettingUp then
                setCloneDirty(true)
            end
        end)
    end
    local var9 = arg1:FindFirstChildWhichIsA("FaceControls", true)

    if var9 and not tbl5[tbl6.FaceControlsChanged] then
        tbl5[tbl6.FaceControlsChanged] = var9.InternalFacsOverrideChanged:Connect(function()
            setCloneDirty(true)
        end)
    end

    tbl5.DescendantAdded = arg1.DescendantAdded:Connect(function(descendant: Instance)
        if viewportFrame == nil or var6 == nil then
            return
        end
        if descendant.Name == "Head" then
            head = ModelUtils.getHead(arg1)

            updateCachedHeadColor(head)
        end

        if descendant:IsA("Humanoid") and descendant and not tbl5[tbl6.HumanoidStateChanged] then
            tbl5[tbl6.HumanoidStateChanged] = descendant.StateChanged:Connect(function(old: Enum.HumanoidStateType, new: Enum.HumanoidStateType)
                if old == Enum.HumanoidStateType.PlatformStanding and new == Enum.HumanoidStateType.Running then
                    setCloneDirty(true)
                end
                if new == Enum.HumanoidStateType.GettingUp then
                    setCloneDirty(true)
                end
            end)
        end

        if descendant:IsA("FaceControls") and not tbl5[tbl6.FaceControlsChanged] then
            tbl5[tbl6.FaceControlsChanged] = descendant.InternalFacsOverrideChanged:Connect(function()
                setCloneDirty(true)
            end)
        end

        if ModelUtils.shouldMarkCloneDirtyForDescendant(descendant) then
            setCloneDirty(true)
        end
    end)
    tbl5.DescendantRemoving = arg1.DescendantRemoving:Connect(function(descendant: Instance)
        if viewportFrame == nil or var6 == nil then
            return
        end

        if not descendant or not descendant:IsA("MeshPart") and not descendant:IsA("Accessory") then
            return
        end

        if descendant:IsA("MeshPart") and descendant.MeshId == "" then
            return
        end

        if ModelUtils.shouldMarkCloneDirtyForDescendant(descendant) then
            setCloneDirty(true)
        end
    end)

    setCloneDirty(true)
    bool3 = true
end

local function createViewport()
    if viewportFrame then
        viewportFrame:Destroy()
    end

    viewportFrame = Instance.new("ViewportFrame")
    viewportFrame.Position = UDim2.new(0, 0, 0, 0)
    viewportFrame.Size = UDim2.new(1, 0, 1, 0)
    viewportFrame.BackgroundTransparency = 1
    viewportFrame.Parent = var6

    viewportFrame.Ambient = Color3.new(0.7529411765, 0.7098039216, 0.7137254902)
    viewportFrame.LightColor = Color3.new(1, 0.9960784314, 0.9960784314)
    viewportFrame.LightDirection = Vector3.new(9.5, -12, 7.5)
    viewportFrame.IsMirrored = true

    local _uiCorner = Instance.new("UICorner")
    Instance.new("UICorner").Parent = viewportFrame

    createCloneAnchor()

    if var6 then
        var6.Destroying:Connect(clearViewportFrame)
    end

    camera = Instance.new("Camera")
    assert(camera ~= nil)

    camera.FieldOfView = 70
    viewportFrame.CurrentCamera = camera
    camera.Parent = viewportFrame
end

function ReInit(localPlayer)
    assert(localPlayer.Character ~= nil)

    if GetFFlagSelfViewVisibilityFix() and var8 and not var8.Visible then
        bool4 = false
        return
    end

    head = ModelUtils.getHead(localPlayer.Character)
    updateCachedHeadColor(head)

    setCloneDirty(false)
    clearObserver("CharacterAdded")
    clearObserver("CharacterRemoving")
    clearClone()
    createViewport()
    playerAdded(localPlayer)
    startRenderStepped(localPlayer)
end

local function onCharacterAdded(character: Model)
    if connection2 then
        connection2:Disconnect()
    end
    if not bool3 then
        characterAdded(character)
    else
        ReInit(LocalPlayer)
    end

    clearObserver("HumanoidStateChanged")
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid then
        return
    end

    if not humanoid then
        return
    end
    if tbl5[tbl6.HumanoidStateChanged] then
        return
    end

    tbl5[tbl6.HumanoidStateChanged] = humanoid.StateChanged:Connect(function(old: Enum.HumanoidStateType, new: Enum.HumanoidStateType)
        if old == Enum.HumanoidStateType.PlatformStanding and new == Enum.HumanoidStateType.Running then
            setCloneDirty(true)
        end
        if new == Enum.HumanoidStateType.GettingUp then
            setCloneDirty(true)
        end
    end)
end

local function FindInParents(str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if not str1 then
        return nil
    end

    if not var6 then
        return nil
    end

    assert(var6 ~= nil, "Wrapper Frame cannot be nil")
    assert(str1 ~= nil, "Frame name cannot be nil ")

    return var6:FindFirstAncestor(str1)
end

function clearViewportFrame()
    if viewportFrame then
        viewportFrame:Destroy()
    end
    var6 = nil
    stopRenderStepped()
end

local function onOuterContainerVisibilityChanged()
    if not var8 then
        return
    end

    if not var8.Visible then
        bool4 = false
        return
    end

    if not bool3 then
        return
    end
    bool4 = true
end

function playerAdded(arg1)
    if arg1 == nil or arg1 ~= LocalPlayer then
        return
    end

    if connection2 ~= nil then
        connection2:Disconnect()
        connection2 = nil
        clearObserver("CharacterAdded")
    end

    local _character = arg1.Character
    local character = arg1.Character

    connection2 = arg1.CharacterAdded:Connect(onCharacterAdded)

    if character then
        characterAdded(character)
    end

    tbl5.CharacterAdded = arg1.CharacterAdded:Connect(characterAdded)
    tbl5.CharacterRemoving = arg1.CharacterRemoving:Connect(function()
        clearObserver("DescendantAdded")
        clearObserver("DescendantRemoving")
        clearObserver("HeadSize")
        clearObserver("Color")
        clearClone()
        clearObserver("CharacterRemoving")
    end)
end

function stopRenderStepped()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

function updateClonePartsColor(color)
    if pcall(function()
        hasProperty(head, "Color")
    end) and head and head.Color ~= var3 then
        local character = LocalPlayer.Character

        if not character then
            return
        end
        assert(character ~= nil)

        if not clone then
            return
        end
        assert(clone ~= nil)

        for _, child in pairs(character:GetChildren()) do
            if not child:IsA("MeshPart") then
                continue
            end

            local var9 = clone:FindFirstChild(child.Name)
            if var9 and var9:IsA("MeshPart") and var9.Color and child.Color then
                var9.Color = child.Color
            end
        end
    end

    var3 = color
end

function startRenderStepped(arg1)
    stopRenderStepped()
    local rbxScriptSignal = if bool2 then RunService.Heartbeat else RunService.RenderStepped

    connection = rbxScriptSignal:Connect(function(num3: number)
        if bool2 then
            debug.profilebegin("faceclone")
        end

        if GetFFlagSelfViewVisibilityFix() and clone and var8 and not bool4 then
            if animator ~= nil then
                local playingAnimationTracks = animator:GetPlayingAnimationTracks()
                for _, playingAnimationTrack in pairs(playingAnimationTracks) do
                    if playingAnimationTrack ~= nil then
                        playingAnimationTrack:Stop(0)
                    end
                end
            end
            return
        end

        if LocalPlayer then
            local character = LocalPlayer.Character

            if not character or character.Parent == nil then
                return
            end
            assert(character ~= nil)

            if head == nil or head.Parent ~= character then
                head = ModelUtils.getHead(character)
            end

            if head then
                local animator2 = ModelUtils.getAnimator(character, 0)

                if animator ~= nil and animator2 ~= nil then
                    assert(animator ~= nil)

                    local playingAnimationTracks = animator:GetPlayingAnimationTracks()
                    for _, playingAnimationTrack in pairs(playingAnimationTracks) do
                        if playingAnimationTrack ~= nil then
                            playingAnimationTrack:Stop(0)
                        end
                    end

                    local playingAnimationTracks2 = animator2:GetPlayingAnimationTracks()

                    tbl4 = {}
                    for _, playingAnimationTrack in ipairs(playingAnimationTracks2) do
                        local animation = playingAnimationTrack.Animation
                        if not animation or not animation:IsA("Animation") or animation.AnimationId == "" then
                            continue
                        end

                        tbl4[animation.AnimationId] = playingAnimationTrack
                        if not tbl3[animation.AnimationId] then
                            tbl3[animation.AnimationId] = animator:LoadAnimation(animation)
                        end
                        local var9 = tbl3[animation.AnimationId]
                        assert(var9 ~= nil)
                        var9:Play()
                        var9.TimePosition = playingAnimationTrack.TimePosition
                        var9.Priority = playingAnimationTrack.Priority
                        var9:AdjustWeight(playingAnimationTrack.WeightCurrent, 0.1)
                    end

                    for value in tbl3 do
                        local var9 = tbl3[value]
                        if not var9 then
                            continue
                        end

                        local animation = var9.Animation
                        if not animation or tbl4[animation.AnimationId] then
                            continue
                        end

                        local var10 = tbl3[animation.AnimationId]
                        if var10 ~= nil then
                            var10:Stop(0)
                        end
                        tbl3[animation.AnimationId] = nil
                    end

                    for _, value in ipairs(animator2:GetPlayingAnimationTracksCoreScript()) do
                        local playingAnimationTracksCoreScript = animator:GetPlayingAnimationTracksCoreScript()
                        for _, value2 in pairs(playingAnimationTracksCoreScript) do
                            if value2.Animation:IsA("TrackerStreamAnimation") then
                                value2.Priority = value.Priority
                                value2:AdjustWeight(value.WeightCurrent, 0)
                            end
                        end
                    end
                end
            end

            local var9 = nil

            local platform = UserInputService:GetPlatform()
            if (platform == Enum.Platform.IOS or platform == Enum.Platform.Android) and animator ~= nil then
                local playingAnimationTracksCoreScript = animator:GetPlayingAnimationTracksCoreScript()
                for _, value in pairs(playingAnimationTracksCoreScript) do
                    if value.Animation:IsA("TrackerStreamAnimation") then
                        local _, _
                        _, var9, _ = value:GetTrackerData()
                    end
                end
            end

            num2 += 1
            if num2 == 1 then
                num2 = 0

                if clone then
                    var5 = not var5 and ModelUtils.getHead(clone)

                    if var5 then
                        neck = ModelUtils.getNeck(clone, var5)
                    end

                    if var5 then
                        cFrame = var5.CFrame
                    end
                end

                if camera and var5 then
                    local position = var5.Position
                    local position2 = var5.Position

                    local _cFrame = var5.CFrame

                    if neck then
                        local part0 = neck.Part0
                        local _part1 = neck.Part1
                        local c0 = neck.C0
                        local c1 = neck.C1
                        local transform = neck.Transform

                        if part0 and c0 then
                            local var10 = part0.CFrame * c0 * transform * c1:Inverse()

                            position2 = Vector3.new(
                                var10.Position.X * 0.25,
                                (var5.CFrame.Position.Y + var10.Position.Y + var10.Position.Y * 0.75) * 0.33333,
                                var10.Position.Z
                            )

                            position = Vector3.new(
                                var10.Position.X * 0.6,
                                (var5.CFrame.Position.Y + var10.Position.Y + var10.Position.Y * 0.75) * 0.33333,
                                var10.Position.Z
                            )
                        end
                    end

                    if not vec3 then
                        warn("boundsSize is nil, this shouldn't be possible")
                    end
                    assert(vec3 ~= nil)

                    if var1 and var1.VideoAnimationEnabled and (var9 ~= nil or engineFeature) then
                        if engineFeature then
                            local cFrame2 = game:GetService("PlayerViewService"):GetDeviceCameraCFrameForSelfView()
                            local cFrame2Position = cFrame2.Position
                            local rx, ry, rz = cFrame2:ToEulerAnglesYXZ()
                            local cFrame3 = CFrame.fromEulerAnglesYXZ(rx, ry, rz)
                            local var10 = if cFrame2Position.Z > 0 then math.clamp(0.5 - cFrame2Position.Z * 3, -0.5, 0.5) else 0
                            local num4 = -(vec3.Z + 1)

                            local vec3_2 = Vector3.new(0, 0.105, math.floor((num4 + var10 * num4) * 100) / 100)

                            camera.CFrame = camera.CFrame:Lerp(CFrame.lookAt(cFrame3 * (position + vec3_2), position2), 0.5)
                        elseif var9 then
                            local vec3_2 = Vector3.new(0, 0.105, -(vec3.Z + 1))
                            local var10, var11, var12 = var9:ToEulerAnglesXYZ()

                            local cFrame2 = CFrame.Angles(-var10 * 0.5, -var11 * 0.5, -var12 * 0.5)

                            camera.CFrame = CFrame.lookAt(cFrame2 * (position + vec3_2), position2)
                        end
                    else
                        local vec3_2 = Vector3.new(0, Y * 0.25 - 1.25, -(vec3.Z + 1) + 0.125)

                        if character then
                            local head2 = character:FindFirstChild("Head")
                            if head2 then
                                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                                if humanoidRootPart then
                                    local var10 = humanoidRootPart.CFrame:Inverse() * head2.CFrame

                                    local vec3_3 = Vector3.new(var10.Position.X * 0.15 + 0.125, var10.Position.Y, var10.Position.Z * 0.05)

                                    camera.CFrame = CFrame.lookAt(position + vec3_2 + vec3_3, position2)
                                    camera.Focus = var5.CFrame
                                end
                            end
                        end
                    end
                end
            end

            if head then
                if head.Size ~= Size then
                    Size = head.Size
                    setCloneDirty(true)
                end

                if pcall(function()
                    hasProperty(head, "Color")
                end) and head.Color ~= var3 then
                    updateClonePartsColor(head.Color)
                end
            end
        end

        if num1 > 0 then
            num1 -= num3
            if num1 <= 0 then
                updateClone(arg1)
                num1 = 0
            end
        end

        if bool2 then
            debug.profileend()
        end
    end)
end

local function Initialize(arg1, arg2, str1: string?)
    if not arg2 then
        return
    end

    var6 = arg2

    if GetFFlagSelfViewVisibilityFix() and str1 then
        var7 = str1

        var8 = FindInParents(var7)

        if var8 then
            var8:GetPropertyChangedSignal("Visible"):Connect(onOuterContainerVisibilityChanged)
        end
    end

    createViewport()

    playerAdded(arg1)

    Players.PlayerAdded:Connect(playerAdded)
    Players.PlayerRemoving:Connect(function(player: Player)
        if player ~= LocalPlayer then
            return
        end

        clearObserver("HumanoidStateChanged")
        clearObserver("CharacterAdded")
        clearObserver("CharacterRemoving")
        clearObserver("FaceControlsChanged")
        clearClone()
    end)

    startRenderStepped(arg1)

    return clearClone
end

return Initialize
