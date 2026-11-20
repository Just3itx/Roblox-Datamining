-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FaceAnimatorService = game:GetService("FaceAnimatorService")
local Modules = game:GetService("CoreGui").RobloxGui.Modules

local var1 = require(Modules.SelfView.Analytics).new()
local publicApi = require(Modules.SelfView.publicApi)
local toggleSelfViewSignal = require(Modules.SelfView.toggleSelfViewSignal)

return function()
    if not FaceAnimatorService or not FaceAnimatorService:IsStarted() then
        return
    end

    FaceAnimatorService.VideoAnimationEnabled = not FaceAnimatorService.VideoAnimationEnabled
    var1:setLastCtx("bubbleChatToggle")

    local selfViewIsOpenAndVisible = publicApi.getSelfViewIsOpenAndVisible()
    if FaceAnimatorService.VideoAnimationEnabled and not selfViewIsOpenAndVisible then
        toggleSelfViewSignal:fire()
    end
end
