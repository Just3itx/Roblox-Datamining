-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Types)
local avatarFloorPosition = require(script.Parent._Utils.avatarFloorPosition)
local frameCamera = require(script.Parent._Utils.frameCamera)
local cameraPath = require(script.Parent._Utils.cameraPath)
local avatarBackground = require(script.Parent._Utils.avatarBackground)
local avatarRig = require(script.Parent._Utils.avatarRig)
local applyDefaultClothing = require(script.Parent._Utils.applyDefaultClothing)
local createPlayhead = require(script.Parent._Utils.createPlayhead)
local addKeyLight = require(script.addKeyLight)
local addFallbackBackdrop = require(script.addFallbackBackdrop)
local resolveOutfit = require(script.resolveOutfit)
local emotes = require(script.emotes)
local Flags = require(script.Flags)

local function resolveBackgroundAssetId(backgroundAssetId: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if typeof(backgroundAssetId) == "number" and backgroundAssetId > 0 then backgroundAssetId else avatarBackground.DEFAULT_ASSET_ID
end

local function resolveEmoteId(tbl1, humanoidRigType)
    if emotes.isName(tbl1.emote) then
        return emotes.resolve(tbl1.emote, humanoidRigType)
    end
    if tbl1.emote ~= nil then
        warn(`AvatarMoment: unknown emote {tbl1.emote}, falling through to emoteId or wave`)
    end
    if typeof(tbl1.emoteId) ~= "number" or not (tbl1.emoteId > 0) then
        return emotes.resolve("wave", humanoidRigType)
    end

    if humanoidRigType == Enum.HumanoidRigType.R6 then
        warn(
            `AvatarMoment: emoteId {tbl1.emoteId} plays as authored on an R6 rig, and an R15 clip will not move it. The emote arg resolves per rig.`
        )
    end
    return tbl1.emoteId
end

local function addBackdrop(model: Model, backgroundAssetId: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    addKeyLight(model)
    local var1 = resolveBackgroundAssetId(backgroundAssetId)
    local var2 = avatarBackground.attach(model, var1)
    if var2 == nil then
        addFallbackBackdrop(model)
    end
    return var2
end

local function positiveId(arg1): number? -- Luacid: Inlined by compiler; 2 call sites recovered
    return if typeof(arg1) == "number" and arg1 > 0 then arg1 else nil
end

local function resolveSnapshot(tbl1)
    local var1 = positiveId(tbl1.outfitId)
    local var2 = positiveId(tbl1.userId)

    if var1 ~= nil and var2 ~= nil then
        error("AvatarMoment: supply outfitId or userId, not both")
    end
    if var1 ~= nil then
        return resolveOutfit.resolve(var1)
    end
    if var2 ~= nil then
        return resolveOutfit.resolveUser(var2)
    end
    error("AvatarMoment: outfitId or userId (positive number) is required")
end

local function buildAvatarMoment(tbl1)
    local tbl2 = tbl1 or {}
    local var1

    if Flags.MomentScenesAvatarMomentUserId then
        var1 = resolveSnapshot(tbl2)
    else
        if typeof(tbl2.outfitId) ~= "number" or tbl2.outfitId <= 0 then
            error("AvatarMoment: outfitId (positive number) is required")
        end
        var1 = resolveOutfit.resolve(tbl2.outfitId)
    end

    local live3DScene = Instance.new("Model")
    live3DScene.Name = "Live3DScene"

    local var2 = addBackdrop(live3DScene, tbl2.backgroundAssetId)

    live3DScene.WorldPivot = CFrame.new()
    if var2 ~= nil then
        avatarBackground.pinToParent(var2, live3DScene)
    end

    local humanoidDescription = var1.humanoidDescription
    if Flags.MomentScenesAvatarMomentDefaultClothing then
        humanoidDescription = applyDefaultClothing(humanoidDescription)
    end
    local avatar = avatarRig.createAvatar(humanoidDescription, var1.rigType)
    avatar.Name = "Avatar"
    local humanoid = avatar:FindFirstChildOfClass("Humanoid")
    if humanoid ~= nil then
        humanoid.NameOcclusion = Enum.NameOcclusion.OccludeAll
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        humanoid.NameDisplayDistance = 0
    end
    avatarFloorPosition.positionOnFloor(avatar, 0, CFrame.new())
    avatar.Parent = live3DScene
    local var3 = if var1.gearAssetId ~= nil then avatarRig.equipGear(avatar, var1.gearAssetId, var1.rigType) else nil
    local sceneCamera = Instance.new("Camera")
    sceneCamera.Name = "SceneCamera"
    sceneCamera.CameraType = Enum.CameraType.Scriptable
    sceneCamera.FieldOfView = 56
    sceneCamera.Parent = live3DScene

    local cameraPath2 = tbl2.cameraPath or "subtle"
    local var4 = cameraPath.resolve(cameraPath2)

    local _, pos, var5 = (if cameraPath.framingFor(cameraPath2) == "face" then frameCamera.fitStandingFace else frameCamera.fitStandingCharacters)(
        { avatar },
        sceneCamera.FieldOfView
    )
    sceneCamera.Focus = CFrame.new(pos)

    local var6 = resolveEmoteId(tbl2, var1.rigType)
    local var7 = avatarRig.playEmote(avatar, var6)

    local function duration() -- Luacid: Inlined by compiler; 2 call sites recovered
        local var8 = if var7 == nil then 0 else var7.Length
        return if var8 <= 0 then 0 else var8 * 4
    end

    local var8 = createPlayhead
    local tbl3 = {
        root = live3DScene,
        tracks = var7 == nil and {} or { var7 },
        animator = if humanoid == nil then nil else humanoid:FindFirstChildOfClass("Animator"),
        getDuration = duration,
        syncVisuals = 0,
        play = 0,
        dispose = 0
    }

    function tbl3.syncVisuals(num1: number)
        local var9 = duration()
        local var10 = if var9 > 0 then num1 % var9 / var9 else 0
        sceneCamera.CFrame = cameraPath.eval(pos, var5, var4, var10)
    end
    function tbl3.play(callback)
        if humanoid ~= nil then
            humanoid.AutoRotate = false
        end
        callback()
    end
    function tbl3.dispose(callback)
        if var3 ~= nil then
            var3:Stop(0)
            var3 = nil
        end
        callback()
    end

    local playhead = var8(tbl3)

    local bool1 = duration() > 0

    return {
        root = live3DScene,
        camera = sceneCamera,
        playhead = playhead,
        capabilities = { canUserToggle = bool1, hasDuration = bool1 },
        dispose = playhead.dispose
    }
end

return buildAvatarMoment
