-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:51:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)

local scriptParentParent = script.Parent.Parent
local FFlagTopBarDeprecateCoreGuiRodux = require(scriptParentParent.Flags.FFlagTopBarDeprecateCoreGuiRodux)
local FFlagTopBarDeprecateChatRodux = require(scriptParentParent.Flags.FFlagTopBarDeprecateChatRodux)
local FFlagTopBarDeprecateDisplayOptionsRodux = require(scriptParentParent.Flags.FFlagTopBarDeprecateDisplayOptionsRodux)
local FFlagTopBarDeprecateRespawnRodux = require(scriptParentParent.Flags.FFlagTopBarDeprecateRespawnRodux)
local FFlagTopBarDeprecateMoreMenuRodux = require(scriptParentParent.Flags.FFlagTopBarDeprecateMoreMenuRodux)

local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local FFlagTopBarSignalizeHealthBar = CoreGuiCommon.Flags.FFlagTopBarSignalizeHealthBar
local FFlagTopBarSignalizeMenuOpen = CoreGuiCommon.Flags.FFlagTopBarSignalizeMenuOpen

local CoreGuiConnector = require(script.CoreGuiConnector)
local MenuConnector = require(script.MenuConnector)
local ChatConnector = require(script.ChatConnector)
local HealthConnector = require(script.HealthConnector)
local EnabledNotifier = require(script.EnabledNotifier)
local OpenUIConnector = require(script.OpenUIConnector)
local _LastInputTypeConnector = require(script.LastInputTypeConnector)

local var1 = Roact.PureComponent:extend("Connection")

function var1.render(_)
    return Roact.createFragment({
        CoreGuiConnector = if FFlagTopBarDeprecateCoreGuiRodux then nil else Roact.createElement(CoreGuiConnector),
        MenuConnector = if FFlagTopBarSignalizeMenuOpen and FFlagTopBarDeprecateRespawnRodux then nil else Roact.createElement(MenuConnector),
        ChatConnector = if FFlagTopBarDeprecateChatRodux then nil else Roact.createElement(ChatConnector),
        HealthConnector = if FFlagTopBarSignalizeHealthBar then nil else Roact.createElement(HealthConnector),
        EnabledNotifier = if FFlagTopBarDeprecateDisplayOptionsRodux then nil else Roact.createElement(EnabledNotifier),
        OpenUIConnector = if FFlagTopBarDeprecateMoreMenuRodux then nil else Roact.createElement(OpenUIConnector)
    })
end

return var1
