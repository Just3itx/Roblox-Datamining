-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local uDim2 = UDim2.new(1.1, 0, 1.1, 0)

local uDim2_2 = UDim2.new(0.9, 0, 0.9, 0)

local TweenService = game:GetService("TweenService")
local CorePackages = game:GetService("CorePackages")
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Sine)
local tweenInfo2 = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)

local bool1 = game:DefineFastFlag("LocalizeGameplayPaused", false)

local function build()
    return Create("ImageLabel")({
        Name = "NetworkPause",
        Image = "rbxasset://textures/ui/PurchasePrompt/LoadingBG.png",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 8, 12, 12),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        ImageColor3 = Color3.fromRGB(122, 122, 122),
        ImageTransparency = 0,
        BackgroundTransparency = 1,
        Create("UISizeConstraint")({ MaxSize = Vector2.new(312, 251) }),
        Create("UIPadding")({
            PaddingTop = UDim.new(0, 24),
            PaddingLeft = UDim.new(0, 24),
            PaddingRight = UDim.new(0, 24),
            PaddingBottom = UDim.new(0, 24)
        }),
        Create("Frame")({
            Name = "Accent",
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(66, 66, 66),
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 0, 88),
            BackgroundTransparency = 0
        }),
        Create("Frame")({
            Name = "Upper",
            Size = UDim2.new(1, 0, 0, 88),
            BackgroundTransparency = 1,
            Create("Frame")({
                Name = "IconContainer",
                Size = UDim2.new(0, 40, 0, 37),
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.new(0.5, 0, 0, 0),
                BackgroundTransparency = 1,
                Create("ImageLabel")({
                    Name = "Icon",
                    BackgroundTransparency = 1,
                    Image = "rbxasset://textures/ui/NetworkPause/no connection.png",
                    Size = uDim2_2,
                    Position = UDim2.new(0.5, 0, 0.88, 0),
                    AnchorPoint = Vector2.new(0.5, 0.88),
                    ImageTransparency = 0
                })
            }),
            Create("TextLabel")({
                Name = "Label",
                Font = AppFonts.default:getBold(),
                Text = bool1 and RobloxTranslator:FormatByKey("InGame.GameplayPaused.Title") or "Gameplay Paused",
                TextSize = 22,
                TextWrapped = true,
                Size = UDim2.new(1, 0, 0, 22),
                Position = UDim2.new(0, 0, 0, 54),
                BackgroundTransparency = 1,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextTransparency = 0
            })
        }),
        Create("TextLabel")({
            Name = "Lower",
            Font = AppFonts.default:getDefault(),
            Text = bool1 and RobloxTranslator:FormatByKey("InGame.GameplayPaused.Body")
                or "Gameplay has been paused: please wait while the game content loads.",
            TextColor3 = Color3.fromRGB(190, 190, 190),
            TextSize = 18,
            TextWrapped = true,
            Position = UDim2.new(0, 0, 0, 89),
            Size = UDim2.new(1, 0, 1, -89),
            BackgroundTransparency = 1,
            TextTransparency = 0
        })
    })
end

local module = {}
module.__index = module

function module.new()
    local self = setmetatable({}, module)
    local instance = build()

    local tween = TweenService:Create(instance, tweenInfo, { ImageTransparency = 0 })
    local tween2 = TweenService:Create(instance, tweenInfo, { ImageTransparency = 1 })

    local tween3 = TweenService:Create(instance.Upper.IconContainer.Icon, tweenInfo2, { Size = uDim2, ImageTransparency = 0.75 })

    self.__gui = instance
    self.__guiParent = nil
    self.__show = false
    self.__animations = { show = tween, hide = tween2, pulse = tween3 }

    return self
end

function module:Show()
    self.__gui.Upper.IconContainer.Icon.Size = uDim2_2
    self.__gui.Upper.IconContainer.Icon.ImageTransparency = 0
    self.__show = true
    self.__gui.Parent = self.__guiParent
    self.__animations.pulse:Play()
end

function module:Hide()
    self.__show = false
    self.__gui.Parent = nil
    self.__animations.pulse:Cancel()
end

function module:SetParent(arg1)
    self.__guiParent = arg1
    if self.__show then
        self.__gui.Parent = arg1
    end
end

return module
