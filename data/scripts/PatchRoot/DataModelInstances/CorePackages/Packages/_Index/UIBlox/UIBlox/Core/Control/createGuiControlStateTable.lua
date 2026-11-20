-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent

local ControlState = require(scriptParent.Enum.ControlState)
local ControlStateEvent = require(scriptParent.Enum.ControlStateEvent)

local StateTable = require(scriptParentParentParent.StateTable.StateTable)

local function createGuiControlStateTable(func1: (...any) -> (...any))
    local stateTable = StateTable.new("GuiStateTable", ControlState.Initialize, {}, {
        [ControlState.Initialize] = {
            [ControlStateEvent.Idle] = {
                nextState = ControlState.Default
            },
            [ControlStateEvent.Enabled] = {
                nextState = ControlState.Default
            },
            [ControlStateEvent.Disabled] = {
                nextState = ControlState.Disabled
            }
        },
        [ControlState.Default] = {
            [ControlStateEvent.PrimaryPressed] = {
                nextState = ControlState.Pressed
            },
            [ControlStateEvent.PointerHover] = {
                nextState = ControlState.Hover
            },
            [ControlStateEvent.SelectionGained] = {
                nextState = ControlState.Selected
            },
            [ControlStateEvent.Disabled] = {
                nextState = ControlState.Disabled
            }
        },
        [ControlState.Hover] = {
            [ControlStateEvent.SelectionGained] = {
                nextState = ControlState.Selected
            },
            [ControlStateEvent.PrimaryPressed] = {
                nextState = ControlState.Pressed
            },
            [ControlStateEvent.PointerHoverEnd] = {
                nextState = ControlState.Default
            },
            [ControlStateEvent.Disabled] = {
                nextState = ControlState.Disabled
            }
        },
        [ControlState.Pressed] = {
            [ControlStateEvent.SelectionGained] = {
                nextState = ControlState.SelectedPressed
            },
            [ControlStateEvent.PrimaryReleasedHover] = {
                nextState = ControlState.Hover
            },
            [ControlStateEvent.PrimaryReleased] = {
                nextState = ControlState.Default
            },
            [ControlStateEvent.Disabled] = {
                nextState = ControlState.Disabled
            }
        },
        [ControlState.Selected] = {
            [ControlStateEvent.SelectionLost] = {
                nextState = ControlState.Default
            },
            [ControlStateEvent.PrimaryPressed] = {
                nextState = ControlState.SelectedPressed
            },
            [ControlStateEvent.Disabled] = {
                nextState = ControlState.Disabled
            }
        },
        [ControlState.SelectedPressed] = {
            [ControlStateEvent.SelectionLost] = {
                nextState = ControlState.Default
            },
            [ControlStateEvent.PrimaryReleasedHover] = {
                nextState = ControlState.Selected
            },
            [ControlStateEvent.PrimaryReleased] = {
                nextState = ControlState.Selected
            },
            [ControlStateEvent.Disabled] = {
                nextState = ControlState.Disabled
            }
        },
        [ControlState.Disabled] = {
            [ControlStateEvent.Enabled] = {
                nextState = ControlState.Default
            }
        }
    })
    stateTable:onStateChange(func1)

    return stateTable
end

return createGuiControlStateTable
