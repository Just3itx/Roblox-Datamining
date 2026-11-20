-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)
local Foundation = require(CorePackages.Packages.Foundation)
local LuauPolyfill = require(CorePackages.Packages.LuauPolyfill)
local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local CoreScriptsRootProvider = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).CoreScriptsRootProvider
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local useSnackbarSlideMotionFromBottom = require(script.Parent.useSnackbarSlideMotionFromBottom)
local setTimeout = LuauPolyfill.setTimeout
local clearTimeout = LuauPolyfill.clearTimeout

local num1 = game:DefineFastInt("VoiceRestrictionEndedSnackbarDismissSeconds", 4)

local var1 = nil
local var2 = nil
local var3, var4 = Signals.createSignal(0)

local function unmountSnackbar() -- Luacid: Inlined by compiler; 1 call site recovered
    if var2 then
        var2:unmount()
        var2 = nil
    end
    if var1 then
        var1:Destroy()
        var1 = nil
    end
end

local function dismissSnackbar(num2: number)
    if var3(false) ~= num2 then
        return
    end

    unmountSnackbar()
end

local function VoiceRestrictionEndedSnackbar(tbl1)
    local var5 = SignalsReact.useSignalState(var3)
    local var6 = useSnackbarSlideMotionFromBottom()
    local enter = var6.enter
    local exit = var6.exit

    React.useEffect(function()
        enter()
        local var7 = setTimeout(function()
            exit(function()
                tbl1.onDismiss(var5)
            end)
        end, num1 * 1000)
        return function()
            clearTimeout(var7)
        end
    end, {
        var5,
        enter,
        exit,
        tbl1.onDismiss
    })
    return React.createElement(Foundation.Snackbar, {
        title = RobloxTranslator:FormatByKey("Feature.InExperienceIntervention.Description.StartNewGameToTurnOnVoiceChat"),
        AnchorPoint = var6.anchorPoint,
        Position = var6.position
    })
end

local function mountHost() -- Luacid: Inlined by compiler; 1 call site recovered
    local voiceRestrictionEndedSnackbar = Instance.new("ScreenGui")
    voiceRestrictionEndedSnackbar.Name = "VoiceRestrictionEndedSnackbar"
    voiceRestrictionEndedSnackbar.DisplayOrder = 10
    voiceRestrictionEndedSnackbar.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    voiceRestrictionEndedSnackbar.ResetOnSpawn = false

    voiceRestrictionEndedSnackbar.ScreenInsets = Enum.ScreenInsets.None
    voiceRestrictionEndedSnackbar.ClipToDeviceSafeArea = false
    voiceRestrictionEndedSnackbar.Parent = CoreGui
    var1 = voiceRestrictionEndedSnackbar

    local root = ReactRoblox.createRoot(voiceRestrictionEndedSnackbar)
    var2 = root
    return root
end

local function showVoiceRestrictionEndedSnackbar()
    var4(var3(false) + 1)
    if var2 then
        return
    end

    mountHost():render(
        React.createElement(
            CoreScriptsRootProvider,
            {},
            {
                Snackbar = React.createElement(VoiceRestrictionEndedSnackbar, { onDismiss = dismissSnackbar })
            }
        )
    )
end
return showVoiceRestrictionEndedSnackbar
