-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local AppStorageService = game:GetService("AppStorageService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")

local Images = require(CorePackages.Packages.InGameMenuDependencies).UIBlox.App.ImageSet.Images

local Modules = CoreGui.RobloxGui.Modules
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local IXPServiceWrapper = require(CorePackages.Workspace.Packages.IxpServiceWrapper).IXPServiceWrapper
local var1 = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).CoreLogger:new(script.Name)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local default = require(Modules.VoiceChat.VoiceChatServiceManager).default
local Constants = require(Modules.VoiceChat.Constants)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local BuilderIcons = require(CorePackages.Packages.BuilderIcons)
local _Migration = BuilderIcons.Migration

local GetFFlagVoiceUserAgencyEnableIXP = require(Modules.Flags.GetFFlagVoiceUserAgencyEnableIXP)
local GetFStringVoiceUserAgencyIXPLayerName = require(Modules.Flags.GetFStringVoiceUserAgencyIXPLayerName)

local num1 = game:DefineFastInt("VoiceUserAgencyAlertInitTimeOffset", 5)
local num2 = game:DefineFastInt("VoiceUserAgencyAlertStartTimeOffset", 3)
local time = game:DefineFastInt("VoiceUserAgencyAlertTimerDuration", 7)

local bool1 = game:DefineFastFlag("VoiceUserAgencyAddMuteDecisionAnalytics", false)
local bool2 = game:DefineFastFlag("VoiceUserAgencyAdjustDescriptionText", false)

local string2 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.VoiceUserAgency.Remember")

local str1 = tostring(game.PlaceId)
local UserId = Players.LocalPlayer.UserId

local function getAppStorageTable()
    local success, result = pcall(function(): string
        return AppStorageService:GetItem("VoiceUserAgencyPlaceIds")
    end)
    if success then
        local success2, result2 = pcall(function()
            return HttpService:JSONDecode(result)
        end)
        if success2 then
            return result2
        end
    end
    return {}
end

local bool3 = false
local function resetHistory() -- Luacid: Inlined by compiler; 2 call sites recovered
    if bool3 then
        return
    end
    local success, result = pcall(function()
        local appStorageTable = getAppStorageTable()
        for value, _ in appStorageTable do
            if value ~= str1 then
                continue
            end

            appStorageTable[value] = nil
            AppStorageService:SetItem("VoiceUserAgencyPlaceIds", HttpService:JSONEncode(appStorageTable))
            AppStorageService:Flush()
            bool3 = true
            return
        end
    end)

    if not success then
        var1:trace(result)
    end
end

local function bindResetHistory()
    default.muteAllChanged.Event:Connect(function(_)
        resetHistory()
    end)

    default.mutedNonFriends.Event:Connect(function()
        resetHistory()
    end)
end

local function removeUserAgencyPrompt(screenGui: ScreenGui, isRememberSetting, isMuteAll: boolean)
    screenGui:Destroy()

    if isRememberSetting then
        local appStorageTable = getAppStorageTable()
        appStorageTable[str1] = isMuteAll
        AppStorageService:SetItem("VoiceUserAgencyPlaceIds", HttpService:JSONEncode(appStorageTable))
        AppStorageService:Flush()
    end

    if bool1 then
        RbxAnalyticsService:SendEventDeferred("client", "voiceChat", "SelectJoinWithVoice", {
            userId = UserId,
            voiceSessionId = default:getService():GetSessionId(),
            voiceExperienceId = default:getService():GetVoiceExperienceId(),
            isMuteAll = isMuteAll,
            isRememberSetting = isRememberSetting
        })
    end

    default:FireUserAgencySelectedEvent(isMuteAll)

    bindResetHistory()
end

local function showUserAgencyPrompt()
    local bool4 = false
    local visible = false

    if GetFFlagVoiceUserAgencyEnableIXP() then
        local success, result = pcall(function()
            return IXPServiceWrapper:GetLayerData(GetFStringVoiceUserAgencyIXPLayerName())
        end)

        if not success then
            return
        end

        if not result then
            return
        end
        if not result.VoiceUserAgencyEnabled then
            return
        end
    end

    local success, result = pcall(function()
        local appStorageTable = getAppStorageTable()
        for k, value in pairs(appStorageTable) do
            if k == str1 and value ~= nil then
                return value
            end
        end
    end)
    if not success then
        var1:trace(result)
        return
    end

    if result ~= nil then
        default:MuteAll(result, Constants.VOICE_CONTEXT_TYPE.USER_AGENCY)
        default:FireUserAgencySelectedEvent(result)

        bindResetHistory()
        RbxAnalyticsService:SendEventDeferred("client", "voiceChat", "JoinWithVoice", {
            userId = UserId,
            voiceSessionId = default:getService():GetSessionId(),
            voiceExperienceId = default:getService():GetVoiceExperienceId(),
            isMutedAll = result
        })
        return
    end

    local voiceUserAgency = Instance.new("ScreenGui")
    voiceUserAgency.Name = "VoiceUserAgency"
    voiceUserAgency.ResetOnSpawn = false
    voiceUserAgency.DisplayOrder = -1
    voiceUserAgency.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    voiceUserAgency.Parent = CoreGui

    local var2 = Create("TextButton")({
        Name = "MuteAllButton",
        BorderSizePixel = 0,
        Size = UDim2.new(0.5, -6, 0, 36),
        Font = AppFonts.default:getDefault(),
        Text = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.VoiceUserAgency.JoinMuted"),
        TextSize = 16,
        BackgroundColor3 = Color3.fromRGB(57, 59, 61),
        TextColor3 = Color3.fromRGB(178, 178, 178),
        LayoutOrder = 1,
        Create("UICorner")({ CornerRadius = UDim.new(0, 8) }),
        Create("UIStroke")(
            {
                Thickness = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Color = Color3.fromRGB(178, 178, 178)
            }
        )
    })

    var2.Activated:Connect(function()
        bool4 = true
        default:MuteAll(bool4, Constants.VOICE_CONTEXT_TYPE.USER_AGENCY)
        removeUserAgencyPrompt(voiceUserAgency, visible, bool4)
    end)

    local var3 = Create("TextButton")({
        Name = "UnmuteAllButton",
        BorderSizePixel = 0,
        Size = UDim2.new(0.5, -6, 0, 36),
        Font = AppFonts.default:getDefault(),
        Text = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.VoiceUserAgency.JoinUnmuted"),
        TextSize = 16,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        TextColor3 = Color3.fromRGB(57, 59, 61),
        LayoutOrder = 2,
        Create("UICorner")({ CornerRadius = UDim.new(0, 8) })
    })

    var3.Activated:Connect(function()
        bool4 = false
        default:MuteAll(bool4, Constants.VOICE_CONTEXT_TYPE.USER_AGENCY)
        removeUserAgencyPrompt(voiceUserAgency, visible, bool4)
    end)

    local instance = Create("Frame")({
        Name = "TimerBar",
        BorderSizePixel = 0,
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0
    })

    local propertyTable = {
        Size = UDim2.fromScale(1, 1)
    }
    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Sine)
    local tween = TweenService:Create(instance, tweenInfo, propertyTable)
    tween.Completed:Connect(function(playbackState: Enum.PlaybackState)
        if playbackState == Enum.PlaybackState.Completed then
            removeUserAgencyPrompt(voiceUserAgency, visible, bool4)
        end
    end)

    local var4 = Create("TextLabel")({
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = BuilderIcons.Migration["icons/status/success_small"].name,
        FontFace = BuilderIcons.Font[BuilderIcons.Migration["icons/status/success_small"].variant]
    })
    local var5 = Create("ImageButton")({
        Size = UDim2.new(0, 14, 0, 14),
        BackgroundTransparency = 1,
        Image = Images["squircles/hollow"].Image,
        ImageRectOffset = Images["squircles/hollow"].ImageRectOffset,
        ImageRectSize = Images["squircles/hollow"].ImageRectSize
    })
    var4.Visible = false
    var4.Parent = var5
    var5.Activated:Connect(function()
        var4.Visible = not var4.Visible
        visible = var4.Visible
        tween:Pause()

        RbxAnalyticsService:SendEventDeferred("client", "voiceChat", "RememberJoinWithVoice", {
            userId = UserId,
            voiceSessionId = default:getService():GetSessionId(),
            voiceExperienceId = default:getService():GetVoiceExperienceId(),
            shouldRememberStatus = visible
        })
    end)

    local var6 = Create("TextLabel")({
        Name = "CheckboxTextLabel",
        Font = AppFonts.default:getDefault(),
        Text = string2,
        TextColor3 = Color3.fromRGB(190, 190, 190),
        TextSize = 16,
        TextWrapped = true,
        Size = UDim2.new(0, 350, 0, 24),
        BackgroundTransparency = 1,
        TextTransparency = 0,
        LayoutOrder = 2
    })

    local vector2 = TextService:GetTextSize(string2, 16, AppFonts.default:getDefault(), Vector2.new(350, 24))

    var6.Size = UDim2.new(0, vector2.X + 10, 0, 24)

    Create("Frame")({
        Name = "VoiceUserAgencyFrame",
        AnchorPoint = Vector2.new(0.5, 0),
        Size = UDim2.new(0.9, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 4),
        BackgroundColor3 = Color3.fromRGB(57, 59, 61),
        BorderSizePixel = 0,
        Create("UICorner")({ CornerRadius = UDim.new(0, 8) }),
        Create("UISizeConstraint")({ MaxSize = Vector2.new(400, 216) }),
        Create("UIPadding")({
            PaddingTop = UDim.new(0, 24),
            PaddingLeft = UDim.new(0, 24),
            PaddingRight = UDim.new(0, 24),
            PaddingBottom = UDim.new(0, 24)
        }),
        Create("UIListLayout")(
            {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        Create("TextLabel")({
            Name = "Title",
            Font = AppFonts.default:getBold(),
            Text = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.VoiceUserAgency.JoinUnmuted.Title"),
            TextSize = 20,
            TextWrapped = true,
            Size = UDim2.new(1, 0, 0, 22),
            BackgroundTransparency = 1,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0,
            LayoutOrder = 1
        }),
        Create("TextLabel")({
            Name = "Lower",
            Font = AppFonts.default:getDefault(),
            Text = bool2 and RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.VoiceUserAgency.JoinUnmuted.Description")
                or RobloxTranslator:FormatByKey("Feature.SettingsHub.VoiceUserAgency.JoinUnmuted.Description"),
            TextColor3 = Color3.fromRGB(190, 190, 190),
            TextSize = 16,
            TextWrapped = true,
            Size = UDim2.new(1, 0, 0, 60),
            BackgroundTransparency = 1,
            TextTransparency = 0,
            LayoutOrder = 2
        }),
        Create("Frame")({
            Name = "TimerFrame",
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, 48, 0, 3),
            BackgroundTransparency = 0,
            LayoutOrder = 3,
            instance
        }),
        Create("Frame")({
            Name = "ButtonsContainer",
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 62),
            BackgroundTransparency = 1,
            LayoutOrder = 4,
            Create("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 12)
            }),
            var3,
            var2
        }),
        Create("Frame")({
            Name = "CheckboxContainer",
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 28),
            BackgroundTransparency = 1,
            LayoutOrder = 5,
            Create("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8)
            }),
            var5,
            var6
        })
    }).Parent = voiceUserAgency

    task.delay(num2, function()
        RbxAnalyticsService:SendEventDeferred("client", "voiceChat", "ShowJoinWithVoice", {
            userId = UserId,
            voiceSessionId = default:getService():GetSessionId(),
            voiceExperienceId = default:getService():GetVoiceExperienceId()
        })

        tween:Play()
    end)
end

task.delay(num1, function()
    default:asyncInit():andThen(function()
        showUserAgencyPrompt()
    end):catch(function()
        var1:trace("VoiceChatServiceManager did not initialize for VoiceUserAgency")
    end)
end)
