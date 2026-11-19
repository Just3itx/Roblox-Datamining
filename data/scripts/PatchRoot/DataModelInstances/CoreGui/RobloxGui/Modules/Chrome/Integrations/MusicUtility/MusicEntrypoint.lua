-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local Chrome2 = require(CorePackages.Workspace.Packages.Chrome)
local SideSheetPlacement = Chrome2.Enums.SideSheetPlacement
local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local Songbird = require(CorePackages.Workspace.Packages.Songbird)
local Service = require(Chrome.Service)
local Constants = require(Chrome.Integrations.MusicUtility.Constants)
local CommonIcon = require(Chrome.Integrations.CommonIcon)
local WindowSizeSignal = require(Chrome.ChromeShared.Service.WindowSizeSignal)
local Responsive = require(CorePackages.Workspace.Packages.Responsive)
local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local MappedSignal = require(Chrome.ChromeShared.Service.ChromeUtils).MappedSignal

local MUSIC_WINDOW_MAX_SIZE = Constants.MUSIC_WINDOW_MAX_SIZE

local useSignalState = SignalsReact.useSignalState

local windowSizeSignal = WindowSizeSignal.new(MUSIC_WINDOW_MAX_SIZE.X, MUSIC_WINDOW_MAX_SIZE.Y)

local mappedSignal = MappedSignal.new(Service:onIntegrationStatusChanged(), function()
    return Service:isWindowOpen("music_entrypoint")
end)

local var1, var2 = Signals.createSignal(false)

local function focusMusicWindow()
    GuiService:SetMenuIsOpen(true, "music_entrypoint")
    var2(true)
end

local function unfocusMusicWindow() -- Luacid: Inlined by compiler; 1 call site recovered
    var2(false)
    GuiService:SetMenuIsOpen(false, "music_entrypoint")
end

return Service:register({
    initialAvailability = Service.AvailabilitySignal.Available,
    id = "music_entrypoint",
    sideSheetPlacement = SideSheetPlacement.BelowFold,
    draggable = true,
    cachePosition = true,
    windowSize = windowSizeSignal,
    label = "CoreScripts.TopBar.Music",
    activated = function()
        if Responsive.GetInputModeStore(false).getLastInputType(false) == Responsive.Input.Directional then
            Chrome2.FocusUtils.FocusOffChrome(focusMusicWindow)

            if not mappedSignal:get() then
                Service:toggleWindow("music_entrypoint")
            end
        else
            Service:toggleWindow("music_entrypoint")
        end
    end,
    isActivated = mappedSignal,
    components = {
        Icon = function(_)
            return CommonIcon("icons/common/music", "icons/common/musicFilled_medium", mappedSignal)
        end,
        Window = function()
            local isFocused = useSignalState(var1)

            return React.createElement(Foundation.View, {
                tag = "auto-xy",
                onAbsoluteSizeChanged = function(arg1)
                    windowSizeSignal:requestSize(arg1.AbsoluteSize.X, arg1.AbsoluteSize.Y)
                end
            }, {
                ChromeWindowWrapper = React.createElement(Songbird.ChromeWindowWrapper, {
                    isFocused = isFocused,
                    onClose = function()
                        unfocusMusicWindow()
                        Service:toggleWindow("music_entrypoint")
                    end,
                    onUnfocus = unfocusMusicWindow
                })
            })
        end
    }
})
