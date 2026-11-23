-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local clientDataModelCollector = require(BuildExperience.Chat.clientDataModelCollector)
local InGameBuildShell = require(script.Parent.InGameBuildShell)
local InstanceSelectionProtocol = require(script.Parent.InstanceSelectionProtocol)

local function noop() end

local function finishWithInstance(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    InstanceSelectionProtocol.finishSelection({
        status = "selected",
        path = clientDataModelCollector.getInstancePath(arg1),
        displayName = arg1.Name,
        className = arg1.ClassName
    })
end

local function cancelSelection()
    InstanceSelectionProtocol.finishSelection({ status = "cancelled" })
end

local function InstanceSelectionShell(tbl1)
    local var1, var2 = React.useState(nil)

    React.useEffect(function()
        local connection = tbl1.itemSelected:Connect(function(arg1)
            if tbl1.isTouchInput() then
                var2(arg1)
            elseif arg1 ~= nil then
                finishWithInstance(arg1)
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, { tbl1.itemSelected, tbl1.isTouchInput })

    return React.createElement(InGameBuildShell, {
        isSelecting = true,
        onActivated = noop,
        onSelectionCancelled = cancelSelection,
        onSelectionConfirmed = var1 ~= nil and function()
            finishWithInstance(var1)
        end or nil
    })
end

return InstanceSelectionShell
