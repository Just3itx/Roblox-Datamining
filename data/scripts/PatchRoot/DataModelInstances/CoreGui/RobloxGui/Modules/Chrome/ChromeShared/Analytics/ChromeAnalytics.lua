-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")
local playerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")

local Cryo = require(CorePackages.Packages.Cryo)

local Service = require(ChromeShared.Service)
local Constants = require(ChromeShared.Unibar.Constants)
local _Chrome = require(CorePackages.Workspace.Packages.Chrome)

local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagIntegrationsChromeShortcutTelemetry = require(ChromeShared.Parent.Flags.FFlagIntegrationsChromeShortcutTelemetry)

local Tracker = require(ChromeShared.Analytics.Tracker)

local module = ({})
module.__index = module

local function getDynamicEventProps()
    local var1

    if playerGui then
        var1 = Constants.ANALYTICS.SCREEN_ORIENTATION_MAP[playerGui.CurrentScreenOrientation]
        var1 = var1 or tostring(playerGui.CurrentScreenOrientation)
    else
        var1 = "Unknown"
    end
    return {
        screen_orientation = var1,
        last_input_device = Constants.ANALYTICS.INPUT_TYPE_MAP[UserInputService:GetLastInputType()]
            or tostring(UserInputService:GetLastInputType())
    }
end

local function getTrackerName(str1: string, arg1) -- Luacid: Inlined by compiler; 27 call sites recovered
    return str1 .. arg1
end

local function getIntegration(arg1) -- Luacid: Inlined by compiler; 9 call sites recovered
    return Service:integrations()[arg1]
end

local function getInteractionSource(integrationId) -- Luacid: Inlined by compiler; 3 call sites recovered
    if isSideSheetEnabled and Service:withinOpenSideSheet(integrationId) then
        return "sidesheet"
    elseif Service:withinCurrentSubmenu(integrationId) then
        return (Service:currentSubMenu():get())
    end
    return if Service:withinCurrentTopLevelMenu(integrationId) then "unibar" else "unknown"
end

function module.new()
    local self = setmetatable({
        _target = "client",
        _context = "chrome",
        _defaultProps = {
            screen_width = 0,
            screen_height = 0,
            universeid = tostring(game.GameId),
            placeid = tostring(game.PlaceId),
            sessionid = RbxAnalyticsService:GetSessionId(),
            is_game_menu_opened = false
        },
        _tracker = Tracker.new()
    }, module)

    if engineFeature then
        self._defaultProps.playsessionid = RbxAnalyticsService:GetPlaySessionId()
    end

    function self._observeIntegration(arg1)
        local integration = getIntegration(arg1)

        if not integration or not integration.windowSize then
            return
        end

        self._tracker:set(getTrackerName("window_size_", arg1), integration.windowSize:get())

        integration.windowSize:connect(function(arg2)
            if typeof(arg2) ~= "UDim2" then
                return
            end

            local var1 = integration.windowSize:get()
            local var2 = self._tracker:get((getTrackerName("window_status_", arg1)))
            local trackerName = getTrackerName("window_size_", arg1)

            if var2 ~= 1 then
                return
            end

            if self._tracker:get(trackerName) then
                self:onWindowResize(arg1, var1)
            end
            self._tracker:set(trackerName, var1)
        end)
    end

    function self._resetWindowTrackers(arg1)
        self._tracker:reset((getTrackerName("window_dposition_", arg1)))
        self._tracker:reset((getTrackerName("window_position_", arg1)))
        self._tracker:reset((getTrackerName("window_size_", arg1)))
        self._tracker:reset((getTrackerName("window_drag_", arg1)))
        self._tracker:reset((getTrackerName("window_status_", arg1)))
    end

    function self._defaultWindowTrackers(arg1)
        self._resetWindowTrackers(arg1)
        self._tracker:startTime((getTrackerName("window_time_", arg1)))
        self._tracker:set(getTrackerName("window_status_", arg1), 1)
    end

    function self._sendEvent(eventName: string, arg1)
        local additionalArgs = Cryo.Dictionary.join(getDynamicEventProps(), self._defaultProps, arg1 or {})
        RbxAnalyticsService:SendEventDeferred(self._target, self._context, eventName, additionalArgs)
    end

    function self._calculateWindowAbsolutePosition(uDim2: UDim2, uDim2_2: UDim2): Vector2
        local screenWidth = self._defaultProps.screen_width
        local screenHeight = self._defaultProps.screen_height
        return Vector2.new(
            uDim2.X.Scale * screenWidth + uDim2.X.Offset - uDim2_2.Width.Offset / 2,
            uDim2.Y.Scale * screenHeight + uDim2.Y.Offset - uDim2_2.Height.Offset / 2
        )
    end

    function self._setWindowLastPosition(arg1, vector2: Vector2)
        self._tracker:set(getTrackerName("window_position_", arg1), vector2)
    end

    GuiService.MenuOpened:Connect(function()
        self._defaultProps.is_game_menu_opened = not self._defaultProps.is_game_menu_opened
    end)

    for _, value in Service:integrations() do
        self._observeIntegration(value.id)
    end

    Service:onIntegrationRegistered():connect(function(arg1)
        self._observeIntegration(arg1)
    end)

    Service:onIntegrationActivated():connect(function(arg1, arg2)
        if FFlagIntegrationsChromeShortcutTelemetry then
            self:onIconActivated(arg1, arg2)
            return
        end
        self:onIconActivated(arg1)
    end)

    Service:onIntegrationStatusChanged():connect(function(arg1, window: number)
        local integration = getIntegration(arg1)

        if not integration or not integration.components.Window then
            return
        end

        if window == Service.IntegrationStatus.Window then
            self:onWindowOpened(arg1)
            return
        end
        self:onWindowClosed(arg1)
    end)

    return self
end

function module:setScreenSize(vector2: Vector2)
    self._defaultProps.screen_width = vector2.X
    self._defaultProps.screen_height = vector2.Y
    return nil
end

function module:onIconActivated(integrationId, arg1)
    local integration = getIntegration(integrationId)

    if integration then
        local var1 = integration.notification:get()
        local var2 = if var1.type == "count" then tonumber(var1.value) or 0 else 0
        local isToggleOn = if integration.isActivated then not integration.isActivated:get() else nil
        self._sendEvent(Constants.ANALYTICS.ICON_ACTIVATED, {
            integration_id = integrationId,
            source = getInteractionSource(integrationId),
            notification_count = var2,
            is_toggle_on = isToggleOn,
            used_shortcut = if FFlagIntegrationsChromeShortcutTelemetry and arg1 then arg1.fromShortcut or false else nil
        })
    end

    return nil
end

function module:onIconTouchBegan(arg1)
    self._tracker:set(getTrackerName("icon_drag_", arg1), 1)
    return nil
end

function module:onIconDrag(integrationId)
    local trackerName = getTrackerName("icon_drag_", integrationId)

    if self._tracker:get(trackerName) == 1 then
        self._tracker:set(trackerName, 2)
        self._sendEvent(
            Constants.ANALYTICS.ICON_DRAG_START,
            {
                integration_id = integrationId,
                source = getInteractionSource(integrationId)
            }
        )
    end

    return nil
end

function module:onIconTouchEnded(integrationId, vector2: Vector2, willReposition: boolean)
    local trackerName = getTrackerName("icon_drag_", integrationId)
    local var1 = self._tracker:get(trackerName)
    local integration = getIntegration(integrationId)

    if integration and integration.windowSize and var1 == 2 then
        self._tracker:reset(trackerName)
        self._setWindowLastPosition(integrationId, vector2)
        local var2 = integration.windowSize:get()

        self._sendEvent(Constants.ANALYTICS.ICON_DRAG_END, {
            integration_id = integrationId,
            source = getInteractionSource(integrationId),
            window_position_x = vector2.X,
            window_position_y = vector2.Y,
            window_width = var2.Width.Offset,
            window_height = var2.Height.Offset,
            will_reposition = willReposition
        })
    end
    return nil
end

function module:onWindowOpened(integrationId)
    local integration = getIntegration(integrationId)

    local var1 = self._tracker:get((getTrackerName("window_status_", integrationId)))

    if integration and var1 ~= 1 then
        self._defaultWindowTrackers(integrationId)
        local trackerName = getTrackerName("window_dposition_", integrationId)

        if not self._tracker:get(trackerName) and integration.windowSize then
            local var2 = integration.windowSize:get()
            if var2 then
                local var3 = Service:windowPosition(integration.id) or integration.startingWindowPosition or UDim2.fromOffset(0, 0)
                self:setWindowDefaultPosition(integrationId, (self._calculateWindowAbsolutePosition(var3, var2)))
            end
        end

        self._sendEvent(Constants.ANALYTICS.WINDOW_OPENED, { integration_id = integrationId })
    end

    return nil
end

function module:onWindowClosed(integrationId)
    if self._tracker:get((getTrackerName("window_status_", integrationId))) == 1 then
        self._sendEvent(Constants.ANALYTICS.WINDOW_CLOSED, {
            integration_id = integrationId,
            total_open_time = self._tracker:finishTime((getTrackerName("window_time_", integrationId)))
        })
        self._resetWindowTrackers(integrationId)
    end
    return nil
end

function module:onWindowTouchBegan(arg1, _vector2: Vector2)
    local integration = getIntegration(arg1)

    if integration and integration.windowSize then
        self._tracker:set(getTrackerName("window_drag_", arg1), 1)
    end
    return nil
end

function module:onWindowDrag(integrationId, vec1: vector)
    local trackerName = getTrackerName("window_drag_", integrationId)
    local var1 = self._tracker:get(trackerName)
    local integration = getIntegration(integrationId)

    if integration and integration.windowSize and var1 == 1 then
        local var2 = self._tracker:get((getTrackerName("window_position_", integrationId)))

        if var2 then
            local vector2 = Vector2.new(vec1.X - var2.X, vec1.Y - var2.Y)

            if vector2.X ~= 0 or vector2.Y ~= 0 then
                self._tracker:set(trackerName, 2)
                local var3 = integration.windowSize:get()

                local var4 = self._tracker:get((getTrackerName("window_dposition_", integrationId)))

                self._sendEvent(Constants.ANALYTICS.WINDOW_DRAG_START, {
                    integration_id = integrationId,
                    position_x = var2.X,
                    position_y = var2.Y,
                    width = var3.Width.Offset,
                    height = var3.Height.Offset,
                    is_starting_position = var4 == var2
                })
            end
        end
    end
    return nil
end

function module:onWindowTouchEnded(integrationId, vector2: Vector2, willAutoposition: boolean)
    local var1 = self._tracker:get((getTrackerName("icon_drag_", integrationId)))
    local integration = getIntegration(integrationId)

    if var1 == 2 then
        return self:onIconTouchEnded(integrationId, vector2, willAutoposition)
    end

    local trackerName = getTrackerName("window_drag_", integrationId)
    local var2 = self._tracker:get(trackerName)

    if integration and integration.windowSize and var2 == 2 then
        local var3 = integration.windowSize:get()
        self._tracker:reset(trackerName)
        self._setWindowLastPosition(integrationId, vector2)
        self._sendEvent(Constants.ANALYTICS.WINDOW_DRAG_END, {
            integration_id = integrationId,
            position_x = vector2.X,
            position_y = vector2.Y,
            width = var3.Width.Offset,
            height = var3.Height.Offset,
            will_autoposition = willAutoposition
        })
    end
    return nil
end

function module:setWindowDefaultPosition(arg1, vector2: Vector2)
    self._tracker:set(getTrackerName("window_dposition_", arg1), vector2)
    self._setWindowLastPosition(arg1, vector2)
    return nil
end

function module:onWindowResize(integrationId, uDim2: UDim2)
    local integration = getIntegration(integrationId)

    if integration and integration.windowSize then
        local trackerName = getTrackerName("window_size_", integrationId)
        local trackerName2 = getTrackerName("window_position_", integrationId)
        local var1 = self._tracker:get(trackerName)
        local var2 = self._tracker:get(trackerName2)
        local var3

        if var2 then
            local var4 = (var1.Height.Offset - uDim2.Height.Offset) / 2
            local var5 = (var1.Width.Offset - uDim2.Width.Offset) / 2

            var3 = Vector2.new(var2.X + var5, var2.Y + var4)
        else
            var3 = nil
        end

        if var3 then
            self._setWindowLastPosition(integrationId, var3)
        end

        self._tracker:set(trackerName, uDim2)

        self._sendEvent(Constants.ANALYTICS.WINDOW_RESIZE, {
            integration_id = integrationId,
            previous_position_x = if var2 then var2.X or nil else nil,
            previous_position_y = if var2 then var2.Y or nil else nil,
            previous_width = if var1 then var1.Width.Offset or nil else nil,
            previous_height = if var1 then var1.Height.Offset or nil else nil,
            current_position_x = if var3 then var3.X or nil else nil,
            current_position_y = if var3 then var3.Y or nil else nil,
            current_width = uDim2.Width.Offset,
            current_height = uDim2.Height.Offset
        })
    end
    return nil
end

module.default = module.new()
return module
