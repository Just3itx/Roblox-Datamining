-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui.RobloxGui
local Shell = RobloxGui:FindFirstChild("Modules"):FindFirstChild("Shell")

local Analytics = require(script.Parent.Analytics)
local AppState = require(script.Parent.AppState)
local GlobalSettings = require(script.Parent.GlobalSettings)
local ScreenItem = require(script.Parent.Models.ScreenItem)
local PageHeartbeatTimer = require(script.Parent.PageHeartbeatTimer)
local InsertScreen = require(script.Parent.Actions.InsertScreen)
local RemoveScreen = require(script.Parent.Actions.RemoveScreen)
local contentHistory = require(Shell.XboxPrimaryNav:FindFirstChild("contentHistory"))
local GetFIntXboxPrimaryNavABLogging = require(Shell.Flags.GetFIntXboxPrimaryNavABLogging)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

local module = {}

local tbl1 = ({})

local tbl2 = { RobloxGui }

local function getScreenPriority(screen) -- Luacid: Inlined by compiler; 1 call site recovered
    local defaultPriority = GlobalSettings.DefaultPriority
    if screen.GetPriority ~= nil then
        defaultPriority = screen:GetPriority()
    end
    return defaultPriority
end

local function setRBXEventStream_Screen(screen, status: string)
    if not screen or type(screen.GetAnalyticsInfo) ~= "function" then
        return
    end

    local analyticsInfo = screen:GetAnalyticsInfo()
    if type(analyticsInfo) == "table" and analyticsInfo[Analytics.WidgetNames("WidgetId")] then
        analyticsInfo.Status = status
        Analytics.SetRBXEventStream("Widget", analyticsInfo)
    end
end

function module.GetScreenGuiByPriority(_, arg1)
    arg1 = math.max(1, arg1)
    if not tbl2[arg1] then
        for i = 1, arg1 do
            if tbl2[i] then
                continue
            end

            local tbl3 = tbl2
            local var1 = Create("ScreenGui")
            local tbl4 = {
                Name = "AppShell" .. tostring(i),
                Parent = CoreGui
            }
            tbl3[i] = var1(tbl4)
        end
    end

    return tbl2[arg1]
end

function module.OpenScreen(_, screen, hidePrevious)
    if hidePrevious == nil then
        hidePrevious = true
    end

    local str1 = tostring(screen)
    tbl1[str1] = { screen = screen, isShown = false }

    local screenItem = ScreenItem.new(str1, getScreenPriority(screen), { hidePrevious = hidePrevious })

    if GetFIntXboxPrimaryNavABLogging() > 0 then
        local topScreen = module:GetTopScreen()
        if topScreen then
            contentHistory:setLastSelectedContent(topScreen)
        end
    end

    AppState.store:dispatch(InsertScreen(screenItem))
end

function module.CloseCurrent(_, arg1)
    local screenList = AppState.store:getState().ScreenList
    local var1 = #screenList > 0 and screenList[1]

    if var1 and tbl1[var1.id] and (not arg1 or var1.id == tostring(arg1)) then
        AppState.store:dispatch(RemoveScreen(var1))
    end
end

local function handleScreensRemoved(screenList)
    local tbl3 = {}
    for _, value in ipairs(screenList) do
        tbl3[value.id] = true
    end

    local tbl4 = {}
    for k, _ in pairs(tbl1) do
        if not tbl3[k] then
            table.insert(tbl4, k)
        end
    end

    for _, value in ipairs(tbl4) do
        local var1 = tbl1[value]
        if var1 then
            local screen = var1.screen

            screen:RemoveFocus()
            screen:Hide()

            if screen.ScreenRemoved then
                screen:ScreenRemoved()
            end

            setRBXEventStream_Screen(screen, "Close")
        end

        tbl1[value] = nil
    end
end

local function handleScreensAdded(screenList)
    for i = #screenList, 1, -1 do
        local var1 = screenList[i]

        local var2 = tbl1[var1.id]
        if not var2 then
            continue
        end

        local screen = var2.screen
        if i > 1 then
            local var3 = screenList[i - 1]
            local var4 = not (var3 and var3.data) or var3.data.hidePrevious

            screen:RemoveFocus()
            if var4 then
                screen:Hide()
                var2.isShown = false
            end

            if not (var2.isShown or var4) then
                screen:Show()
                var2.isShown = true
            end
        else
            if not var2.isShown then
                screen:Show()
                var2.isShown = true
                setRBXEventStream_Screen(screen, "Show")
            end
            screen:Focus()
            setRBXEventStream_Screen(screen, "Focus")

            local analyticsInfo = var2.screen.GetAnalyticsInfo and var2.screen.GetAnalyticsInfo()

            if analyticsInfo then
                PageHeartbeatTimer.onPageChanged(analyticsInfo[Analytics.WidgetNames("WidgetId")])
            end
        end
    end

    Analytics.reportPageChanged()
end

local function update(screenList) -- Luacid: Inlined by compiler; 1 call site recovered
    handleScreensRemoved(screenList)
    handleScreensAdded(screenList)
end

AppState.store.changed:connect(function(arg1, arg2)
    local screenList = arg1.ScreenList
    if screenList == arg2.ScreenList then
        return
    end

    update(screenList)
end)

function module.GetTopScreen(_)
    local screenList = AppState.store:getState().ScreenList
    if not (screenList and #screenList > 0) then
        return nil
    end

    local var1 = screenList[1]
    return tbl1[var1.id].screen
end

return module
