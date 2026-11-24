-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceLoadingScriptParent = script:FindFirstAncestor("ExperienceLoadingScript").Parent

local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")

local SplashScreenManager = require(ExperienceLoadingScriptParent.SplashScreenManager).SplashScreenManager
local bool1 = game:DefineFastFlag("LoadingRemoveRemoteCallErrorPrint", false)
local Create = require(ExperienceLoadingScriptParent.AppCommonLib).Create

local function FadeElements(arg1, arg2, time)
    time = time or 0.5
    if arg1 == nil then
        return
    end

    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

    if arg1:IsA("ImageLabel") or arg1:IsA("ImageButton") then
        TweenService:Create(arg1, tweenInfo, { ImageTransparency = arg2 }):Play()
    end
    if arg1:IsA("GuiObject") then
        TweenService:Create(arg1, tweenInfo, { BackgroundTransparency = arg2 }):Play()
    end
    if arg1:IsA("TextLabel") or arg1:IsA("TextBox") or arg1:IsA("TextButton") then
        TweenService:Create(arg1, tweenInfo, { TextTransparency = arg2 }):Play()
    end
    for _, child in pairs(arg1:GetChildren()) do
        FadeElements(child, arg2, time)
    end
end

local tbl1 = {}

local bindableEvent = Instance.new("BindableEvent")
tbl1.Finished = false
tbl1.GameAssetInfo = nil
tbl1.LoadingFinishedEvent = bindableEvent.Event

function tbl1:GetGameName()
    return if self.GameAssetInfo == nil then "" else self.GameAssetInfo.Name
end

function tbl1:GetCreatorName()
    if self.GameAssetInfo == nil then
        return ""
    end

    return self.GameAssetInfo.Creator.Name
end

function tbl1:IsReady()
    return self.Finished
end

function tbl1:LoadAssetsAsync()
    spawn(function()
        while game.PlaceId <= 0 do
            wait()
        end

        local success, result = pcall(function()
            self.GameAssetInfo = MarketplaceService:GetProductInfoAsync(game.PlaceId)
        end)
        if not (bool1 or success) then
            print("LoadingScript->GameInfoProvider:LoadAssets:", result)
        end

        self.Finished = true
        bindableEvent:Fire()
    end)
end

local var1 = Create("Frame")({
    Name = "VRLoadingScreenContainer",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    BackgroundColor3 = Color3.new(0, 0, 0)
})

local var2 = Create("ImageLabel")({
    Name = "LoadingBackground",
    Position = UDim2.new(0.25, 0, 0.25, 0),
    Size = UDim2.new(0.5, 0, 0.5, 0),
    Image = "rbxasset://textures/ui/LoadingScreen/BackgroundLight.png",
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(70, 70, 110, 110),
    BackgroundTransparency = 1,
    Parent = var1,
    ImageColor3 = Color3.new(0, 0, 0)
})

local num1 = 0
local var3 = Create("ImageLabel")({
    Name = "Spinner",
    Size = UDim2.new(0.25, 0, 0.25, 0),
    SizeConstraint = Enum.SizeConstraint.RelativeYY,
    Position = UDim2.new(0.375, 0, 0.325, 0),
    Image = "rbxasset://textures/ui/LoadingScreen/LoadingSpinner.png",
    BackgroundTransparency = 1,
    Parent = var2
})

local var4 = Create("TextLabel")({
    Name = "LoadingText",
    Text = "Loading...",
    BackgroundTransparency = 1,
    Font = Enum.Font.SourceSans,
    FontSize = Enum.FontSize.Size60,
    Position = UDim2.new(0.5, 0, 0.2, 0),
    Parent = var2,
    TextColor3 = Color3.new(77 / 255, 163 / 255, 224 / 255)
})

local var5 = Create("TextLabel")({
    Name = "GameNameText",
    Text = "",
    BackgroundTransparency = 1,
    Font = Enum.Font.SourceSans,
    FontSize = Enum.FontSize.Size60,
    Size = UDim2.new(0.9, 0, 0.1, 0),
    Position = UDim2.new(0.05, 0, 0.65, 0),
    ClipsDescendants = true,
    Parent = var2,
    TextColor3 = Color3.new(1 / 17, 79 / 85, 1)
})

local var6 = Create("Frame")({
    Name = "CreatorTextContainer",
    Size = UDim2.new(0.9, 0, 0.1, 0),
    Position = UDim2.new(0.05, 0, 0.77, 0),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    Parent = var2
})

local xOffset = 0
local instance = Create("TextLabel")({
    Name = "CreatorText",
    Text = "",
    BackgroundTransparency = 1,
    Font = Enum.Font.SourceSans,
    FontSize = Enum.FontSize.Size42,
    Size = UDim2.new(1, 0, 1, 0),
    Parent = var6,
    TextColor3 = Color3.new(1 / 17, 79 / 85, 1)
})

local bool2 = false
local bool3 = true
delay(2.5, function()
    bool3 = false
end)

local function UpdateLayout(arg1)
    if instance.TextBounds.X < var6.AbsoluteSize.X then
        instance.Position = UDim2.new(0, 0, 0, 0)
        instance.Size = UDim2.new(1, 0, 1, 0)
    elseif arg1 ~= nil then
        instance.Size = UDim2.new(0, instance.TextBounds.X, 1, 0)
        if not bool3 then
            local var7 = xOffset - arg1 * 25
            if var7 + instance.AbsoluteSize.X < var6.AbsoluteSize.X then
                bool3 = true
                spawn(function()
                    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

                    TweenService:Create(instance, tweenInfo, { TextTransparency = 1 }):Play()
                    wait(1.5)
                    if bool2 then
                        return
                    end
                    xOffset = 0
                    TweenService:Create(instance, tweenInfo, { TextTransparency = 0 }):Play()
                    wait(1.5)
                    bool3 = false
                end)
            else
                xOffset = var7
            end
        end
        instance.Position = UDim2.new(0, xOffset, 0, 0)
    end

    if var5.TextFits then
        return
    end

    var5.Size = UDim2.new(0.9, 0, 0.3, 0)
    var5.Position = UDim2.new(0.05, 0, 0.5, 0)
    var5.TextScaled = true
    var5.TextWrapped = true

    var3.Position = UDim2.new(0.375, 0, 0.225, 0)
    var4.Position = UDim2.new(0.5, 0, 0.15, 0)
end

local function CleanUp() -- Luacid: Inlined by compiler; 3 call sites recovered
    if bool2 then
        return
    end
    bool2 = true

    FadeElements(var1, 1, 2.5)
    wait(2.5)

    RunService:UnbindFromRenderStep("LoadingGui3D")
    var1.Parent = nil
end

local function OnGameInfoLoaded() -- Luacid: Inlined by compiler; 1 call site recovered
    local creatorName = tbl1:GetCreatorName()
    if creatorName and creatorName ~= "" then
        creatorName = string.format("By %s", tostring(creatorName))
    end
    var5.Text = tbl1:GetGameName()
    instance.Text = creatorName
end

local function OnDefaultLoadingGuiRemoved()
    CleanUp()
end

local var7 = tick()
RunService:BindToRenderStep("LoadingGui3D", Enum.RenderPriority.Last.Value, function()
    local now = tick()
    local var8 = now - var7

    UpdateLayout(var8)

    local var9 = var8 * 0.5 * 360
    num1 += var9
    var3.Rotation = num1

    var7 = now
end)
UpdateLayout()

tbl1:LoadAssetsAsync()
if tbl1:IsReady() then
    OnGameInfoLoaded()
end

tbl1.LoadingFinishedEvent:Connect(OnGameInfoLoaded)

if ReplicatedFirst:IsDefaultLoadingGuiRemoved() then
    CleanUp()
else
    ReplicatedFirst.RemoveDefaultLoadingGuiSignal:connect(OnDefaultLoadingGuiRemoved)
end

GuiService.ErrorMessageChanged:connect(function() end)

GuiService.UiMessageChanged:connect(function(_uiMessageType: Enum.UiMessageType, _: string) end)

SplashScreenManager.addStatusChangeListener(function(arg1)
    if arg1 then
        CleanUp()
    end
end)

return var1
