-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t

local UIBlox = InGameMenuDependencies.UIBlox
local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Resources.Constants)
local Direction = require(scriptParentParent.Enums.Direction)
local SetCurrentZone = require(scriptParentParent.Actions.SetCurrentZone)

local PortalSize = Constants.Zone.PortalSize

local tbl1 = {
    [Direction.Up] = {
        size = UDim2.new(1, 0, 0, PortalSize),
        position = UDim2.new(0, 0, 0, 0)
    },
    [Direction.Down] = {
        size = UDim2.new(1, 0, 0, PortalSize),
        position = UDim2.new(0, 0, 1, -PortalSize)
    },
    [Direction.Left] = {
        size = UDim2.new(0, PortalSize, 1, 0),
        position = UDim2.new(0, 0, 0, 0)
    },
    [Direction.Right] = {
        size = UDim2.new(0, PortalSize, 1, 0),
        position = UDim2.new(1, -PortalSize, 0, 0)
    }
}

local var3 = Roact.PureComponent:extend("ZonePortal")

var3.validateProps = t.strictInterface({ targetZone = t.number, direction = Direction.isEnumValue, setCurrentZone = t.optional(t.callback) })

function var3.render(arg1)
    local direction = arg1.props.direction
    local var4 = tbl1[direction]

    return var1(function(arg2)
        local createElement = Roact.createElement
        local tbl2 = {
            Size = var4.size,
            Position = var4.position,
            BackgroundTransparency = 1,
            Selectable = true,
            ZIndex = 2147483647,
            SelectionImageObject = arg2(var2.Invisible)
        }

        tbl2[Roact.Event.SelectionGained] = function()
            arg1.props.setCurrentZone(arg1.props.targetZone)
        end

        return createElement("Frame", tbl2)
    end)
end

return (RoactRodux.UNSTABLE_connect2(nil, function(arg1)
    return {
        setCurrentZone = function(arg2)
            return arg1(SetCurrentZone(arg2))
        end
    }
end)(var3))
