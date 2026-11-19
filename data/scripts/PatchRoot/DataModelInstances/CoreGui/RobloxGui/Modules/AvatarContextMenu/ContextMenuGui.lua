-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Modules = RobloxGui:WaitForChild("Modules")
local Settings = Modules:WaitForChild("Settings")
local AvatarContextMenu = Modules:WaitForChild("AvatarContextMenu")
local var1 = nil
local bindableEvent = Instance.new("BindableEvent")

local _ContextMenuUtil = require(AvatarContextMenu:WaitForChild("ContextMenuUtil"))
local _Utility = require(Settings:WaitForChild("Utility"))

local tbl1 = {}
tbl1.__index = tbl1

function tbl1:CreateContextMenuHolder(_): Frame
    local avatarContextMenu = Instance.new("Frame")
    avatarContextMenu.Name = "AvatarContextMenu"
    avatarContextMenu.Position = UDim2.new(0, 0, 0, 0)
    avatarContextMenu.Size = UDim2.new(1, 0, 1, 0)
    avatarContextMenu.BackgroundTransparency = 1
    avatarContextMenu.Parent = RobloxGui
    avatarContextMenu.AutoLocalize = false
    return avatarContextMenu
end

function tbl1:CreateLeaveMenuButton(parent, arg1): ImageButton
    local closeMenuButton = Instance.new("ImageButton")
    closeMenuButton.Name = "CloseMenuButton"
    closeMenuButton.BackgroundTransparency = 1
    closeMenuButton.AnchorPoint = Vector2.new(1, 0)
    closeMenuButton.Position = UDim2.new(1, -10, 0, 10)
    closeMenuButton.Size = UDim2.new(0.05, 0, 0.1, 0)
    closeMenuButton.Image = arg1.LeaveMenuImage
    closeMenuButton.Selectable = false

    closeMenuButton.Activated:Connect(function() -- name: closeMenu
        self.CloseMenuFunc()
    end)
    local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    uiAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
    uiAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
    uiAspectRatioConstraint.AspectRatio = 1
    uiAspectRatioConstraint.Parent = closeMenuButton

    closeMenuButton.Parent = parent

    return closeMenuButton
end

local function listenToViewportChange(callback) -- Luacid: Inlined by compiler; 1 call site recovered
    if callback == nil then
        return
    end
    local connection = nil

    local function updateCamera() -- Luacid: Inlined by compiler; 1 call site recovered
        local currentCamera = workspace.CurrentCamera
        if connection then
            connection:Disconnect()
        end
        connection = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(callback)
        callback()
    end

    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(updateCamera)
    updateCamera()
end

function tbl1:CreateMenuFrame(arg1): ImageButton
    local var2 = self:CreateContextMenuHolder()

    local menu = Instance.new("ImageButton")
    menu.Name = "Menu"
    menu.AnchorPoint = arg1.AnchorPoint
    menu.Size = arg1.Size
    menu.Position = arg1.OnScreenPosition
    menu.BackgroundTransparency = arg1.BackgroundTransparency
    menu.BackgroundColor3 = arg1.BackgroundColor
    menu.Image = arg1.BackgroundImage
    menu.ScaleType = arg1.BackgroundImageScaleType
    menu.SliceCenter = arg1.BackgroundImageSliceCenter
    menu.AutoButtonColor = false
    menu.BorderSizePixel = 0
    menu.Selectable = false
    menu.Visible = false
    menu.Active = true
    menu.ClipsDescendants = true
    menu.Modal = true

    GuiService:AddSelectionParent("AvatarContextMenuGroup", menu)

    local menuAspectRatio = Instance.new("UIAspectRatioConstraint")
    menuAspectRatio.AspectType = Enum.AspectType.ScaleWithParentSize
    menuAspectRatio.DominantAxis = Enum.DominantAxis.Height
    menuAspectRatio.Name = "MenuAspectRatio"
    menuAspectRatio.AspectRatio = arg1.AspectRatio
    menuAspectRatio.Parent = menu

    local function updateAspectRatioForViewport() -- Luacid: Inlined by compiler; 1 call site recovered
        local viewportSize = workspace.CurrentCamera.ViewportSize
        if viewportSize.x < viewportSize.y then
            menuAspectRatio.DominantAxis = Enum.DominantAxis.Width
            return
        end
        menuAspectRatio.DominantAxis = Enum.DominantAxis.Height
    end

    listenToViewportChange(updateAspectRatioForViewport)
    local menuSizeConstraint = Instance.new("UISizeConstraint")
    menuSizeConstraint.Name = "MenuSizeConstraint"
    menuSizeConstraint.MaxSize = arg1.MaxSize
    menuSizeConstraint.MinSize = arg1.MinSize
    menuSizeConstraint.Parent = menu

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, 0, 1, 0)
    content.BackgroundTransparency = 1
    content.Parent = menu

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Parent = content

    local contextActionList = Instance.new("ScrollingFrame")
    contextActionList.Name = "ContextActionList"
    contextActionList.AnchorPoint = Vector2.new(0.5, 1)
    contextActionList.BackgroundColor3 = arg1.ButtonFrameColor
    contextActionList.BackgroundTransparency = arg1.ButtonFrameTransparency
    contextActionList.BorderSizePixel = 0
    contextActionList.LayoutOrder = 2
    contextActionList.Size = UDim2.new(1, -12, 0.54, 0)
    contextActionList.CanvasSize = UDim2.new(0, 0, 0, 208)
    contextActionList.ScrollBarThickness = 4
    contextActionList.Selectable = false
    contextActionList.Parent = content

    local uiListLayout2 = Instance.new("UIListLayout")
    uiListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout2.VerticalAlignment = Enum.VerticalAlignment.Top

    uiListLayout2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        contextActionList.CanvasSize = UDim2.new(0, 0, 0, uiListLayout2.AbsoluteContentSize.Y)
    end)

    uiListLayout2.Parent = contextActionList

    local nameTag = Instance.new("TextButton")
    nameTag.Name = "NameTag"
    nameTag.AnchorPoint = Vector2.new(0.5, 1)
    nameTag.BackgroundColor3 = arg1.NameTagColor
    nameTag.AutoButtonColor = false
    nameTag.BorderSizePixel = 0
    nameTag.LayoutOrder = 1
    nameTag.Size = UDim2.new(1, -12, 0.16, 0)
    nameTag.Font = arg1.Font
    nameTag.TextColor3 = arg1.TextColor
    nameTag.TextSize = 24 * arg1.TextScale
    nameTag.Text = ""
    nameTag.TextXAlignment = Enum.TextXAlignment.Center
    nameTag.TextYAlignment = Enum.TextYAlignment.Center
    nameTag.Selectable = false
    nameTag.Parent = content

    local underline = Instance.new("Frame")
    underline.Name = "Underline"
    underline.BackgroundColor3 = arg1.NameUnderlineColor
    underline.AnchorPoint = Vector2.new(0, 1)
    underline.BorderSizePixel = 0
    underline.Position = UDim2.new(0, 0, 1, 0)
    underline.Size = UDim2.new(1, 0, 0, 2)
    underline.Parent = nameTag

    self:CreateLeaveMenuButton(menu, arg1)

    menu.Parent = var2
    self.ContextMenuFrame = menu

    return menu
end

function tbl1:UpdateGuiTheme(arg1)
    self.ContextMenuFrame.Size = arg1.Size
    self.ContextMenuFrame.AnchorPoint = arg1.AnchorPoint

    self.ContextMenuFrame.BackgroundTransparency = arg1.BackgroundTransparency
    self.ContextMenuFrame.BackgroundColor3 = arg1.BackgroundColor
    self.ContextMenuFrame.Image = arg1.BackgroundImage
    self.ContextMenuFrame.ScaleType = arg1.BackgroundImageScaleType
    self.ContextMenuFrame.SliceCenter = arg1.BackgroundImageSliceCenter

    self.ContextMenuFrame.CloseMenuButton.Image = arg1.LeaveMenuImage

    self.ContextMenuFrame.MenuSizeConstraint.MaxSize = arg1.MaxSize
    self.ContextMenuFrame.MenuSizeConstraint.MinSize = arg1.MinSize

    self.ContextMenuFrame.MenuAspectRatio.AspectRatio = arg1.AspectRatio

    local content = self.ContextMenuFrame.Content
    content.ContextActionList.BackgroundColor3 = arg1.ButtonFrameColor
    content.ContextActionList.BackgroundTransparency = arg1.ButtonFrameTransparency

    content.NameTag.BackgroundColor3 = arg1.NameTagColor
    content.NameTag.Font = arg1.Font
    content.NameTag.TextColor3 = arg1.TextColor
    content.NameTag.TextSize = 24 * arg1.TextScale

    content.NameTag.Underline.BackgroundColor3 = arg1.NameUnderlineColor

    if var1 then
        var1:UpdateGuiTheme(arg1)
    end
end

function tbl1:BuildPlayerCarousel(arg1, arg2)
    if not var1 then
        var1 = require(AvatarContextMenu.PlayerCarousel).new(arg2)
        var1.rbxGui.Parent = self.ContextMenuFrame.Content
    end

    var1:ClearPlayerEntries()

    if self.PlayerChangedConnection then
        self.PlayerChangedConnection:Disconnect()
    end
    self.PlayerChangedConnection = var1.PlayerChanged:Connect(function(arg3)
        if arg3 then
            self.ContextMenuFrame.Content.NameTag.Text = arg3.Name
        else
            self.ContextMenuFrame.Content.NameTag.Text = ""
        end
        bindableEvent:Fire(arg3)
    end)

    for i = 1, #arg1 do
        var1:CreatePlayerEntry(arg1[i][1], arg1[i][2])
    end
    var1:FadeTowardsEdges()
    var1:AddCarouselDivider()
end

function tbl1.RemovePlayerEntry(_, arg1)
    if not var1 then
        return
    end
    var1:RemovePlayerEntry(arg1)
end

function tbl1.GetBottomScreenPaddingConstant(_): number
    return 0.02
end

function tbl1:SetCloseMenuFunc(closeMenuFunc)
    self.CloseMenuFunc = closeMenuFunc
end

function tbl1.SwitchToPlayerEntry(_, arg1, arg2)
    if not var1 then
        return
    end

    var1:SwitchToPlayerEntry(arg1, arg2)
end

function tbl1.OffsetPlayerEntry(_, arg1)
    if not var1 then
        return
    end

    var1:OffsetPlayerEntry(arg1)
end

function tbl1.GetSelectedPlayer(_)
    if not var1 then
        return nil
    end

    return var1:GetSelectedPlayer()
end

function tbl1.new()
    local self = setmetatable({}, tbl1)

    self.CloseMenuFunc = nil

    self.ContextMenuFrame = nil
    self.LastSetPlayerIcon = nil

    self.PlayerChangedConnection = nil

    self.SelectedPlayerChanged = bindableEvent.Event

    return self
end

return tbl1.new()
