-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Packages = CorePackages.Packages
local React = require(Packages.React)
local LuauPolyfill = require(Packages.LuauPolyfill)
local setTimeout = LuauPolyfill.setTimeout
local clearTimeout = LuauPolyfill.clearTimeout

local useTrackerMode = require(script.Parent.useTrackerMode)
local FaceChatUtils = require(script.Parent.Parent.Utils.FaceChatUtils)
local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization

local TrackerMode = Enum.TrackerMode

return function()
    local var1 = React.useRef(FaceChatUtils.getTrackerMode())
    local current = useTrackerMode()

    local var3 = useLocalization({
        controlMessageSound = "CoreScripts.TopBar.ControlMessageSound",
        controlMessageMotion = "CoreScripts.TopBar.ControlMessageMotion",
        controlMessageOn = "CoreScripts.TopBar.ControlMessageOn",
        controlMessageOff = "CoreScripts.TopBar.ControlMessageOff"
    })

    local var4, var5 = React.useState({ visible = false, text = var3.controlMessageMotion, status = var3.controlMessageOff })
    local var6 = React.useRef(nil)
    local function func1()
        local _controlMessageMotion = var3.controlMessageMotion
        local _controlMessageOff = var3.controlMessageOff
        local var7, var8

        if current ~= TrackerMode.None then
            var7 = var3.controlMessageOn
            if current == TrackerMode.AudioVideo or current == TrackerMode.Video then
                var8 = var3.controlMessageMotion
            else
                var8 = var3.controlMessageSound
            end
        else
            var7 = var3.controlMessageOff
            if var1.current == TrackerMode.Audio then
                var8 = var3.controlMessageSound
            else
                var8 = var3.controlMessageMotion
            end
        end

        var1.current = current

        return { visible = true, text = var8, status = var7 }
    end

    React.useEffect(function()
        if var6.current then
            clearTimeout(var6.current)
        end
        var5((func1()))
        var6.current = setTimeout(function()
            var5({ visible = false, text = var4.text, status = var4.status })
        end, 2000)
    end, { current })
    return var4
end
