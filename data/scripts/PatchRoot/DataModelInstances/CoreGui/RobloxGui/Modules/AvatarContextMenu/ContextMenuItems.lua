-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local Chat = game:GetService("Chat")
local RunService = game:GetService("RunService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local GuiService = game:GetService("GuiService")
local CorePackages = game:GetService("CorePackages")
local TextChatService = game:GetService("TextChatService")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Modules = RobloxGui:WaitForChild("Modules")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local GameTranslator = require(RobloxGui.Modules.GameTranslator)
local AvatarContextMenu = Modules:WaitForChild("AvatarContextMenu")
local ContextMenuUtil = require(AvatarContextMenu:WaitForChild("ContextMenuUtil"))
local ThemeHandler = require(AvatarContextMenu.ThemeHandler)

local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)
local t = require(CorePackages.Packages.t)
local ArgCheck = require(CorePackages.Workspace.Packages.ArgCheck)
local ExpChat = require(CorePackages.Workspace.Packages.ExpChat)

local FFlagAvatarContextMenuItemsChatButtonRefactor = require(Modules.Flags.FFlagAvatarContextMenuItemsChatButtonRefactor)

local FFlagWhisperEmoteOnAvatarContextMenuWithExpChat = require(Modules.Common.Flags.FFlagWhisperEmoteOnAvatarContextMenuWithExpChat)

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players.PlayerAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

local tbl1 = {
    [Enum.AvatarContextMenuOption.Chat] = true,
    [Enum.AvatarContextMenuOption.Friend] = true,
    [Enum.AvatarContextMenuOption.Emote] = true,
    [Enum.AvatarContextMenuOption.InspectMenu] = true
}

local tbl2 = ({})
local num1 = 0

local module = {}
module.__index = module

function module.UpdateInspectMenuEnabled(_)
    local inspectMenuEnabled = GuiService:GetInspectMenuEnabled()

    if inspectMenuEnabled ~= tbl1[Enum.AvatarContextMenuOption.InspectMenu] then
        tbl1[Enum.AvatarContextMenuOption.InspectMenu] = inspectMenuEnabled
    end
end

function module:ClearMenuItems()
    local children = self.MenuItemFrame:GetChildren()
    for i = 1, #children do
        if children[i]:IsA("GuiObject") then
            children[i]:Destroy()
        end
    end
end

function module:AddCustomAvatarMenuItem(arg1, event)
    num1 += 1
    tbl2[arg1] = { event = event, layoutOrder = num1 }
end

function module:RemoveCustomAvatarMenuItem(arg1)
    tbl2[arg1] = nil
end

function module:IsContextAvatarEnumItem(arg1)
    local enumItems = Enum.AvatarContextMenuOption:GetEnumItems()
    for i = 1, #enumItems do
        if arg1 == enumItems[i] then
            return true
        end
    end
    return false
end

function module:EnableDefaultMenuItem(arg1)
    tbl1[arg1] = true
end

function module:RemoveDefaultMenuItem(arg1)
    tbl1[arg1] = false
end

function module:RegisterCoreMethods()
    StarterGui:RegisterSetCore("AddAvatarContextMenuOption", function(arg1) -- name: addMenuItemFunc
        if type(arg1) == "table" then
            local str1 = ""
            if arg1[1] and type(arg1[1]) == "string" then
                str1 = arg1[1]
            else
                error("AddAvatarContextMenuOption first argument must be a table or Enum.AvatarContextMenuOption")
            end

            if arg1[2] and typeof(arg1[2]) == "Instance" and arg1[2].ClassName == "BindableEvent" then
                self:AddCustomAvatarMenuItem(str1, arg1[2])
                return
            end
            error("AddAvatarContextMenuOption second table entry must be a BindableEvent")
        elseif typeof(arg1) == "EnumItem" then
            if self:IsContextAvatarEnumItem(arg1) then
                self:EnableDefaultMenuItem(arg1)
                return
            end
            error("AddAvatarContextMenuOption given EnumItem is not valid")
        else
            error("AddAvatarContextMenuOption first argument must be a table or Enum.AvatarContextMenuOption")
        end
    end)

    StarterGui:RegisterSetCore("RemoveAvatarContextMenuOption", function(arg1) -- name: removeMenuItemFunc
        if type(arg1) == "string" then
            self:RemoveCustomAvatarMenuItem(arg1)
            return
        end

        if typeof(arg1) ~= "EnumItem" then
            error("RemoveAvatarContextMenuOption first argument must be a string or Enum.AvatarContextMenuOption")
            return
        end

        if self:IsContextAvatarEnumItem(arg1) then
            self:RemoveDefaultMenuItem(arg1)
            return
        end
        error("RemoveAvatarContextMenuOption given EnumItem is not valid")
    end)
end

function module:CreateCustomMenuItems()
    for k, value in pairs(tbl2) do
        RbxAnalyticsService:TrackEvent("Game", "AvatarContextMenuCustomButton", "name: " .. tostring(k))

        local var1 = GameTranslator:TranslateGameText(self.MenuItemFrame, k)

        local var2 = ContextMenuUtil:MakeStyledButton("CustomButton", var1, UDim2.new(0.96, 0, 0, 52), function() -- name: customButtonFunc
            if self.CloseMenuFunc then
                self:CloseMenuFunc()
            end

            value.event:Fire(self.SelectedPlayer)
        end, ThemeHandler:GetTheme())

        var2.Name = "CustomButton"
        var2.LayoutOrder = value.layoutOrder
        var2.Parent = self.MenuItemFrame
    end
end

local str1 = "Add Friend"
local str2 = "Friends"
local str3 = "Friend Request Pending"
local str4 = "Accept Friend Request"
local str5 = "Player Blocked"

function module:CreateFriendButton(friendStatus, arg1)
    str1 = RobloxTranslator:FormatByKey("Corescripts.AvatarContextMenu.AddFriend")
    str2 = RobloxTranslator:FormatByKey("Corescripts.AvatarContextMenu.Friends")
    str3 = RobloxTranslator:FormatByKey("Corescripts.AvatarContextMenu.FriendRequestPending")
    str4 = RobloxTranslator:FormatByKey("Corescripts.AvatarContextMenu.AcceptFriendRequest")
    str5 = RobloxTranslator:FormatByKey("Corescripts.AvatarContextMenu.PlayerBlocked")

    local friendStatus2 = self.MenuItemFrame:FindFirstChild("FriendStatus")
    if friendStatus2 then
        friendStatus2:Destroy()
        friendStatus2 = nil
    end

    local var1 = nil

    local function func1()
        if not var1 or not friendStatus2.Selectable then
            return
        end

        friendStatus2.Selectable = false
        var1.TextTransparency = 0.75
        var1.Text = str3
        RbxAnalyticsService:ReportCounter("AvatarContextMenu-RequestFriendship")
        RbxAnalyticsService:TrackEvent("Game", "RequestFriendship", "AvatarContextMenu")
        LocalPlayer:RequestFriendship(self.SelectedPlayer)
    end

    friendStatus2, var1 = ContextMenuUtil:MakeStyledButton("FriendStatus", str1, UDim2.new(0.96, 0, 0, 52), func1, ThemeHandler:GetTheme())

    if arg1 then
        friendStatus2.Selectable = false
        var1.TextTransparency = 0.75
        var1.Text = str5
    elseif friendStatus == Enum.FriendStatus.Friend then
        friendStatus2.Selectable = false
        var1.TextTransparency = 0.75
        var1.Text = str2
    elseif friendStatus == Enum.FriendStatus.FriendRequestSent then
        friendStatus2.Selectable = false
        var1.TextTransparency = 0.75
        var1.Text = str3
    elseif friendStatus == Enum.FriendStatus.FriendRequestReceived then
        var1.Text = str4
    else
        friendStatus2.Selectable = true
        var1.TextTransparency = 0
    end

    local layoutOrder = num1 + 1
    friendStatus2.LayoutOrder = layoutOrder
    local menuItemFrame = self.MenuItemFrame
    friendStatus2.Parent = menuItemFrame
end

function module:UpdateFriendButton(arg1, arg2)
    if self.MenuItemFrame:FindFirstChild("FriendStatus") then
        self:CreateFriendButton(arg1, arg2)
    end
end

function module:CreateInspectAndBuyButton()
    local function browseItems()
        if self.CloseMenuFunc then
            self:CloseMenuFunc()
        end

        if not tbl1[Enum.AvatarContextMenuOption.InspectMenu] then
            warn("The Inspect Menu is not currently available.")
            return
        end

        GuiService:InspectPlayerFromUserIdWithCtx(self.SelectedPlayer.UserId, "avatarContextMenu")
    end
    local var1 = ContextMenuUtil:MakeStyledButton(
        "View",
        RobloxTranslator:FormatByKey("InGame.InspectMenu.Action.View"),
        UDim2.new(0.96, 0, 0, 52),
        browseItems,
        ThemeHandler:GetTheme()
    )
    var1.LayoutOrder = num1 + 4
    var1.Parent = self.MenuItemFrame
end

local function findFirstTextChannel()
    local rbxGeneral = TextChatService:FindFirstChild("RBXGeneral", true)
    if rbxGeneral then
        return rbxGeneral
    end
    for _, descendant in ipairs(TextChatService:GetDescendants()) do
        if not descendant:IsA("TextSource") or descendant.UserId ~= Players.LocalPlayer.UserId or descendant.CanSend ~= true then
            continue
        end

        local descendantParent = descendant.Parent
        if descendantParent:IsA("TextChannel") then
            return descendantParent
        end
    end

    return nil
end

local function isExperienceChatOn(textChatService): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    local success, _result = pcall(function()
        local _legacyChatService = Enum.ChatVersion.LegacyChatService
    end)
    return not not (success and textChatService.ChatVersion == Enum.ChatVersion.TextChatService)
end

function module:CreateEmoteButton()
    local function wave()
        if self.CloseMenuFunc then
            self:CloseMenuFunc()
        end

        RbxAnalyticsService:ReportCounter("AvatarContextMenu-Wave")
        RbxAnalyticsService:TrackEvent("Game", "AvatarContextMenuWave", "placeId: " .. tostring(game.PlaceId))

        Players:Chat("/e wave")

        if not isExperienceChatOn(self.TextChatService) then
            return
        end

        local firstTextChannel = findFirstTextChannel()
        if firstTextChannel then
            firstTextChannel:SendAsync("/e wave")
        end
    end

    local var1 = RobloxTranslator:FormatByKey("Corescripts.AvatarContextMenu.Wave")
    local var2 = ContextMenuUtil:MakeStyledButton("Wave", var1, UDim2.new(0.96, 0, 0, 52), wave, ThemeHandler:GetTheme())

    var2.LayoutOrder = num1 + 5
    var2.Parent = self.MenuItemFrame
end

local var1 = t.interface({ localPlayerChatEnabled = t.boolean, localPlayerCanChatWithSelectedPlayer = t.boolean })

function module:CreateChatButton(arg1)
    local var2 = FFlagWhisperEmoteOnAvatarContextMenuWithExpChat

    if not var2 and isExperienceChatOn(self.TextChatService) then
        return
    end

    local bool1 = false
    local function chatFunc()
        if bool1 then
            return
        end

        if self.CloseMenuFunc then
            self:CloseMenuFunc()
        end

        RbxAnalyticsService:ReportCounter("AvatarContextMenu-Chat")
        RbxAnalyticsService:TrackEvent("Game", "AvatarContextMenuChat", "placeId: " .. tostring(game.PlaceId))

        if var2 and isExperienceChatOn(self.TextChatService) then
            local firstTextChannel = findFirstTextChannel()
            if firstTextChannel then
                task.spawn(function()
                    firstTextChannel:SendAsync("/w @" .. self.SelectedPlayer.Name)
                end)
                if ExpChat.Events and ExpChat.Events.AvatarContextMenuWhisperSelected then
                    ExpChat.Events.AvatarContextMenuWhisperSelected()
                end
            end

            return
        end

        local chatSelector = require(RobloxGui.Modules.ChatSelector)
        chatSelector:SetVisible(true)
        if chatSelector:EnterWhisperState(self.SelectedPlayer) then
            return
        end
        local chatBar = nil
        pcall(function()
            chatBar = LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar
        end)
        if chatBar then
            local var3 = "/w " .. self.SelectedPlayer.Name
            chatBar.Text = var3
        end
        chatSelector:FocusChatBar()
    end

    local var3 = RobloxTranslator:FormatByKey("Corescripts.AvatarContextMenu.Chat")
    local var4, var5 = ContextMenuUtil:MakeStyledButton("ChatStatus", var3, UDim2.new(0.96, 0, 0, 52), chatFunc, ThemeHandler:GetTheme())

    var4.LayoutOrder = num1 + 3
    local localPlayerChatEnabled

    if FFlagAvatarContextMenuItemsChatButtonRefactor then
        ArgCheck.assert(var1(arg1))
        localPlayerChatEnabled = arg1.localPlayerChatEnabled
    else
        local success, result = pcall(function(): boolean
            return Chat:CanUserChatAsync(LocalPlayer.UserId)
        end)
        localPlayerChatEnabled = success and (RunService:IsStudio() or result)
    end

    if not localPlayerChatEnabled then
        var4.Parent = nil
        return
    end

    var4.Parent = self.MenuItemFrame

    if not (if FFlagAvatarContextMenuItemsChatButtonRefactor then arg1.localPlayerCanChatWithSelectedPlayer else ContextMenuUtil:GetCanChatWith(self.SelectedPlayer)) then
        bool1 = true
        var4.Selectable = false
        var5.TextTransparency = 0.75
        var5.Text = RobloxTranslator:FormatByKey("Corescripts.AvatarContextMenu.ChatDisabled")
    end
end

function module:RemoveLastButtonUnderline()
    local children = self.MenuItemFrame:GetChildren()
    local var2 = nil
    local num2 = -1
    for _, child in pairs(children) do
        if child:IsA("GuiObject") and num2 < child.LayoutOrder then
            num2 = child.LayoutOrder
            var2 = child
        end
    end

    if not var2 then
        return
    end

    local underline = var2:FindFirstChild("Underline")
    if underline then
        underline:Destroy()
    end
end

function module.BuildContextMenuItems(arg1, arg2, arg3)
    if not arg2 then
        return
    end

    local friendStatus = ContextMenuUtil:GetFriendStatus(arg2)
    local isPlayerBlockedByUserId = BlockingUtility:IsPlayerBlockedByUserId(arg2.UserId)
    arg1:ClearMenuItems()
    arg1:SetSelectedPlayer(arg2)
    if tbl1[Enum.AvatarContextMenuOption.Friend] then
        arg1:CreateFriendButton(friendStatus, isPlayerBlockedByUserId)
    end
    if tbl1[Enum.AvatarContextMenuOption.Chat] then
        arg1:CreateChatButton(arg3)
    end
    if tbl1[Enum.AvatarContextMenuOption.Emote] then
        arg1:CreateEmoteButton()
    end

    if tbl1[Enum.AvatarContextMenuOption.InspectMenu] then
        arg1:CreateInspectAndBuyButton()
    end
    arg1:CreateCustomMenuItems()

    arg1:RemoveLastButtonUnderline()
end

function module:SetSelectedPlayer(selectedPlayer)
    self.SelectedPlayer = selectedPlayer
end

function module.SetCloseMenuFunc(arg1, closeMenuFunc)
    arg1.CloseMenuFunc = closeMenuFunc
end

function module.new(menuItemFrame, arg1)
    local self = setmetatable({}, module)

    self.MenuItemFrame = menuItemFrame
    self.SelectedPlayer = nil
    self.TextChatService = arg1 and arg1.TextChatService or TextChatService
    self:RegisterCoreMethods()

    module:UpdateInspectMenuEnabled()

    return self
end

GuiService.InspectMenuEnabledChangedSignal:Connect(function(enabled: boolean)
    if not enabled then
        module:RemoveDefaultMenuItem(Enum.AvatarContextMenuOption.InspectMenu)
        return
    end
    module:EnableDefaultMenuItem(Enum.AvatarContextMenuOption.InspectMenu)
end)

return module
