-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:21:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui.RobloxGui
local NotificationService = game:GetService("NotificationService")
local HttpService = game:GetService("HttpService")
local HttpRbxApiService = game:GetService("HttpRbxApiService")

local ErrorPrompt = require(RobloxGui.Modules.ErrorPrompt)
local Url = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Url

local function leaveGame() -- Luacid: Inlined by compiler; 2 call sites recovered
    GuiService.SelectedCoreObject = nil
    game:Shutdown()
end

local tbl1 = { Warning = 1, Lockout = 2 }

local function parseResponse(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        State = arg1.response.state.type,
        Messages = arg1.response.state.messages
    }
end

local function markRead(id) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = "mesasgeId=" .. id
    local _success, _result = pcall(
        HttpRbxApiService.GetAsyncFullUrl,
        HttpRbxApiService,
        Url.RCS_URL .. "screen-time-api/v1/messages/mark-read" .. "?" .. var1
    )
end

local tbl2 = {
    pendingResolveMessage = {},
    displaying = nil,
    resolvedMessage = {},
    displayMessageCallback = nil,
    update = function(arg1, arg2)
        for _, value in pairs(arg2) do
            table.insert(arg1.pendingResolveMessage, { id = value.id, message = value.text })
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
            return
        end

        arg1.displaying = displaying

        if arg1.displayMessageCallback then
            arg1.displayMessageCallback(displaying.message)
        end

        spawn(function()
            markRead(displaying.id)
        end)
    end,
    resolve = function(arg1)
        arg1.resolvedMessage[arg1.displaying.id] = arg1.displaying.message
        arg1.displaying = nil
        arg1:processNext()
    end
}

local errorPrompt = ErrorPrompt.new("Default", { MessageTextScaled = true, HideErrorCode = true, MenuIsOpenKey = "AnitAddictionPrompt" })
errorPrompt:setParent(RobloxGui)

function tbl2.displayMessageCallback(arg1)
    errorPrompt:_open(arg1)
end

errorPrompt:updateButtons({{
    Text = "OK",
    LocalizationKey = "InGame.CommonUI.Button.Ok",
    LayoutOrder = 1,
    Callback = function() -- name: resolveMessage
        errorPrompt:_close()
        tbl2:resolve()
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
local connection = nil
local function antiAddictionStatesUpdated(arg1) -- Luacid: unused: defined but never referenced
    local tbl3 = parseResponse(arg1)

    if tbl3.State == 2 then
        if connection then
            connection:Disconnect()
        end

        leaveGame()
    end

    tbl2:update(tbl3.Messages)
end

connection = NotificationService.RobloxEventReceived:Connect(function(eventData)
    if eventData.namespace ~= "AntiAddictionNotifications" then
        return
    end

    local tbl3 = parseResponse((HttpService:JSONDecode(eventData.detail)))

    if tbl3.State == tbl1.Lockout then
        if connection then
            connection:Disconnect()
        end

        leaveGame()
    end

    tbl2:update(tbl3.Messages)
end)
