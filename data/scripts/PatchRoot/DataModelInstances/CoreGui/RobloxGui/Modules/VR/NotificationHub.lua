-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Utility = require(RobloxGui.Modules.Settings.Utility)
local Panel3D = require(CorePackages.Workspace.Packages.VrCommon).Panel3D
local VRHub = require(CorePackages.Workspace.Packages.VrCommon).VRHub
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

local _ = CFrame.Angles(-math.rad(5), 0, 0) * CFrame.new(0, 4, 0) * CFrame.Angles(-math.rad(15), 0, 0)

local smokyGrey = Color3.new(26 / 85, 28 / 85, 32 / 85)
local smokyGrey2 = Color3.new(82 / 255, 101 / 255, 47 / 85)
local reallyBlack = Color3.new(4 / 51, 4 / 51, 4 / 51)

local black = Color3.new(0.2, 0.2, 0.2)

local SelectionImageObject = Create("ImageLabel")({ BackgroundTransparency = 1, Image = "" })

local white = Color3.new(1, 1, 1)

local module = {
    ModuleName = "Notifications",
    KeepVRTopbarOpen = true,
    VRIsExclusive = true,
    VRClosesNonExclusive = true
}

function module.UnreadCountChanged(...) end
module.SetVisible = nil
VRHub:RegisterModule(module)

local var2 = Panel3D.Get("Notifications")

local var3 = Panel3D.Get("NotificationDetails")

local function IsDeveloperGroupEnabled(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return false
end

local tbl1 = {}

local tbl2 = {}
local tbl3 = { __index = tbl1 }
function tbl1.new(panel, arg1, text)
    local tbl4 = {}
    table.insert(tbl2, tbl4)
    tbl4.zeroCF = panel.localCF
    tbl4.zOffset = 0
    tbl4.isPopping = false
    tbl4.isAnimating = false
    tbl4.tweener = nil
    tbl4.panel = panel
    tbl4.SetPopOut = nil
    function tbl4.panel.OnMouseEnter()
        for _, value in pairs(tbl2) do
            if value ~= tbl4 then
                value:SetPopOut(false)
            end
        end
        tbl4:SetPopOut(true)
    end

    tbl4.titlebar = Create("ImageLabel")({
        Parent = arg1,
        Name = "TitlebarBackground",
        Position = UDim2.new(0, -1, 0, -1),
        Size = UDim2.new(1, 2, 0, 74),
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
        ImageColor3 = smokyGrey,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 10, 10)
    })
    tbl4.titleText = Create("TextLabel")({
        Parent = tbl4.titlebar,
        Name = "TitleText",
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
        Text = text,
        TextColor3 = white,
        Font = Enum.Font.SourceSans,
        FontSize = Enum.FontSize.Size36,
        BackgroundTransparency = 1
    })

    tbl4.content = Create("ImageLabel")({
        Parent = arg1,
        Name = "ContentFrame",
        Position = UDim2.new(0, -1, 0, 74),
        Size = UDim2.new(1, 2, 1, -76),
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
        ImageColor3 = reallyBlack,
        ImageTransparency = 0.5,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 10, 10)
    })

    return (setmetatable(tbl4, tbl3))
end

function tbl1:SetTitle(text)
    self.titleText.Text = text
end

function tbl1:AddCloseButton(arg1)
    self.closeButton = Create("ImageButton")({
        Parent = self.titlebar,
        Name = "CloseButton",
        Position = UDim2.new(0, 22, 0, 22),
        Size = UDim2.new(0, 32, 0, 32),
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/Keyboard/close_button_icon.png",
        SelectionImageObject = Create("ImageButton")({
            Name = "CloseButtonHover",
            Position = UDim2.new(0, -11, 0, -11),
            Size = UDim2.new(1, 22, 1, 22),
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png"
        })
    })

    self.closeButton.MouseButton1Click:connect(arg1)
end

function tbl1:TweenZOffsetTo(arg1, arg2, arg3, arg4)
    if self.tweener and not self.tweener:IsFinished() then
        self.tweener:Cancel()
    end
    self.tweener = Utility:TweenProperty(self, "zOffset", self.zOffset, arg1, arg2, arg3, arg4)
end

function tbl1:AnimateOut(callback)
    self.isAnimating = true
    self:TweenZOffsetTo(-100, 0.25, Utility:GetEaseInOutQuad(), function()
        if callback then
            callback()
        end

        self.isAnimating = false
    end)
end

function tbl1:AnimateIn(callback)
    self.zOffset = -100
    self:OnUpdate(0)
    self.isAnimating = true
    self:TweenZOffsetTo(0, 0.25, Utility:GetEaseInOutQuad(), function()
        if callback then
            callback()
        end

        self.isAnimating = false
    end)
end

function tbl1:SetPopOut(arg1)
    if self.isAnimating then
        return
    end

    if arg1 then
        self.isPopping = true
        self:TweenZOffsetTo(0.25, 0.25, Utility:GetEaseInOutQuad(), function()
            self.isPopping = false
        end)
    else
        self.isPopping = true
        self:TweenZOffsetTo(0, 0.25, Utility:GetEaseInOutQuad(), function()
            self.isPopping = false
        end)
    end
end

function tbl1:OnUpdate(_)
    self.panel.localCF = self.zeroCF * CFrame.new(0, 0, self.zOffset)
    self.panel.needsLocalPositionUpdate = self.isAnimating or self.isPopping

    if self.isPopping then
        local alpha = math.max(0, math.min(1, self.zOffset / 0.25))
        self.titlebar.ImageColor3 = smokyGrey:lerp(smokyGrey2, alpha)
    end
end

var2:SetType(Panel3D.Type.Standard)
var2:SetVisible(false)
var2:SetCanFade(false)
var2:ResizeStuds(2.277333324, 3.5, 150)
local var4 = Create("TextButton")({
    Parent = var2:GetGUI(),
    Name = "NotificationsListFrame",
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, -4, 1, 0),
    BackgroundTransparency = 1,
    Text = "",
    Selectable = true,
    SelectionImageObject = SelectionImageObject
})
local var5 = tbl1.new(var2, var4, "Notifications")
var5:AddCloseButton(function()
    module:SetVisible(false)
end)

function var2.OnUpdate(_, arg1)
    var5:OnUpdate(arg1)
end

var3:SetType(Panel3D.Type.Standard)
var3:SetVisible(false)
var3:SetCanFade(false)
var3:ResizeStuds(3.4159999859999997, 3.5, 150)
local var6 = Create("TextButton")({
    Parent = var3:GetGUI(),
    Name = "NotificationsDetailFrame",
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = "",
    Selectable = true,
    SelectionImageObject = SelectionImageObject
})
local var7 = tbl1.new(var3, var6, "Friend Requests")
function var3.OnUpdate(_, arg1)
    var7:OnUpdate(arg1)
end

local tbl4 = ({})
local tbl5 = {}
local function groupSort(arg1, arg2): boolean
    return arg1.order < arg2.order
end
local var8 = nil

local function layoutNotificationsGroups()
    local yOffset = 20
    for _, value in ipairs(tbl5) do
        if not (#value.notifications > 0) then
            continue
        end

        local yOffset2 = (math.min(3, #value.notifications) - 1) * 20 + 80

        value.frame.Position = UDim2.new(0.07500000000000001, 0, 0, yOffset)
        value.frame.Size = UDim2.new(0.85, -40, 0, yOffset2)
        yOffset = yOffset + yOffset2 + 20

        if not value.notificationsDirty then
            continue
        end

        value.notificationsDirty = false

        local num1 = 0
        local num2 = 0

        local notificationsLen = #value.notifications
        if not (notificationsLen > 0) then
            continue
        end

        local num3 = math.max(1, notificationsLen - 3 + 1)
        for i = 1, notificationsLen do
            local notification = value.notifications[i]
            if num3 <= i then
                notification.frame.Visible = true
                notification.frame.Position = UDim2.new(0, num1, 0, num1)
                num1 += 20
                var2:SetSubpanelDepth(notification.frame, num2)
                num2 += 0.25
            else
                notification.frame.Visible = false
            end
        end

        if var8 ~= value then
            continue
        end

        local num4 = math.max(1, notificationsLen - 2 + 1)
        local yScale = 0

        for i = 1, notificationsLen do
            local notification = value.notifications[i]
            if num4 <= i then
                notification.detailsFrame.Visible = true
                notification.detailsFrame.Position = UDim2.new(0, 20, yScale, 20)
                notification.detailsFrame.Size = UDim2.new(1, -40, 0.5, -40)

                yScale += 0.5
            else
                notification.detailsFrame.Visible = false
            end
        end
    end
end

local tbl6 = {}

local tbl7 = { __index = tbl6 }
function tbl6.new(key, title, order)
    local self = setmetatable({}, tbl7)

    self.key = key
    self.title = title
    self.order = order
    self.notifications = {}
    self.notificationsDirty = false
    self.frame = Create("Frame")({ Parent = var5.content, Name = "NotificationGroup", BackgroundTransparency = 1 })

    self.detailsFrame = Create("Frame")(
        {
            Parent = nil,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0)
        }
    )
    tbl4[key] = self
    table.insert(tbl5, self)

    return self
end

function tbl6:Deactivate()
    self.detailsFrame.Parent = nil
    for _, child in pairs(self.detailsFrame:GetChildren()) do
        var3:RemoveSubpanel(child)
    end
end

function tbl6:SwitchTo()
    var7:SetTitle(self.title)
    for _, value in pairs(tbl4) do
        if value ~= self then
            value:Deactivate()
        end
    end
    self.detailsFrame.Parent = var7.content

    var8 = self
    self.notificationsDirty = true
end

function tbl6:BringNotificationToFront(arg1)
    if var8 ~= self then
        self:SwitchTo()
    end

    if #self.notifications ~= 0 and arg1 == self.notifications[#self.notifications] then
        layoutNotificationsGroups()
        return
    end

    for i, notification in ipairs(self.notifications) do
        if notification == arg1 then
            table.remove(self.notifications, i)
            break
        end
    end

    table.insert(self.notifications, arg1)
    self.notificationsDirty = true
    layoutNotificationsGroups()
end

function tbl6:RemoveNotification(arg1)
    for i, notification in ipairs(self.notifications) do
        if notification ~= arg1 then
            continue
        end

        table.remove(self.notifications, i)
        var2:RemoveSubpanel(arg1.frame)
        var3:RemoveSubpanel(arg1.detailsFrame)
        arg1.detailsFrame:Destroy()
        arg1.frame:Destroy()

        self.notificationsDirty = true
        layoutNotificationsGroups()
        return
    end
end

function tbl6:GetTopNotification()
    local notificationsLen = #self.notifications
    return if notificationsLen <= 0 then nil else self.notifications[notificationsLen]
end

tbl6.new("Friends", "Friends", 1)
tbl6.new("BadgeAwards", "Badges", 2)
tbl6.new("PlayerPoints", "Points", 3)

if IsDeveloperGroupEnabled() then
    tbl6.new("Developer", "Other", 4)
end
table.sort(tbl5, groupSort)

local function doCallback(callback, ...)
    if not callback then
        return
    end

    if type(callback) == "function" then
        callback(...)
        return
    end

    if callback:IsA("BindableEvent") then
        callback:Fire(...)
    elseif callback:IsA("BindableFunction") then
        callback:Invoke(...)
    end
end

local tbl8 = {}

local tbl9 = { __index = tbl8 }
function tbl8.new(group, arg1)
    local self = setmetatable({}, tbl9)
    self.group = group
    self.frame = Create("ImageButton")({
        Parent = group.frame,
        Size = UDim2.new(1, 0, 0, 80),
        SelectionImageObject = SelectionImageObject,
        BackgroundTransparency = 1
    })

    self.frame.MouseButton1Click:connect(function()
        self:OnClicked()
    end)
    self.background = Create("ImageLabel")({
        Parent = self.frame,
        Position = UDim2.new(0, -1, 0, -1),
        Size = UDim2.new(1, 2, 1, 2),
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/vr/rectBackgroundWhite.png",
        ImageColor3 = black,
        ImageTransparency = 0.1,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 10, 10)
    })
    self.imageBackground = Create("ImageLabel")({
        Parent = self.frame,
        Position = UDim2.new(0, 5, 0, 5),
        Size = UDim2.new(0, 70, 0, 70),
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/VR/circleWhite.png",
        ImageColor3 = arg1.imgBackgroundColor or Color3.new(1, 1, 1)
    })
    self.image = Create("ImageLabel")({
        Parent = self.imageBackground,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Image = arg1.Image
    })

    local text = arg1.Text
    if arg1.Title and arg1.Text then
        text = ("%s\n%s"):format(arg1.Title, arg1.Text)
    end
    self.text = Create("TextLabel")({
        Parent = self.frame,
        Position = UDim2.new(0, 80, 0, 0),
        Size = UDim2.new(1, -80, 1, 0),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = text,
        TextWrapped = true,
        Font = Enum.Font.SourceSans,
        FontSize = Enum.FontSize.Size18,
        TextColor3 = white
    })

    self.detailsFrame = Create("Frame")({ Parent = group.detailsFrame, BackgroundTransparency = 1 })

    self.detailsFrame.MouseEnter:connect(function()
        var3:SetSubpanelDepth(self.detailsFrame, 0.25)
    end)
    self.detailsFrame.MouseLeave:connect(function()
        var3:SetSubpanelDepth(self.detailsFrame, 0)
    end)
    self.detailsBackground = Create("ImageLabel")({
        Parent = self.detailsFrame,
        Position = UDim2.new(0, -1, 0, -1),
        Size = UDim2.new(1, 2, 1, 2),
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
        ImageColor3 = Color3.new(0.2, 0.2, 0.2),
        ImageTransparency = 0.1,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 10, 10)
    })

    self.detailsIconBackground = Create("ImageLabel")({
        Parent = self.detailsFrame,
        Position = UDim2.new(0, 20, 0, 10),
        Size = UDim2.new(0, 80, 0, 80),
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/VR/circleWhite.png",
        ImageColor3 = arg1.imgBackgroundColor or Color3.new(1, 1, 1)
    })
    self.detailsIcon = Create("ImageLabel")({
        Parent = self.detailsIconBackground,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Image = arg1.Image
    })

    local var9 = arg1.DetailText or arg1.Title
    self.detailsText = Create("TextLabel")({
        Parent = self.detailsFrame,
        Position = UDim2.new(0, 110, 0, 10),
        Size = UDim2.new(1, -120, 0, 90),
        BackgroundTransparency = 1,
        Text = var9,
        TextWrapped = true,
        TextColor3 = white,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.SourceSansBold,
        FontSize = Enum.FontSize.Size36
    })

    local function createButton(xScale: number, xScale2: number, text2)
        local var10 = Create("ImageButton")({
            Parent = self.detailsFrame,
            Position = UDim2.new(xScale, 0, 0.55, 0),
            Size = UDim2.new(xScale2, 0, 0.29, 0),
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 6, 46, 44),
            SelectionImageObject = SelectionImageObject
        })
        local var11 = Create("TextLabel")({
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, -6),
            BackgroundTransparency = 1,
            Text = text2,
            TextColor3 = white,
            Font = Enum.Font.SourceSansBold,
            FontSize = Enum.FontSize.Size24
        })
        var11.Parent = var10

        var10.SelectionGained:connect(function()
            var10.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
        end)
        var10.SelectionLost:connect(function()
            var10.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
        end)
        return var10, var11
    end

    if arg1.Button1Text and arg1.Button2Text then
        local detailsButton1, detailsButton1Text = createButton(0.07, 0.415, arg1.Button1Text)
        self.detailsButton1 = detailsButton1
        self.detailsButton1Text = detailsButton1Text
        local detailsButton2, detailsButton2Text = createButton(0.511, 0.415, arg1.Button2Text)
        self.detailsButton2 = detailsButton2
        self.detailsButton2Text = detailsButton2Text

        self.detailsButton1.MouseButton1Click:connect(function()
            doCallback(arg1.Callback, arg1.Button1Text)
            self:Dismiss()
        end)
        self.detailsButton2.MouseButton1Click:connect(function()
            doCallback(arg1.Callback, arg1.Button2Text)
            self:Dismiss()
        end)
    elseif not arg1.button2Text then
        local detailsButton1, detailsButton1Text = createButton(0.07, 0.86, arg1.Button1Text or "Dismiss")
        self.detailsButton1 = detailsButton1
        self.detailsButton1Text = detailsButton1Text
        self.detailsButton1.MouseButton1Click:connect(function()
            doCallback(arg1.Callback, arg1.Button1Text)
            self:Dismiss()
        end)
    end

    table.insert(group.notifications, self)
    group.notificationsDirty = true
    layoutNotificationsGroups()

    return self
end

function tbl8:OnClicked()
    self.group:SwitchTo()
    layoutNotificationsGroups()
end

function tbl8:Dismiss()
    self.group:RemoveNotification(self)
end

local tbl10 = {}
local IsVisible = false
local num1 = 0

RobloxGui:WaitForChild("SendNotificationInfo").Event:connect(function(arg1)
    local var9 = arg1.GroupName and tbl4[arg1.GroupName]
    if not var9 then
        if not IsDeveloperGroupEnabled() then
            return
        end

        var9 = tbl4.Developer
    end

    tbl8.new(var9, arg1)

    if not IsVisible then
        num1 += 1
        module.UnreadCountChanged(num1)
    end
end)

local function onMenuCloseShortcut(_, userInputState, _)
    if userInputState == Enum.UserInputState.Begin then
        module:SetVisible(false)
    end
end

module.VisibilityStateChanged = Create("BindableEvent")({ Name = "VisibilityStateChanged" })

function module.GetNumberOfPendingNotifications(_): number
    return #tbl10
end

function module.IsVisible(_)
    return IsVisible
end

function module.SetVisible(_, arg1)
    if IsVisible == arg1 then
        return
    end
    IsVisible = arg1

    Panel3D.Get("Topbar3D"):SetCanFade(not arg1)
    if arg1 then
        num1 = 0
        module.UnreadCountChanged(num1)

        var2.localCF = CFrame.new(-1.7079999929999998, 0, 0)
        var5.zeroCF = var2.localCF

        var5:AnimateIn(nil)

        var3.localCF = CFrame.new(1.138666662, 0, 0)
        var7.zeroCF = var3.localCF

        var7:AnimateIn(nil)

        var2:SetVisible(true)
        var3:SetVisible(true)

        ContextActionService:BindCoreAction(
            "NotificationsMenuCloseShortcut",
            onMenuCloseShortcut,
            false,
            Enum.KeyCode.ButtonB,
            Enum.KeyCode.ButtonStart
        )
        VRHub:FireModuleOpened(module.ModuleName)
    else
        spawn(function()
            var5:AnimateOut(function()
                var2:SetVisible(false)
            end)
            var7:AnimateOut(function()
                var3:SetVisible(false)
            end)
        end)

        ContextActionService:UnbindCoreAction("NotificationsMenuCloseShortcut")

        VRHub:FireModuleClosed(module.ModuleName)
    end

    module.VisibilityStateChanged:Fire(arg1)
end

VRHub.ModuleOpened.Event:connect(function(moduleName, _, _, _)
    if moduleName ~= module.ModuleName then
        module:SetVisible(false)
    end
end)

return module
