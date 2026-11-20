-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local RunService = game:GetService("RunService")
local LocalizationService = game:GetService("LocalizationService")
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local UserProfiles = require(CorePackages.Workspace.Packages.UserProfiles)
local formatUsername = UserProfiles.Formatters.formatUsername
local Cryo = require(CorePackages.Packages.Cryo)
local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)
local OpenTypeSupport = require(CorePackages.Packages.UIBlox).Utility.OpenTypeSupport
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization

local Utility = require(RobloxGui.Modules.Settings.Utility)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

local ReportAbuseMenuContainerPage = require(RobloxGui.Modules.Settings.Pages.ReportAbuseMenuContainerPage)
local SocialUtil = require(RobloxGui.Modules:WaitForChild("SocialUtil"))
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local onBlockButtonActivated = require(script:FindFirstAncestor("Settings").onBlockButtonActivated)
local VoiceAnalytics = require(script:FindFirstAncestor("Settings").Analytics.VoiceAnalytics)
local Constants = require(RobloxGui.Modules.VoiceChat.Constants)
local BlockingAnalytics = require(script:FindFirstAncestor("Settings").Analytics.BlockingAnalytics)
local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)
local var1 = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).CoreLogger:new(script.Name)
local MenuButtonsContainer = require(RobloxGui.Modules.Settings.Components.MenuButtons.MenuButtonsContainer)

local BuilderIcons = require(CorePackages.Packages.BuilderIcons)
local uiblox = BuilderIcons.Migration.uiblox

local GameInviteAnalyticsManager = require(CorePackages.Workspace.Packages.GameInvite).GameInviteAnalyticsManager

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagUserProfilePlatformProfile = SharedFlags.FFlagUserProfilePlatformProfile
local GetFFlagLuaAppEnableOpenTypeSupport = SharedFlags.GetFFlagLuaAppEnableOpenTypeSupport
local FFlagIEMTabFocusNav = SharedFlags.FFlagIEMTabFocusNav
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagRelocateMobileMenuButtons = require(RobloxGui.Modules.Settings.Flags.FFlagRelocateMobileMenuButtons)
local FIntRelocateMobileMenuButtonsVariant = require(RobloxGui.Modules.Settings.Flags.FIntRelocateMobileMenuButtonsVariant)
local FFlagMenuButtonsMountWithIEM = require(RobloxGui.Modules.Settings.Flags.FFlagMenuButtonsMountWithIEM)
local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")
local FFlagHidePeoplePageInviteFriends = SharedFlags.FFlagHidePeoplePageInviteFriends
local FFlagAddInviteFriendsIntegration = SharedFlags.FFlagAddInviteFriendsIntegration

local UserProfileStore = UserProfiles.Stores.UserProfileStore

local _success, result = pcall(function(): PlatformFriendsService
    return game:GetService("PlatformFriendsService")
end)

local Theme = require(script.Parent.Parent.Theme)

local Constants2 = require(RobloxGui.Modules:WaitForChild("InGameMenu"):WaitForChild("Resources"):WaitForChild("Constants"))

local uDim2 = UDim2.new(0.5, -10, 0, 52)

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players.ChildAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

local GetFFlagVoiceChatUILogging = require(RobloxGui.Modules.Flags.GetFFlagVoiceChatUILogging)

local GetFFlagDefaultFriendingLabelTextNonEmpty = require(RobloxGui.Modules.Settings.Flags.GetFFlagDefaultFriendingLabelTextNonEmpty)

local GetFFlagEnableLeaveGameUpsellEntrypoint = require(RobloxGui.Modules.Settings.Flags.GetFFlagEnableLeaveGameUpsellEntrypoint)

local GetFFlagDestroyPlayerCardOnLeave = require(RobloxGui.Modules.Settings.Flags.GetFFlagDestroyPlayerCardOnLeave)

local GetFFlagEnableConsoleJoinVoice = require(RobloxGui.Modules.Settings.Flags.GetFFlagEnableConsoleJoinVoice)
local bool1 = game:DefineFastFlag("EnableConsoleJoinVoiceTranslation", false)
local bool2 = game:DefineFastFlag("CheckButtonFrameBeforeDestroy", false)

local isEngineTruncationEnabledForIngameSettings = require(RobloxGui.Modules.Flags.isEngineTruncationEnabledForIngameSettings)

local engineFeature2 = game:GetEngineFeature("VoiceChatMultistreamSubscriptionsEnabled")

local bool3 = game:DefineFastFlag("LuaFlagVoiceChatDisableSubscribeRetryForMultistream", true)
local bool4 = game:DefineFastFlag("PlayerListRefactorUsernameFormatting", false)
local bool5 = game:DefineFastFlag("CheckShareGameButtonInMuteAllLayout", false)
local bool6 = game:DefineFastFlag("OnlyCaptureFocusIfOnPlayerPage", false)

local num1 = game:DefineFastInt("SettingsHubPlayersButtonsResponsiveThreshold", 200)
local GetFFlagCleanupMuteSelfButton = require(RobloxGui.Modules.Settings.Flags.GetFFlagCleanupMuteSelfButton)

local bool7 = game:DefineFastFlag("CheckForNilUserIdOnPlayerList", false)
local var2 = require(CorePackages.Workspace.Packages.Chrome).Enabled()

local MuteStatusIcons = default.MuteStatusIcons
local PlayerMuteStatusIcons = default.PlayerMuteStatusIcons

local function Initialize()
    local var3 = require(RobloxGui.Modules.Settings.SettingsPageFactory):CreateNewPage()

    var3.PageListLayout.Padding = UDim.new(0, 16)
    var3.playSessionId = ""
    if engineFeature then
        var3.playSessionId = RbxAnalyticsService:GetPlaySessionId()
    end

    local tbl1 = ({})
    local robloxLocaleId = LocalizationService.RobloxLocaleId
    if not tbl1[robloxLocaleId] then
        tbl1[robloxLocaleId] = Localization.new(robloxLocaleId)
    end

    var3.TabHeader.Name = "PlayersTab"
    local iconsMenuFriends = uiblox["icons/menu/friends"]
    var3.TabHeader.TabLabel.Icon.Text = iconsMenuFriends.name
    var3.TabHeader.TabLabel.Icon.FontFace = BuilderIcons.Font[iconsMenuFriends.variant]

    var3.TabHeader.TabLabel.Title.Text = "People"

    local function getFriendStatus(player: Player) -- Luacid: Inlined by compiler; 1 call site recovered
        local success, result2 = pcall(function(): Enum.FriendStatus
            return LocalPlayer:GetFriendStatus(player)
        end)
        return if success then result2 else Enum.FriendStatus.NotFriend
    end

    var3.Page.Name = "Players"

    local function showRightSideButtons(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        return arg1 and arg1 ~= LocalPlayer and arg1.UserId > 0 and LocalPlayer.UserId > 0
    end

    local function useOptimizedPortraitLayout() -- Luacid: Inlined by compiler; 3 call sites recovered
        return Utility:IsSmallTouchScreen() and Utility:IsPortrait()
    end

    local function getIsBlocked(player) -- Luacid: Inlined by compiler; 2 call sites recovered
        return BlockingUtility:IsPlayerBlockedByUserId(player.UserId)
    end

    local function createFriendStatusTextLabel(friendStatus, player: Player)
        if friendStatus == nil then
            return nil
        end

        local frame = Instance.new("Frame")
        frame.BackgroundTransparency = 1

        local var4 = nil
        local var5 = nil
        if friendStatus == Enum.FriendStatus.Friend or friendStatus == Enum.FriendStatus.FriendRequestSent then
            var4 = Instance.new("TextButton")
            var4.BackgroundTransparency = 1
            local fontSize = Theme.fontSize(Enum.FontSize.Size24)
            var4.FontSize = fontSize
            local font = Theme.font(Enum.Font.SourceSans)
            var4.Font = font
            local white = Color3.new(1, 1, 1)
            var4.TextColor3 = white
            var4.SelectionImageObject = frame
            if friendStatus == Enum.FriendStatus.Friend then
                local var8 = tbl1[robloxLocaleId]:Format(Constants2.FriendLocalizedKey)
                var4.Text = var8
            else
                var4.Text = "Request Sent"
            end
        elseif friendStatus == Enum.FriendStatus.Unknown
            or friendStatus == Enum.FriendStatus.NotFriend
            or friendStatus == Enum.FriendStatus.FriendRequestReceived
        then
            local function func1()
                if not var4 or not var5 or var5.Text == "" then
                    return
                end

                var4.ImageTransparency = 1
                var5.Text = ""
                if GetFFlagDefaultFriendingLabelTextNonEmpty() then
                    var5.Text = tbl1[robloxLocaleId]:Format(Constants2.AddFriendLocalizedKey)
                end
                if not LocalPlayer or not player then
                    return
                end

                RbxAnalyticsService:ReportCounter("PlayersMenu-RequestFriendship")
                RbxAnalyticsService:SetRBXEventStream(
                    Constants2.AnalyticsTargetName,
                    Constants2.AnalyticsRequestFriendContext,
                    Constants2.AnalyticsRequestFriendName,
                    { category = "Game" }
                )

                LocalPlayer:RequestFriendship(player)
            end

            var4, var5 = Utility:MakeStyledButton(
                "FriendStatus",
                tbl1[robloxLocaleId]:Format(Constants2.AddFriendLocalizedKey),
                UDim2.new(0, 182, 0, Theme.ButtonHeight),
                func1
            )

            var5.ZIndex = 3
            local var6 = var5.Position + UDim2.new(0, 0, 0, 1)
            var5.Position = var6
        end

        if var4 then
            var4.Name = "FriendStatus"
            var4.ZIndex = 3
            local uDim2_2 = UDim2.new(0, 150, 0, Theme.ButtonHeight)
            var4.Size = uDim2_2
            local uDim2_3 = UDim2.new(1, -198, 0, 7)
            var4.Position = uDim2_3
            if var5 then
                local uDim2_4 = UDim2.new(0, 0, 0, 0)
                var5.Position = uDim2_4
            end
        end
        return var4
    end

    local function createFriendStatusImageLabel(friendStatus, player: Player)
        if friendStatus == Enum.FriendStatus.Friend or friendStatus == Enum.FriendStatus.FriendRequestSent then
            local str1, num2

            if friendStatus == Enum.FriendStatus.Friend then
                str1 = "icons/menu/friends"
                num2 = 0
            else
                str1 = "icons/actions/friends/friendAdd"
                num2 = 0.5
            end

            local var4, _ = Utility:MakeStyledImageButton(
                "FriendStatus",
                str1,
                UDim2.new(0, Theme.ButtonHeight, 0, Theme.ButtonHeight),
                UDim2.new(0, 28, 0, 28)
            )
            var4.Name = "FriendStatus"
            var4.Selectable = false
            var4.FriendStatusTextLabel.TextTransparency = num2

            return var4
        end
        if friendStatus ~= Enum.FriendStatus.Unknown
            and friendStatus ~= Enum.FriendStatus.NotFriend
            and friendStatus ~= Enum.FriendStatus.FriendRequestReceived
        then
            return nil
        end

        local var4 = nil
        local var5 = nil
        local function func1()
            if not var4 or not var5 or var4.ImageTransparency == 1 then
                return
            end

            var4.ImageTransparency = 1
            var5.TextTransparency = 1
            if not LocalPlayer or not player then
                return
            end

            RbxAnalyticsService:ReportCounter("PlayersMenu-RequestFriendship")
            RbxAnalyticsService:SetRBXEventStream(
                Constants2.AnalyticsTargetName,
                Constants2.AnalyticsRequestFriendContext,
                Constants2.AnalyticsRequestFriendName,
                { category = "Game" }
            )

            LocalPlayer:RequestFriendship(player)
        end

        var4, var5 = Utility:MakeStyledImageButton(
            "FriendStatus",
            "icons/actions/friends/friendAdd",
            UDim2.new(0, Theme.ButtonHeight, 0, Theme.ButtonHeight),
            UDim2.new(0, 28, 0, 28),
            func1
        )

        var4.Name = "FriendStatus"
        var4.Selectable = true
        return var4
    end

    local var4 = nil
    local var5 = nil
    local var6 = nil
    local var7 = nil
    local tbl2 = ({})
    local voiceAnalytics = VoiceAnalytics.new(RbxAnalyticsService, "Players")

    local bool8 = false

    local tbl3 = {}
    local var8 = nil
    local var9 = nil

    local function func1(): boolean
        return var3.Page.AbsoluteSize.X < num1 * #tbl3
    end

    local function func2()
        tbl3 = {}

        if var4 then
            table.insert(tbl3, var4)
        end

        if var5 then
            table.insert(tbl3, var5)
        end

        if var6 then
            table.insert(tbl3, var6)
        end

        if GetFFlagEnableConsoleJoinVoice() and var7 then
            table.insert(tbl3, var7)
        end

        bool8 = func1()

        if not (#tbl3 > 0) then
            if bool2 then
                if var8 then
                    var8:Destroy()
                    var8 = nil
                    return
                end
            else
                var8:Destroy()
                var8 = nil
            end

            return
        end

        local uDim2_2 = UDim2.new(1 / #tbl3, 0, 0, 52)
        local tbl4 = {
            Size = UDim2.new(1, (#tbl3 - 1) * -20, 0, 52),
            AutomaticSize = Enum.AutomaticSize.None
        }
        local tbl5 = {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 20)
        }

        if bool8 then
            uDim2_2 = UDim2.new(1, 0, 0, 52)
            tbl4 = {
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            }
            tbl5 = {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 16)
            }
        end

        local num2 = 1
        for _, value in tbl3 do
            value.Size = uDim2_2
            value.Parent = var8
            value.LayoutOrder = num2
            num2 += 1
        end

        for value, value2 in tbl5 do
            if not GetFFlagCleanupMuteSelfButton() or var9 then
                var9[value] = value2
            end
        end

        for value, value2 in tbl4 do
            if not GetFFlagCleanupMuteSelfButton() or var8 then
                var8[value] = value2
            end
        end
    end

    local function getDisplayNameLabel(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        if arg1 and arg1.Parent then
            return arg1:FindFirstChild("DisplayNameLabel")
        end
        return nil
    end

    local function getInExperienceCombinedName(data) -- Luacid: Inlined by compiler; 3 call sites recovered
        if #data == 0 then
            return ""
        end
        local var10 = data[1]
        if var10 == nil then
            return ""
        end
        local names = var10.names
        if names == nil then
            return ""
        end
        return names.getInExperienceCombinedName(false)
    end

    local function resizeFriendButton(arg1, player, arg2, arg3)
        local friendStatus = arg1:FindFirstChild("FriendStatus")
        if friendStatus and arg2 == arg3 then
            return
        end

        if friendStatus then
            friendStatus:Destroy()
            friendStatus = nil
        end

        local friendStatus2 = if showRightSideButtons(player) then getFriendStatus(player) else nil

        if getIsBlocked(player) == false then
            if arg2 then
                friendStatus = createFriendStatusImageLabel(friendStatus2, player)
            else
                friendStatus = createFriendStatusTextLabel(friendStatus2, player)
            end
        end

        if not friendStatus then
            return
        end

        friendStatus.Name = "FriendStatus"
        friendStatus.LayoutOrder = 5
        friendStatus.Selectable = true
        local var10 = "utility-focus-state" .. "-friendstatuslabel-" .. player.Name
        Utility:MakeFocusState(friendStatus, var10)
        friendStatus.Parent = arg1
    end

    local function friendStatusCreate(arg1, player: Player)
        local rightSideButtons = if arg1 then arg1:FindFirstChild("RightSideButtons") else nil

        if not rightSideButtons then
            return
        end
        for _, child in pairs(rightSideButtons:GetChildren()) do
            if not child or child.Name ~= "FriendStatus" then
                continue
            end

            if GuiService.SelectedCoreObject == child then
                GuiService.SelectedCoreObject = var4
            end
            child:Destroy()
        end

        resizeFriendButton(rightSideButtons, player, Utility:IsPortrait(), nil)
    end

    LocalPlayer.FriendStatusChanged:connect(function(player: Player, _friendStatus: Enum.FriendStatus)
        if not player then
            return
        end

        local var10 = var3.Page:FindFirstChild("PlayerLabel" .. player.Name)
        if var10 then
            friendStatusCreate(var10, player)
        end
    end)

    local resizeBlockButton = nil
    local trySelection = nil
    local blockingAnalytics = BlockingAnalytics.new(LocalPlayer.UserId, { EventStream = RbxAnalyticsService })

    local function createBlockButton(arg1, player, arg2, _)
        local isBlocked = getIsBlocked(player)

        local function updateBlockButton(bool9: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
            local var10 = resizeBlockButton(arg1, player, arg2, not arg2)
            resizeFriendButton(arg1, player, arg2, not arg2)
            if bool9 then
                trySelection(var10)
            end
        end

        local function blockUser()
            local bool9 = GuiService.SelectedCoreObject ~= nil or GuiService.SelectedObject ~= nil
            onBlockButtonActivated(player, blockingAnalytics, Constants2.AnalyticsInGameMenuName):andThen(function()
                updateBlockButton(bool9)
            end)
        end

        local function unBlockUser()
            if not BlockingUtility:UnblockPlayerAsync(player) then
                return
            end

            blockingAnalytics:action("SettingsHub", "unblockUser", { blockeeUserId = player.UserId })
            resizeBlockButton(arg1, player, arg2, not arg2)
            resizeFriendButton(arg1, player, arg2, not arg2)
        end

        if isBlocked then
            return Utility:MakeStyledButton(
                "BlockButton",
                RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.Unblock"),
                UDim2.new(0, 110, 0, Theme.ButtonHeight),
                unBlockUser
            )
        end

        return Utility:MakeStyledImageButton(
            "BlockButton",
            "icons/actions/block",
            UDim2.new(0, Theme.ButtonHeight, 0, Theme.ButtonHeight),
            UDim2.new(0, 28, 0, 28),
            blockUser
        )
    end

    trySelection = function(selectionParent: Instance)
        if selectionParent and not selectionParent.Selectable then
            GuiService:Select(selectionParent)
            return
        end
        GuiService.SelectedCoreObject = selectionParent
    end

    resizeBlockButton = function(arg1, player, arg2, arg3)
        local blockButton = arg1:FindFirstChild("BlockButton")
        if blockButton and arg2 == arg3 then
            return blockButton
        end

        if blockButton then
            blockButton:Destroy()
            blockButton = nil
        end

        if showRightSideButtons(player) then
            blockButton = createBlockButton(arg1, player, arg2, arg3)
        end

        if blockButton then
            blockButton.Name = "BlockButton"
            blockButton.LayoutOrder = 4
            blockButton.Selectable = true
            local var10 = "utility-focus-state" .. "-blockbutton-" .. player.Name
            Utility:MakeFocusState(blockButton, var10)
            blockButton.Parent = arg1
        end
        return blockButton
    end

    local bool9 = false
    local bool10 = false

    local function muteButtonUpdate(arg1, participant)
        local rightSideButtons = if arg1 then arg1:FindFirstChild("RightSideButtons") else nil

        if not rightSideButtons then
            return
        end
        local muteStatusButton = rightSideButtons:FindFirstChild("MuteStatusButton")

        if participant == nil then
            if muteStatusButton then
                muteStatusButton:Destroy()
            end
            return
        end

        local uDim2_2 = UDim2.fromOffset(36, 36)
        local uDim2_3 = UDim2.fromOffset(0, 0)
        local num2 = 0

        local var10 = participant.isMuted and MuteStatusIcons.MicOff or MuteStatusIcons.MicOn

        if participant.subscriptionFailed then
            var10 = MuteStatusIcons.Error
            uDim2_2 = UDim2.fromOffset(36, 36)
            uDim2_3 = UDim2.fromOffset(2, -2)
            if bool3 and engineFeature2 then
                num2 = 0.5
            end
        elseif participant.isMutedLocally then
            var10 = MuteStatusIcons.MicDisabled
            num2 = 0.5
        elseif not participant.subscriptionCompleted then
            var10 = MuteStatusIcons.Loading
        elseif participant.isSignalActive then
            local num3 = math.floor(0.5 + 5 * math.random()) * 20
            var10 = default:GetIcon("Unmuted" .. tostring(num3), "SpeakerLight")
        end

        if muteStatusButton then
            local var11 = tbl2[participant.userId] or rightSideButtons:FindFirstChild("MuteStatusImageLabel", true)
            var11.Image = var10
            var11.Size = uDim2_2
            var11.ImageTransparency = num2
            return
        end
        if not default.voiceUIVisible then
            return
        end

        local var11, var12 = Utility:MakeStyledImageButton(
            "MuteStatus",
            var10,
            UDim2.fromOffset(Theme.ButtonHeight, Theme.ButtonHeight),
            uDim2_2,
            function()
                local participant2 = default.participants[tostring(participant.userId)]
                if participant2.subscriptionCompleted then
                    if voiceAnalytics then
                        voiceAnalytics:onToggleMutePlayer(participant.userId, not participant2.isMutedLocally)
                    end
                    default:ToggleMutePlayer(participant.userId, Constants.VOICE_CONTEXT_TYPE.IN_GAME_MENU)
                elseif participant2.subscriptionFailed and (not bool3 or not engineFeature2) then
                    default:SubscribeRetry(participant.userId)
                end
            end
        )

        tbl2[participant.userId] = var12
        var12.ZIndex = 3
        var12.Position += uDim2_3
        var12.ImageTransparency = num2
        local var13 = "utility-focus-state" .. "-mutestatusbutton-" .. participant.userId
        Utility:MakeFocusState(var11, var13)
        var11.Parent = rightSideButtons
    end

    local buttonsContainer = Create("Frame")({
        Name = "ButtonsContainer",
        Size = UDim2.new(1, 0, 0, Theme.ButtonHeight),
        BackgroundTransparency = 1,
        Parent = var3.Page,
        Visible = false
    })

    var3.ButtonsContainer = buttonsContainer

    if isSideSheetEnabled
        or FFlagRelocateMobileMenuButtons
            and (FIntRelocateMobileMenuButtonsVariant == 1 or FIntRelocateMobileMenuButtonsVariant == 3)
    then
        buttonsContainer.Parent = nil
    end

    Create("UIPadding")({
        PaddingBottom = UDim.new(0, 1),
        PaddingTop = UDim.new(0, 1),
        PaddingLeft = UDim.new(0, 1),
        PaddingRight = UDim.new(0, 1),
        Parent = buttonsContainer
    })

    local function func3()
        if GetFFlagEnableLeaveGameUpsellEntrypoint() and var3.HubRef.leaveGameUpsellProp ~= Constants.PHONE_UPSELL_VALUE_PROP.None then
            var3.HubRef:SwitchToPage(var3.HubRef.LeaveGameUpsellPage, nil, 1, true)
            return
        end
        var3.HubRef:SwitchToPage(var3.HubRef.LeaveGamePage, false, 1)
    end

    local var11, var12 = Utility:MakeStyledButton("LeaveButton", "Leave", UDim2.new(1 / 3, -12, 1, 0), func3)
    var11.AnchorPoint = Vector2.new(0, 0)
    var11.Position = UDim2.new(0, 0, 0, 0)
    var12.Size = UDim2.new(1, -4, 1, 0)
    var12.Position = UDim2.new(0, 2, 0, 0)
    Create("UIListLayout")({
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Parent = var11
    })
    Create("UIPadding")({ PaddingLeft = UDim.new(0.025, 0), Parent = var11 })

    var12.Size = UDim2.new(0, 0, 1, 0)

    Create("UIFlexItem")({ FlexMode = Enum.UIFlexMode.Grow, Parent = var12 })

    if not FFlagRelocateMobileMenuButtons or FIntRelocateMobileMenuButtonsVariant == 0 then
        var11.Parent = buttonsContainer
    end

    local var13 = tbl1[robloxLocaleId]:Format(Constants2.RespawnLocalizedKey)

    local var14, var15 = Utility:MakeStyledButton("ResetButton", var13, UDim2.new(1 / 3, -12, 1, 0), function()
        var3.HubRef:SwitchToPage(var3.HubRef.ResetCharacterPage, false, 1)
    end)

    var14.AnchorPoint = Vector2.new(0.5, 0)
    var14.Position = UDim2.new(0.5, 0, 0, 0)
    var15.Size = UDim2.new(1, -4, 1, 0)
    var15.Position = UDim2.new(0, 2, 0, 0)

    if not FFlagRelocateMobileMenuButtons or FIntRelocateMobileMenuButtonsVariant == 0 then
        var14.Parent = buttonsContainer
    end

    local function func4()
        var3.HubRef:SetVisibility(false)
        RbxAnalyticsService:SetRBXEventStream(
            Constants2.AnalyticsTargetName,
            Constants2.AnalyticsResumeGameName,
            Constants2.AnalyticsMenuActionName,
            {
                source = Constants2.AnalyticsResumeButtonSource,
                playsessionid = var3.playSessionId,
                universeid = tostring(game.GameId)
            }
        )
    end

    local var16, var17 = Utility:MakeStyledButton("ResumeButton", "Resume", UDim2.new(1 / 3, -12, 1, 0), func4)
    var16.AnchorPoint = Vector2.new(1, 0)
    var16.Position = UDim2.new(1, 0, 0, 0)
    var17.Size = UDim2.new(1, -4, 1, 0)
    var17.Position = UDim2.new(0, 2, 0, 0)

    if not FFlagRelocateMobileMenuButtons or FIntRelocateMobileMenuButtonsVariant == 0 then
        var16.Parent = buttonsContainer

        if FFlagIEMTabFocusNav then
            var3.FirstSelectableObjects = { var16, var14, var11 }
            var3.FirstSelectableObjectsUpdated:fire()
        end
    end

    local function pollImage()
        local localMuted = default.localMuted

        if localMuted == nil then
            return PlayerMuteStatusIcons.Loading
        end

        if localMuted then
            return PlayerMuteStatusIcons.MicOff
        end

        if not default.isTalking then
            return PlayerMuteStatusIcons.MicOn
        end

        local num2 = math.floor(0.5 + 5 * math.random()) * 20
        return (default:GetIcon("Unmuted" .. tostring(num2), "MicLight"))
    end

    local function updateButtonPosition(arg1, position, size, anchorPoint) -- Luacid: unused: defined but never referenced
        local var18 = buttonsContainer:FindFirstChild(arg1 .. "Button", true)
        if not var18 then
            return
        end
        var18.Position = position
        var18.Size = size
        var18.AnchorPoint = anchorPoint
    end

    local function muteButtonReset() -- Luacid: Inlined by compiler; 1 call site recovered
        local playerMuteButtonButton = buttonsContainer:FindFirstChild("PlayerMuteButtonButton", true)
        if playerMuteButtonButton then
            playerMuteButtonButton:Destroy()
        end
    end

    local function resetButtonRow()
        if not FFlagRelocateMobileMenuButtons or FIntRelocateMobileMenuButtonsVariant == 0 then
            local uDim2_2 = UDim2.new(1, 0, 0, 0)
            local uDim2_3 = UDim2.new(1 / 3, -12, 1, 0)
            local vector2 = Vector2.new(1, 0)
            local resumeButtonButton = buttonsContainer:FindFirstChild("ResumeButtonButton", true)
            if resumeButtonButton then
                resumeButtonButton.Position = uDim2_2
                resumeButtonButton.Size = uDim2_3
                resumeButtonButton.AnchorPoint = vector2
            end

            local uDim2_4 = UDim2.new(0.5, 0, 0, 0)
            local uDim2_5 = UDim2.new(1 / 3, -12, 1, 0)
            local vector2_2 = Vector2.new(0.5, 0)
            local resetButtonButton = buttonsContainer:FindFirstChild("ResetButtonButton", true)
            if resetButtonButton then
                resetButtonButton.Position = uDim2_4
                resetButtonButton.Size = uDim2_5
                resetButtonButton.AnchorPoint = vector2_2
            end

            local uDim2_6 = UDim2.new(0, 0, 0, 0)
            local uDim2_7 = UDim2.new(1 / 3, -12, 1, 0)
            local vector2_3 = Vector2.new(0, 0)
            local leaveButtonButton = buttonsContainer:FindFirstChild("LeaveButtonButton", true)
            if leaveButtonButton then
                leaveButtonButton.Position = uDim2_6
                leaveButtonButton.Size = uDim2_7
                leaveButtonButton.AnchorPoint = vector2_3
            end
        end

        muteButtonReset()
    end

    local function updateMuteSelfButtonIcon() -- Luacid: Inlined by compiler; 2 call sites recovered
        local muteSelfButtonImageLabel = nil
        if not GetFFlagCleanupMuteSelfButton() or var8 then
            muteSelfButtonImageLabel = var8:FindFirstChild("MuteSelfButtonImageLabel", true)
        end

        if not muteSelfButtonImageLabel then
            return
        end

        muteSelfButtonImageLabel.Image = pollImage()
    end

    Utility:OnResized(buttonsContainer, function(_, arg1)
        if not arg1 and not Utility:IsSmallTouchScreen() or Theme.AlwaysShowBottomBar() then
            buttonsContainer.Visible = false
            buttonsContainer.Size = UDim2.new(1, 0, 0, 0)
            return
        end

        local textSize = arg1 and Theme.textSize(18) or Theme.textSize(24)
        buttonsContainer.Visible = true
        buttonsContainer.Size = UDim2.new(1, 0, 0, Theme.ButtonHeight)
        if not FFlagRelocateMobileMenuButtons or FIntRelocateMobileMenuButtonsVariant == 0 then
            var15.TextSize = textSize
            var12.TextSize = textSize
            var17.TextSize = textSize
        end
    end)

    local function reportAbuseButtonCreate(arg1, player: Player)
        local rightSideButtons = arg1:FindFirstChild("RightSideButtons")
        if not rightSideButtons then
            return
        end

        local reportPlayer = rightSideButtons:FindFirstChild("ReportPlayer")
        if reportPlayer then
            reportPlayer:Destroy()
        end

        if not showRightSideButtons(player) then
            return
        end

        local function func5()
            ReportAbuseMenuContainerPage:ReportPlayer(player, "MenuPlayerList")
        end

        local var18 = Utility:MakeStyledImageButton(
            "ReportPlayer",
            "icons/actions/feedback",
            UDim2.new(0, Theme.ButtonHeight, 0, Theme.ButtonHeight),
            UDim2.new(0, 28, 0, 28),
            func5
        )

        var18.Name = "ReportPlayer"
        var18.Position = UDim2.new(1, -260, 0, 7)
        var18.LayoutOrder = 3
        var18.Selectable = true
        local var19 = "utility-focus-state" .. "-reportplayer-" .. player.Name
        Utility:MakeFocusState(var18, var19)
        var18.Parent = rightSideButtons
    end

    local var18 = nil

    local bool11 = false
    local connection = nil

    local function muteAllButtonRemove() -- Luacid: Inlined by compiler; 2 call sites recovered
        if var5 then
            var5.Visible = false
            var5:Destroy()
            var5 = nil
        end
        func2()
    end

    local function muteSelfButtonRemove() -- Luacid: Inlined by compiler; 2 call sites recovered
        if var6 then
            var6.Visible = false
            var6:Destroy()
            var6 = nil
        end
        if connection then
            connection:Disconnect()
            connection = nil
        end
        func2()
    end

    local function joinVoiceButtonRemove() -- Luacid: Inlined by compiler; 3 call sites recovered
        if var7 then
            var7.Visible = false
            var7:Destroy()
            var7 = nil
        end
        func2()
    end

    local function shouldShowJoinVoiceButton()
        local shouldShowJoinVoiceOnDisconnect = GetFFlagEnableConsoleJoinVoice()
            and game:GetEngineFeature("VoiceChatSupported")
            and not (bool11 or var2)
            and default:verifyUniverseAndPlaceCanUseVoice()
            and default:ShouldShowJoinVoiceOnDisconnect()
        return shouldShowJoinVoiceOnDisconnect
            and default:GetVoiceConnectCookie() == ""
            and default:HasSeamlessVoiceFeature("InitialJoinVoice")
    end

    local function createRow(className: string, arg1, bool12: boolean?): Instance
        local instance = Instance.new(className)
        instance.Size = UDim2.new(1, 0, 0, 62)
        instance.Position = UDim2.new(0, 0, 0, 0)
        instance.ZIndex = 2
        instance.BackgroundColor3 = Theme.color("PlayerRowFrame")
        instance.BackgroundTransparency = Theme.transparency("PlayerRowFrame")
        Create("UICorner")({ CornerRadius = Theme.DefaultCornerRadius, Parent = instance })
        local var19

        if bool12 then
            var19 = Instance.new("TextLabel")
            var19.TextColor3 = Color3.new(1, 1, 1)
            var19.TextSize = 24
        else
            var19 = Instance.new("ImageLabel")
        end
        var19.Name = "Icon"
        var19.BackgroundTransparency = 1
        var19.Size = UDim2.new(0, 36, 0, 36)
        var19.Position = UDim2.new(0, 12, 0, 12)
        var19.ZIndex = 3
        var19.Parent = instance

        local textLabel = Instance.new("TextLabel")
        textLabel.Text = ""
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.Font = Theme.font(Enum.Font.SourceSans, "DisplayName")
        textLabel.FontSize = arg1 and Theme.fontSize(Enum.FontSize.Size36, "DisplayName") or Theme.fontSize(Enum.FontSize.Size24, "DisplayName")
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.BackgroundTransparency = 1
        textLabel.Position = arg1 and UDim2.new(0, 60, 0.5, -10) or UDim2.new(0, 60, 0.5, 0)
        textLabel.Size = UDim2.new(0, 0, 0, 0)
        textLabel.ZIndex = 3
        textLabel.Parent = instance

        if arg1 then
            local secondRow = Instance.new("TextLabel")
            secondRow.Text = ""
            secondRow.Name = "SecondRow"
            secondRow.TextXAlignment = Enum.TextXAlignment.Left
            secondRow.Font = Theme.font(Enum.Font.SourceSans)
            secondRow.FontSize = Theme.fontSize(Enum.FontSize.Size24, "Username")
            secondRow.TextColor3 = Color3.fromRGB(162, 162, 162)
            secondRow.BackgroundTransparency = 1
            secondRow.Position = UDim2.new(0, 60, 0.5, 12)
            secondRow.Size = UDim2.new(0, 0, 0, 0)
            secondRow.ZIndex = 3
            secondRow.Parent = instance
        end

        return instance
    end

    local function func5()
        local row = createRow("ImageButton", nil, true)
        row.Size = UDim2.new(1, 0, 0, 52)
        local textLabel = row.TextLabel
        local icon = row.Icon
        if bool11 or GetFFlagEnableConsoleJoinVoice() and shouldShowJoinVoiceButton() then
            row.Size = uDim2
            textLabel.Size = UDim2.new(1, -60, 0, 0)
            textLabel.TextTruncate = Enum.TextTruncate.AtEnd
            row.AnchorPoint = Vector2.new(0, 0)
        end

        textLabel.Font = Theme.font(Enum.Font.SourceSansSemibold, "Semibold")
        textLabel.AutoLocalize = false
        textLabel.Text = tbl1[robloxLocaleId]:Format(Constants2.InviteFriendsLocalizedKey)

        icon.AnchorPoint = Vector2.new(0, 0.5)
        icon.Position = UDim2.new(0, 18, 0.5, 0)
        local iconsActionsFriendsFriendInvite = uiblox["icons/actions/friends/friendInvite"]
        local iconsActionsFriendsFriendInvite2 = if iconsActionsFriendsFriendInvite then uiblox["icons/actions/friends/friendInvite"] else Theme.Images["icons/actions/friends/friendInvite"]

        if iconsActionsFriendsFriendInvite2 then
            if iconsActionsFriendsFriendInvite then
                icon.Text = iconsActionsFriendsFriendInvite2.name
                icon.FontFace = BuilderIcons.Font[iconsActionsFriendsFriendInvite2.variant]
            else
                icon.Image = iconsActionsFriendsFriendInvite2.Image
                icon.ImageRectOffset = iconsActionsFriendsFriendInvite2.ImageRectOffset
                icon.ImageRectSize = iconsActionsFriendsFriendInvite2.ImageRectSize
            end
        end

        local function setIsHighlighted(bool12: boolean) -- Luacid: Inlined by compiler; 6 call sites recovered
            if bool12 then
                row.ImageTransparency = 0.65
                return
            end
            row.ImageTransparency = 0.85
        end

        row.InputBegan:Connect(function()
            setIsHighlighted(true)
        end)

        row.InputEnded:Connect(function()
            setIsHighlighted(false)
        end)

        row.Activated:Connect(function()
            setIsHighlighted(false)
        end)

        row.TouchPan:Connect(function(_: {Vector2}, totalTranslation: Vector2)
            if math.abs(totalTranslation.Y) > 20 then
                setIsHighlighted(false)
            end
        end)

        row.SelectionGained:connect(function()
            setIsHighlighted(true)
        end)

        row.SelectionLost:connect(function()
            setIsHighlighted(false)
        end)

        row.SelectionImageObject = row:Clone()

        Utility:MakeFocusState(row, "utility-focus-state-sharegame")

        return row
    end

    local function func6()
        local row = createRow("ImageButton")
        row.Size = UDim2.new(if var4 then 0.5 else 1, -10, 0, 52)
        row.Position = UDim2.new(1, 0, 0, 0)
        row.AnchorPoint = Vector2.new(1, 0)
        local textLabel = row.TextLabel
        local icon = row.Icon

        textLabel.Size = UDim2.new(1, -60, 0, 0)
        textLabel.TextTruncate = Enum.TextTruncate.AtEnd
        textLabel.Font = Theme.font(Enum.Font.SourceSansSemibold, "Semibold")
        textLabel.AutoLocalize = false
        textLabel.Text = RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.MuteAll")

        icon.Size = UDim2.new(0, 32, 0, 32)
        icon.Position = UDim2.new(0, 18, 0, 16)
        icon.Image = default:GetIcon("UnmuteAll", "Misc")
        icon.AnchorPoint = Vector2.new(0, 0.5)
        icon.Position = UDim2.new(0, 18, 0.5, 0)

        local function setIsHighlighted(bool12: boolean) -- Luacid: Inlined by compiler; 6 call sites recovered
            if bool12 then
                row.ImageTransparency = 0.65
                return
            end
            row.ImageTransparency = 0.85
        end

        row.InputBegan:Connect(function()
            setIsHighlighted(true)
        end)

        row.InputEnded:Connect(function()
            setIsHighlighted(false)
        end)

        row.Activated:Connect(function()
            setIsHighlighted(false)
        end)

        row.TouchPan:Connect(function(_: {Vector2}, totalTranslation: Vector2)
            if math.abs(totalTranslation.Y) > 20 then
                setIsHighlighted(false)
            end
        end)

        row.SelectionGained:connect(function()
            setIsHighlighted(true)
        end)

        row.SelectionLost:connect(function()
            setIsHighlighted(false)
        end)

        row.SelectionImageObject = row:Clone()

        Utility:MakeFocusState(row, "utility-focus-state-muteall")

        return row
    end

    local function func7()
        local muteSelfButton = createRow("ImageButton")
        muteSelfButton.Name = "MuteSelfButton"
        muteSelfButton.Size = UDim2.new(0, Theme.ButtonHeight, 0, Theme.ButtonHeight)
        muteSelfButton.Position = UDim2.new(1, 0, 0, 0)
        muteSelfButton.AnchorPoint = Vector2.new(1, 0)
        local textLabel = muteSelfButton.TextLabel
        local icon = muteSelfButton.Icon

        textLabel.Size = UDim2.new(1, -60, 0, 0)
        textLabel.TextTruncate = Enum.TextTruncate.AtEnd
        textLabel.Font = Theme.font(Enum.Font.SourceSansSemibold, "Semibold")
        textLabel.AutoLocalize = false

        icon.Name = "MuteSelfButtonImageLabel"
        icon.Size = UDim2.new(0, 32, 0, 32)
        icon.Position = UDim2.new(0, 18, 0, 16)
        icon.Image = pollImage()
        icon.AnchorPoint = Vector2.new(0, 0.5)
        icon.Position = UDim2.new(0, 18, 0.5, 0)

        local function setIsHighlighted(bool12: boolean) -- Luacid: Inlined by compiler; 6 call sites recovered
            if bool12 then
                muteSelfButton.ImageTransparency = 0.65
                return
            end
            muteSelfButton.ImageTransparency = 0.85
        end

        muteSelfButton.InputBegan:Connect(function()
            setIsHighlighted(true)
        end)

        muteSelfButton.InputEnded:Connect(function()
            setIsHighlighted(false)
        end)

        muteSelfButton.Activated:Connect(function()
            setIsHighlighted(false)
        end)

        muteSelfButton.TouchPan:Connect(function(_: {Vector2}, totalTranslation: Vector2)
            if math.abs(totalTranslation.Y) > 20 then
                setIsHighlighted(false)
            end
        end)

        muteSelfButton.SelectionGained:connect(function()
            setIsHighlighted(true)
        end)

        muteSelfButton.SelectionLost:connect(function()
            setIsHighlighted(false)
        end)

        muteSelfButton.SelectionImageObject = muteSelfButton:Clone()

        Utility:MakeFocusState(muteSelfButton, "utility-focus-state-playermute")

        local function updatePlayerMuteText(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
            textLabel.Text = tbl1[robloxLocaleId]:Format(
                if arg1 then "CoreScripts.InGameMenu.QuickActions.UnmuteSelf" else "CoreScripts.InGameMenu.QuickActions.MuteSelf"
            )
        end
        updatePlayerMuteText(default.localMuted)

        connection = default.muteChanged.Event:Connect(function(arg1)
            bool9 = arg1
            updateMuteSelfButtonIcon()
            updatePlayerMuteText(arg1)
        end)

        muteSelfButton.Activated:Connect(function()
            default:ToggleMic("InGameMenuPlayers")
            if voiceAnalytics then
                voiceAnalytics:onToggleMuteSelf(bool9)
            end
        end)

        if GetFFlagCleanupMuteSelfButton() then
            return muteSelfButton
        end
        var6 = muteSelfButton
    end

    local function addMuteButtonExperience() -- Luacid: Inlined by compiler; 3 call sites recovered
        if var2 then
            return
        end

        if GetFFlagCleanupMuteSelfButton() then
            var6 = func7()
        else
            func7()
        end
    end

    var18 = GetFFlagEnableConsoleJoinVoice() and function()
        local row = createRow("ImageButton", nil, true)
        row.Size = UDim2.new(1, 0, 0, 52)
        row.Size = uDim2
        row.AnchorPoint = Vector2.new(0, 0)

        local textLabel = row.TextLabel
        textLabel.Size = UDim2.new(1, -60, 0, 0)
        textLabel.TextTruncate = Enum.TextTruncate.AtEnd

        textLabel.Font = Theme.font(Enum.Font.SourceSansSemibold, "Semibold")
        textLabel.AutoLocalize = false
        if bool1 then
            textLabel.Text = tbl1[robloxLocaleId]:Format("Feature.SettingsHub.Action.ConnectVoiceChat")
        else
            textLabel.Text = "Connect Voice Chat"
        end

        local icon = row.Icon
        icon.AnchorPoint = Vector2.new(0, 0.5)
        icon.Position = UDim2.new(0, 18, 0.5, 0)

        local iconsControlsPublicAudioJoin = uiblox["icons/controls/publicAudioJoin"]
        local iconsControlsPublicAudioJoin2 = if iconsControlsPublicAudioJoin then uiblox["icons/controls/publicAudioJoin"] else Theme.Images["icons/controls/publicAudioJoin"]

        if iconsControlsPublicAudioJoin2 then
            if iconsControlsPublicAudioJoin then
                icon.Text = iconsControlsPublicAudioJoin2.name
                icon.FontFace = BuilderIcons.Font[iconsControlsPublicAudioJoin2.variant]
            else
                icon.Image = iconsControlsPublicAudioJoin2.Image
                icon.ImageRectOffset = iconsControlsPublicAudioJoin2.ImageRectOffset
                icon.ImageRectSize = iconsControlsPublicAudioJoin2.ImageRectSize
            end
        end

        local function setIsHighlighted(bool12: boolean) -- Luacid: Inlined by compiler; 6 call sites recovered
            if bool12 then
                row.ImageTransparency = 0.65
                return
            end
            row.ImageTransparency = 0.85
        end

        row.InputBegan:Connect(function()
            setIsHighlighted(true)
        end)

        row.InputEnded:Connect(function()
            setIsHighlighted(false)
        end)

        row.Activated:Connect(function()
            setIsHighlighted(false)
        end)

        row.TouchPan:Connect(function(_: {Vector2}, totalTranslation: Vector2)
            if math.abs(totalTranslation.Y) > 20 then
                setIsHighlighted(false)
            end
        end)

        row.SelectionGained:connect(function()
            setIsHighlighted(true)
        end)

        row.SelectionLost:connect(function()
            setIsHighlighted(false)
        end)

        row.SelectionImageObject = row:Clone()

        Utility:MakeFocusState(row, "utility-focus-state-joinVoice")

        row.Activated:Connect(function()
            default.pendingConnectionSource = Constants.VOICE_CONNECTION_SOURCE.SETTINGS_TOGGLE_ON
            default:JoinVoice()
        end)

        return row
    end or var18

    local function addJoinVoiceButton() -- Luacid: Inlined by compiler; 1 call site recovered
        if not shouldShowJoinVoiceButton() or var7 then
            return
        end

        var7 = var18()
    end

    local function createInspectButtonImage(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        return (Utility:MakeStyledImageButton(
            "InspectButton",
            "icons/actions/zoomIn",
            UDim2.new(0, Theme.ButtonHeight, 0, Theme.ButtonHeight),
            UDim2.new(0, 28, 0, 28),
            arg1
        ))
    end
    local function resizeInspectButton(rightSideButtons, player: Player, arg1, arg2)
        local inspect = rightSideButtons:FindFirstChild("Inspect")
        if inspect and arg1 == arg2 then
            return
        end

        if inspect then
            inspect:Destroy()
        end

        local inspectButtonImage = createInspectButtonImage(function()
            RbxAnalyticsService:SetRBXEventStream(
                Constants2.AnalyticsTargetName,
                Constants2.AnalyticsExamineAvatarName,
                Constants2.AnalyticsMenuActionName,
                {
                    playsessionid = var3.playSessionId,
                    universeid = tostring(game.GameId)
                }
            )

            GuiService:InspectPlayerFromUserIdWithCtx(player.UserId, "escapeMenu")
            var3.HubRef:SetVisibility(false)
        end)

        inspectButtonImage.Name = "Inspect"
        inspectButtonImage.LayoutOrder = 2
        inspectButtonImage.Selectable = true
        inspectButtonImage.Parent = rightSideButtons
        local var19 = "utility-focus-state" .. "-inspect-" .. player.Name
        Utility:MakeFocusState(inspectButtonImage, var19)
    end

    local function resizePlatformName(rightSideButtons, arg1, arg2)
        local platformNameContainer = rightSideButtons:FindFirstChild("PlatformNameContainer")

        if platformNameContainer then
            platformNameContainer:Destroy()
        end

        if arg1 == nil then
            return
        end

        local platformNameContainer2 = Instance.new("Frame")
        platformNameContainer2.Name = "PlatformNameContainer"
        platformNameContainer2.BackgroundTransparency = 1
        platformNameContainer2.ZIndex = 3
        platformNameContainer2.Position = UDim2.new(0, 0, 0, 0)
        platformNameContainer2.Size = UDim2.new(0, 0, 1, 0)
        platformNameContainer2.AutomaticSize = Enum.AutomaticSize.X
        platformNameContainer2.Selectable = false
        platformNameContainer2.LayoutOrder = -1
        platformNameContainer2.Parent = rightSideButtons

        local var19 = game:GetEngineFeature("PlatformFriendsService")
            and game:GetEngineFeature("PlatformFriendsProfile")
            and result
            and result:IsProfileEnabled()
            and arg2
            and arg2 ~= ""
            and function()
                result:ShowProfile(arg2)
            end
            or nil

        local var20, var21 = Utility:MakeStyledButton("consoleNameContainer", arg1, UDim2.new(0, 0, 0, Theme.ButtonHeight), var19)

        var20.AnchorPoint = Vector2.new(0, 0.5)
        var20.Position = UDim2.fromScale(0, 0.5)
        var20.AutomaticSize = Enum.AutomaticSize.X
        var20.Parent = platformNameContainer2

        var21.Size = UDim2.fromScale(0, 1)
        var21.AutoLocalize = false
        var21.TextSize = Theme.platformNameTextSize
        var21.TextScaled = false
        var21.TextWrapped = false
        var21.AutomaticSize = Enum.AutomaticSize.X

        local var22 = Create("ImageLabel")({
            Name = "iconLabel",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = Theme.platformNameIconSize,
            Image = "rbxasset://textures/ui/Shell/Icons/PlatformLogo@3x.png",
            ImageColor3 = Color3.new(1, 1, 1)
        })
        var22.Parent = var20

        Create("UIListLayout")({
            Name = "PLatformNameUIListLayout",
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12)
        }).Parent = var20

        var22.LayoutOrder = 1
        var21.LayoutOrder = 2

        Create("UIPadding")({ PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), Parent = var20 })

        return platformNameContainer2
    end

    local function func8()
        local row = createRow("ImageLabel", true)
        row.TextLabel.Name = "DisplayNameLabel"
        row.SecondRow.Name = "NameLabel"
        row.Selectable = false
        row.SelectionGroup = true
        if GetFFlagLuaAppEnableOpenTypeSupport() then
            row.NameLabel.OpenTypeFeatures = OpenTypeSupport:getUserNameStylisticAlternative()
        end
        local rightSideButtons = Instance.new("Frame")
        rightSideButtons.Name = "RightSideButtons"
        rightSideButtons.BackgroundTransparency = 1
        rightSideButtons.ZIndex = 2
        rightSideButtons.Position = UDim2.new(0, 0, 0, 0)
        rightSideButtons.Size = UDim2.new(1, -12, 1, 0)
        rightSideButtons.Parent = row

        local function func9(selectedCoreObject) -- Luacid: Inlined by compiler; 2 call sites recovered
            if not row then
                return
            end
            if GuiService.SelectedCoreObject
                and GuiService.SelectedCoreObject ~= selectedCoreObject
                and GuiService.SelectedCoreObject.Parent == rightSideButtons
            then
                row.ImageTransparency = 0.65
                return
            end
            row.ImageTransparency = 0.85
        end

        local frame = nil
        rightSideButtons.ChildAdded:connect(function(child: Instance)
            if not child:IsA("GuiObject") then
                return
            end

            if frame and child ~= frame then
                frame:Destroy()
                frame = nil
            end
            child.SelectionGained:connect(function()
                func9(nil)
            end)

            child.SelectionLost:connect(function()
                func9(child)
            end)
        end)

        frame = Instance.new("Frame")
        frame.Selectable = true
        local uDim2_2 = UDim2.new(1, 0, 1, 0)
        frame.Size = uDim2_2
        frame.BackgroundTransparency = 1
        local frame2 = frame:Clone()
        frame.SelectionImageObject = frame2
        frame.Parent = rightSideButtons

        local rightSideListLayout = Instance.new("UIListLayout")
        rightSideListLayout.Name = "RightSideListLayout"
        rightSideListLayout.FillDirection = Enum.FillDirection.Horizontal
        rightSideListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        rightSideListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        rightSideListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        rightSideListLayout.Padding = UDim.new(0, 12)
        rightSideListLayout.Parent = rightSideButtons

        pcall(function()
            row.NameLabel.Localize = false

            row.DisplayNameLabel.Localize = false
        end)

        return row
    end

    local function managePlayerNameCutoff(arg1, player: Player)
        local var19 = nil
        local connection2 = nil
        local function reportFlagChanged(arg2, str1: string, text)
            if str1 ~= "AbsolutePosition" or not var19 then
                return
            end

            local var20 = arg2.AbsolutePosition.X - 20 - arg1.NameLabel.AbsolutePosition.X
            arg1.NameLabel.Text = "@" .. player.Name
            arg1.DisplayNameLabel.Text = player.DisplayName
            if text then
                arg1.DisplayNameLabel.Text = text
            end

            local var21 = utf8.len(player.DisplayName)
            if text then
                var21 = utf8.len(text)
            end

            while var20 < arg1.NameLabel.TextBounds.X and var21 > 0 do
                if text then
                    local num2 = utf8.offset(text, var21)
                    arg1.NameLabel.Text = string.sub(text, 1, num2) .. "..."
                else
                    local num2 = utf8.offset(player.DisplayName, var21)
                    local nameLabel = arg1.NameLabel
                    nameLabel.Text = string.sub(player.DisplayName, 1, num2) .. "..."
                end
                var21 -= 1
            end

            local var22 = "@" .. player.Name
            local num2 = string.len(var22)
            while var20 < arg1.NameLabel.TextBounds.X and num2 > 0 do
                arg1.NameLabel.Text = string.sub(var22, 1, num2) .. "..."
                num2 -= 1
            end
        end

        local function reportFlagChangedWithCombinedName(arg2, _, _)
            if bool7 and not player.UserId then
                reportFlagChanged(arg2, "AbsolutePosition")
                return
            end
            local fetchNamesByUserIds = UserProfileStore.get().fetchNamesByUserIds
            local tbl4 = { tostring(player.UserId) }

            fetchNamesByUserIds(tbl4, function(arg3)
                local displayNameLabel = getDisplayNameLabel(arg1)
                if displayNameLabel == nil then
                    return
                end
                local inExperienceCombinedName = getInExperienceCombinedName(arg3.data)
                if string.len(inExperienceCombinedName) > 0 and inExperienceCombinedName ~= displayNameLabel.Text then
                    reportFlagChanged(arg2, "AbsolutePosition", inExperienceCombinedName)
                elseif player.DisplayName ~= displayNameLabel.Text then
                    reportFlagChanged(arg2, "AbsolutePosition")
                end
            end)
        end

        if not isEngineTruncationEnabledForIngameSettings() then
            Utility:OnResized(arg1.NameLabel, function(_, arg2)
                if var19 ~= nil and var19 == arg2 then
                    return
                end

                arg2 = arg2 and not useOptimizedPortraitLayout()

                var19 = arg2
                if arg2 then
                    if connection2 == nil then
                        connection2 = arg1.RightSideButtons.ChildAdded:connect(function(child: Instance)
                            if child.Name == "Inspect" then
                                child.Changed:connect(function(_)
                                    reportFlagChangedWithCombinedName(child, "AbsolutePosition")
                                end)
                                reportFlagChangedWithCombinedName(child, "AbsolutePosition")
                            end
                        end)
                    end
                    local inspect = arg1.RightSideButtons:FindFirstChild("Inspect")
                    if inspect then
                        inspect.Changed:connect(function(arg3)
                            reportFlagChangedWithCombinedName(inspect, arg3)
                        end)

                        reportFlagChangedWithCombinedName(inspect, "AbsolutePosition")
                    end

                    return
                end

                if not arg1:FindFirstChild("NameLabel") then
                    return
                end
                arg1.NameLabel.Text = "@" .. player.Name
                if bool7 and not player.UserId then
                    arg1.DisplayNameLabel.Text = player.DisplayName
                    return
                end
                local fetchNamesByUserIds = UserProfileStore.get().fetchNamesByUserIds
                local tbl4 = { tostring(player.UserId) }

                fetchNamesByUserIds(tbl4, function(arg3)
                    local displayNameLabel = getDisplayNameLabel(arg1)
                    if displayNameLabel == nil then
                        return
                    end
                    local displayNameLabelText = getInExperienceCombinedName(arg3.data)
                    if string.len(displayNameLabelText) > 0 and displayNameLabelText ~= displayNameLabel.Text then
                        displayNameLabel.Text = displayNameLabelText
                        return
                    end
                    local displayName = player.DisplayName
                    if displayName ~= displayNameLabel.Text then
                        displayNameLabel.Text = displayName
                    end
                end)
            end)
        end

        local function getNearestRightSideButtonXPosition()
            local absolutePositionX = nil

            for _, child in pairs(arg1.RightSideButtons:GetChildren()) do
                if child:IsA("ImageButton") and (not absolutePositionX or child.AbsolutePosition.X < absolutePositionX) then
                    absolutePositionX = child.AbsolutePosition.X
                end
            end

            return absolutePositionX
        end

        local var20 = nil
        local function rightSideButtonsChanged()
            local nearestRightSideButtonXPosition = getNearestRightSideButtonXPosition()

            if nearestRightSideButtonXPosition == var20 then
                return
            end
            var20 = nearestRightSideButtonXPosition
            local uDim2_2 = if nearestRightSideButtonXPosition then UDim2.new(0, nearestRightSideButtonXPosition - arg1.NameLabel.AbsolutePosition.X - 20, 0, 0) else UDim2.new(1, -20, 0, 0)
            arg1.NameLabel.Size = uDim2_2
            arg1.DisplayNameLabel.Size = uDim2_2
            local nameLabel = arg1.NameLabel
            nameLabel.Text = if bool4 then formatUsername(player.Name) else "@" .. player.Name

            if bool7 and not player.UserId then
                arg1.DisplayNameLabel.Text = player.DisplayName
                return
            end
            local fetchNamesByUserIds = UserProfileStore.get().fetchNamesByUserIds
            local tbl4 = { tostring(player.UserId) }

            fetchNamesByUserIds(tbl4, function(arg2)
                local displayNameLabel = getDisplayNameLabel(arg1)
                if displayNameLabel == nil then
                    return
                end
                local displayNameLabelText = getInExperienceCombinedName(arg2.data)
                if string.len(displayNameLabelText) > 0 and displayNameLabelText ~= displayNameLabel.Text then
                    displayNameLabel.Text = displayNameLabelText
                    return
                end
                local displayName = player.DisplayName
                if displayName ~= displayNameLabel.Text then
                    displayNameLabel.Text = displayName
                end
            end)
        end

        if not isEngineTruncationEnabledForIngameSettings() then
            return
        end

        connection2 = arg1.RightSideButtons.ChildAdded:connect(function(child: Instance)
            rightSideButtonsChanged()
            child:GetPropertyChangedSignal("AbsolutePosition"):Connect(rightSideButtonsChanged)
        end)

        rightSideButtonsChanged()
    end

    local function canShareCurrentGame(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return LocalPlayer.UserId > 0
    end

    local players = nil
    local tbl4 = ({})
    local tbl5 = {}

    local bool12 = false

    local function updateAllMuteButtons()
        if not var5 or not default.voiceUIVisible then
            return
        end

        local players2 = Players:GetPlayers()
        local bool13 = true
        for _, player in ipairs(players2) do
            local var19 = tbl4[player.Name]

            if not (player and var19) then
                continue
            end

            local participant = default.participants[tostring(player.UserId)]

            if participant and not participant.isMutedLocally then
                bool13 = false
            end

            muteButtonUpdate(var19, participant)
        end

        if bool13 then
            bool10 = true
        else
            bool10 = false
        end
        local var19 = bool10 and RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.UnmuteAll")
            or RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.MuteAll")

        if not (var5 and var5:FindFirstChild("TextLabel")) then
            return
        end
        var5.TextLabel.Text = var19
        var5.Icon.Image = default:GetIcon(if bool10 then "MuteAll" else "UnmuteAll", "Misc")
    end

    local function destroyAllUserMuteButtons()
        for _, player in (Players:GetPlayers()) do
            local var19 = tbl4[player.Name]
            if not var19 then
                continue
            end

            local rightSideButtons = var19:FindFirstChild("RightSideButtons")
            if not rightSideButtons then
                continue
            end

            local muteStatusButton = rightSideButtons:FindFirstChild("MuteStatusButton")
            if not muteStatusButton then
                continue
            end

            if GuiService.SelectedCoreObject == muteStatusButton then
                if UserInputService.GamepadEnabled then
                    GuiService.SelectedCoreObject = var4
                else
                    GuiService.SelectedCoreObject = nil
                end
            end
            muteStatusButton:Destroy()
        end
    end

    local function func9(_)
        var3.LastSelectableObjects = {}
        if FFlagIEMTabFocusNav and not var3.ButtonsContainer.Visible then
            var3.FirstSelectableObjects = {}
        end
        players = Players:GetPlayers()

        if var2 then
            table.sort(players, function(player: Player, player2: Player): boolean
                local str1 = player.Name:lower()
                local str2 = player2.Name:lower()

                return (if player == LocalPlayer then " " else str1) < (if player2 == LocalPlayer then " " else str2)
            end)
        else
            table.sort(players, function(player: Player, player2: Player): boolean
                return player.Name:lower() < player2.Name:lower()
            end)
        end

        local num2 = 20
        if Utility:IsSmallTouchScreen() or Utility:IsPortrait() then
            num2 = 85
        end

        local voiceUiVisible = bool11 and not var5 and default.voiceUIVisible

        local var19 = FFlagHidePeoplePageInviteFriends and FFlagAddInviteFriendsIntegration and isSideSheetEnabled
        local bool13 = canShareCurrentGame() and not var4 and not (RunService:IsStudio() or var19)

        if (bool13 or voiceUiVisible) and not var8 then
            var8 = Create("Frame")({
                Name = "Holder",
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = var3.Page,
                LayoutOrder = 1
            })

            var9 = Create("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 20),
                Parent = var8
            })
        end

        local function layoutMuteAll()
            var8 = var8
                or Create("Frame")(
                    {
                        Name = "Holder",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 52),
                        Parent = var3.Page,
                        LayoutOrder = 1
                    }
                )

            var4.Parent = var8
            var4.Size = uDim2
            var5.Parent = var8
        end

        local bool14 = not RunService:IsStudio()

        if canShareCurrentGame() and not var4 and bool14 and not var19 then
            local var20 = GameInviteAnalyticsManager:withButtonName(GameInviteAnalyticsManager.ButtonName.SettingsHub)

            var4 = func5()
            var4.Activated:connect(function()
                var20:inputShareGameEntryPoint()

                var3.HubRef:InviteToGame()
            end)

            var4.LayoutOrder = 1
            if voiceUiVisible then
                var4.Parent = var8
            else
                var4.Parent = var3.Page
            end
        end

        if GetFFlagEnableConsoleJoinVoice() and shouldShowJoinVoiceButton() then
            addJoinVoiceButton()
            func2()
        end

        if FFlagIEMTabFocusNav then
            if voiceUiVisible then
                table.insert(var3.FirstSelectableObjects, var5)
            end
            if bool13 then
                table.insert(var3.FirstSelectableObjects, var4)
            end
            if voiceUiVisible or bool13 then
                var3.FirstSelectableObjectsUpdated:fire()
            end
        end

        local inspectMenuEnabled = GuiService:GetInspectMenuEnabled()

        for i = 1, #players do
            local player = players[i]

            local var20 = tbl4[player.Name]

            if not player then
                continue
            end

            tbl5[player.Name] = true

            if not (var20 and var20.Parent) then
                var20 = func8((i - 1) * 80 + num2)
                local page = var3.Page
                var20.Parent = page
                tbl4[player.Name] = var20
            end
            local str1 = "PlayerLabel" .. player.Name
            var20.Name = str1

            if bool11 then
                local participant = default.participants[tostring(player.UserId)]
                muteButtonUpdate(var20, participant)
            end

            local image = SocialUtil.GetPlayerImage(
                math.max(1, player.UserId),
                Enum.ThumbnailSize.Size100x100,
                Enum.ThumbnailType.AvatarThumbnail
            )
            var20.Icon.Image = image

            local nameLabel = var20.NameLabel
            nameLabel.Text = if bool4 then formatUsername(player.Name) else "@" .. player.Name

            var20.ImageTransparency = 0.85

            local layoutOrder = i + 1
            var20.LayoutOrder = layoutOrder

            if isEngineTruncationEnabledForIngameSettings() then
                var20.NameLabel.TextTruncate = Enum.TextTruncate.AtEnd
                var20.DisplayNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
            end

            managePlayerNameCutoff(var20, player)

            friendStatusCreate(var20, player)

            local var21 = nil
            Utility:OnResized(var20, function(_, arg1)
                local rightSideButtons = var20:FindFirstChild("RightSideButtons")
                local displayNameLabel = var20:FindFirstChild("DisplayNameLabel")
                local nameLabel2 = var20:FindFirstChild("NameLabel")
                local rightSideListLayout = rightSideButtons and rightSideButtons:FindFirstChild("RightSideListLayout")

                if useOptimizedPortraitLayout() then
                    var20.Size = UDim2.new(1, 0, 0, 105)

                    if displayNameLabel then
                        if nameLabel2 then
                            displayNameLabel.Position = UDim2.new(0, 60, 0.275, -10)
                            nameLabel2.Position = UDim2.new(0, 60, 0.275, 12)
                        else
                            displayNameLabel.Position = UDim2.new(0, 60, 0.275, 0)
                        end
                    end

                    if rightSideButtons then
                        rightSideButtons.Position = UDim2.new(0, 57, 0, -2)
                        rightSideButtons.Size = UDim2.new(1, -12, 0.99, -8)
                    end

                    if rightSideListLayout then
                        rightSideListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
                        rightSideListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
                    end
                else
                    var20.Size = UDim2.new(1, 0, 0, 62)

                    if displayNameLabel then
                        if nameLabel2 then
                            displayNameLabel.Position = UDim2.new(0, 60, 0.5, -10)
                            nameLabel2.Position = UDim2.new(0, 60, 0.5, 12)
                        else
                            displayNameLabel.Position = UDim2.new(0, 60, 0.5, 0)
                        end
                    end

                    if rightSideButtons then
                        rightSideButtons.Position = UDim2.new(0, 0, 0, 0)
                        rightSideButtons.Size = UDim2.new(1, -12, 1, 0)
                    end

                    if rightSideListLayout then
                        rightSideListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                        rightSideListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                    end
                end

                if not rightSideButtons then
                    return
                end

                resizeFriendButton(rightSideButtons, player, arg1, var21)
                resizeBlockButton(rightSideButtons, player, arg1, var21)
                if inspectMenuEnabled then
                    resizeInspectButton(rightSideButtons, player, arg1, var21)
                end
                var21 = arg1
            end)

            reportAbuseButtonCreate(var20, player)

            if i == #players then
                local rightSideButtons = var20:FindFirstChild("RightSideButtons")
                if rightSideButtons then
                    for _, child in rightSideButtons:GetChildren() do
                        if child:IsA("ImageButton") then
                            table.insert(var3.LastSelectableObjects, child)
                        end
                    end
                    var3.LastSelectableObjectsUpdated:fire()
                end
            end
            if not FFlagIEMTabFocusNav or i ~= 1 or #var3.FirstSelectableObjects ~= 0 then
                continue
            end

            local rightSideButtons = var20:FindFirstChild("RightSideButtons")
            if not rightSideButtons then
                continue
            end

            for _, child in rightSideButtons:GetChildren() do
                if child:IsA("ImageButton") then
                    table.insert(var3.FirstSelectableObjects, child)
                end
            end
            var3.FirstSelectableObjectsUpdated:fire()
        end

        if voiceUiVisible then
            var5 = func6()
            var5.Activated:connect(function()
                bool10 = not bool10
                local var20 = bool10 and RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.UnmuteAll")
                    or RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.MuteAll")
                var5.TextLabel.Text = var20
                var5.Icon.Image = default:GetIcon(if bool10 then "MuteAll" else "UnmuteAll", "Misc")
                if GetFFlagVoiceChatUILogging() then
                    var1:debug("{} all players", if bool10 then "Muting" else "Unmuting")
                end

                if voiceAnalytics then
                    voiceAnalytics:onToggleMuteAll(bool10)
                end

                default:MuteAll(bool10, Constants.VOICE_CONTEXT_TYPE.IN_GAME_MENU)
                updateAllMuteButtons()
            end)

            var5.LayoutOrder = 1

            if not bool5 or var4 ~= nil then
                layoutMuteAll()
            else
                var5.Parent = var8
            end
            func2()
        end

        local var20 = if bool7 then Cryo.List.filterMap(players, function(arg1)
            if not arg1.UserId then
                return nil
            end
            return tostring(arg1.UserId)
        end) else Cryo.List.filter(players, function(arg1): string
            return tostring(arg1.UserId)
        end)

        for _, player in ipairs(players) do
            tbl4[player.Name].DisplayNameLabel.Text = player.DisplayName
        end
        UserProfileStore.get().fetchNamesByUserIds(var20, function(arg1)
            for _, value in arg1.data do
                local username = value.names.getUsername(false)
                local var21 = tbl4[username]
                if not var21 then
                    continue
                end

                local inExperienceCombinedName = value.names.getInExperienceCombinedName(false)
                if string.len(inExperienceCombinedName) > 0 and inExperienceCombinedName ~= var21.DisplayNameLabel.Text then
                    var21.DisplayNameLabel.Text = inExperienceCombinedName
                end
                local rightSideButtons = var21:FindFirstChild("RightSideButtons")
                local platformName = if value.names.getPlatformName(false) == "" then nil else value.names.getPlatformName(false)

                if game:GetEngineFeature("PlatformFriendsService") and game:GetEngineFeature("PlatformFriendsProfile") then
                    resizePlatformName(rightSideButtons, platformName, value.getPlatformProfileId(false))
                else
                    resizePlatformName(rightSideButtons, platformName)
                end
            end
        end, FFlagUserProfilePlatformProfile)

        local num3 = 0
        if bool11 and not bool12 then
            var1:debug("Setting Up Playerlist Mic Update Renderstep Hook")
            RunService:BindToRenderStep("player-list-mute-update", Enum.RenderPriority.Last.Value, function()
                num3 += 1

                if num3 % 3 == 0 then
                    updateAllMuteButtons()
                    updateMuteSelfButtonIcon()
                end
            end)

            bool12 = true
        end

        for k, value in pairs(tbl4) do
            if not tbl5[k] then
                value:Destroy()
                tbl4[k] = nil
            end
        end

        if UserInputService.GamepadEnabled and not (FFlagIEMTabFocusNav and GuiService.SelectedCoreObject) then
            if GetFFlagCleanupMuteSelfButton() then
                pcall(function()
                    if not bool6 or var3.Active then
                        GuiService.SelectedCoreObject = var4
                    end
                end)
            else
                GuiService.SelectedCoreObject = var4
            end
        end

        Utility:OnResized("MenuPlayerListExtraPageSize", function(_, _)
            local num4 = 20
            if Utility:IsSmallTouchScreen() or Utility:IsPortrait() then
                num4 = 85
            end

            local num5 = #players + 1

            if useOptimizedPortraitLayout() then
                var3.Page.Size = UDim2.new(1, 0, 0, num4 + num5 * 123 - 5)
                return
            end
            var3.Page.Size = UDim2.new(1, 0, 0, num4 + num5 * 80 - 5)
        end)
    end

    local function func10()
        if bool12 then
            var1:debug("Unbinding Playerlist Mic Update Renderstep Hook")
            bool12 = false
            RunService:UnbindFromRenderStep("player-list-mute-update")
        end
    end

    if game:GetEngineFeature("VoiceChatSupported") and not bool11 then
        default:asyncInit():andThen(function()
            bool11 = true
            default:SetupParticipantListeners()
            addMuteButtonExperience()

            default.participantsUpdate.Event:Connect(function()
                updateAllMuteButtons()
            end)
            default.participantLeft.Event:Connect(function(_, arg1)
                updateAllMuteButtons()
                tbl2[arg1] = nil
            end)
            default:getService().StateChanged:Connect(function(_, voiceChatState)
                if voiceChatState == Enum.VoiceChatState.Ended then
                    muteAllButtonRemove()
                    muteSelfButtonRemove()

                    if GetFFlagEnableConsoleJoinVoice() then
                        joinVoiceButtonRemove()
                    end

                    bool11 = false
                    return
                end
                if voiceChatState ~= Enum.VoiceChatState.Joined or bool11 ~= false then
                    return
                end

                bool11 = true
                if GetFFlagEnableConsoleJoinVoice() then
                    joinVoiceButtonRemove()
                end

                func9()
            end)

            if not GetFFlagCleanupMuteSelfButton() then
                func9()
            end

            default.showVoiceUI.Event:Connect(function()
                if GetFFlagCleanupMuteSelfButton() then
                    if not var6 then
                        addMuteButtonExperience()
                    end
                elseif not buttonsContainer:FindFirstChild("MuteSelfButton", true) then
                    addMuteButtonExperience()
                end

                if GetFFlagEnableConsoleJoinVoice() then
                    joinVoiceButtonRemove()
                end

                func9()
            end)
            default.hideVoiceUI.Event:Connect(function()
                if var5 then
                    muteAllButtonRemove()
                end

                muteSelfButtonRemove()
                destroyAllUserMuteButtons()
                func9()
                resetButtonRow()
            end)
            default.muteAllChanged.Event:Connect(function()
                updateAllMuteButtons()
            end)
        end):catch(function(_)
            if GetFFlagVoiceChatUILogging() then
                var1:warning("Failed to init VoiceChatServiceManager")
            end
        end)
    end

    var3.Displayed.Event:connect(func9)
    var3.Hidden.Event:connect(func10)

    Players.PlayerRemoving:Connect(function(player: Player)
        tbl5[player.Name] = nil

        local var19 = tbl4[player.Name]

        if not var19 then
            return
        end

        local rightSideButtons = var19:FindFirstChild("RightSideButtons")
        if not rightSideButtons then
            return
        end

        local friendStatus = rightSideButtons:FindFirstChild("FriendStatus")
        if friendStatus then
            if GuiService.SelectedCoreObject == friendStatus then
                if UserInputService.GamepadEnabled then
                    GuiService.SelectedCoreObject = var4
                else
                    GuiService.SelectedCoreObject = nil
                end
            end
            friendStatus:Destroy()
        end

        local reportPlayer = rightSideButtons:FindFirstChild("ReportPlayer")
        if reportPlayer then
            if GuiService.SelectedCoreObject == reportPlayer then
                if UserInputService.GamepadEnabled then
                    GuiService.SelectedCoreObject = var4
                else
                    GuiService.SelectedCoreObject = nil
                end
            end
            reportPlayer:Destroy()
        end

        local muteStatusButton = rightSideButtons:FindFirstChild("MuteStatusButton")
        if muteStatusButton then
            if GuiService.SelectedCoreObject == muteStatusButton then
                if UserInputService.GamepadEnabled then
                    GuiService.SelectedCoreObject = var4
                else
                    GuiService.SelectedCoreObject = nil
                end
            end
            muteStatusButton:Destroy()
        end

        local blockButton = rightSideButtons:FindFirstChild("BlockButton")
        if blockButton then
            if GuiService.SelectedCoreObject == blockButton then
                if UserInputService.GamepadEnabled then
                    GuiService.SelectedCoreObject = var4
                else
                    GuiService.SelectedCoreObject = nil
                end
            end
            blockButton:Destroy()
        end

        local inspect = rightSideButtons:FindFirstChild("Inspect")
        if inspect then
            if GuiService.SelectedCoreObject == inspect then
                GuiService.SelectedCoreObject = nil
            end
            inspect:Destroy()
        end

        if GetFFlagDestroyPlayerCardOnLeave() then
            tbl4[player.Name] = nil
            var19:Destroy()
        end
    end)

    local function removeInspectButtons()
        for _, value in pairs(tbl4) do
            local rightSideButtons = value:FindFirstChild("RightSideButtons")

            if not rightSideButtons then
                continue
            end

            local inspect = rightSideButtons:FindFirstChild("Inspect")
            if not inspect then
                continue
            end

            if GuiService.SelectedCoreObject == inspect then
                GuiService.SelectedCoreObject = nil
            end
            inspect:Destroy()
        end
    end

    GuiService.InspectMenuEnabledChangedSignal:Connect(function(enabled: boolean)
        if not enabled then
            removeInspectButtons()
        end
    end)

    function var3.CreateMenuButtonsContainer(_)
        if FIntRelocateMobileMenuButtonsVariant ~= 2 then
            return
        end

        if var3.buttonsContainerRoot then
            return
        end

        var3.buttonsContainerRoot = ReactRoblox.createRoot(buttonsContainer)
        local experienceControlStore = var3.HubRef:GetExperienceControlStore()
        var3.buttonsContainerRoot:render(
            React.createElement(MenuButtonsContainer, {
                onLeaveGame = experienceControlStore.onLeaveGame,
                onRespawn = experienceControlStore.onRespawn,
                onResume = experienceControlStore.onResume,
                setAddMenuKeyBindings = function() end,
                setRemoveMenuKeyBindings = function() end,
                getVisibility = function(): boolean
                    return true
                end,
                getCanRespawn = experienceControlStore.getCanRespawn
            })
        )
    end

    function var3.UnmountMenuButtonsContainer(_)
        if FFlagMenuButtonsMountWithIEM and FIntRelocateMobileMenuButtonsVariant == 2 and var3.buttonsContainerRoot then
            var3.buttonsContainerRoot:unmount()
            var3.buttonsContainerRoot = nil
        end
    end

    return var3
end

return (Initialize())
