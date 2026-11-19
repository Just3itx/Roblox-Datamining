-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:21:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxGui = game:GetService("CoreGui").RobloxGui
local CorePackages = game:GetService("CorePackages")
local NotificationService = game:GetService("NotificationService")
local HttpService = game:GetService("HttpService")
local AppUpdateService = game:GetService("AppUpdateService")

local ErrorPrompt = require(RobloxGui.Modules.ErrorPrompt)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local function translateOrFallback(str1: string, arg1, tbl1: {RBX_NAME: any}) -- Luacid: Inlined by compiler; 2 call sites recovered
    local success, result = pcall(function()
        return RobloxTranslator:FormatByKey(str1, tbl1)
    end)
    if success then
        arg1 = result or arg1
    end

    return arg1
end

local function performUpdate()
    AppUpdateService:PerformManagedUpdate()
end

local function resolveUpdateName(str1: string, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if str1 == "BetaProgram" then arg1.betaProgramName elseif str1 == "BoundChannel" then arg1.channelName else nil
end

local module = {}

function module.init()
    local errorPrompt = ErrorPrompt.new("Default", { MessageTextScaled = true, HideErrorCode = true, MenuIsOpenKey = "ChannelUpdatePrompt" })
    errorPrompt:setParent(RobloxGui)

    local function showUpdatePrompt(arg1, arg2)
        local rbxName = arg2 or ""
        local var2

        if arg1 == "BetaProgram" then
            var2 = translateOrFallback(
                "InGame.ChannelUpdatePrompt.Message.BetaProgram",
                "An update is required for the Beta Program you are in: \"" .. rbxName .. "\".",
                { RBX_NAME = rbxName }
            )
        else
            if arg1 ~= "BoundChannel" then
                warn("ChannelUpdatePrompt: unknown updateType '" .. tostring(arg1) .. "', skipping prompt")
                return
            end

            var2 = translateOrFallback(
                "InGame.ChannelUpdatePrompt.Message.BoundChannel",
                "An update is required for the channel you are bound to: \"" .. rbxName .. "\".",
                { RBX_NAME = rbxName }
            )
        end

        errorPrompt:_open(var2)
    end

    errorPrompt:updateButtons({{
        Text = "Restart Now",
        LocalizationKey = "InGame.CommonUI.Button.RestartNow",
        LayoutOrder = 1,
        Callback = performUpdate,
        Primary = true
    }})
    errorPrompt:setErrorTitle("Update Required", "InGame.CommonUI.Title.UpdateRequired")

    local absoluteSizeX = RobloxGui.AbsoluteSize.X
    local absoluteSizeY = RobloxGui.AbsoluteSize.Y

    local function onScreenSizeChanged() -- Luacid: Inlined by compiler; 1 call site recovered
        local absoluteSizeX2 = RobloxGui.AbsoluteSize.X
        local absoluteSizeY2 = RobloxGui.AbsoluteSize.Y
        if absoluteSizeX ~= absoluteSizeX2 or absoluteSizeY ~= absoluteSizeY2 then
            absoluteSizeX = absoluteSizeX2
            absoluteSizeY = absoluteSizeY2
            errorPrompt:resizeWidthAndHeight(absoluteSizeX, absoluteSizeY)
        end
    end

    RobloxGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(onScreenSizeChanged)
    onScreenSizeChanged()

    NotificationService.RobloxEventReceived:Connect(function(eventData)
        if eventData.namespace == "ChannelUpdateRequired" then
            local var1 = HttpService:JSONDecode(eventData.detail)
            local updateType = var1.updateType
            local var2 = if updateType == "BetaProgram" then resolveUpdateName("BetaProgram", var1) elseif updateType == "BoundChannel" then resolveUpdateName("BoundChannel", var1) else nil
            showUpdatePrompt(var1.updateType, var2)
        end
    end)

    local success, result = pcall(function(): string
        return AppUpdateService:GetProtocolLaunchUpdateType()
    end)
    local success2, result2 = pcall(function(): string
        return AppUpdateService:GetProtocolLaunchUpdateName()
    end)
    if success and result ~= "" then
        showUpdatePrompt(result, success2 and result2 or "")
    end
end

return module
