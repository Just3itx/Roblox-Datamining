-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local InExperienceCloudPlay = script:FindFirstAncestor("InExperienceCloudPlay")
local InExperienceCloudPlayParent = InExperienceCloudPlay.Parent

local Foundation = require(InExperienceCloudPlayParent.Foundation)
local React = require(InExperienceCloudPlayParent.React)
local ReactRoblox = require(InExperienceCloudPlayParent.ReactRoblox)
local TransientUIOverlay = require(InExperienceCloudPlayParent.TransientUIOverlay)
local RestyleTimeLimitSnackbar = require(InExperienceCloudPlay.Components.RestyleTimeLimitSnackbar)
local showUnsuccessfulJoinSnackbar = require(InExperienceCloudPlay.showUnsuccessfulJoinSnackbar)

local displayOrder = game:DefineFastInt("CloudPlayUIOverlayDisplayOrder", 6)

local function mountCloudPlayUIOverlay()
    local inExperienceCloudPlay = Instance.new("Folder")
    inExperienceCloudPlay.Name = "InExperienceCloudPlay"
    inExperienceCloudPlay.Parent = CoreGui

    local root = ReactRoblox.createRoot(inExperienceCloudPlay)
    root:render(
        React.createElement(Foundation.FoundationProvider, {
            colorMode = Foundation.Enums.ColorMode.Dark
        }, {
            OverlayScreen = React.createElement(TransientUIOverlay.OverlayScreen, { displayOrder = displayOrder }),
            RestyleTimeLimitSnackbar = React.createElement(RestyleTimeLimitSnackbar)
        })
    )
    showUnsuccessfulJoinSnackbar()

    return root
end

return mountCloudPlayUIOverlay
