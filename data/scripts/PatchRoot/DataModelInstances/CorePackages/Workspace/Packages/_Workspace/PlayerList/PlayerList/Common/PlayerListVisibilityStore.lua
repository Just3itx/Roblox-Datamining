-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Signals = require(scriptParentParentParent.Signals)

local getVisible, var2 = Signals.createSignal(true)

local bool1 = false

local function setShouldPersistVisibility(bool2: boolean)
    bool1 = bool2
end

local function setVisible(playerListVisible: boolean)
    var2(playerListVisible)
    if bool1 then
        UserSettings().GameSettings.PlayerListVisible = playerListVisible
    end
end

local var3, var4 = Signals.createSignal({})

local getEffectiveVisible = Signals.createComputed(function(arg1)
    return getVisible(arg1) and next(var3(arg1)) == nil
end)

local var5 = nil

return {
    getVisible = getVisible,
    setVisible = setVisible,
    setShouldPersistVisibility = setShouldPersistVisibility,
    getEffectiveVisible = getEffectiveVisible,
    setTempHide = function(str1: string, bool2: boolean?)
        local bool3 = next(var3(false)) == nil
        var4(function(arg1)
            local var6 = table.clone(arg1)
            var6[str1] = if bool2 then true else nil
            return var6
        end)
        local bool4 = next(var3(false)) == nil
        if bool3 and not bool4 then
            var5 = getVisible(false)
            return
        end

        if bool3 or not bool4 or var5 == nil then
            return
        end

        local var6 = var5
        var5 = nil
        if getVisible(false) ~= var6 then
            var2(var6)
        end
    end,
    setTempHideSnapshot = function(bool2: boolean)
        if var5 ~= nil then
            var5 = bool2
        end
    end,
    reset = function()
        bool1 = false
        var5 = nil
        var4({})
        var2(true)
    end
}
