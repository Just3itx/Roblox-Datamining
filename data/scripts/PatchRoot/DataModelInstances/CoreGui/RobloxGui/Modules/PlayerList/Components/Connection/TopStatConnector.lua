-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local Roact = require(CorePackages.Packages.Roact)
local React = require(CorePackages.Packages.React)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local TenFootInterface = require(RobloxGui.Modules.TenFootInterface)

local scriptParentParentParent = script.Parent.Parent.Parent
local FFlagPlayerListReduceRerenders = require(scriptParentParentParent.Flags.FFlagPlayerListReduceRerenders)
local FFlagPlayerListRemoveTopStat = require(scriptParentParentParent.Flags.FFlagPlayerListRemoveTopStat)

local FFlagEnableMobilePlayerListOnConsole = PlayerList.Flags.FFlagEnableMobilePlayerListOnConsole
local bool1 = game:DefineFastFlag("PlayerListTopStatCheckGamepad", false)

local FFlagLuaSupportMicroGamepadPreferredInput = require(CorePackages.Workspace.Packages.SharedFlags).FFlagLuaSupportMicroGamepadPreferredInput

local var1 = nil
if not FFlagPlayerListRemoveTopStat then
    local var2 = not bool1
        or UserInputService.PreferredInput == Enum.PreferredInput.Gamepad
        or FFlagLuaSupportMicroGamepadPreferredInput and UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad

    if FFlagEnableMobilePlayerListOnConsole then
        if GuiService.ViewportDisplaySize ~= Enum.DisplaySize.Large then
            var2 = false
        end
    else
        var2 = TenFootInterface:IsEnabled()
    end

    if var2 then
        var1 = TenFootInterface:SetupTopStat()
    end
end

local var2 = Roact.PureComponent:extend("TopStatConnector")

function var2.render(arg1)
    if var1 then
        var1:SetTopStatEnabled(arg1.props.displayOptions.playerlistCoreGuiEnabled)
    end
    return nil
end

local function mapStateToProps(arg1)
    return {
        displayOptions = arg1.displayOptions
    }
end

if FFlagPlayerListReduceRerenders then
    return React.memo(RoactRodux.connect(mapStateToProps, nil)(var2))
end

return RoactRodux.connect(mapStateToProps, nil)(var2)
