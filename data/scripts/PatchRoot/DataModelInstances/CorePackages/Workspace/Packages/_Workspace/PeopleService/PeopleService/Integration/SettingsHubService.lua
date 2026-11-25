-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParentParent = script.Parent.Parent.Parent

local Signals = require(scriptParentParentParent.Signals)

local var1 = nil
local showMenuButtonsContainer, setShowMenuButtonsContainer = Signals.createSignal(false)

local function createSettingsHubService()
    return {
        register = function(arg1)
            var1 = arg1
        end,
        hubRef = function()
            return var1 and var1.HubRef or nil
        end,
        pageRef = function()
            return var1 and var1.Page or nil
        end,
        showMenuButtonsContainer = showMenuButtonsContainer,
        setShowMenuButtonsContainer = setShowMenuButtonsContainer
    }
end

return (createSettingsHubService())
