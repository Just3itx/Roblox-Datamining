-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local ContextActionService = game:GetService("ContextActionService")

local SocialUpsell = script:FindFirstAncestor("SocialUpsell")

local SocialUpsellParent = SocialUpsell.Parent
local ReactRoblox = require(SocialUpsellParent.ReactRoblox)
local React = require(SocialUpsellParent.React)
local Signals = require(SocialUpsellParent.Signals)

local InExpOverlay = require(SocialUpsell.Components.InExpOverlay)
local Constants = require(SocialUpsell.Constants)

local getOverlayStore = require(SocialUpsell.Store.getOverlayStore)

local root = nil
local folder = nil

function mount()
    if not root then
        if not folder then
            folder = Instance.new("Folder")
            folder.Name = "Overlay"
            folder.Parent = CoreGui
        end

        root = ReactRoblox.createRoot(folder)
    end
    GuiService:SetMenuIsOpen(true, Constants.OVERLAY_MENU_NAME)
    ContextActionService:BindCoreAction(Constants.OVERLAY_CORE_ACTION_NAME, function() end, false, Enum.KeyCode.ButtonB, Enum.KeyCode.Escape)

    root:render(React.createElement(InExpOverlay, { gui = folder }))
end

function unmount()
    if root then
        root:unmount()
        ContextActionService:UnbindCoreAction(Constants.OVERLAY_CORE_ACTION_NAME)
        GuiService:SetMenuIsOpen(false, Constants.OVERLAY_MENU_NAME)
    end
end

local effect = nil
return function()
    local overlayStore = getOverlayStore(false)

    effect = Signals.createEffect(function(arg1)
        if overlayStore.getCurrentOverlayType(arg1) then
            mount()
            return
        end
        unmount()
    end)
end
