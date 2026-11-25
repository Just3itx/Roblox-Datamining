-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
local WhatsNew = script:FindFirstAncestor("WhatsNew")
local Constants = require(WhatsNew.Constants)
local _Types = require(WhatsNew.Types)
local Foundation = require(WhatsNew.Parent.Foundation)
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local isSideSheetEnabled = require(WhatsNew.Parent.InExperienceSideSheetUtils.isSideSheetEnabled)

local publishedTime = game:DefineFastString("RoseWhatsNewTourPublishedTime", "2026-08-12T00:00:00Z")

local disabledTime = game:DefineFastString("RoseWhatsNewTourDisabledTime", "2026-09-30T00:00:00Z")

return {
    constants = Constants.DEFAULT,
    scopeTours = {
        InGame = { id = "InGame", parentScopeId = nil },
        TiltMenu = {
            id = "TiltMenu",
            parentScopeId = "InGame",
            anchorId = "nine_dot",
            openActionKey = "OpenTiltMenu",
            closeActionKey = "CloseTiltMenu",
            align = PopoverAlign.Start,
            onboardingTitle = "CoreScripts.FTUX.Heading.NewTiltOnboarding",
            onboardingText = "CoreScripts.FTUX.Label.NewTiltOnboarding",
            updatesTitle = "CoreScripts.FTUX.Heading.NewTiltUpdate",
            updatesText = "CoreScripts.FTUX.Label.NewTiltUpdate"
        }
    },
    whatsNew = {
        {
            id = "SideSheet",
            scopeId = "TiltMenu",
            anchorId = "sideSheet",
            title = "CoreScripts.FTUX.Heading.SideSheetUpdate",
            text = "CoreScripts.FTUX.Label.SideSheetUpdate",
            icon = "",
            enabled = isSideSheetEnabled,
            side = PopoverSide.Right,
            align = PopoverAlign.Center,
            publishedTime = publishedTime,
            disabledTime = disabledTime
        },
        {
            id = "LeaveRespawn",
            scopeId = "TiltMenu",
            anchorId = "LeaveRespawn",
            title = "CoreScripts.FTUX.Heading.LeaveRespawn",
            text = "CoreScripts.FTUX.Label.LeaveRespawn",
            icon = "",
            enabled = isSideSheetEnabled,
            side = PopoverSide.Right,
            align = PopoverAlign.End,
            publishedTime = publishedTime,
            disabledTime = disabledTime
        }
    },
    onboarding = {
        {
            id = "TopBar",
            scopeId = "InGame",
            anchorId = "chat",
            title = "CoreScripts.FTUX.Heading.SocialOnboarding",
            text = "CoreScripts.FTUX.Label.SocialOnboarding",
            icon = "",
            enabled = true,
            align = PopoverAlign.Start,
            publishedTime = publishedTime,
            disabledTime = disabledTime
        },
        {
            id = "SideSheet",
            scopeId = "TiltMenu",
            anchorId = "sideSheet",
            title = "CoreScripts.FTUX.Heading.SideSheetUpdate",
            text = "CoreScripts.FTUX.Label.SideSheetOnboarding",
            icon = "",
            enabled = isSideSheetEnabled,
            side = PopoverSide.Right,
            align = PopoverAlign.Center,
            publishedTime = publishedTime,
            disabledTime = disabledTime
        },
        {
            id = "LeaveRespawn",
            scopeId = "TiltMenu",
            anchorId = "LeaveRespawn",
            title = "CoreScripts.FTUX.Heading.LeaveRespawn",
            text = "CoreScripts.FTUX.Label.LeaveRespawn",
            icon = "",
            enabled = isSideSheetEnabled,
            side = PopoverSide.Right,
            align = PopoverAlign.End,
            publishedTime = publishedTime,
            disabledTime = disabledTime
        }
    }
}
