-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local GamepadMenu = script.Parent.Parent.Components.Presentation.GamepadMenu
local _EnumGamepadMenuOptions = require(GamepadMenu.EnumGamepadMenuOptions)
local engineFeature = game:GetEngineFeature("TelemetryServicePlaySessionInfoEnabled")
local throttlingPercentage = game:DefineFastInt("GamepadMenuActionThrottleHundrethsPercent", 0)

local function mapProp(arg1, func1: (...any) -> (...any)) -- Luacid: unused: defined but never referenced
    if arg1 ~= nil then
        return (func1(arg1))
    end

    return nil
end

local module = ({})
module.__index = module

function module.new()
    return (setmetatable({}, module))
end

function module.onOptionSelected(tbl1)
    local config = {
        eventName = "coreui_gamepad_menu_action",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 25, 4, 30 },
        description = "Event fired from the client every time GamepadMenu Options are Selected",
        links = "https://github.rbx.com/Roblox/proto-schemas/pull/5803"
    }

    local tbl2 = { "addPlaceId", "addUniverseId", "addSessionInfo" }
    local customFields = {
        menu_option_name = tbl1.menuOptionName,
        used_shortcut = 0,
        is_toggle_open = 0
    }
    local usedShortcut = tbl1.usedShortcut
    local tostring2 = tostring
    customFields.used_shortcut = if usedShortcut == nil then nil else tostring2(usedShortcut)
    local isToggleOpen = tbl1.isToggleOpen
    local tostring = tostring
    customFields.is_toggle_open = if isToggleOpen == nil then nil else tostring(isToggleOpen)

    if engineFeature then
        table.insert(tbl2, "addPlaySessionId")
    else
        customFields.playsessionid = RbxAnalyticsService:GetPlaySessionId()
        tbl2 = { "addPlaceId", "addUniverseId", "addSessionInfo" }
    end

    TelemetryService:LogEvent(config, { standardizedFields = tbl2, customFields = customFields })
end

module.default = module.new()

return module
