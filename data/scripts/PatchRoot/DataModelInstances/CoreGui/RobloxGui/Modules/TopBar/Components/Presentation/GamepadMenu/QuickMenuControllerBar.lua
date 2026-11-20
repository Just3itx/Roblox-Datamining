-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local LocalizationService = game:GetService("LocalizationService")

local React = require(CorePackages.Packages.React)
local Roact = require(CorePackages.Packages.Roact)
local UIBlox = require(CorePackages.Packages.UIBlox)

local InGameMenuConstants = require(RobloxGui.Modules.InGameMenuConstants)
local ControllerBar = UIBlox.App.Bar.ControllerBar

local _RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization

local useSelector = require(CorePackages.Workspace.Packages.RoactUtils).Hooks.RoactRodux.useSelector

local function QuickMenuControllerBar(arg1)
    local localization = Localization.new(LocalizationService.RobloxLocaleId)

    local rightHints = {
        {
            text = localization:Format("CoreScripts.TopBar.Respawn"),
            keyCode = Enum.KeyCode.ButtonY
        },
        {
            text = localization:Format("CoreScripts.TopBar.Leave"),
            keyCode = Enum.KeyCode.ButtonX
        }
    }

    if arg1.chatMenuEnabled then
        local var1 = React.useCallback(function(arg2)
            return arg2.chat.visible
        end)

        table.insert(rightHints, 1, {
            text = localization:Format(if useSelector(var1) then "CoreScripts.TopBar.HideChat" else "CoreScripts.TopBar.ShowChat"),
            keyCode = Enum.KeyCode.ButtonR1
        })
    end

    return React.createElement(Roact.Portal, { target = CoreGui }, {
        QuickMenuControllerBar = React.createElement(
            "ScreenGui",
            {
                DisplayOrder = InGameMenuConstants.DisplayOrder.ControllerBar
            },
            {
                ControllerBar = React.createElement(ControllerBar, {
                    leftHint = {
                        text = localization:Format("CoreScripts.TopBar.Back"),
                        keyCode = Enum.KeyCode.ButtonB
                    },
                    rightHints = rightHints
                })
            }
        )
    })
end
return QuickMenuControllerBar
