-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BadgeService = game:GetService("BadgeService")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local PointsService = game:GetService("PointsService")
local MarketplaceService = game:GetService("MarketplaceService")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")
local _UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local VRService = game:GetService("VRService")
local GroupService = game:GetService("GroupService")
local TeleportService = game:GetService("TeleportService")
local LocalizationService = game:GetService("LocalizationService")
local CorePackages = game:GetService("CorePackages")
local UniversalAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy)
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local Logging = require(CorePackages.Workspace.Packages.AppCommonLib).Logging
local RobloxGui = CoreGui.RobloxGui
local GameSettings = UserSettings().GameSettings
local FFlagCoreScriptShowTeleportPrompt = require(RobloxGui.Modules.Flags.FFlagCoreScriptShowTeleportPrompt)
local FriendingUtility = require(RobloxGui.Modules.FriendingUtility)

local engineFeature = game:GetEngineFeature("ClientToastNotificationsEnabled")

local GetFFlagClientToastNotificationsRedirect = require(RobloxGui.Modules.Flags.GetFFlagClientToastNotificationsRedirect)
local GetFFlagFriendshipNotifsUseSendr = require(RobloxGui.Modules.Flags.GetFFlagFriendshipNotifsUseSendr)

local bool1 = game:DefineFastFlag("NotificationsRenameFriendRequestToConnection", false)

local shouldSaveScreenshotToAlbum = require(RobloxGui.Modules.shouldSaveScreenshotToAlbum)
local bool2 = game:DefineFastFlag("FixOnBadgeAwardedError", false)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local function LocalizedGetString(arg1, arg2) -- Luacid: unused: defined but never referenced
    pcall(function()
        arg2 = RobloxTranslator:FormatByKey(arg1)
    end)
    return arg2
end

while not Players.LocalPlayer do
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
end
local LocalPlayer = Players.LocalPlayer
local scriptParent = script.Parent
local tbl1 = {}
local tbl2 = {}
local tbl3 = ({})
local tbl4 = ({})
local SavedQualityLevelValue = GameSettings.SavedQualityLevel.Value
local SendNotificationInfo = Instance.new("BindableEvent")
SendNotificationInfo.Name = "SendNotificationInfo"
SendNotificationInfo.Parent = RobloxGui

local isEnabled = require(RobloxGui.Modules.TenFootInterface):IsEnabled()

local bool3 = true
local bool4 = true

local SocialUtil = require(RobloxGui.Modules.SocialUtil)
local GameTranslator = require(RobloxGui.Modules.GameTranslator)
local CachedPolicyService = require(CorePackages.Workspace.Packages.CachedPolicyService)

local var1 = 0.6 * GameSettings.PreferredTransparency

local num1 = if isEnabled then 72 else 48

local yOffset = if isEnabled then 145 else 64
local xOffset = if isEnabled then 450 else 200
local xOffset2 = num1 / 6

local yOffset2 = if isEnabled then 42 else 18
local num2 = if isEnabled then 84 else 36
local yOffset3 = -yOffset2
local fontSize = isEnabled and Enum.FontSize.Size42 or Enum.FontSize.Size18

local yOffset4 = if isEnabled then 72 else 28
local num3 = if isEnabled then 144 else 56

local fontSize2 = isEnabled and Enum.FontSize.Size36 or Enum.FontSize.Size14

local yOffset5 = yOffset / 2
local offset = xOffset2 / 2
local fontSize3 = isEnabled and Enum.FontSize.Size42 or Enum.FontSize.Size18
local MaxTextSize = if isEnabled then 42 else 18
local MinTextSize = if isEnabled then 30 else 14

local InOut = Enum.EasingDirection.InOut
local Sine = Enum.EasingStyle.Sine

local num6 = 5

local function translateString(str1: string, tbl5)
    local robloxLocaleId = LocalizationService.RobloxLocaleId
    local localization = Localization.new(robloxLocaleId)
    localization:SetLocale(robloxLocaleId)

    local success, result = pcall(function()
        return localization:Format(str1, tbl5)
    end)
    if success then
        return result
    end
    Logging.warn("Failed to translate string with key: " .. str1)
    return ""
end

local success, result = pcall(function(): number?
    return tonumber(settings():GetFVariable("FriendRequestNotificationThrottle"))
end)
if success and result ~= nil then
    num6 = result
end

StarterGui:RegisterSetCore("PointsNotificationsActive", function(arg1)
    if type(arg1) == "boolean" then
        bool3 = arg1
    end
end)
StarterGui:RegisterSetCore("BadgesNotificationsActive", function(arg1)
    if type(arg1) == "boolean" then
        bool4 = arg1
    end
end)

StarterGui:RegisterGetCore("PointsNotificationsActive", function()
    return bool3
end)
StarterGui:RegisterGetCore("BadgesNotificationsActive", function()
    return bool4
end)

local function createFrame(frameName: string, frameSize, framePosition, backgroundTransparency): Frame -- Luacid: Inlined by compiler; 3 call sites recovered
    local frame = Instance.new("Frame")
    frame.Name = frameName
    frame.Size = frameSize
    frame.Position = framePosition
    frame.BackgroundTransparency = backgroundTransparency

    return frame
end

local function createTextButton(textButtonName: string, textButtonPosition): TextButton
    local textButton = Instance.new("TextButton")
    textButton.Name = textButtonName
    textButton.Size = UDim2.new(0.5, -1, 0, yOffset5)
    textButton.Position = textButtonPosition
    textButton.BackgroundTransparency = var1
    textButton.BackgroundColor3 = Color3.new(0, 0, 0)
    textButton.BorderSizePixel = 0
    textButton.Font = Enum.Font.SourceSansBold
    textButton.FontSize = fontSize3
    textButton.TextColor3 = Color3.new(1, 1, 1)
    textButton.TextTruncate = Enum.TextTruncate.AtEnd
    textButton.TextScaled = true

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingTop = UDim.new(0, offset / 2)
    uiPadding.PaddingBottom = UDim.new(0, offset / 2)
    uiPadding.PaddingLeft = UDim.new(0, offset)
    uiPadding.PaddingRight = UDim.new(0, offset)
    uiPadding.Parent = textButton

    local uiTextSizeConstraint = Instance.new("UITextSizeConstraint")
    uiTextSizeConstraint.MaxTextSize = MaxTextSize
    uiTextSizeConstraint.MinTextSize = MinTextSize
    uiTextSizeConstraint.Parent = textButton

    return textButton
end

local frame = createFrame("NotificationFrame", UDim2.new(0, xOffset, 0.42, 0), UDim2.new(1, -xOffset - 4, 0.5, 0), 1)

if FFlagCoreScriptShowTeleportPrompt then
    frame.ZIndex = 3
else
    frame.ZIndex = 2
end
frame.Parent = scriptParent

local function createDefaultNotification()
    local frame2 = createFrame("Notification", UDim2.new(1, 0, 0, yOffset), UDim2.new(0, 0, 0, 0), var1)
    frame2.BackgroundColor3 = Color3.new(0, 0, 0)
    frame2.BorderSizePixel = 0
    return frame2
end

local frame2 = createDefaultNotification()

local NotificationTitle = Instance.new("TextLabel")
NotificationTitle.Name = "NotificationTitle"
NotificationTitle.Size = UDim2.new(1, -xOffset2 * 2, 0, yOffset2)
NotificationTitle.Position = UDim2.new(0, xOffset2, 0.5, yOffset3)
NotificationTitle.BackgroundTransparency = 1
NotificationTitle.Font = Enum.Font.SourceSansBold
NotificationTitle.FontSize = fontSize
NotificationTitle.TextColor3 = Color3.new(0.97, 0.97, 0.97)

local NotificationText = Instance.new("TextLabel")
NotificationText.Name = "NotificationText"
NotificationText.Size = UDim2.new(1, -xOffset2 * 2, 0, yOffset4)
NotificationText.Position = UDim2.new(0, xOffset2, 0.5, 1)
NotificationText.BackgroundTransparency = 1
NotificationText.Font = Enum.Font.SourceSans
NotificationText.FontSize = fontSize2
NotificationText.TextColor3 = Color3.new(0.92, 0.92, 0.92)
NotificationText.TextWrap = true
NotificationText.TextYAlignment = Enum.TextYAlignment.Top

local NotificationImage = Instance.new("ImageLabel")
NotificationImage.Name = "NotificationImage"
NotificationImage.Size = UDim2.new(0, num1, 0, num1)
NotificationImage.Position = UDim2.new(0, xOffset2, 0, 0.5 * (yOffset - num1))
NotificationImage.BackgroundTransparency = 1
NotificationImage.Image = ""

local frame3 = createFrame("PopupFrame", UDim2.new(0, 360, 0, 160), UDim2.new(0.5, -180, 0.5, -50), 0)
frame3.Style = Enum.FrameStyle.DropShadow
frame3.ZIndex = 4
frame3.Visible = false
frame3.Parent = scriptParent

local PopupAcceptButton = Instance.new("TextButton")
PopupAcceptButton.Name = "PopupAcceptButton"
PopupAcceptButton.Size = UDim2.new(0, 100, 0, 50)
PopupAcceptButton.Position = UDim2.new(0.5, -102, 1, -58)
PopupAcceptButton.Style = Enum.ButtonStyle.RobloxRoundButton
PopupAcceptButton.Font = Enum.Font.SourceSansBold
PopupAcceptButton.FontSize = Enum.FontSize.Size24
PopupAcceptButton.TextColor3 = Color3.new(1, 1, 1)
PopupAcceptButton.Text = "Accept"
PopupAcceptButton.ZIndex = 5
PopupAcceptButton.Parent = frame3

local textButton = PopupAcceptButton:Clone()
textButton.Name = "PopupDeclineButton"
textButton.Position = UDim2.new(0.5, 2, 1, -58)
textButton.Text = "Decline"
textButton.Parent = frame3

local textButton2 = PopupAcceptButton:Clone()
textButton2.Name = "PopupOKButton"
textButton2.Position = UDim2.new(0.5, -50, 1, -58)
textButton2.Text = "OK"
textButton2.Visible = false
textButton2.Parent = frame3

local PopupText = Instance.new("TextLabel")
PopupText.Name = "PopupText"
PopupText.Size = UDim2.new(1, -16, 0.8, 0)
PopupText.Position = UDim2.new(0, 8, 0, 8)
PopupText.BackgroundTransparency = 1
PopupText.Font = Enum.Font.SourceSansBold
PopupText.FontSize = Enum.FontSize.Size36
PopupText.TextColor3 = Color3.new(0.97, 0.97, 0.97)
PopupText.TextWrap = true
PopupText.ZIndex = 5
PopupText.TextYAlignment = Enum.TextYAlignment.Top
PopupText.Text = "This is a popup"
PopupText.Parent = frame3

local var2 = nil

local function getFriendImage(userId) -- Luacid: Inlined by compiler; 3 call sites recovered
    return SocialUtil.GetPlayerImage(userId, Enum.ThumbnailSize.Size48x48, Enum.ThumbnailType.HeadShot, 5)
end

local function createNotification(textLabelText, textLabel2Text, image)
    local frame4 = frame2:Clone()
    frame4.Position = UDim2.new(1, 4, 1, -yOffset - 4)

    local textLabel = NotificationTitle:Clone()
    textLabel.Text = textLabelText
    textLabel.Parent = frame4

    local textLabel2 = NotificationText:Clone()
    textLabel2.Text = textLabel2Text
    textLabel2.Parent = frame4

    local bool5 = false
    local function updateNotificationForMultiLineTitle()
        bool5 = true
        textLabel.TextWrapped = true
        textLabel.TextTruncate = Enum.TextTruncate.AtEnd

        local yOffset6 = math.min(
            TextService:GetTextSize(textLabel.Text, textLabel.TextSize, textLabel.Font, Vector2.new(textLabel.AbsoluteSize.X, 1000)).Y - textLabel.Size.Y.Offset,
            num2 - textLabel.Size.Y.Offset
        )

        textLabel.Size += UDim2.new(0, 0, 0, yOffset6)
        textLabel.Position -= UDim2.new(0, 0, 0, yOffset6 / 2)
        textLabel2.Position += UDim2.new(0, 0, 0, yOffset6 / 2)
        frame4.Size += UDim2.new(0, 0, 0, yOffset6)
    end

    frame4.Parent = frame

    if image == nil or image == "" then
        if not textLabel.TextFits then
            bool5 = true
            updateNotificationForMultiLineTitle()
        end

        if not textLabel2.TextFits then
            local yOffset6 = math.min(
                TextService:GetTextSize(
                    textLabel2.Text,
                    textLabel2.TextSize,
                    textLabel2.Font,
                    Vector2.new(textLabel2.AbsoluteSize.X, 1000)
                ).Y - textLabel2.Size.Y.Offset,
                num3 - textLabel2.Size.Y.Offset
            )

            textLabel2.Size += UDim2.new(0, 0, 0, yOffset6)
            textLabel.Position -= UDim2.new(0, 0, 0, yOffset6 / 2)
            textLabel2.Position -= UDim2.new(0, 0, 0, yOffset6 / 2)
            frame4.Size += UDim2.new(0, 0, 0, yOffset6)
        end
    else
        local xOffset3 = num1 + xOffset2 * 2
        local num7 = xOffset2

        local imageLabel = NotificationImage:Clone()
        imageLabel.Image = image
        imageLabel.Parent = frame4

        textLabel.Size = UDim2.new(1, -xOffset3 - num7, 0, textLabel.Size.Y.Offset)
        textLabel.Position = UDim2.new(0, xOffset3, textLabel.Position.Y.Scale, textLabel.Position.Y.Offset)
        textLabel.TextXAlignment = Enum.TextXAlignment.Left

        textLabel2.Size = UDim2.new(1, -xOffset3 - num7, 0, textLabel2.Size.Y.Offset)
        textLabel2.Position = UDim2.new(0, xOffset3, textLabel2.Position.Y.Scale, textLabel2.Position.Y.Offset)
        textLabel2.TextXAlignment = Enum.TextXAlignment.Left

        if not textLabel.TextFits then
            updateNotificationForMultiLineTitle()

            local textSize = textLabel2.TextSize
            textLabel2.Size -= UDim2.new(0, 0, 0, textSize)

            textLabel.Position += UDim2.new(0, 0, 0, textSize / 2 - 2)
            textLabel2.Position += UDim2.new(0, 0, 0, textSize / 2 - 2)
            frame4.Size -= UDim2.new(0, 0, 0, textSize + 4)
        end

        if not textLabel2.TextFits then
            local string2 = nil
            local textLabel2Text = textLabel2.Text
            for i = string.len(textLabel2Text) - 1, 2, -1 do
                if string.sub(textLabel2Text, i, i) ~= " " then
                    continue
                end

                local num8 = i - 1
                textLabel2.Text = string.sub(textLabel2Text, 1, num8)
                if textLabel2.TextFits then
                    string2 = string.sub(textLabel2Text, i + 1)
                    break
                end
            end

            if string2 then
                local textLabel3 = NotificationText:Clone()
                textLabel3.TextXAlignment = Enum.TextXAlignment.Left
                textLabel3.Text = string2
                textLabel3.Name = "ExtraText"
                textLabel3.TextTruncate = Enum.TextTruncate.AtEnd
                textLabel3.Parent = frame4

                local yOffset6 = math.min(
                    TextService:GetTextSize(string2, textLabel3.TextSize, textLabel3.Font, Vector2.new(textLabel3.AbsoluteSize.X, 1000)).Y,
                    num3 - textLabel2.Size.Y.Offset
                )
                textLabel3.Size = UDim2.new(textLabel3.Size.X.Scale, textLabel3.Size.X.Offset, 0, yOffset6)
                textLabel.Position -= UDim2.new(0, 0, 0, yOffset6 / 2)
                textLabel2.Position -= UDim2.new(0, 0, 0, yOffset6 / 2)
                frame4.Size += UDim2.new(0, 0, 0, yOffset6)

                textLabel3.AnchorPoint = Vector2.new(0.5, 0)
                textLabel3.Position = UDim2.new(0.5, 0, textLabel2.Position.Y.Scale, textLabel2.Position.Y.Offset + textLabel2.AbsoluteSize.Y)
            else
                textLabel2.Text = textLabel2Text
            end
        end
    end

    if bool5 and textLabel2.TextFits then
        local vector2 = TextService:GetTextSize(
            textLabel2.Text,
            textLabel2.TextSize,
            textLabel2.Font,
            Vector2.new(textLabel2.AbsoluteSize.X, 1000)
        )
        if vector2.Y < textLabel2.Size.Y.Offset then
            local yOffset6 = textLabel2.Size.Y.Offset - vector2.Y
            textLabel2.Size -= UDim2.new(0, 0, 0, yOffset6)
            textLabel.Position += UDim2.new(0, 0, 0, yOffset6 / 2)
            textLabel2.Position += UDim2.new(0, 0, 0, yOffset6 / 2)
            frame4.Size -= UDim2.new(0, 0, 0, yOffset6)
        end
    end

    frame4.Parent = nil

    GuiService:AddSelectionParent(HttpService:GenerateGUID(false), frame4)

    return frame4
end

local function findNotification(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    for i = 1, #tbl1 do
        if tbl1[i] == arg1 then
            return i
        end
    end
end

local function updateNotifications()
    local num7 = 1
    local num8 = 0
    for i = #tbl1, 1, -1 do
        local var3 = tbl1[i]
        if not var3 then
            continue
        end

        local frame4 = var3.Frame
        if not (frame4 and frame4.Parent) then
            continue
        end

        if var3.IsFriend and (yOffset + 2) * 1.5 then
        end
        num8 += var3.IsFriend and frame4.Size.Y.Offset + (yOffset + 2) * 0.5 or frame4.Size.Y.Offset

        frame4:TweenPositionInternal(UDim2.new(0, 0, 1, -num8 - num7 * 4), InOut, Sine, 0.35, true, function()
            if var3.TweenOutCallback then
                var3.TweenOutCallback()
            end
        end)

        num7 += 1
    end
end

local num7 = 0
local function func1(arg1)
    spawn(function()
        arg1.IsActive = true
        local num8 = #tbl1
        if num8 == 3 then
            tbl1[1].Duration = 0
            tbl2[#tbl2 + 1] = arg1
            return
        end

        tbl1[num8 + 1] = arg1
        arg1.Frame.Parent = frame

        spawn(function()
            wait(0.7)

            while arg1.Duration > 0 do
                wait(0.2)
                arg1.Duration -= 0.2
            end

            var2(arg1)
        end)

        while tick() - num7 < 0.35 do
            wait()
        end
        num7 = tick()

        updateNotifications()
    end)
end

var2 = function(arg1)
    if not arg1 then
        return
    end

    local notification = findNotification(arg1)
    table.remove(tbl1, notification)
    local frame4 = arg1.Frame
    if frame4 and frame4.Parent then
        arg1.IsActive = false
        spawn(function()
            local function doTweenOut()
                if frame4:IsDescendantOf(game) then
                    return frame4:TweenPositionInternal(UDim2.new(1, 0, 1, frame4.Position.Y.Offset), InOut, Sine, 0.35, false, function()
                        frame4:Destroy()
                        arg1 = nil
                    end)
                end

                return false
            end

            if not doTweenOut() then
                arg1.TweenOutCallback = doTweenOut
            end
        end)
    end
    if not (#tbl2 > 0) then
        updateNotifications()
        return
    end

    local var3 = tbl2[1]
    table.remove(tbl2, 1)

    func1(var3)

    if #tbl2 > 0 and tbl1[1] then
        tbl1[1].Duration = 0
    end
end

local function sendNotificationInfo(arg1) -- Luacid: Inlined by compiler; 10 call sites recovered
    arg1.Duration = arg1.Duration or 5
    SendNotificationInfo:Fire(arg1)
end

local function createNotificationButtonDetails(text: string, buttonType, callback) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        Text = text,
        ButtonType = buttonType,
        OnActivated = function()
            if callback and type(callback) ~= "function" then
                pcall(function()
                    callback:Invoke(text)
                end)
            elseif type(callback) == "function" then
                callback(text)
            end
        end
    }
end

SendNotificationInfo.Event:connect(function(arg1) -- name: onSendNotificationInfo
    if VRService.VREnabled then
        return
    end
    local callback = arg1.Callback

    local button1Text = arg1.Button1Text
    local button2Text = arg1.Button2Text

    if engineFeature and GetFFlagClientToastNotificationsRedirect() then
        local buttons = {}

        if button1Text and button1Text ~= "" then
            table.insert(buttons, (createNotificationButtonDetails(button1Text, Enum.NotificationButtonType.Primary, callback)))
        end

        if button2Text and button2Text ~= "" then
            table.insert(buttons, (createNotificationButtonDetails(button2Text, Enum.NotificationButtonType.Secondary, callback)))
        end

        local notificationInfo = {
            Title = if arg1.Autolocalize then GameTranslator:TranslateGameText(CoreGui, arg1.Title) else arg1.Title,
            Text = if arg1.AutoLocalize then GameTranslator:TranslateGameText(CoreGui, arg1.Text) else arg1.Text,
            Icon = arg1.Image,
            OnDisplay = arg1.OnDisplay,
            OnDismiss = arg1.OnDismiss,
            Buttons = buttons
        }
        GuiService:SendNotification(notificationInfo)
        return
    end

    local tbl5 = {}
    local frame4 = if arg1.AutoLocalize then createNotification(
        GameTranslator:TranslateGameText(CoreGui, arg1.Title),
        GameTranslator:TranslateGameText(CoreGui, arg1.Text),
        arg1.Image
    ) else createNotification(arg1.Title, arg1.Text, arg1.Image)
    local textButton3

    if button1Text and button1Text ~= "" then
        tbl5.IsFriend = true
        textButton3 = createTextButton("Button1", UDim2.new(0, 0, 1, 2))
        if arg1.AutoLocalize then
            GameTranslator:TranslateAndRegister(textButton3, CoreGui, button1Text)
        else
            textButton3.Text = button1Text
        end

        textButton3.Parent = frame4
        local connection = nil
        connection = textButton3.MouseButton1Click:connect(function()
            if not connection then
                return
            end

            connection:disconnect()
            connection = nil
            var2(tbl5)
            if callback and type(callback) ~= "function" then
                pcall(function()
                    callback:Invoke(button1Text)
                end)
            elseif type(callback) == "function" then
                callback(button1Text)
            end
        end)
    else
        textButton3 = nil
    end

    if button2Text and button2Text ~= "" then
        tbl5.IsFriend = true

        local textButton4 = createTextButton("Button2", UDim2.new(0.5, 1, 1, 2))

        if arg1.AutoLocalize then
            GameTranslator:TranslateAndRegister(textButton4, CoreGui, button2Text)
        else
            textButton4.Text = button2Text
        end

        textButton4.Parent = frame4
        local connection = nil
        connection = textButton4.MouseButton1Click:connect(function()
            if not connection then
                return
            end

            connection:disconnect()
            connection = nil
            var2(tbl5)
            if callback and type(callback) ~= "function" then
                pcall(function()
                    callback:Invoke(button2Text)
                end)
            elseif type(callback) == "function" then
                callback(arg1.Button2Text)
            end
        end)
    elseif textButton3 then
        textButton3.Size = UDim2.new(1, 0, 0, yOffset5)
    end

    tbl5.Frame = frame4
    tbl5.Duration = arg1.Duration
    func1(tbl5)
end)
StarterGui:RegisterSetCore("SendNotification", function(arg1) -- name: createDeveloperNotification
    if type(arg1) ~= "table" or type(arg1.Title) ~= "string" or type(arg1.Text) ~= "string" then
        return
    end

    local image = if type(arg1.Icon) ~= "string" then "" else arg1.Icon or ""

    local duration = if type(arg1.Duration) ~= "number" then 5 else arg1.Duration or 5

    local callback = if typeof(arg1.Callback) == "Instance" and arg1.Callback:IsA("BindableFunction") then arg1.Callback or nil else nil
    local button1, button2

    if engineFeature and GetFFlagClientToastNotificationsRedirect() then
        if type(arg1.Button1) == "string" then
            button1 = arg1.Button1 or nil
        else
            button1 = nil
        end

        if type(arg1.Button2) == "string" then
            button2 = arg1.Button2 or nil
        else
            button2 = nil
        end
    else
        button1 = if type(arg1.Button1) ~= "string" then "" else arg1.Button1 or ""
        button2 = if type(arg1.Button2) ~= "string" then "" else arg1.Button2 or ""
    end

    local autoLocalize = arg1.AutoLocalize == nil or arg1.AutoLocalize == true
    sendNotificationInfo({
        GroupName = "Developer",
        Title = arg1.Title,
        Text = arg1.Text,
        Image = image,
        Duration = duration,
        Callback = callback,
        Button1Text = button1,
        Button2Text = button2,
        AutoLocalize = autoLocalize
    })
end)

local tbl5 = ({})

local function func2(player: Player): boolean
    local var3 = tbl5[player]

    if var3 and tick() < var3 then
        return true
    end

    tbl5[player] = tick() + num6
    return false
end

local function sendFriendNotification(player: Player)
    if func2(player) then
        return
    end

    local var3 = if bool1 and UniversalAppPolicy.getAppFeaturePolicies().getRenameFriendsToConnections() then translateString("InGame.NotificationScript2.Message.FriendRequestEvent.Sent") else "Sent you a friend request!"

    sendNotificationInfo({
        GroupName = "Friends",
        Title = player.DisplayName,
        Text = var3,
        DetailText = player.DisplayName,
        Image = getFriendImage(player.UserId),
        Duration = 8,
        Callback = function(arg1)
            if arg1 == "Accept" then
                RbxAnalyticsService:ReportCounter("NotificationScript-RequestFriendship")
                RbxAnalyticsService:TrackEvent("Game", "RequestFriendship", "NotificationScript")

                RbxAnalyticsService:ReportCounter("NotificationScript-AcceptFriendship")
                RbxAnalyticsService:TrackEvent("Game", "AcceptFriendship", "NotificationScript")

                LocalPlayer:RequestFriendship(player)
                return
            end
            RbxAnalyticsService:ReportCounter("NotificationScript-RevokeFriendship")
            RbxAnalyticsService:TrackEvent("Game", "RevokeFriendship", "NotificationScript")

            LocalPlayer:RevokeFriendship(player)
            tbl3[player] = true
        end,
        Button1Text = "Accept",
        Button2Text = "Decline",
        OnDisplay = function()
            RbxAnalyticsService:ReportCounter("NotificationScript-FriendshipNotificationDisplayed")
            RbxAnalyticsService:TrackEvent("Game", "FriendshipNotificationDisplayed", "NotificationScript")
        end,
        OnDismiss = function()
            RbxAnalyticsService:ReportCounter("NotificationScript-FriendshipNotificationDismissed")
            RbxAnalyticsService:TrackEvent("Game", "FriendshipNotificationDismissed", "NotificationScript")
        end
    })
end

local function onFriendRequestEvent(player: Player, player: Player, friendRequestEvent: Enum.FriendRequestEvent)
    if player ~= LocalPlayer and player ~= LocalPlayer then
        return
    end

    local title = if bool1 and UniversalAppPolicy.getAppFeaturePolicies().getRenameFriendsToConnections() then translateString("InGame.NotificationScript2.Message.FriendRequestEvent.Accepted") else "New Friend"

    local var4 = UniversalAppPolicy.getAppFeaturePolicies().getRequiresOSAFriendingEducation()

    local friendCountAsync = FriendingUtility:GetFriendCountAsync(LocalPlayer.UserId)
    local bool5 = friendCountAsync == 0 or friendCountAsync == nil

    if player == LocalPlayer then
        if friendRequestEvent == Enum.FriendRequestEvent.Accept and not GetFFlagFriendshipNotifsUseSendr() then
            local detailText = RobloxTranslator:FormatByKey("InGame.NotificationScript2.FriendRequestEvent.Accept", { RBX_NAME = player.Name })
            sendNotificationInfo({
                GroupName = "Friends",
                Title = title,
                Text = player.Name,
                DetailText = detailText,
                Image = getFriendImage(player.UserId),
                Duration = 5
            })
        end

        return
    end

    if player ~= LocalPlayer then
        return
    end

    if friendRequestEvent == Enum.FriendRequestEvent.Issue and not GetFFlagFriendshipNotifsUseSendr() then
        if tbl3[player] or var4 and bool5 then
            return
        else
            sendFriendNotification(player)
            return
        end
    end

    if friendRequestEvent ~= Enum.FriendRequestEvent.Accept then
        return
    end

    local detailText = RobloxTranslator:FormatByKey("InGame.NotificationScript2.FriendRequestEvent.Accept", { RBX_NAME = player.Name })
    sendNotificationInfo({
        GroupName = "Friends",
        Title = title,
        Text = player.Name,
        DetailText = detailText,
        Image = getFriendImage(player.UserId),
        Duration = 5
    })
end

local function onPointsAwarded(userId: number, pointsAwarded: number, _: number, _: number)
    if not bool3 or userId ~= LocalPlayer.UserId then
        return
    end

    local var3, str1

    if pointsAwarded == 1 then
        var3 = RobloxTranslator:FormatByKey(
            "InGame.NotificationScript2.onPointsAwarded.single",
            {
                RBX_NUMBER = tostring(pointsAwarded)
            }
        )
        str1 = "Point Awarded"
    elseif pointsAwarded > 0 then
        var3 = RobloxTranslator:FormatByKey(
            "InGame.NotificationScript2.onPointsAwarded.multiple",
            {
                RBX_NUMBER = tostring(pointsAwarded)
            }
        )
        str1 = "Points Awarded"
    else
        if not (pointsAwarded < 0) then
            return
        end

        var3 = RobloxTranslator:FormatByKey(
            "InGame.NotificationScript2.onPointsAwarded.negative",
            {
                RBX_NUMBER = tostring(pointsAwarded)
            }
        )
        str1 = "Points Lost"
    end

    sendNotificationInfo({
        GroupName = "PlayerPoints",
        Title = str1,
        Text = var3,
        DetailText = var3,
        Image = "https://www.roblox.com/asset?id=206410433",
        Duration = 5
    })
end

local function onBadgeAwarded(userId: number, creatorId: number, badgeId: number)
    if tbl4[badgeId] or not bool4 or userId ~= LocalPlayer.UserId then
        return
    end

    tbl4[badgeId] = true
    local str1 = ""
    if game.CreatorType == Enum.CreatorType.Group then
        local success2, result2 = pcall(function()
            return GroupService:GetGroupInfoAsync(creatorId)
        end)

        if result2 then
            str1 = result2.Name
        else
            str1 = if success2 then str1 else ""
        end
    elseif game.CreatorType == Enum.CreatorType.User then
        local success2, result2 = pcall(function(): string
            return Players:GetNameFromUserIdAsync(creatorId)
        end)

        str1 = if success2 then result2 else ""
    end

    local success2, result2 = pcall(function()
        return BadgeService:GetBadgeInfoAsync(badgeId)
    end)
    if not success2 then
        return
    end

    if bool2 then
        str1 = if str1 == nil then "" else str1
    end

    local detailText = RobloxTranslator:FormatByKey(
        "InGame.NotificationScript2.onBadgeAwardedDetail",
        {
            RBX_NAME = LocalPlayer.Name,
            CREATOR_NAME = str1,
            BADGE_NAME = result2.DisplayName
        }
    )
    local var4 = nil
    local str2 = "InGame.NotificationScript2.onBadgeAwardedTitle"

    pcall(function()
        var4 = RobloxTranslator:FormatByKey(str2)
    end)
    sendNotificationInfo({
        GroupName = "BadgeAwards",
        Title = var4,
        Text = detailText,
        DetailText = detailText,
        Image = "https://www.roblox.com/asset?id=206410289",
        Duration = 5,
        OnDisplay = function()
            RbxAnalyticsService:ReportCounter("NotificationScript-BadgeAwardNotificationDisplayed")
            RbxAnalyticsService:TrackEvent("Game", "BadgeAwardNotificationDisplayed", "NotificationScript")
        end,
        OnDismiss = function()
            RbxAnalyticsService:ReportCounter("NotificationScript-BadgeAwardNotificationDismissed")
            RbxAnalyticsService:TrackEvent("Game", "BadgeAwardNotificationDismissed", "NotificationScript")
        end
    })
end

function onGameSettingsChanged(arg1, arg2)
    if arg1 ~= "SavedQualityLevel" then
        return
    end

    local var3 = GameSettings.SavedQualityLevel.Value + arg2
    local var4 = if var3 > 10 then 10 elseif var3 < 1 then 1 else var3

    if not (var4 > 0)
        or var4 == SavedQualityLevelValue
        or GameSettings.SavedQualityLevel == Enum.SavedQualitySetting.Automatic
    then
        return
    end

    ("%s to (%d)"):format(if SavedQualityLevelValue < var4 then "Increased" else "Decreased", var4)
    local detailText = if SavedQualityLevelValue < var4 then RobloxTranslator:FormatByKey(
        "InGame.NotificationScrip2.onCurrentGraphicsQualityLevelChanged.Increased",
        {
            RBX_NUMBER = tostring(var4)
        }
    ) else RobloxTranslator:FormatByKey(
        "InGame.NotificationScrip2.onCurrentGraphicsQualityLevelChanged.Decreased",
        {
            RBX_NUMBER = tostring(var4)
        }
    )
    sendNotificationInfo({
        GroupName = "Graphics",
        Title = "Graphics Quality",
        Text = detailText,
        DetailText = detailText,
        Image = "",
        Duration = 2
    })

    SavedQualityLevelValue = var4
end

if not CachedPolicyService:IsSubjectToChinaPolicies() then
    BadgeService.OnBadgeAwarded:connect(onBadgeAwarded)
end

if not isEnabled then
    Players.FriendRequestEvent:connect(onFriendRequestEvent)
    PointsService.PointsAwarded:connect(onPointsAwarded)

    game.GraphicsQualityChangeRequest:Connect(function(_: boolean)
        onGameSettingsChanged("SavedQualityLevel", 0)
    end)
end

if not CachedPolicyService:IsSubjectToChinaPolicies() then
    if not shouldSaveScreenshotToAlbum() then
        game.ScreenshotReady:Connect(function(_: string)
            local title = RobloxTranslator:FormatByKey("InGame.NotificationScript2.Screenshot.Title")
            local var4 = RobloxTranslator:FormatByKey("InGame.NotificationScript2.Screenshot.Description")
            local button1Text = RobloxTranslator:FormatByKey("InGame.NotificationScript2.Screenshot.ButtonText")

            sendNotificationInfo({
                Title = title,
                Text = var4,
                Duration = 3,
                Button1Text = button1Text,
                Callback = function(arg1)
                    if arg1 == button1Text then
                        game:OpenScreenshotsFolder()
                    end
                end
            })
        end)
    end

    settings():GetService("GameSettings").VideoRecordingChangeRequest:Connect(function(recording: boolean)
        if recording then
            return
        end

        local title = RobloxTranslator:FormatByKey("InGame.NotificationScript2.Video.Title")
        local var4 = RobloxTranslator:FormatByKey("InGame.NotificationScript2.Video.Description")
        local button1Text = RobloxTranslator:FormatByKey("InGame.NotificationScript2.Video.ButtonText")

        sendNotificationInfo({
            Title = title,
            Text = var4,
            Duration = 3,
            Button1Text = button1Text,
            Callback = function(arg1)
                if arg1 == button1Text then
                    game:OpenVideosFolder()
                end
            end
        })
    end)
end

function GuiService.SendCoreUiNotification(title: string, text: string)
    local frame4 = createNotification(title, text, "")
    frame4.BackgroundTransparency = 0.5
    frame4.Size = UDim2.new(0.5, 0, 0.1, 0)
    frame4.Position = UDim2.new(0.25, 0, -0.1, 0)
    frame4.NotificationTitle.FontSize = Enum.FontSize.Size36
    frame4.NotificationText.FontSize = Enum.FontSize.Size24
    frame4.Parent = scriptParent
    frame4:TweenPositionInternal(UDim2.new(0.25, 0, 0, 0), InOut, Sine, 0.35, true)
    wait(5)
    if frame4 then
        frame4:Destroy()
    end
end

MarketplaceService.ClientLuaDialogRequested:connect(function(arguments, popupAcceptButtonText, textButtonText): boolean -- name: onClientLuaDialogRequested
    PopupText.Text = arguments

    local connection = nil
    local connection2 = nil
    local function disconnectCns() -- Luacid: Inlined by compiler; 2 call sites recovered
        if connection then
            connection:disconnect()
        end
        if connection2 then
            connection2:disconnect()
        end

        GuiService:RemoveCenterDialog(frame3)
        frame3.Visible = false
    end

    connection = PopupAcceptButton.MouseButton1Click:connect(function()
        disconnectCns()
        MarketplaceService:SignalServerLuaDialogClosed(true)
    end)
    connection2 = textButton.MouseButton1Click:connect(function()
        disconnectCns()
        MarketplaceService:SignalServerLuaDialogClosed(false)
    end)

    if not pcall(function()
        GuiService:AddCenterDialog(frame3, Enum.CenterDialogType.QuitDialog, function()
            textButton2.Visible = false
            PopupAcceptButton.Visible = true
            textButton.Visible = true
            PopupAcceptButton.Text = popupAcceptButtonText
            textButton.Text = textButtonText
            frame3.Visible = true
        end, function()
            frame3.Visible = false
        end)
    end) then
        frame3.Visible = true
        PopupAcceptButton.Text = popupAcceptButtonText
        textButton.Text = textButtonText
    end

    return true
end)

local function onPreferredTransparencyChanged()
    var1 = 0.6 * GameSettings.PreferredTransparency
    frame2.BackgroundTransparency = var1

    for i = 1, #tbl1 do
        tbl1[i].Frame.BackgroundTransparency = var1
    end
end
GameSettings:GetPropertyChangedSignal("PreferredTransparency"):connect(onPreferredTransparencyChanged)

if not FFlagCoreScriptShowTeleportPrompt then
    return
end

local function onMenuTeleportAttemptNotification()
    local str1 = "Teleporting Paused"
    local str2 = "Feature.SettingsHub.Prompt.TeleportBlock.Title"

    pcall(function()
        str1 = RobloxTranslator:FormatByKey(str2)
    end)
    local title = str1

    local str4 = "Teleporting will resume upon menu close."
    local str5 = "Feature.SettingsHub.Prompt.TeleportBlock.Subtitle"

    pcall(function()
        str4 = RobloxTranslator:FormatByKey(str5)
    end)
    sendNotificationInfo({
        GroupName = "Teleport",
        Title = title,
        Text = str4,
        Image = "http://www.roblox.com/asset/?id=10961494062",
        Duration = 5,
        BottomPadding = yOffset3
    })
end

local function connectMenuTeleportAttemptEvent()
    TeleportService.MenuTeleportAttempt:Connect(function()
        onMenuTeleportAttemptNotification()
    end)
end

connectMenuTeleportAttemptEvent()
