-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileBackground = script:FindFirstAncestor("EditProfileBackground")
local EditProfileBackgroundParent = EditProfileBackground.Parent
local React = require(EditProfileBackgroundParent.React)
local Cryo = require(EditProfileBackgroundParent.Cryo)
local Foundation = require(EditProfileBackgroundParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local View = Foundation.View
local useLocalUserId = require(EditProfileBackgroundParent.RobloxAppHooks).useLocalUserId
local useSelectedTheme = require(EditProfileBackgroundParent.RoactUtils).Hooks.useSelectedTheme
local getDisplayBackgroundId = require(EditProfileBackground.Common.BackgroundUtils).getDisplayBackgroundId
local ErrorTypes = require(EditProfileBackground.Analytics).ErrorTypes

local FFlagProfilePlatformNewProfileHeader = require(EditProfileBackgroundParent.SharedFlags).FFlagProfilePlatformNewProfileHeader

local FFlagProfilePlatformMeTabMobileProfileHero = require(EditProfileBackgroundParent.SharedFlags).FFlagProfilePlatformMeTabMobileProfileHero
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Promise = require(EditProfileBackgroundParent.Promise)
local LoadableImage = require(EditProfileBackgroundParent.UIBlox).App.Loading.LoadableImage

local function shouldEnableAnimation(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return UserInputService.PreferredInput ~= Enum.PreferredInput.Touch
end

local midGray = Color3.fromRGB(210, 210, 210)
local institutionalWhite = Color3.fromRGB(250, 250, 250)

local var1 = if FFlagProfilePlatformNewProfileHeader then 6.5 else nil

local var2 = if FFlagProfilePlatformNewProfileHeader then 8 else nil

local var3 = if FFlagProfilePlatformNewProfileHeader then 70 else nil
local var4 = if FFlagProfilePlatformNewProfileHeader then math.rad(var3 / 2) else nil

local function getCameraDistanceForCharacterHeight(num1: number, cameraDistanceScale: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return math.clamp(num1 / (math.tan(var4) * 2) * cameraDistanceScale, var1 * cameraDistanceScale, var2 * cameraDistanceScale)
end

local var5 = if FFlagProfilePlatformNewProfileHeader then 2 else nil

local cFrame = CFrame.new(Vector3.new(0, 1000, 0))

local FFlagPPVBackgroundUse2DAsLoadingState = require(EditProfileBackgroundParent.SharedFlags).FFlagPPVBackgroundUse2DAsLoadingState
local engineFeature = game:DefineFastFlag("PPVBackgroundUnthrottleProfileV2", false)
    and game:GetEngineFeature("IsGetThrottleFramerateEnabledAvailable")
local bool1 = game:DefineFastFlag("PPVBackgroundUnthrottleRefCount", false)
local FFlagPPVEnable3DBackground = require(EditProfileBackgroundParent.SharedFlags).FFlagPPVEnable3DBackground
local FFlagProfileInspectAvatarSlideIn = require(EditProfileBackgroundParent.SharedFlags).FFlagProfileInspectAvatarSlideIn
local FFlagProfileInspectAvatarShopChip = require(EditProfileBackgroundParent.SharedFlags).FFlagProfileInspectAvatarShopChip
local AvatarModelPrefetch = require(EditProfileBackground.Common.AvatarModelPrefetch)
local getCharacterAppearanceInfoAsync = require(EditProfileBackground.Common.getCharacterAppearanceInfoAsync)

local InsertService = game:GetService("InsertService")

local num1 = 0
local throttleFramerateEnabled = nil

local function acquireUnthrottle() -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 == 0 then
        throttleFramerateEnabled = RunService:getThrottleFramerateEnabled()
        RunService:setThrottleFramerateEnabled(false)
    end
    num1 += 1
end

local function releaseUnthrottle()
    num1 -= 1
    if num1 <= 0 then
        num1 = 0
        RunService:setThrottleFramerateEnabled(throttleFramerateEnabled == true)
        throttleFramerateEnabled = nil
    end
end

local function playToolAnimation(arg1)
    if not arg1:IsDescendantOf(game) then
        return
    end

    local animate = arg1:FindFirstChild("Animate")
    assert(animate ~= nil, "Expected animate to always exist")

    local toolnone = animate:FindFirstChild("toolnone")
    assert(toolnone ~= nil, "Expected tool animation to always exist")

    local var6 = toolnone:GetChildren()[1]
    if var6 == nil then
        return
    end
    assert(var6:IsA("Animation"), "Unexpected type for tool animation")

    local humanoid = arg1:FindFirstChild("Humanoid")
    assert(humanoid ~= nil, "Expected humanoid to always exist")

    local animator = humanoid:FindFirstChild("Animator")
    assert(animator ~= nil, "Expected Animator to always exist")

    assert(animator:IsA("Animator"), "Animator should be of type Animator")

    local animationResult = animator:LoadAnimation(var6)
    animationResult.Looped = true
    animationResult:Play()
end

local function BackgroundDisplay(tbl1)
    local var6 = useLocalUserId()
    local var7 = tbl1.userId or var6 and tonumber(var6)
    local var8 = useSelectedTheme()
    local ref = React.useRef(nil)
    local var9 = React.useRef(nil)
    local var10 = React.useRef(nil)
    local var12 = React.useRef(nil)
    local var13, var14 = React.useState(true)
    local var15 = if engineFeature then React.useRef(nil) else nil

    if FFlagPPVEnable3DBackground then
        React.useEffect(function()
            task.defer(function()
                if not tbl1.currentBackgroundId then
                    return
                end

                local success, result = pcall(function(): Instance
                    return InsertService:LoadAsset(getDisplayBackgroundId(tbl1.currentBackgroundId, var8))
                end)

                if not success or not result then
                    return
                end

                if var9.current then
                    for _, child in pairs(var9.current:GetChildren()) do
                        if child.Name ~= "Character" then
                            child:Destroy()
                        end
                    end
                end

                local backgroundModel = Instance.new("Model")
                backgroundModel.Name = "BackgroundModel"
                backgroundModel.Parent = var9.current

                for _, child in pairs(result:GetChildren()) do
                    child.Parent = backgroundModel
                end

                backgroundModel:PivotTo(CFrame.new(0, 7, -4.5))
                result:Destroy()

                local current = ref.current
                if current then
                    current.Ambient = midGray
                    current.LightColor = institutionalWhite
                    current.LightDirection = Vector3.new(-0.5, 0.2, 0.2)
                end
            end)
        end, { tbl1.currentBackgroundId })
    end

    if engineFeature then
        React.useEffect(function()
            if bool1 then
                acquireUnthrottle()
                return releaseUnthrottle
            end

            var15.current = RunService:getThrottleFramerateEnabled()
            RunService:setThrottleFramerateEnabled(false)
            return function()
                RunService:setThrottleFramerateEnabled(var15.current or true)
            end
        end, {})
    end

    local var16 = React.useCallback(function(arg1, parent)
        if not (arg1 and parent) then
            return
        end

        local rightHand = arg1:FindFirstChild("RightHand")
        if not (rightHand and rightHand:IsA("BasePart")) then
            return
        end
        local rightGripAttachment = rightHand:FindFirstChild("RightGripAttachment")
        if not (rightGripAttachment and rightGripAttachment:IsA("Attachment")) then
            return
        end

        local handle = parent:FindFirstChild("Handle")
        if not (handle and handle:IsA("BasePart")) then
            return
        end

        for _, descendant in ipairs(parent:GetDescendants()) do
            if descendant:IsA("Script") or descendant:IsA("LocalScript") then
                descendant.Disabled = true
            end
        end
        parent.Parent = arg1

        playToolAnimation(arg1)

        handle.CFrame = rightGripAttachment.WorldCFrame
        local weld = Instance.new("Weld")
        weld.Parent = parent
        weld.Part0 = handle
        weld.Part1 = rightHand
        weld.C0 = parent.Grip
        weld.C1 = rightGripAttachment.CFrame
    end, {})

    local var17 = React.useCallback(function(arg1, parent)
        if not (arg1 and parent) then
            return
        end
        local rightArm = arg1:FindFirstChild("Right Arm")
        if not (rightArm and rightArm:IsA("BasePart")) then
            return
        end
        local rightGripAttachment = rightArm:FindFirstChild("RightGripAttachment")
        if not (rightGripAttachment and rightGripAttachment:IsA("Attachment")) then
            return
        end
        local rightShoulder = arg1:FindFirstChild("Right Shoulder", true)
        if not (rightShoulder and rightShoulder:IsA("Motor6D")) then
            return
        end
        local handle = parent:FindFirstChild("Handle")
        if not (handle and handle:IsA("BasePart")) then
            return
        end
        for _, descendant in ipairs(parent:GetDescendants()) do
            if descendant:IsA("Script") or descendant:IsA("LocalScript") then
                descendant.Disabled = true
            end
        end
        parent.Parent = arg1
        rightShoulder.C0 *= CFrame.Angles(0, 0, math.pi / 2)
        handle.CFrame = rightGripAttachment.WorldCFrame
        local c1 = CFrame.new(0, -1, 0) * CFrame.Angles(-(math.pi / 2), 0, 0)
        local weld = Instance.new("Weld")
        weld.Parent = parent
        weld.Part0 = handle
        weld.Part1 = rightArm
        weld.C0 = parent.Grip
        weld.C1 = c1
    end, {})

    local useEffect = React.useEffect

    local function func1()
        task.defer(function()
            if not var7 then
                return
            end

            var14(true)
            local var18 = Promise.resolve(nil)
            local var19 = Promise.resolve(nil)

            local var20 = AvatarModelPrefetch.get(var7)

            local promise = Promise.new(function(callback)
                local success, result = pcall(function()
                    if FFlagProfileInspectAvatarSlideIn or FFlagProfileInspectAvatarShopChip then
                        return getCharacterAppearanceInfoAsync(var7)
                    end
                    return game.Players:GetCharacterAppearanceInfoAsync(var7)
                end)
                if success and result then
                    if result.emotes and #result.emotes > 0 then
                        var18 = Promise.new(function(callback2)
                            local success2, result2 = pcall(function(): Animation?
                                return (InsertService:LoadAsset(result.emotes[1].assetId):FindFirstChildOfClass("Animation"))
                            end)
                            if not success2 then
                                result2 = nil
                            end

                            callback2(result2)
                        end)
                    end

                    if result.assets then
                        local where = Cryo.List.findWhere(result.assets, function(arg1): boolean
                            return arg1.assetType.name == "Gear"
                        end)
                        if where then
                            local asset = result.assets[where]
                            var19 = Promise.new(function(callback2)
                                local success2, result2 = pcall(function(): Tool?
                                    return InsertService:LoadAsset(asset.id):FindFirstChildOfClass("Tool")
                                end)
                                callback2(success2 and result2 and result2:IsA("Tool") and result2 or nil)
                            end)
                        end
                    end
                end

                callback(if success then result else nil)
            end)

            local var21, var22 = Promise.all({
                var20,
                promise:catch(function()
                    return nil
                end)
            }):await()

            if not var21 then
                if tbl1.analytics then
                    tbl1.analytics.fireAnalyticsEvent(
                        "EditProfileBackgroundFailure",
                        {
                            errorType = ErrorTypes.CharacterModelCreationFailed
                        }
                    )
                end

                var14(false)
                return
            end

            local var23 = var22[1]
            local var24 = var22[2]
            AvatarModelPrefetch.clear(var7)

            var23.Name = "Character"
            var23.Parent = var9.current

            if var23.PrimaryPart then
                var23.PrimaryPart.CFrame = cFrame
            end

            var12.current = var23

            if var24 then
                local _, var25 = var19:await()
                if var25 then
                    local playerAvatarType = var24.playerAvatarType
                    if playerAvatarType == "R15" then
                        var16(var23, var25)
                    elseif playerAvatarType == "R6" then
                        var17(var23, var25)
                    end
                end
            end

            local humanoid = var23:FindFirstChild("Humanoid")
            if humanoid then
                Promise.race({ Promise.fromEvent(humanoid.ClusterCompositionFinished), Promise.delay(3) }):await()
            end

            if var23.PrimaryPart then
                var23.PrimaryPart.CFrame = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(0, 0, -10))
                local var25 = var23:FindFirstChild("RightFoot") or var23:FindFirstChild("Right Leg")
                if var25 and var25:IsA("BasePart") then
                    local num2 = var25.Position.Y - var25.Size.Y / 2

                    local y = var23.PrimaryPart.Position.Y + (-3 - num2)

                    var23.PrimaryPart.CFrame = CFrame.lookAt(Vector3.new(0, y, 0), Vector3.new(0, 0, -10))

                    if FFlagProfilePlatformNewProfileHeader and var10.current then
                        local var26, var27 = var23:GetBoundingBox()
                        local var28 = var27.Y + var5
                        local y2 = var26.Position.Y
                        local cameraDistanceForCharacterHeight = if FFlagProfilePlatformMeTabMobileProfileHero then getCameraDistanceForCharacterHeight(var28, tbl1.cameraDistanceScale or 1) else math.clamp(var28 / (math.tan(var4) * 2), var1, var2)
                        local vec3 = Vector3.new(0, 0, -cameraDistanceForCharacterHeight)
                        local vec3_2 = Vector3.new(0, y2, 10)
                        var10.current.CFrame = CFrame.lookAt(vec3, vec3_2)
                    end
                end
            end
            var14(false)
            if FFlagProfileInspectAvatarSlideIn or FFlagProfileInspectAvatarShopChip then
                local onSceneReady = tbl1.onSceneReady
                if onSceneReady and var10.current and ref.current and var9.current then
                    onSceneReady({ character = var23, camera = var10.current, viewportFrame = ref.current, worldModel = var9.current })
                end
            end

            if not engineFeature and not shouldEnableAnimation() then
                return
            end

            local success, _result = pcall(function()
                local _, animation = var18:await()

                local animation1 = var23:FindFirstChild("Animate"):FindFirstChild("idle"):FindFirstChild("Animation1")
                local animator = var23:FindFirstChild("Humanoid"):FindFirstChild("Animator")

                if not animation1 or not animator or not animator:IsA("Animator") then
                    return
                end

                local animationTrack = animator:LoadAnimation(animation1)
                if not animation then
                    animationTrack:Play()
                    return
                end

                local animationTrack2 = animator:LoadAnimation(animation)
                animationTrack2.Looped = false
                animationTrack2:Play()
                animationTrack2.Stopped:Connect(function()
                    animationTrack:Play()
                end)
            end)

            if not success and tbl1.analytics then
                tbl1.analytics.fireAnalyticsEvent("EditProfileBackgroundFailure", { errorType = ErrorTypes.CharacterAnimationFailed })
            end
        end)
    end

    local cameraDistanceScale = if FFlagProfilePlatformMeTabMobileProfileHero then tbl1.cameraDistanceScale else nil
    useEffect(func1, { var7, cameraDistanceScale })

    React.useEffect(function()
        if ref.current and var10.current then
            ref.current.CurrentCamera = var10.current
        end
    end)

    local createElement = React.createElement
    local var18 = View
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, tbl1.height),
        ZIndex = 2
    }
    local tbl3 = {
        Background = React.createElement("ViewportFrame", {
            Size = UDim2.fromScale(1, 1),
            ref = ref,
            Ambient = midGray,
            LightColor = institutionalWhite,
            BackgroundTransparency = 1
        }, {
            WorldModel = React.createElement("WorldModel", { ref = var9 }),
            Camera = React.createElement("Camera", {
                CameraType = Enum.CameraType.Scriptable,
                CFrame = CFrame.lookAt(Vector3.new(0, 0, -8), Vector3.new(0, 1, 10)),
                ref = var10
            })
        }),
        LoadingFrame = 0
    }

    if var13 then
        local createElement2 = React.createElement
        local var19 = View
        local tbl4 = { tag = "size-full-full", ZIndex = 2 }
        local element

        if FFlagPPVBackgroundUse2DAsLoadingState then
            element = React.createElement(LoadableImage, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, -24),
                Size = UDim2.new(1, -48, 1, -48),
                ScaleType = Enum.ScaleType.Fit,
                BackgroundTransparency = 1,
                Image = tbl1.userThumbnail,
                useShimmerAnimationWhileLoading = true,
                ZIndex = 2
            })
        else
            element = React.createElement(
                Loading,
                {
                    size = IconSize.Large,
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5)
                }
            )
        end

        var13 = createElement2(var19, tbl4, { element })
    end

    tbl3.LoadingFrame = var13
    return createElement(var18, tbl2, tbl3)
end

return BackgroundDisplay
