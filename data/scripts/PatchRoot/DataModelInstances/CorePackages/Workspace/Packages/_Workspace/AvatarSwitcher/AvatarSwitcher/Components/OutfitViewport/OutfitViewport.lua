-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local AvatarSwitcherParent = script:FindFirstAncestor("AvatarSwitcher").Parent

local React = require(AvatarSwitcherParent.React)
local EventConnection = require(AvatarSwitcherParent.ReactUtils).EventConnection
local Foundation = require(AvatarSwitcherParent.Foundation)

local OutfitViewportUtils = require(script.Parent.OutfitViewportUtils)
local useOutfitViewportInteractions = require(script.Parent.useOutfitViewportInteractions)

local bool1 = game:DefineFastFlag("AvatarSwitcherPlayRandomEmote", false)

local FFlagAvatarSwitcherAccurateAvatarWarning = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherAccurateAvatarWarning

local brickYellow = Color3.fromRGB(218, 203, 173)

return React.memo(function(tbl1) -- name: OutfitViewport
    local ref = React.useRef(nil)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(nil)
    local var4, var5 = React.useState(true)
    local var6 = React.useRef("")
    local defaultCameraDistanceRef = React.useRef(0)

    local bool2 = not var4
    local var8 = useOutfitViewportInteractions({ defaultCameraDistanceRef = defaultCameraDistanceRef })

    local var9 = React.useCallback(function(num1: number?, arg1)
        var5(true)
        if ref.current then
            ref.current:ClearAllChildren()
        end

        if not (num1 and arg1) then
            return
        end

        local current = HttpService:GenerateGUID(false)
        var6.current = current
        local result, var9

        if FFlagAvatarSwitcherAccurateAvatarWarning then
            local success, result2

            success, result, result2 = pcall(function()
                return OutfitViewportUtils.buildOutfitModel(num1, arg1)
            end)
            if not (success and result and result2) then
                if tbl1.onLoadingFailed then
                    tbl1.onLoadingFailed()
                end
                return
            end

            local humanoid = result:WaitForChild("Humanoid", 10)
            var9 = humanoid and humanoid.RootPart
            if not (humanoid and var9) then
                if tbl1.onLoadingFailed then
                    tbl1.onLoadingFailed()
                end
                return
            end

            if var6.current ~= current then
                result:Destroy()
                return
            end

            if tbl1.onLoaded then
                tbl1.onLoaded(humanoid, result2)
            end
        else
            local success

            success, result = pcall(function()
                return OutfitViewportUtils.buildOutfitModel(num1, arg1)
            end)
            if not (success and result) then
                if tbl1.onLoadingFailed then
                    tbl1.onLoadingFailed()
                end
                return
            end

            var9 = result:WaitForChild("HumanoidRootPart", 10)
            if not var9 then
                if tbl1.onLoadingFailed then
                    tbl1.onLoadingFailed()
                end
                return
            end

            if var6.current ~= current then
                result:Destroy()
                return
            end
        end

        result.Parent = ref.current
        local var10, _ = result:GetBoundingBox()

        var9.CFrame = CFrame.new(var9.CFrame.Position - var10.Position)

        defaultCameraDistanceRef.current = OutfitViewportUtils.getCameraDistance(result, 50)
        if bool1 then
            OutfitViewportUtils.playRandomEmote(result)
        else
            local var11 = OutfitViewportUtils.loadIdleAnimationForAvatar(result)
            if var11 then
                var11:Play()
            end
        end

        var5(false)
    end, { tbl1.onLoadingFailed })

    React.useEffect(function()
        task.spawn(function()
            var9(tbl1.outfitId, tbl1.rigType)
        end)
    end, { tbl1.outfitId, tbl1.rigType, var9 })

    React.useLayoutEffect(function()
        if var2.current then
            var2.current.CurrentCamera = var1.current
        end
    end, {})

    local var10 = React.useCallback(function(interactable: boolean)
        local var10 = var2.current and var2.current:FindFirstAncestorOfClass("ScreenGui")
        local inputWrapper = var10 and var10:FindFirstChild("InputWrapper", true)
        if inputWrapper and inputWrapper:IsA("Frame") then
            inputWrapper.Interactable = interactable
        end
    end, {})

    local createElement = React.createElement
    local str1 = "ViewportFrame"
    local tbl2 = {
        Size = UDim2.fromScale(1, 1),
        LightColor = brickYellow,
        LightDirection = Vector3.new(-1, -1, 2),
        BackgroundTransparency = 1,
        ref = var2,
        [React.Event.InputBegan] = if bool2 then var8.onInputBegan else nil
    }

    tbl2[React.Event.MouseEnter] = function()
        var10(false)
    end
    tbl2[React.Event.MouseLeave] = function()
        var10(true)
    end

    return createElement(str1, tbl2, {
        WorldModel = React.createElement("WorldModel", { ref = ref }),
        Camera = React.createElement(
            "Camera",
            {
                CameraType = Enum.CameraType.Scriptable,
                CFrame = var8.cameraCFrame,
                FieldOfView = 50,
                ref = var1
            }
        ),
        LoadingSpinner = var4
            and React.createElement(Foundation.Loading, { Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5) }),
        InputChangedConnection = bool2
            and React.createElement(EventConnection, { event = UserInputService.InputChanged, callback = var8.onInputChanged }),
        InputEndedConnection = bool2 and React.createElement(EventConnection, { event = UserInputService.InputEnded, callback = var8.onInputEnded })
    })
end)
