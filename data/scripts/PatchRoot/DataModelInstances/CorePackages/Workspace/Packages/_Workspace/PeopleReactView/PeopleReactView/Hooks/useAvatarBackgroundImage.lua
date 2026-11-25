-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactViewParent = script:FindFirstAncestor("PeopleReactView").Parent

local Signals = require(PeopleReactViewParent.Signals)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)
local AvatarBackground = require(PeopleReactViewParent.DataHydration.AvatarBackground)

local signal = Signals.createSignal(nil)

local function useAvatarBackgroundImage(num1: number)
    local avatarBackgroundStore = AvatarBackground.getAvatarBackgroundStore(false)
    local var1 = if num1 > 0 then avatarBackgroundStore.getAndFetchAvatarBackground(num1).data else signal
    local var2 = SignalsReact.useSignalState(var1)
    local assetId = var2 and var2.assetId
    if assetId then
        return (AvatarBackground.getAvatarBackgroundImageUrl(assetId))
    end

    return nil
end

return useAvatarBackgroundImage
