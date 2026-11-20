-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RunService = game:GetService("RunService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local ShareGame = RobloxGui.Modules.Settings.Pages.ShareGame

local Constants = require(ShareGame.Constants)
local StoppedToastTimer = require(ShareGame.Actions.StoppedToastTimer)
local Theme = require(RobloxGui.Modules.Settings.Theme)
local InviteStatus = Constants.InviteStatus

local var1 = require(ShareGame.getTranslator)()

local var2 = Roact.PureComponent:extend("ErrorToaster")

function var2.restartTimer(arg1)
    if arg1.timerConnection then
        return
    end

    arg1.timerConnection = RunService.RenderStepped:Connect(function()
        local failedInvites = arg1.props.failedInvites

        if #failedInvites == 0 then
            arg1:stopTimer()
            return
        end

        if failedInvites[#failedInvites].timeStamp + 4 < tick() then
            arg1:stopTimer()
        end
    end)
end

function var2.stopTimer(arg1)
    if arg1.timerConnection then
        arg1.timerConnection:Disconnect()
        arg1.timerConnection = nil
    end

    arg1.props.stoppedTimerDispatch()
end

function var2.didUpdate(arg1)
    if #arg1.props.failedInvites ~= 0 then
        arg1:restartTimer()
    end
end

function var2.render(arg1)
    local deviceLayout = arg1.props.deviceLayout
    local failedInvites = arg1.props.failedInvites

    local toastHeight = Constants.LayoutSpecific[deviceLayout].TOAST_HEIGHT

    if #failedInvites == 0 then
        return
    end

    local status = failedInvites[#failedInvites].status
    local str1

    if status == InviteStatus.Moderated then
        str1 = "Feature.SettingsHub.Label.ModeratedInviteError"
    else
        if status ~= InviteStatus.Failed then
            return
        end

        str1 = "Feature.SettingsHub.Label.GameInviteError"
    end

    return Roact.createElement("ScreenGui", {
        DisplayOrder = 2,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }, {
        ToastFrame = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundColor3 = Constants.Color.RED,
            BorderSizePixel = 0,
            Position = UDim2.new(0.5, 0, 0, 0),
            Size = UDim2.new(0.5, 0, 0, toastHeight)
        }, {
            InnerTextPadding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6) }),
            ToastText = Roact.createElement("TextLabel", {
                BackgroundTransparency = 1,
                Font = Theme.font(Enum.Font.SourceSansSemibold, "Semibold"),
                Size = UDim2.new(1, 0, 1, 0),
                Text = var1:FormatByKey(str1),
                TextColor3 = Constants.Color.WHITE,
                TextSize = Theme.textSize(16),
                TextWrapped = true
            })
        })
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1) -- name: mapStateToProps
    return {
        deviceLayout = arg1.DeviceInfo.DeviceLayout,
        failedInvites = arg1.Toasts.failedInvites
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        stoppedTimerDispatch = function()
            callback(StoppedToastTimer())
        end
    }
end)(var2)
