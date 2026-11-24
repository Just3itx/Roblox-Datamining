-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceCloudPlay = script:FindFirstAncestor("InExperienceCloudPlay")
local InExperienceCloudPlayParent = InExperienceCloudPlay.Parent

local Foundation = require(InExperienceCloudPlayParent.Foundation)
local TransientUIOverlay = require(InExperienceCloudPlayParent.TransientUIOverlay)
local DefaultLoadingScreen = require(InExperienceCloudPlay.DefaultLoadingScreen)
local UnsuccessfulJoin = require(InExperienceCloudPlay.UnsuccessfulJoin)

local num1 = game:DefineFastInt("CloudPlayUnsuccessfulJoinSnackbarSeconds", 7)

local function showUnsuccessfulJoinSnackbar()
    if not UnsuccessfulJoin.consumeUnsuccessfulJoin() then
        return
    end

    local function show() -- Luacid: Inlined by compiler; 2 call sites recovered
        TransientUIOverlay.displaySnackbar({
            kind = "snackbar",
            title = "Cloud Play isn't working. You're playing normally.",
            icon = Foundation.Enums.IconName.TriangleExclamation
        }, num1)
    end

    if DefaultLoadingScreen.isRemoved() then
        show()
        return
    end

    local var1 = nil
    var1 = DefaultLoadingScreen.subscribeRemoved(function()
        var1()
        show()
    end)
end

return showUnsuccessfulJoinSnackbar
