-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local scriptParentParent = script.Parent.Parent

if require(scriptParentParent.Flags.FFlagTopBarDeprecateDisplayOptionsRodux) then
    return nil
end

local Actions = scriptParentParent.Actions
local SetMenuOpen = require(Actions.SetMenuOpen)
local SetTopBarEnabled = require(Actions.SetTopBarEnabled)
local SetSmallTouchDevice = require(Actions.SetSmallTouchDevice)
local SetScreenSize = require(Actions.SetScreenSize)
local SetKeepOutArea = require(Actions.SetKeepOutArea)
local RemoveKeepOutArea = require(Actions.RemoveKeepOutArea)
local _SetInputType = require(Actions.SetInputType)
local SetInspectMenuOpen = require(Actions.SetInspectMenuOpen)
local SetGamepadMenuOpen = require(Actions.SetGamepadMenuOpen)
local SetGamepadNavigationDialogOpen = require(Actions.SetGamepadNavigationDialogOpen)
local FFlagGamepadNavigationDialogABTest = require(script.Parent.Parent.Flags.FFlagGamepadNavigationDialogABTest)

local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local FFlagTopBarSignalizeMenuOpen = CoreGuiCommon.Flags.FFlagTopBarSignalizeMenuOpen
local FFlagTopBarSignalizeKeepOutAreas = CoreGuiCommon.Flags.FFlagTopBarSignalizeKeepOutAreas
local FFlagTopBarSignalizeScreenSize = CoreGuiCommon.Flags.FFlagTopBarSignalizeScreenSize

local _InputType = require(scriptParentParent.Constants).InputType

local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local tbl1 = {
    menuOpen = false,
    inspectMenuOpen = false,
    topbarEnabled = true,
    isSmallTouchDevice = false,
    screenSize = Vector2.new(0, 0),
    isGamepadMenuOpen = false,
    isGamepadNavigationDialogOpen = not FFlagGamepadNavigationDialogABTest and nil,
    keepOutAreas = {}
}

local createReducer = Rodux.createReducer

local tbl2 = {
    [if FFlagTopBarSignalizeMenuOpen then "" else SetMenuOpen.name] = not FFlagTopBarSignalizeMenuOpen and function(arg1, arg2)
        local isGamepadMenuOpen = arg1.isGamepadMenuOpen
        if not arg1.menuOpen and arg2.menuOpen then
            isGamepadMenuOpen = false
        end

        return Cryo.Dictionary.join(arg1, { menuOpen = arg2.menuOpen, isGamepadMenuOpen = isGamepadMenuOpen })
    end or nil
}

tbl2[SetTopBarEnabled.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { topbarEnabled = arg2.enabled })
end

tbl2[SetSmallTouchDevice.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { isSmallTouchDevice = arg2.isSmallTouchDevice })
end

tbl2[if FFlagTopBarSignalizeScreenSize then "" else SetScreenSize.name] = not FFlagTopBarSignalizeScreenSize and function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { screenSize = arg2.screenSize })
end or nil

tbl2[if FFlagTopBarSignalizeMenuOpen then "" else SetInspectMenuOpen.name] = not FFlagTopBarSignalizeMenuOpen and function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { inspectMenuOpen = arg2.inspectMenuOpen })
end or nil

tbl2[SetGamepadMenuOpen.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(
        arg1,
        {
            isGamepadMenuOpen = arg2.open,
            isGamepadNavigationDialogOpen = not FFlagGamepadNavigationDialogABTest and nil
        }
    )
end
tbl2[SetGamepadNavigationDialogOpen.name] = FFlagGamepadNavigationDialogABTest and function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { isGamepadNavigationDialogOpen = arg2.open })
end or nil

tbl2[if FFlagTopBarSignalizeKeepOutAreas then "" else SetKeepOutArea.name] = not FFlagTopBarSignalizeKeepOutAreas and function(arg1, arg2)
    local keepOutAreas = table.clone(arg1.keepOutAreas)
    keepOutAreas[arg2.id] = {
        size = arg2.size,
        position = arg2.position
    }

    return Cryo.Dictionary.join(arg1, { keepOutAreas = keepOutAreas })
end or nil

tbl2[if FFlagTopBarSignalizeKeepOutAreas then "" else RemoveKeepOutArea.name] = not FFlagTopBarSignalizeKeepOutAreas and function(arg1, arg2)
    local keepOutAreas = table.clone(arg1.keepOutAreas)
    keepOutAreas[arg2.id] = nil

    return Cryo.Dictionary.join(arg1, { keepOutAreas = keepOutAreas })
end or nil

return (createReducer(tbl1, tbl2))
