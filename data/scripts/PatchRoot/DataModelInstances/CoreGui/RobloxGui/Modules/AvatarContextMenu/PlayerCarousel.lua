-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local cyan = Color3.fromRGB(0, 162, 255)
local black = Color3.fromRGB(0, 0, 0)

local AvatarContextMenu = CoreGui:WaitForChild("RobloxGui"):WaitForChild("Modules"):WaitForChild("AvatarContextMenu")
local frame = nil
local uiPageLayout = nil
local bindableEvent = nil
local tbl1 = ({})
local tbl2 = ({})

local function getSortedCarouselButtons()
    local tbl3 = ({})
    local sortedCarouselButtons = {}
    for i, child in ipairs(frame:GetChildren()) do
        if child:IsA("GuiObject") and child.Name ~= "_CarouselDivider" then
            table.insert(sortedCarouselButtons, child)
            tbl3[child] = i
        end
    end
    table.sort(sortedCarouselButtons, function(arg1, arg2): boolean
        if arg1.LayoutOrder == arg2.LayoutOrder then
            return tbl3[arg1] < tbl3[arg2]
        end

        return arg1.LayoutOrder < arg2.LayoutOrder
    end)

    return sortedCarouselButtons
end

local function CreateMenuCarousel(arg1): Frame
    local playerCarousel = Instance.new("Frame")
    playerCarousel.Name = "PlayerCarousel"
    playerCarousel.AnchorPoint = Vector2.new(0.5, 0.5)
    playerCarousel.BackgroundTransparency = 1
    playerCarousel.Position = UDim2.new(0.5, 0, 0.5, 0)
    playerCarousel.Size = UDim2.new(1, 0, 0.28, 0)
    playerCarousel.ClipsDescendants = true

    local innerFrame = Instance.new("Frame")
    innerFrame.Name = "InnerFrame"
    innerFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    innerFrame.BackgroundTransparency = 1
    innerFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    innerFrame.Size = UDim2.new(0.8, 0, 1, 0)
    innerFrame.ClipsDescendants = true
    innerFrame.Active = true
    innerFrame.Parent = playerCarousel

    frame = Instance.new("Frame")
    frame.Name = "SelectedPlayer"
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundTransparency = 1
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.Size = UDim2.new(0, 100, 1, -10)
    frame.Parent = innerFrame

    uiPageLayout = Instance.new("UIPageLayout")
    uiPageLayout.EasingDirection = Enum.EasingDirection.Out
    uiPageLayout.EasingStyle = Enum.EasingStyle.Quad
    uiPageLayout.Padding = UDim.new(0, 5)
    uiPageLayout.TweenTime = 0.25
    uiPageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiPageLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    uiPageLayout.TouchInputEnabled = false
    uiPageLayout.Circular = true
    uiPageLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    uiAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
    uiAspectRatioConstraint.Parent = frame

    bindableEvent = Instance.new("BindableEvent")
    bindableEvent.Name = "PlayerChanged"

    local currentPage = nil
    uiPageLayout:GetPropertyChangedSignal("CurrentPage"):Connect(function()
        if uiPageLayout.CurrentPage then
            if uiPageLayout.CurrentPage.Name == "_CarouselDivider" then
                local sortedCarouselButtons = getSortedCarouselButtons()
                if currentPage == sortedCarouselButtons[1] then
                    uiPageLayout:Previous()
                else
                    uiPageLayout:Next()
                end
            else
                uiPageLayout.CurrentPage.BackgroundColor3 = black
                currentPage = uiPageLayout.CurrentPage
            end
        end
        if GuiService.SelectedCoreObject and GuiService.SelectedCoreObject.Parent == uiPageLayout.Parent then
            GuiService.SelectedCoreObject.BackgroundColor3 = cyan
        end
        GuiService.SelectedCoreObject = uiPageLayout.CurrentPage
        if uiPageLayout.CurrentPage then
            bindableEvent:Fire(tbl1[uiPageLayout.CurrentPage])
        end
    end)

    uiPageLayout.Parent = frame

    local nextButton = Instance.new("ImageButton")
    nextButton.Name = "NextButton"
    nextButton.Image = arg1.ScrollRightImage
    nextButton.BackgroundTransparency = 1
    nextButton.AnchorPoint = Vector2.new(1, 0.5)
    nextButton.Position = UDim2.new(1, -5, 0.5, 0)
    nextButton.Size = UDim2.new(0.3, 0, 0.3, 0)
    nextButton.Selectable = false
    nextButton.Parent = playerCarousel

    local uiAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
    uiAspectRatioConstraint2.DominantAxis = Enum.DominantAxis.Width
    uiAspectRatioConstraint2.Parent = nextButton

    local imageButton = nextButton:Clone()
    imageButton.Name = "PrevButton"
    if arg1.ScrollLeftImage ~= "" then
        imageButton.Image = arg1.ScrollLeftImage
    else
        imageButton.Rotation = 180
    end
    imageButton.AnchorPoint = Vector2.new(0, 0.5)
    imageButton.Position = UDim2.new(0, 5, 0.5, 0)
    imageButton.Selectable = false
    imageButton.Parent = playerCarousel

    local function moveChangePage(bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
        if bool1 then
            uiPageLayout:Next()
            return
        end
        uiPageLayout:Previous()
    end

    nextButton.MouseButton1Click:Connect(function()
        moveChangePage(true)
    end)

    imageButton.MouseButton1Click:Connect(function()
        moveChangePage(false)
    end)

    local function checkButtonVisibility() -- Luacid: Inlined by compiler; 1 call site recovered
        local bool1 = UserInputService:GetLastInputType() == Enum.UserInputType.Touch
        imageButton.Visible = not bool1 and #frame:GetChildren() > 3
        nextButton.Visible = not bool1 and #frame:GetChildren() > 3
    end

    checkButtonVisibility()
    UserInputService.LastInputTypeChanged:Connect(checkButtonVisibility)

    return playerCarousel
end

function module:UpdateGuiTheme(arg1)
    self.rbxGui.NextButton.Image = arg1.ScrollRightImage

    if arg1.ScrollLeftImage ~= "" then
        self.rbxGui.PrevButton.Image = arg1.ScrollLeftImage
        return
    end
    self.rbxGui.PrevButton.Image = arg1.ScrollRightImage
    self.rbxGui.PrevButton.Rotation = 180
end

function module:FadeTowardsEdges()
    if not uiPageLayout.CurrentPage then
        return
    end

    local sortedCarouselButtons = getSortedCarouselButtons()
    local num1 = 0
    for i, sortedCarouselButton in ipairs(sortedCarouselButtons) do
        if sortedCarouselButton == uiPageLayout.CurrentPage then
            num1 = i
            break
        end
    end

    for i, sortedCarouselButton in ipairs(sortedCarouselButtons) do
        local num2 = math.min((num1 - i) % #sortedCarouselButtons, (i - num1) % #sortedCarouselButtons)
        if num2 >= 2 then
            sortedCarouselButton.ImageTransparency = 0.7
        elseif num2 == 1 then
            sortedCarouselButton.ImageTransparency = 0.4
        else
            sortedCarouselButton.ImageTransparency = 0
        end
    end
end

function module.AddCarouselDivider(_)
    local _carouselDivider = frame:FindFirstChild("_CarouselDivider")
    if _carouselDivider then
        _carouselDivider:Destroy()
    end

    if #frame:GetChildren() - 1 < 5 then
        return
    end

    local _carouselDivider2 = Instance.new("Frame")
    _carouselDivider2.Name = "_CarouselDivider"
    _carouselDivider2.Size = UDim2.new(1, 0, 1, 0)
    _carouselDivider2.BackgroundTransparency = 1
    _carouselDivider2.Parent = frame
    _carouselDivider2.LayoutOrder = 1000000

    local line = Instance.new("Frame")
    line.Name = "line"
    line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    line.BorderSizePixel = 0
    line.Position = UDim2.new(0.25, 0, 0, -3)
    line.Size = UDim2.new(0, 2, 1, 6)
    line.Parent = _carouselDivider2

    local frame2 = line:Clone()
    frame2.Position = UDim2.new(0.5, 0, 0, -3)
    frame2.Parent = _carouselDivider2

    local frame3 = line:Clone()
    frame3.Position = UDim2.new(0.75, 0, 0, -3)
    frame3.Parent = _carouselDivider2
end

function module.RemovePlayerEntry(arg1, arg2)
    local var1 = tbl2[arg2]

    if not var1 then
        return
    end

    tbl2[arg2] = nil
    tbl1[var1] = nil

    var1:Destroy()
    if uiPageLayout then
        uiPageLayout:ApplyLayout()
    end
    arg1:FadeTowardsEdges()
end

function module.ClearPlayerEntries(_)
    for k in pairs(tbl1) do
        k:Destroy()
    end

    tbl1 = {}
    tbl2 = {}
end

function module.CreatePlayerEntry(_, arg1, layoutOrder)
    local var1 = tbl2[arg1]
    if var1 then
        var1.LayoutOrder = layoutOrder
        return
    end

    local imageButton = Instance.new("ImageButton")
    imageButton.Name = arg1.Name
    imageButton.BorderSizePixel = 0
    imageButton.LayoutOrder = layoutOrder
    imageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    imageButton.BackgroundTransparency = 0
    imageButton.Size = UDim2.new(1, 0, 1, 0)

    imageButton.SelectionLost:connect(function()
        imageButton.BackgroundColor3 = black
    end)

    imageButton.SelectionGained:connect(function()
        imageButton.BackgroundColor3 = cyan
    end)
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true)

    local tween = TweenService:Create(imageButton, tweenInfo, { BackgroundColor3 = Color3.fromRGB(255, 255, 255) })

    tween:Play()

    tbl1[imageButton] = arg1
    tbl2[arg1] = imageButton

    imageButton.MouseButton1Click:Connect(function()
        uiPageLayout:JumpTo(imageButton)
    end)

    imageButton.Parent = frame

    spawn(function()
        local contextMenuUtil = require(AvatarContextMenu:WaitForChild("ContextMenuUtil"))
        imageButton.Image = contextMenuUtil:GetHeadshotForPlayer(arg1)
        tween:Cancel()
        tween = nil
        if imageButton == GuiService.SelectedCoreObject then
            imageButton.BackgroundColor3 = cyan
            return
        end
        imageButton.BackgroundColor3 = black
    end)
end

function module.SwitchToPlayerEntry(arg1, arg2, arg3)
    if not arg2 then
        return
    end
    local var1 = tbl2[arg2]
    if not var1 then
        arg1:CreatePlayerEntry(arg2, 0)
        var1 = tbl2[arg2]
    end

    if arg3 then
        uiPageLayout.TweenTime = 0
    end
    uiPageLayout:JumpTo(var1)
    spawn(function()
        uiPageLayout.TweenTime = 0.25
    end)
end

function module.OffsetPlayerEntry(_, arg1)
    if arg1 == 0 then
        return
    end
    if arg1 > 0 then
        uiPageLayout:Next()
    else
        uiPageLayout:Previous()
    end
end

function module.GetSelectedPlayer(_)
    return tbl1[uiPageLayout.CurrentPage]
end

function module.new(arg1)
    local self = setmetatable({}, module)

    self.rbxGui = CreateMenuCarousel(arg1)
    self.PlayerChanged = bindableEvent.Event

    bindableEvent.Event:Connect(function()
        self:FadeTowardsEdges()
    end)

    return self
end

return module
