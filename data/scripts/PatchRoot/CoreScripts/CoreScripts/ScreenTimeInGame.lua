-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:40:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui.RobloxGui
local NotificationService = game:GetService("NotificationService")
local HttpService = game:GetService("HttpService")

local ScreenTime = require(CorePackages.Workspace.Packages.ScreenTime)
local HttpRequests = ScreenTime.HttpRequests
local Constants = ScreenTime.Constants
local GetFFlagScreenTimeSignalR = ScreenTime.GetFFlagScreenTimeSignalR
local Logging = require(CorePackages.Workspace.Packages.AppCommonLib).Logging
local ErrorPrompt = require(RobloxGui.Modules.ErrorPrompt)

local function leaveGame() -- Luacid: Inlined by compiler; 3 call sites recovered
    GuiService.SelectedCoreObject = nil
    game:Shutdown()
end

local var1 = HttpRequests:new(HttpService)
local connection = nil

local function disconnectAndLeaveGame() -- Luacid: Inlined by compiler; 2 call sites recovered
    if connection then
        connection:Disconnect()
        connection = nil
    end

    leaveGame()
end

local tbl1 = {
    pendingResolveMessage = {},
    displaying = nil,
    resolvedMessage = {},
    displayMessageCallback = nil,
    update = function(arg1, arg2)
        for _, value in pairs(arg2) do
            table.insert(
                arg1.pendingResolveMessage,
                {
                    id = value.serialId,
                    instructionName = value.instructionName,
                    message = value.message,
                    type = value.type
                }
            )
        end

        arg1:processNext()
    end,
    processNext = function(arg1)
        if arg1.displaying then
            return
        end

        local displaying = table.remove(arg1.pendingResolveMessage, 1)
        if not displaying then
            return
        end

        if arg1.resolvedMessage[displaying.id] then
            arg1:processNext()
        else
            arg1.displaying = displaying
            if arg1.displayMessageCallback then
                arg1.displayMessageCallback(displaying.message)
            end
        end
    end,
    resolve = function(arg1)
        arg1.resolvedMessage[arg1.displaying.id] = arg1.displaying.message

        var1:reportExecution(arg1.displaying.instructionName, arg1.displaying.id)

        arg1.displaying = nil
        arg1:processNext()
    end
}

local errorPrompt = ErrorPrompt.new("Default", { MessageTextScaled = true, HideErrorCode = true, MenuIsOpenKey = "ScreenTimePrompt" })
errorPrompt:setParent(RobloxGui)

function tbl1.displayMessageCallback(arg1)
    errorPrompt:_open(arg1)
end

errorPrompt:updateButtons({{
    Text = "OK",
    LocalizationKey = "InGame.CommonUI.Button.Ok",
    LayoutOrder = 1,
    Callback = function() -- name: resolveMessage
        errorPrompt:_close()
        tbl1:resolve()
    end,
    Primary = true
}})

errorPrompt:setErrorTitle("Warning", "InGame.CommonUI.Title.Warning")

local AbsoluteSizeX = RobloxGui.AbsoluteSize.X
local AbsoluteSizeY = RobloxGui.AbsoluteSize.Y

local function onScreenSizeChanged() -- Luacid: Inlined by compiler; 1 call site recovered
    if not errorPrompt then
        return
    end
    local absoluteSizeX = RobloxGui.AbsoluteSize.X
    local absoluteSizeY = RobloxGui.AbsoluteSize.Y
    if AbsoluteSizeX ~= absoluteSizeX or AbsoluteSizeY ~= absoluteSizeY then
        AbsoluteSizeX = absoluteSizeX
        AbsoluteSizeY = absoluteSizeY
        errorPrompt:resizeWidthAndHeight(AbsoluteSizeX, AbsoluteSizeY)
    end
end

RobloxGui:GetPropertyChangedSignal("AbsoluteSize"):connect(onScreenSizeChanged)
onScreenSizeChanged()

local function screenTimeStatesUpdated(arg1)
    local tbl2 = {}
    for _, value in ipairs(arg1) do
        if value.type == 1 then
            table.insert(tbl2, value)
        else
            if value.type == 2 then
                disconnectAndLeaveGame()
                return
            end

            if value.type == 3 then
            end
        end
    end

    tbl1:update(tbl2)
end

local function requestInstructions() -- Luacid: Inlined by compiler; 2 call sites recovered
    var1:getInstructions(function(arg1, arg2, arg3)
        if arg1 then
            screenTimeStatesUpdated(arg3)
        elseif arg2 then
            Logging.warn("ScreenTimeInGame requestInstructions failed: unauthorized")
        else
            Logging.warn("ScreenTimeInGame requestInstructions failed: error")
        end
    end)
end

connection = NotificationService.RobloxEventReceived:Connect(function(eventData)
    if GetFFlagScreenTimeSignalR() then
        if eventData.namespace == Constants.SIGNALR_NAMESPACE and eventData.detailType == Constants.SIGNALR_TYPE_NEW_INSTRUCTION then
            requestInstructions()
        end

        return
    end

    if eventData.namespace ~= Constants.HEARTBEAT_NOTIFICATIONS_NAMESPACE then
        return
    end

    if eventData.detailType == Constants.HEARTBEAT_CONSECUTIVE_FAILURE then
        disconnectAndLeaveGame()
        return
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(eventData.detail)
    end)
    if not success then
        Logging.warn("ScreenTimeInGame json decoding failed")
        return
    end

    if result.notifications == nil then
        Logging.warn("ScreenTimeInGame empty heartbeat notifications")
        return
    end
    for _, notification in ipairs(result.notifications) do
        if notification.type == Constants.HEARTBEAT_NOTIFICATION_TYPE_NEW_INSTRUCTION then
            requestInstructions()
        end
    end
end)
